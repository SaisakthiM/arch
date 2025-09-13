#!/bin/bash

# Path to Hyprland config
CONFIG="$HOME/.config/hypr/hyprland.conf"

# Backup the original config just in case
cp "$CONFIG" "${CONFIG}.bak_$(date +%F_%T)"

# Configuration content to insert
read -r -d '' CUSTOM_CONF << EOM
general {
    monitor=auto
    animation=off
    blur=0
}

# Keybindings
bind=SUPER+RETURN, exec, konsole
bind=SUPER+Q, killactive
bind=SUPER+F, fullscreen
bind=SUPER+L, exec, logout

# Workspaces
workspace {
    1, name="Web"
    2, name="Code"
    3, name="Media"
    4, name="Misc"
}

# Autostart apps
exec=waybar
EOM

# Append the custom config to the end of the file
echo "$CUSTOM_CONF" >> "$CONFIG"

echo "Hyprland config updated and original backed up as ${CONFIG}.bak_$(date +%F_%T)"
