#!/bin/bash

echo "------------------------- Debian Install -------------------------"
echo "                                                                  "

echo "This script requires sudo permissions. Please enter your password."
sudo -v

echo "Installing nix-shell..."
sh <(curl -L https://nixos.org/nix/install) --daemon
echo "Nix-shell install complete."

echo "Installing packages..."
echo "Packages to be installed:"
echo "fastfetch, neovim, onlyoffice, git, github-cli, fish, cmake, curl, unzip"
nix-env -iA nixpkgs.neovim nixpkgs.fastfetch nixpkgs.onlyoffice-desktopeditors \
  nixpkgs.gh nixpkgs.fish nixpkgs.cmake nixpkgs.curl nixpkgs.unzip nixpkgs.git 
echo "Package install complete."

echo "Configuring Git..."
read -p "Enter github username: " gh_username
read -p "Enter github email: " gh_email
git config --global user.name "$gh_username" 
git config --global user.email "$gh_email"
git config --global core.editor "nvim"
git config --global init.defaultBranch main
git config --global pull.rebase false
echo "Git configuration complete."

echo "Configuring Fish..."
sudo chsh -s $(which fish) $USER
git clone -b debian-nix https://github.com/BUZZKILL1549/fish.git ~/.config/fish/ 
curl -sS https://starship.rs/install.sh | sh
fish -c "source ~/.config/fish/config.fish"
echo "Fish configuration complete."

echo "Configuring Node.js..."
curl -fsSL https://fnm.vercel.app/install | bash
fnm use --install-if-missing v22.10.0
echo "Node.js configuration complete."

echo "Configuring Neovim..."
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

echo "Configuration complete.                                           "
echo "                                                                  "
echo "------------------------------------------------------------------"
