#!/bin/bash
set -e

echo "Updating system..."
sudo pacman -Syu --noconfirm

echo "Installing base dependencies..."
sudo pacman -S --needed base-devel git wget curl vim --noconfirm

# Check if yay is installed
if ! command -v yay &> /dev/null
then
    echo "Installing yay (AUR helper)..."
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd ~
fi

echo "Installing Google Chrome, VS Code, Alacritty, and Waybar..."
yay -S --noconfirm google-chrome code alacritty waybar

echo "Installing VMware tools..."
sudo pacman -S --noconfirm open-vm-tools xf86-video-vmware
sudo systemctl enable --now vmtoolsd
sudo systemctl enable --now vmware-vmblock-fuse

echo "Setting up Hyprland config..."
HYPR_CONFIG_DIR="$HOME/.config/hypr"
mkdir -p "$HYPR_CONFIG_DIR"

cat > "$HYPR_CONFIG_DIR/hyprland.conf" <<EOL
# Basic Beso-style Hyprland config

# General
general {
    monitor=auto
    animation=on
    blur=5
}

# Keybindings
bind=SUPER+RETURN, exec, alacritty
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
exec=nitrogen --restore
exec=waybar
EOL

echo "Hyprland config created at $HYPR_CONFIG_DIR/hyprland.conf"
echo "You can edit it with: vim $HYPR_CONFIG_DIR/hyprland.conf"

echo "Setup complete! Reboot or log out and start Hyprland to test."
