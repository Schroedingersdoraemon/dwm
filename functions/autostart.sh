#!/bin/bash

~/scripts/backgrounds/backgrounds.sh &
#$HOME/.local/bin/anime_wall.sh > /dev/null 2>&1 &

dwmblocks &

picom &
flameshot &
nm-applet &

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

dunst -config ~/.config/dunst/dunstrc_dracula &

sxhkd &
