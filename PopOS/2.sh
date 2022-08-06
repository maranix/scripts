#!/bin/zsh

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
echo "All done..."
