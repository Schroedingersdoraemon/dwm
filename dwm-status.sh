#!/bin/bash
# Screenshot: http://s.natalian.org/2013-08-17/dwm_status.png
# Network speed stuff stolen from http://linuxclues.blogspot.sg/2009/11/shell-script-show-network-speed.html

# This function parses /proc/net/dev file searching for a line containing $interface data.
# Within that line, the first and ninth numbers after ':' are respectively the received and transmited bytes.
function get_bytes {
	# Find active network interface
	interface=$(ip route get 8.8.8.8 2>/dev/null| awk '{print $5}')
	line=$(grep $interface /proc/net/dev | cut -d ':' -f 2 | awk '{print "received_bytes="$1, "transmitted_bytes="$9}')
	eval $line
	now=$(date +%s%N)
}

# Function which calculates the speed using actual and old byte number.
# Speed is shown in KByte per second when greater or equal than 1 KByte per second.
# This function should be called each second.

function get_velocity {
	value=$1
	old_value=$2
	now=$3

	timediff=$(($now - $old_time))
	velKB=$(echo "1000000000*($value-$old_value)/1024/$timediff" | bc)
	if test "$velKB" -gt 1024
	then
		echo $(echo "scale=2; $velKB/1024" | bc)mb/s
	else
		echo ${velKB}kb/s
	fi
}

print_temp(){
	test -f /sys/class/thermal/thermal_zone0/temp || return 0
	echo $(head -c 2 /sys/class/thermal/thermal_zone0/temp)C
}

show_record(){
	test -f /tmp/r2d2 || return
	rp=$(cat /tmp/r2d2 | awk '{print $2}')
	size=$(du -h $rp | awk '{print $1}')
	echo " $size $(basename $rp)"
}


LOC=$(readlink -f "$0")
DIR=$(dirname "$LOC")
export IDENTIFIER="unicode"

#. "$DIR/functions/dwm_transmission.sh"
. "$DIR/functions/dwm_cmus.sh"
. "$DIR/functions/dwm_resources.sh"
. "$DIR/functions/dwm_battery.sh"
#. "$DIR/functions/dwm_mail.sh"
#. "$DIR/functions/dwm_backlight.sh"
. "$DIR/functions/dwm_alsa.sh"
. "$DIR/functions/dwm_weather.sh"
#. "$DIR/functions/dwm_pulse.sh"
#. "$DIR/functions/dwm_jeather.sh"
#. "$DIR/functions/dwm_vpn.sh"
#. "$DIR/functions/dwm_network.sh"
#. "$DIR/functions/dwm_keyboard.sh"
#. "$DIR/functions/dwm_ccurse.sh"
. "$DIR/functions/dwm_date.sh"

# for temporary status show
xsetroot -name "$(dwm_cmus) 💿 $(dwm_resources) [🌏 ⬇️ 0kb/s ⬆️ 0kb/s] $(dwm_alsa) [$(dwm_battery)] $(dwm_date)"

#EXIT=$(pgrep -x wpa_supplicant|wc -l)
#if [ $EXIT -eq 0 ]; then
#    WEATHER=$(dwm_weather)
##    sleep 13
#fi

while true
do
    ping -c 1 www.baidu.com > /dev/null 2>&1
    if [ $? -eq 0 ];then
        xsetroot -name "Retriving Weather Data..."
        WEATHER=$(dwm_weather)
        sleep 1
        break
    else
        sleep 2
    fi
done


while true
do
    # Get initial values
    get_bytes
    old_received_bytes=$received_bytes
    old_transmitted_bytes=$transmitted_bytes
    old_time=$now

    get_bytes
    # Calculates speeds
    vel_recv=$(get_velocity $received_bytes $old_received_bytes $now)
    vel_trans=$(get_velocity $transmitted_bytes $old_transmitted_bytes $now)

    xsetroot -name "$(dwm_cmus) 💿 $(dwm_resources) [🌏 ⬇️$vel_recv ⬆️$vel_trans] $(dwm_alsa) [$(dwm_battery)] $(dwm_date) $WEATHER"

    sleep 1

done
