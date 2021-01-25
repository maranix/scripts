#!/bin/bash

# My Setup Script for Fedora (Run and Done)

## Microsoft Edge
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/edge
sudo mv /etc/yum.repos.d/packages.microsoft.com_yumrepos_edge.repo /etc/yum.repos.d/microsoft-edge-dev.repo

# VSCode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

# Docker
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

## Install
sudo dnf -y update
sudo dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf -y install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf -y install microsoft-edge-dev code dnf-plugins-core docker-ce docker-ce-cli containerd.io go transmission vlc sensors yarn

sudo curl https://rclone.org/install.sh | sudo bash

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash
nvm install node
nvm use node

pip install s-tui

sudo dnf -y remove totem gnome-boxes hg firefox rhythmbox

sudo groupadd docker
sudo usermod -aG docker $USER
sudo systemctl enable docker
