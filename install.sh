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

# --- check hyprland environment ---------------------------
if ! command -v pacman &>/dev/null; then
  echo "This script requires an Arch-based distribution. Exiting."
  exit 1
fi

if ! pacman -Q hyprland &>/dev/null; then
  echo "This script is meant to work with Hyprland."
  read -rp "Do you want to install it? [y/N] " response
  if [[ "$response" =~ ^[Yy]$ ]]; then
    sudo pacman -S --noconfirm hyprland xdg-desktop-portal-hyprland
  else
    echo "Exiting."
    exit 1
  fi
fi

# --- system prep ------------------------------------------
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm ca-certificates
sudo update-ca-trust

# --- install yay if not present ---------------------------
if ! command -v yay &>/dev/null; then
    echo "Installing yay..."
    sudo pacman -S --noconfirm git base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay && makepkg -si --noconfirm
    cd ~ && rm -rf /tmp/yay
fi

# --- install packages -------------------------------------
yay -S --noconfirm "${PACKAGES[@]}"

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
DOTFILES_DIR="$(cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")" && pwd)"

stow --dir="$DOTFILES_DIR" --target="$HOME" hyprland
stow --dir="$DOTFILES_DIR" --target="$HOME" kitty
stow --dir="$DOTFILES_DIR" --target="$HOME" rofi
stow --dir="$DOTFILES_DIR" --target="$HOME" swaync
stow --dir="$DOTFILES_DIR" --target="$HOME" wallpapers

# Replacing some generated files
rm -f "$HOME/.zshrc"
stow --dir="$DOTFILES_DIR" --target="$HOME" zsh

# --- done --------------------------------------------------
echo "Done. Reboot to start SDDM and apply everything."
read -rp "Reboot now? [y/N] " response
if [[ "$response" =~ ^[Yy]$ ]]; then
    sudo reboot
fi
