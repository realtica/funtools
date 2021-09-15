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
#Now i3-gaps should be installed.

## Configuring
#To enable gaps you need to set some variables in your i3 config.
#gaps inner <# of pixels>
#gaps outer <# of pixels>
#Add this to get rid of titlebars because gaps doen't work with titlebars:
#for_window [class="^.*"] border pixel 2
#Refresh i3 and you're good to go!
