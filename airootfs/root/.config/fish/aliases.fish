alias .. 'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'
alias ...... 'cd ../../../../..'
alias a alias
alias apt 'man pacman'
alias apt-get 'man pacman'
alias arc: 'cd ~/storage/archive'
alias asave 'alias > ~/.config/fish/aliases.fish'
alias bk: 'cd ~/storage/backup'
alias cleanup 'sudo pacman -Rns (pacman -Qtdq)'
alias cls clear
alias cp 'cp -v'
alias cups 'firefox http://localhost:631/printers/'
alias d vdir
alias ddel 'rm -rf'
alias dir 'dir --color=auto'
alias e kate
alias egrep 'egrep --color=auto'
alias exvpn expressvpn-toggle
alias ffs /usr/local/bin/FreeFileSync
alias fgrep 'fgrep --color=auto'
alias fish_vi_dec 'fish_vi_inc_dec dec'
alias fish_vi_inc 'fish_vi_inc_dec inc'
alias fixpacman 'sudo rm /var/lib/pacman/db.lck'
alias grubup 'sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias hw 'hwinfo --short'
alias jctl 'journalctl -p 3 -xb'
alias la 'eza -a --color=always --group-directories-first --icons'
alias ll 'eza -l --color=always --group-directories-first --icons'
alias ls 'eza -al --color=always --group-directories-first --icons'
alias lt 'eza -aT --color=always --group-directories-first --icons'
alias mirror 'sudo cachyos-rate-mirrors'
alias ms microsoft-edge-stable
alias mv 'mv -v'
alias myip 'curl https://checkip.amazonaws.com'
alias ok okular
alias pg 'pgrep -a'
alias please sudo
alias psmem 'ps auxf | sort -nr -k 4'
alias psmem10 'ps auxf | sort -nr -k 4 | head -10'
alias rec: 'cd /mnt/data/Recipes'
alias rec:=cd /storage/SkyDrive/recipes
alias rm 'rm -v'
alias sk: 'cd /home/jalong/data/SkyDrive'
alias syncarchive '/usr/local/bin/FreeFileSync /home/jalong/bin/mirror_backup_to_archive.ffs_gui'
alias syncone '/usr/local/bin/FreeFileSync /home/jalong/bin/bisync_data_to_onedrive.ffs_gui'
alias syncopen '/usr/local/bin/FreeFileSync /home/jalong/bin/bisync_data_to_onedrive.ffs_gui'
alias syncosprey '/usr/local/bin/FreeFileSync /home/jalong/bin/mirror_backup_to_osprey.ffs_gui'
alias tarnow 'tar -acf '
alias tb 'nc termbin.com 9999'
alias timers 'systemctl --user list-timers'
alias ts 'du -h --max-depth=1 | sort -hr'
alias untar 'tar -zxvf '
alias update 'sudo pacman -Syu'
alias vdir 'vdir --color=auto'
alias wget 'wget -c '
alias wi whereis
alias x exit
alias xghost 'chmod +x /usr/bin/ghost*'
