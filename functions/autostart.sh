#!/bin/bash

~/scripts/backgrounds/backgrounds.sh &
#~/prog/dwm/dwm_status.sh &
dwmblocks &

picom &
flameshot &
nm-applet &

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
