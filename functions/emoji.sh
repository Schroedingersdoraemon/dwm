#!/bin/sh

file="/home/dylan/prog/dmenu/emoji.mb"

emoji=$(grep -v "#" "$file" | dmenu -l 20 -fn Monospace-18| awk '{print $2}')

echo $emoji | xclip -selection clipboard
echo $emoji | xclip -selection primary

notify-send "$(xclip -o -selection clipboard) copied to clipboard"
