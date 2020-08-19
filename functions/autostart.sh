#!/bin/bash

~/scripts/backgrounds/backgrounds.sh &
~/prog/dwm/dwm_status.sh &

picom &
mate-power-manager &
flameshot &
#birdtray &
#qv2ray &
#sleep 2
plank &
volumeicon &

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
