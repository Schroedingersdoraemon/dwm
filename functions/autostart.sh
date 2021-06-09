#!/bin/bash

~/scripts/backgrounds/backgrounds.sh &
dwmblocks &

picom &
flameshot &
nm-applet &
# birdtray &

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
gnome-pie &

dunst &
