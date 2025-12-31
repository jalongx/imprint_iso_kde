function o
    if test (count $argv) -ne 1
        echo "Usage: o <file>"
        return 1
    end

    xdg-open "$argv[1]" >/dev/null 2>&1 &
end


# eq requires the math argument to be surrounded by quotes
function eq
    set expr (string join " " $argv)
    set result (math "$expr")
    echo "The answer is: $result"
end

function of
    nohup dolphin $argv >/dev/null 2>&1 &
end

function ggl
    set query (string join "+" $argv)
    xdg-open "https://www.google.ca/search?q=$query" >/dev/null &
end

function bing
    set query (string join "+" $argv)
    xdg-open "https://www.bing.com/search?q=$query" >/dev/null &
end

function ff
    if test (count $argv) -lt 1
        echo "Find files and directories using a substring"
        echo "Usage: ff [path] <substring>"
        return 1
    end

    if test (count $argv) -eq 1
        # Only a pattern given, default path is current dir
        set path .
        set pattern $argv[1]
    else
        # Path + pattern
        set path $argv[1]
        set pattern $argv[-1]
    end

    # Case-insensitive recursive search, do not follow symlinks
    # find -P $path -iname "*$pattern*"

    # Case-insensitive recursive search, do not follow symlinks
    find $path -iname "*$pattern*"
end

function ffe
    # ffe [path] <pattern1> [pattern2 ...] [--files | --dirs] [--sym | --nosym] [--xdev | --no-xdev] [--help]
    #
    # Case-insensitive recursive search using `find`.
    # - Defaults to current directory when no path is given.
    # - Patterns are OR'd together (case-insensitive).
    # - By default symlinked directories are not traversed (depends on your find).
    # - --files / --dirs restrict results by type.
    # - --nosym omits symlink entries entirely.
    # - --sym lists symlink entries (they will be listed if matching).
    # - --xdev prevents crossing filesystem boundaries (find -xdev).
    # - Use `--` to stop flag parsing so a pattern beginning with '-' can be used.

    set -l USAGE "
Usage
  ffe [path] <pattern1> [pattern2 ...] [--files | --dirs] [--sym | --nosym] [--xdev | --no-xdev] [--help]

  Synopsis
  Search recursively (from path or current dir) for names matching one or more patterns (case-insensitive).
  Patterns are OR'd: ffe . foo bar  => matches foo OR bar. DO NOT USE WILDCARDS ON THE COMMANDLINE! SUBSTRINGS ONLY!

Flags
  --files             Return only regular files.
  --dirs              Return only directories.
  --sym               Include symlink entries in results (they will be listed if matching).
  --nosym             Exclude symlink entries entirely.
  --xdev              Exclude mounts
  --no-xdev           Include mounts
  --help              Show this help text.

Notes
  - By default symlinked directories are not traversed (find -P).
  - If a single non-flag argument is provided it is treated as a pattern (searches current dir).
  - If two or more non-flag arguments are provided and the first looks like a path (contains '/' or starts with '.' or '~'), the first is treated as the path and the rest as patterns.
  - Otherwise, when two or more non-flag args are given, all are treated as patterns (search current dir).
  - Use '--' to stop flag parsing (e.g., ffe . -- -conf).

Examples
  ffe conf
  ffe /etc conf
  ffe ~/projects conf log
  ffe . conf --files
  ffe /etc conf --dirs --nosym
"

    # If no args at all, show usage
    if test (count $argv) -eq 0
        echo $USAGE
        return 1
    end

    # Split flags and non-flag args; support '--' to stop flag parsing
    set -l raw_args $argv
    set -l flags
    set -l nonflag_args
    set -l stop_flags 0

    for a in $raw_args
        if test $stop_flags -eq 1
            set nonflag_args $nonflag_args $a
            continue
        end

        if test $a = '--'
            set stop_flags 1
            continue
        end

        if string match -q -- '--*' $a
            set flags $flags $a
        else
            set nonflag_args $nonflag_args $a
        end
    end

    # Handle --help early so "ffe --help" works even with no patterns
    for f in $flags
        if test $f = '--help'
            echo $USAGE
            return 0
        end
    end

    # Decide path vs patterns
    set -l path .
    set -l patterns

    if test (count $nonflag_args) -eq 0
        echo "Error: You must provide at least one pattern."
        return 1
    else if test (count $nonflag_args) -eq 1
        set patterns $nonflag_args[1]
    else
        set -l first $nonflag_args[1]
        if string match -q -- '*/*' $first; or string match -q -- '~*' $first; or string match -q -- '.*' $first
            set path $first
            set patterns $nonflag_args[2..-1]
        else
            set patterns $nonflag_args
        end
    end

    # Parse flags into token arrays
    set -l pre_tokens      # tokens that are predicates (we will place these AFTER the path)
    set -l type_tokens     # e.g., -type f
    set -l symlink_tokens  # e.g., ! -type l
    set -l xdev_flag 0

    for f in $flags
        switch $f
            case '--files'
                set type_tokens -type f
            case '--dirs'
                set type_tokens -type d
            case '--sym'
                # include symlinks in results (no exclusion token)
            case '--nosym'
                set symlink_tokens '!' -type l
            case '--xdev'
                set xdev_flag 1
            case '--no-xdev'
                set xdev_flag 0
            case '*'
                echo "Unknown option: $f"
                return 1
        end
    end

    if test $xdev_flag -eq 1
        set pre_tokens $pre_tokens -xdev
    end

    # Build pattern tokens (each pattern -> -iname "pattern")
    set -l pattern_tokens
    for pat in $patterns
        set pattern_tokens $pattern_tokens -iname "*$pat*"
        set pattern_tokens $pattern_tokens -o
    end

    # Remove trailing -o if present
    if test (count $pattern_tokens) -gt 0
        if test $pattern_tokens[-1] = '-o'
            set pattern_tokens $pattern_tokens[1..(math (count $pattern_tokens) - 1)]
        end
    end

    if test (count $pattern_tokens) -eq 0
        echo "Error: No valid patterns to search for."
        return 1
    end

    # Place the path immediately after 'find', then expand predicate/token arrays.
    if test (count $pre_tokens) -gt 0
        if test (count $symlink_tokens) -gt 0
            if test (count $type_tokens) -gt 0
                command find $path $pre_tokens $symlink_tokens $type_tokens '(' $pattern_tokens ')'
            else
                command find $path $pre_tokens $symlink_tokens '(' $pattern_tokens ')'
            end
        else
            if test (count $type_tokens) -gt 0
                command find $path $pre_tokens $type_tokens '(' $pattern_tokens ')'
            else
                command find $path $pre_tokens '(' $pattern_tokens ')'
            end
        end
    else
        if test (count $symlink_tokens) -gt 0
            if test (count $type_tokens) -gt 0
                command find $path $symlink_tokens $type_tokens '(' $pattern_tokens ')'
            else
                command find $path $symlink_tokens '(' $pattern_tokens ')'
            end
        else
            if test (count $type_tokens) -gt 0
                command find $path $type_tokens '(' $pattern_tokens ')'
            else
                command find $path '(' $pattern_tokens ')'
            end
        end
    end
end


function cdd
    set -l file ~/.config/fish/cdd.txt

    if not test -f $file
        echo "No cdd.txt found at $file"
        return 1
    end

    set -l needle ""
    if test (count $argv) -gt 0
        set needle "$argv[1]"
    end

    set -l matches
    while read -l line
        if test -z "$needle"
            set -a matches "$line"
        else if string match -qi "*$needle*" "$line"
            set -a matches "$line"
        end
    end < $file

     if test (count $matches) -eq 0
        echo "No matches found"
        return 1
    end

    if test (count $matches) -eq 1
        cd "$matches[1]"
        return
    end

    set -l choice (printf "%s\n" $matches | fzf --prompt="cdd> " --height=40% --reverse)
    if test -n "$choice"
        cd "$choice"
    end
end

function cdsave
    set -l file ~/.config/fish/cdd.txt
    set -l dir (pwd)

    # Ensure the file exists
    if not test -f $file
        touch $file
    end

    # Check for exact line match
    if string match -q -r "^$dir\$" (cat $file)
        echo "Already saved: $dir"
    else
        echo "$dir" >> $file
        sort -u $file -o $file
        echo "Saved: $dir"
    end
end



function cdd_check
    set -l file /home/jalong/.config/fish/cdd.txt

    if not test -f $file
        echo "File not found: $file"
        return 1
    end

    while read -l line
        # Expand leading ~
        set -l path (string replace -r '^~' $HOME "$line")

        if test -d "$path"
            printf "OK     %s\n" "$line"
        else
            printf "MISSING %s\n" "$line"
        end
    end < $file
end

function new_history
    set -l initial_query (commandline -b)

    history --reverse \
    | string replace -r '^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2} ' '' \
    | fzf --exact --no-sort \
          --height=60% \
          --layout=reverse \
          --prompt="History> " \
          --query="$initial_query" \
    | read -l cmd

    commandline -r -- "$cmd"
    commandline -f repaint
end

function free
    df -h | head -n1
    df -h | grep -i -- $argv
end

function cdd_delete
    set -l file /home/jalong/.config/fish/cdd.txt
    set -l tmp (mktemp)
    set -l timestamp (date +%Y%m%d-%H%M%S)
    set -l backup "$file.bak.$timestamp"

    if not test -f $file
        echo "File not found: $file"
        return 1
    end

    echo "Creating backup: $backup"
    cp $file $backup

    echo "Removing invalid entries from: $file"
    echo

    while read -l line
        # Expand leading ~
        set -l path (string replace -r '^~' $HOME "$line")

        if test -d "$path"
            echo "$line" >> $tmp
        else
            printf "DELETED %s\n" "$line"
        end
    end < $file

    mv $tmp $file
end

function gog_dups --description "List GOG game directories with multiple .exe installers"
    set base "/mnt/media/gog_install"

    for d in $base/*/
        set exes (count $d/*.exe 2>/dev/null)
        if test $exes -gt 1
            echo "$d  →  $exes exe files"
        end
    end
end
