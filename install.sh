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
    rofi-wayland
    quickshell
    sddm
    stow
    ttf-jetbrains-mono
    ttf-jetbrains-mono-nerd
    otf-font-awesome
    awww
    zsh
    playerctl
    wlogout
    swaync
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

# --- zsh --------------------------------------------------
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

# default shell
chsh -s $(which zsh)

# --- enable services --------------------------------------
sudo systemctl enable sddm

# --- stow dotfiles ----------------------------------------
cd "$(dirname "$0")"
stow hyprland

echo "Donw. Reboot and log in via SDDM."
