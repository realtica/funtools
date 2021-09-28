#!/bin/bash

echo '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
echo 'Installing i3-gaps'
echo 'Installing ninja build system'

sudo apt-get install meson ninja-build
echo '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
## Dependencies
echo 'i3-gaps has some packages that are required for it to work so install these things'
sudo apt install dh-autoreconf libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev libxcb-shape0 libxcb-shape0-dev
echo '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++'
echo 'gaps also needs to be installed from source so run these commands:'
git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps
mkdir -p build && cd build
meson ..
ninja
sudo ninja install
echo "put 'exec i3' over .xinitrc then run with 'startx'"

echo "installing bumblebee-status and it's dependencies."
pip3 install --user bumblebee-status
#CPU
pip3 install psutil
#Title
pip3 install i3ipc
#system
sudo apt install python3-tk

