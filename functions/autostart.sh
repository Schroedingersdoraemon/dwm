#!/bin/bash

~/scripts/backgrounds/backgrounds.sh &
dwmblocks &

picom &
flameshot &
nm-applet &

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

dunst -config ~/.config/dunst/dunstrc_dracula &

sxhkd &
