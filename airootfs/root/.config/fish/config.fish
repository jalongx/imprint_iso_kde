source /root/.config/fish/cachyos.conf
source /root/.config/fish/aliases.fish
source /root/.config/fish/functions.fish
source /root/.config/fish/abbr.fish

# ---------------------------------------------------------
# GhostX: ensure binaries are executable
# ---------------------------------------------------------
chmod +x /usr/local/bin/imprintb 2>/dev/null
chmod +x /usr/local/bin/imprintr 2>/dev/null
chmod +x /usr/local/bin/mntnas 2>/dev/null
chmod +x /usr/local/bin/verify_image.sh 2>/dev/null

# ---------------------------------------------------------
# Start KDE Plasma Wayland automatically on TTY1
# ---------------------------------------------------------
if status --is-interactive
    # Only start the desktop on the first console
    if test (tty) = "/dev/tty1"
        # Start audio stack
        pipewire &
        wireplumber &
        pipewire-pulse &

        # Launch Plasma Wayland
        exec startplasma-wayland
    end
end
