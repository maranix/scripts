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

# NVM
echo "Installing node"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | zsh
export NVM_DIR="$HOME/.nvm" && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" &&  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" &&  # This loads nvm bash_completion
nvm install node
nvm use node


# Rust
echo "Installing Rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Flutter / Dart
git clone https://github.com/flutter/flutter.git -b stable --depth=1 "$HOME"/.flutter

# Install applications & Packages

# PPA
sudo add-apt-repository -y ppa:longsleep/golang-backports
sudo add-apt-repository -y ppa:maarten-fonville/android-studio
sudo add-apt-repository -y ppa:kritalime/ppa
sudo add-apt-repository -y ppa:savoury1/ffmpeg4
sudo add-apt-repository -y ppa:savoury1/vlc3

# VSCode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

# GitHub CLI
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

# Docker
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# OnlyOffice
mkdir -p ~/.gnupg
chmod 700 ~/.gnupg
gpg --no-default-keyring --keyring gnupg-ring:/tmp/onlyoffice.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys CB2DE8E5
chmod 644 /tmp/onlyoffice.gpg
sudo chown root:root /tmp/onlyoffice.gpg
sudo mv /tmp/onlyoffice.gpg /etc/apt/trusted.gpg.d/
echo 'deb https://download.onlyoffice.com/repo/debian squeeze main' | sudo tee -a /etc/apt/sources.list.d/onlyoffice.list

sudo nala update
sleep 5

sudo nala install -y android-studio code gh clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen clang clangd cmake gcc g++ krita onlyoffice-desktopeditors vlc fzf ripgrep tmux libssl-dev pkg-config golang-go
sleep 5

# Docker Setup
clear
echo "Installing docker..."
sudo nala install -y --fix-broken ca-certificates curl gnupg lsb-release docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo groupadd docker
sudo usermod -aG docker "$USER"
sudo systemctl enable docker

echo "Installing Typescript & Language servers"
npm install --location=global typescript typescript-language-server yarn vscode-langservers-extracted @tailwindcss/language-server
go install golang.org/x/tools/gopls@latest
cargo install cargo-edit
go install github.com/jesseduffield/lazygit@latest

clear

echo "Cloning & Install Neovim"
mkdir "$HOME/tmp"
cd "$HOME/tmp"
git clone https://github.com/neovim/neovim -b stable --single-branch --depth=1
cd neovim
make CMAKE_BUILD_TYPE=Release
sudo make install

echo "Setting up editor & application configs"
cd "$HOME/tmp"
git clone https://github.com/ramanverma2k/dotfiles
cd dotfiles
cp -r nvim ~/.config/nvim
cp -r lazygit ~/.config/lazygit
git config --global user.name "ramanverma2k"
git config --global user.email "ramanverma4183@gmail.com"
git config --global core.editor "nvim"

echo "Cleaning up"
cd "$HOME"
rm -rf "$HOME/tmp"
sudo nala autoremove
sudo nala autopurge

clear

# Setup ZSH
echo "Setting up ZSH..."
sudo nala install zsh wget curl gpg
echo "Installing ohmyzsh..."
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "Fetching .zshrc from dotfiles repo.."
wget https://raw.githubusercontent.com/ramanverma2k/dotfiles/main/.zshrc -O "$HOME"/hob/.zshrc
echo "Changing default shell to ZHS...."
chsh -s $(which zsh)

echo "All done..."
