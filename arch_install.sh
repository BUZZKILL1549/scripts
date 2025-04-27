#!/bin/bash

echo "------------------------- Arch Install --------------------------"
echo "                                                                 "
echo "This script requires sudo permission. Please enter your password."
sudo -v

echo "Adding Chaotic-AUR..."
sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
sudo bash -c 'echo -e "\n[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist" >> /etc/pacman.conf'
echo "Chaotic-AUR added."

echo "Updating systme..."
sudo pacman -Syu
echo "System update complete."

echo "Installing packages..."
echo "System packages to be installed:"
echo "hyprland (hypr* ecosystem), uwsm, waybar, grim, slurp, wl-clipboard" 
echo "clipse, nemo, kitty, wofi, pipewire, wireplumber"
yay -S hyprland-meta-git uwsm waybar grim slurp wl-clipboard clipse \
  nemo kitty wofi 
echo "Other packages to be installed:"
echo "fastfetch, neovim, fish, git, onlyoffice, github-cli, cmake, unzip, curl, pyprland"
echo "python-pywal16"
yay -S fastfetch neovim fish onlyoffice gh git cmake unzip curl python-pywal16 -y
curl https://raw.githubusercontent.com/hyprland-community/pyprland/main/scripts/get-pypr | sh
echo "Packages installed."

echo "Configuring Git..."
read -p "Enter github username: " gh_username
read -p "Enter github email: " gh_email
git config --global user.name "$gh_username" 
git config --global user.email "$gh_email"
git config --global core.editor "nvim"
git config --global init.defaultBranch main
git config --global pull.rebase false
echo "Git configuration complete."

echo "Configuring Hyprland..."
rm -rf ~/.config
git clone https://github.com/BUZZKILL1549/dotfiles ~/.config
yay -S colorthief -y
wal -i ~/.config/hypr/wallpapers/Tranquility_1920x1080.png --backend colorthief --cols16
echo "Hyprland configuration complete."

echo "Configuring Fish..."
sudo chsh -s $(which fish) $USER
rm -rf ~/.config/fish
git clone https://github.com/BUZZKILL1549/fish.git ~/.config/fish/ 
fish -c "source ~/.config/fish/config.fish"
echo "Fish configuration complete."

echo "Configuring Node.js..."
curl -fsSL https://fnm.vercel.app/install | bash
fnm use --install-if-missing v22.10.0
echo "Node.js configuration complete."

echo "Configuring Neovim..."
rm -rf ~/.config/nvim
git clone https://github.com/BUZZKILL1549/neovim.git ~/.config/nvim/
echo "Neovim configuration complete."

echo "Configuring Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh  -s -- -y
source $HOME/.cargo/env
echo "Rust configuration complete."

echo "Configuring the Documents folder..."
mkdir -p ~/Documents/Projects/rust 
mkdir -p ~/Documents/Projects/c 
mkdir -p ~/Documents/Projects/python
mkdir -p ~/Documents/Projects/cpp
git clone https://github.com/BUZZKILL1549/fanfiction.git ~/Documents/fanfiction
echo "Documents folder configuration complete."

echo "Configuration complete.                                          "
echo "                                                                 "
echo "-----------------------------------------------------------------"
