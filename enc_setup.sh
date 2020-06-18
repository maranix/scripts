#!/bin/bash
set -e
sudo apt-get install cmake git perl nasm meson python3-opencv libsm6 python3 python3-pip python3-setuptools python3-wheel 
sudo pip3 install Av1an
git -C aom pull 2> /dev/null || git clone --depth 1 https://aomedia.googlesource.com/aom
mkdir -p aom_build
wget https://johnvansickle.com/ffmpeg/builds/ffmpeg-git-amd64-static.tar.xz
tar -xvf *.xz && rm -rf *.xz && mv ffmpeg* ffmpeg && cd ffmpeg && sudo cp ffmpeg ffprobe /usr/bin && sudo cp -r model /usr/local/share
cd ..
rm -rf ffmpeg*
cd aom_build
cmake ../aom
make -j16
sudo make install && cd ..
rm -rf aom_build
git -C vmaf pull 2> /dev/null || git clone --depth 1 https://github.com/Netflix/vmaf
cd vmaf/libvmaf
meson build --buildtype release
ninja -vC build
sudo ninja -vC build install
cd ../..
rm -rf vmaf aom