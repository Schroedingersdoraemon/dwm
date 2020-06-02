#!/bin/bash

/home/dylan/scripts/backgrounds.sh &
/home/dylan/scripts/wifi-auto.sh &
/home/dylan/prog/dwm/dwm-status.sh &

albert &
compton &
optimus-manager-qt &
xfce4-power-manager &
fbrowse-tray -f pcmanfm -t alacritty -m dnd /home/dylan &
gnome-pie &
flameshot &
