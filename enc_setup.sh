#!/bin/bash
set -e

sourceDir=$PWD

function deps(){
clear
sudo apt-get install cmake git perl nasm meson python3-opencv libsm6 python3 python3-setuptools python3-wheel
sudo python3 -m pip uninstall pip && sudo apt install python3-pip --reinstall
}

function av1an(){
clear
cd $sourceDir
git clone https://github.com/master-of-zen/Av1an
cd Av1an && sudo python3 setup.py install
}

function aom(){
clear
cd $sourceDir
git clone --depth 1 https://aomedia.googlesource.com/aom
mkdir -p aom_build
cd aom_build
cmake ../aom
make -j12
sudo make install
}

function ffmpeg() {
clear
cd $sourceDir
wget https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz
tar -xvf *.xz && rm -rf *.xz && mv ffmpeg* ffmpeg && cd ffmpeg && sudo cp ffmpeg ffprobe /usr/bin && sudo cp -r model /usr/local/share
}

function vmaf() {
clear
cd $sourceDir
git -C vmaf pull 2> /dev/null || git clone --depth 1 https://github.com/Netflix/vmaf
cd vmaf/libvmaf
meson build --buildtype release
ninja -vC build
sudo ninja -vC build install
}

function cleanup() {
cd $sourceDir
sudo rm -rf aom aom_build Av1an ffmpeg* vmaf
}

function main() {
clear
printf " Choose an Option.\n 1. Install dependencies.\n 2. Install/Update Av1an.\n 3. Install/Update libaom.\n 4. Install/Update FFMPEG binaries.\n 5. Install/Update libvmaf.\n 6. Do everything above.\n 7. Clean up work dirs.\n 8. Exit.\n"
read choice
case $choice in
[1])
deps
;;
[2])
av1an
cleanup
;;
[3])
aom
cleanup
;;
[4)
ffmpeg
cleanup
;;
[5])
vmaf
cleanup
;;
[6])
sudo -v
deps
av1an
aom
ffmpeg
vmaf
cleanup
;;
[7])
cleanup
;;
[8])
exit
clear
echo "Script terminated."
;;
*)
echo "Invalid option, try again."
echo "Script terminated."
esac
}

main
