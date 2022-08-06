#!/bin/bash

# Nala
echo "Installing Nala..."
echo "deb https://deb.volian.org/volian/ scar main" | sudo tee /etc/apt/sources.list.d/volian-archive-scar-unstable.list
wget -qO - https://deb.volian.org/volian/scar.key | sudo tee /etc/apt/trusted.gpg.d/volian-archive-scar-unstable.gpg > /dev/null
sudo apt update && sudo apt install nala -y
sleep 5
clear

# Purge libreoffice
echo "Purging libreoffice..."
sudo nala purge libreoffice -y

# Update packages
echo "Upgrading installed packages..."
sudo nala upgrade -y
sleep 5

# Setup ZSH
echo "Setting up ZSH..."
sudo nala install zsh wget curl gpg
echo "Installing ohmyzsh..."
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "Fetching .zshrc from dotfiles repo.."
wget https://raw.githubusercontent.com/ramanverma2k/dotfiles/main/.zshrc -O "$HOME"/hob/.zshrc
echo "Changing default shell to ZHS...."
chsh -s $(which zsh)

/usr/bin/zsh ./PopOS/1.sh
/usr/bin/zsh ./PopOS/2.sh
