#!/bin/bash
set -e
sudo apt install build-essential libncurses-dev bison flex libssl-dev libelf-dev libncurses5-dev 
git -C kernel pull 2> /dev/null || git clone https://kernel.googlesource.com/pub/scm/linux/kernel/git/stable/linux.git -b linux-5.7.y kernel && cd kernel
cp /boot/config-* .config
make menuconfig
make -j12
sudo make modules_install
sudo make install
