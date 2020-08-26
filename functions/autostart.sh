#!/bin/bash

~/scripts/backgrounds/backgrounds.sh &
~/prog/dwm/dwm_status.sh &

picom &
mate-power-manager &
flameshot &
plank &
volumeicon &

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
