#!/bin/bash

~/scripts/backgrounds/backgrounds.sh > /dev/null 2>&1 &
#$HOME/.local/bin/anime_wall.sh > /dev/null 2>&1 &

dwmblocks > /dev/null 2>&1 &

picom > /dev/null 2>&1 &
flameshot > /dev/null 2>&1 &
nm-applet > /dev/null 2>&1 &

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 > /dev/null 2>&1 &

 /usr/lib/polkit-kde-authentication-agent-1 > /dev/null 2>&1  
#/usr/bin/polkit-dumb-agent > /dev/null 2>&1

dunst -config ~/.config/dunst/dunstrc_dracula > /dev/null 2>&1 &

sxhkd > /dev/null 2>&1 &
