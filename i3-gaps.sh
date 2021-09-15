#!/bin/bash

# Installing i3-gaps

## Dependencies
# i3-gaps has some packages that are required for it to work so install these things:
sudo apt install libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf xutils-dev libtool automake
# You also need to install `libxcb-xrm-dev`, but I got `Unable to locate package libxcb-xrm-dev` when trying to install from the apt repositories on Ubuntu 16.04. If this happens to you, just install it from source using these commands:
mkdir tmp
cd tmp
git clone https://github.com/Airblader/xcb-util-xrm
cd xcb-util-xrm
git submodule update --init
./autogen.sh --prefix=/usr
make
sudo make install

## Installing

#gaps also needs to be installed from source so run these commands:
cd tmp
git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps
git checkout gaps && git pull
autoreconf --force --install
rm -rf build
mkdir build
cd build
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make
sudo make install
#Now i3-gaps should be installed.

## Configuring
#To enable gaps you need to set some variables in your i3 config.
#gaps inner <# of pixels>
#gaps outer <# of pixels>
#Add this to get rid of titlebars because gaps doen't work with titlebars:
#for_window [class="^.*"] border pixel 2
#Refresh i3 and you're good to go!
