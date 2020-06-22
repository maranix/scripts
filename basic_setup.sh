#!/bin/bash
set -e
sudo apt-get install openjdk-14-jdk-headless zram-config git-core cmake perl nasm meson python3-opencv libsm6 python3 python3-pip python3-setuptools python3-wheel build-essential libncurses-dev bison flex libssl-dev libelf-dev libncurses5-dev tasksel snap snapd nodejs npm
sudo tasksel install ubuntu-budgie-desktop

echo "Purging LibreOffice"
sudo apt-get remove --purge libreoffice*
sudo apt-get clean
sudo apt autoremove
sudo snap install --classic code
sudo snap install --classic android-studio
sudo snap install --classic go
sudo snap install vlc kotlin wps-2019-snap

echo "Disabling VNC encryption"
gsettings set org.gnome.Vino require-encryption false
