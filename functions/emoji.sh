#!/bin/sh

file="/home/dylan/prog/dmenu/emoji.mb"

emoji=$(grep -v "#" "$file" | dmenu -l 20 -fn SauceCodeProNerdFontMono-18| awk '{print $1}')

echo $emoji | xclip -selection clipboard
#echo $emoji | xclip -selection primary

if [[ $(xclip -o -selection clipboard) != "" ]]; then
	notify-send "$(xclip -o -selection clipboard) copied to clipboard"
fi
