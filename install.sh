#!/usr/bin/env bash
# install.sh - snaw dotfiles bootstrap
# Better run this on a fresh Arch install

set -euo pipefail

# --- packages ---------------------------------------------
PACKAGES=(
    hyprland
    xdg-desktop-portal-hyprland
    polkit-kde-agent
    qt5-wayland
    qt6-wayland
    kitty
    wofi
    quickshell
    sddm
    stow
    ttf-jetbrains-mono
    ttf-jetbrains-mono-nerd
    otf-font-awesome
)

# --- install yay if not present ---------------------------
if ! command -v yay &>/dev/null; then
    echo "Installing yay..."
    sudo pacman -S --noconfirm git base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay && makepkg -si --noconfirm
    cd ~ && rm -rf /tmp/yay
fi

# --- install packages -------------------------------------
yay -S --noconfim "${PACKAGES[@]}"

# --- enable services --------------------------------------
sudo systemctl enable sddm

# --- stow dotfiles ----------------------------------------
cd "$(dirname "$0")"
stow hyprland

echo "Donw. Reboot and log in via SDDM."
