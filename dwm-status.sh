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


#print_volume() {
#	volume="$(amixer get Master | tail -n1 | sed -r 's/.*\[(.*)%\].*/\1/')"
#	if test "$volume" -gt 0
#	then
#		echo -e "\uE05D${volume}"
#	else
#		echo -e "Mute"
#	fi
#}

print_mem(){
    # Used and total memory
    MEMUSED=$(free -h | awk '(NR == 2) {print $3}')
    MEMTOT=$(free -h |awk '(NR == 2) {print $2}')

    if [ "$IDENTIFIER" = "unicode" ]; then
        #printf "💻 MEM %s/%s CPU %s STO %s/%s: %s" "$MEMUSED" "$MEMTOT" "$CPU" "$STOUSED" "$STOTOT" "$STOPER"
        #printf "💻 %s/%s" "$MEMUSED" "$MEMTOT"
        printf "%s/%s" "$MEMUSED" "$MEMTOT"
    else
        #printf "STA | MEM %s/%s CPU %s STO %s/%s: %s" "$MEMUSED" "$MEMTOT" "$CPU" "$STOUSED" "$STOTOT" "$STOPER"
        #printf "STA | %s/%s" "$MEMUSED" "$MEMTOT"
        printf "%s/%s" "$MEMUSED" "$MEMTOT"
    fi

	memfree=$(($(grep -m1 'MemAvailable:' /proc/meminfo | awk '{print $2}') / 1024))
	#echo -e "$memfree"
}

print_temp(){
	test -f /sys/class/thermal/thermal_zone0/temp || return 0
	echo $(head -c 2 /sys/class/thermal/thermal_zone0/temp)C
}

#!/bin/bash

get_time_until_charged() {

	# parses acpitool's battery info for the remaining charge of all batteries and sums them up
	sum_remaining_charge=$(acpitool -B | grep -E 'Remaining capacity' | awk '{print $4}' | grep -Eo "[0-9]+" | paste -sd+ | bc);

	# finds the rate at which the batteries being drained at
	present_rate=$(acpitool -B | grep -E 'Present rate' | awk '{print $4}' | grep -Eo "[0-9]+" | paste -sd+ | bc);

	# divides current charge by the rate at which it's falling, then converts it into seconds for `date`
	seconds=$(bc <<< "scale = 10; ($sum_remaining_charge / $present_rate) * 3600");

	# prettifies the seconds into h:mm:ss format
	pretty_time=$(date -u -d @${seconds} +%T);

	echo $pretty_time;
}

get_battery_combined_percent() {

	# get charge of all batteries, combine them
	total_charge=$(expr $(acpi -b | awk '{print $4}' | grep -Eo "[0-9]+" | paste -sd+ | bc));

	# get amount of batteries in the device
	battery_number=$(acpi -b | wc -l);

	percent=$(expr $total_charge / $battery_number);

	echo $percent;
}

get_battery_charging_status() {

	if $(acpi -b | grep --quiet Discharging)
	then
		echo "🔋";
	else # acpi can give Unknown or Charging if charging, https://unix.stackexchange.com/questions/203741/lenovo-t440s-battery-status-unknown-but-charging
		echo "🔌";
	fi
}



print_bat(){
	#hash acpi || return 0
	#onl="$(grep "on-line" <(acpi -V))"
	#charge="$(awk '{ sum += $1 } END { print sum }' /sys/class/power_supply/BAT*/capacity)%"
	#if test -z "$onl"
	#then
		## suspend when we close the lid
		##systemctl --user stop inhibit-lid-sleep-on-battery.service
		#echo -e "${charge}"
	#else
		## On mains! no need to suspend
		##systemctl --user start inhibit-lid-sleep-on-battery.service
		#echo -e "${charge}"
	#fi
	#echo "$(get_battery_charging_status) $(get_battery_combined_percent)%, $(get_time_until_charged )";
	#echo "$(get_battery_charging_status) $(get_battery_combined_percent)%";

	if $(acpi -b | grep --quiet Discharging)
    then
	    echo "$(get_battery_charging_status) $(get_battery_combined_percent)%";
    else
        if $(acpi -b|grep --quiet 100)
        then
	        echo "$(get_battery_charging_status) $(get_battery_combined_percent)%";
        else
	        echo "⚡ $(get_battery_charging_status) $(get_battery_combined_percent)%, $(get_time_until_charged )";
        fi
	fi
}

print_date(){
    printf "%s" "$SEP1"
    if [ "$IDENTIFIER" = "unicode" ]; then
        printf "📆 %s" "$(date "+%m-%d %T %a")"
        #printf "📆 %s" "$(date "+%y-%m-%d %T %a")"
    else
        printf "DAT %s" "$(date "+%m-%d %T %a")"
        #printf "DAT %s" "$(date "+%y-%m-%d %T %a")"
    fi
    printf "%s\n" "$SEP2"
	#date '+%Y-%m-%d %H:%M'
    #date '%y-%m-%d %T +%a'
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
#. "$DIR/functions/dwm_cmus.sh"
#. "$DIR/functions/dwm_resources.sh"
#. "$DIR/functions/dwm_battery.sh"
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



#dwm_weather() {
#    LOCATION=baoji
#
#    printf "%s" "$SEP1"
#    if [ "$IDENTIFIER" = "unicode" ]; then
#        printf "%s" "$(curl -s wttr.in/$LOCATION?format=1)"
#    else
#        printf "WEA %s" "$(curl -s wttr.in/$LOCATION?format=1 | grep -o "[0-9].*")"
#    fi
#    printf "%s\n" "$SEP2"
#}



#xsetroot -name "💿 $(print_mem)  [🌐🌏 ⬇️$vel_recv ⬆️$vel_trans]  $(dwm_alsa)  [$(print_bat)]  📆 $(print_date) "
#xsetroot -name "💿 $(print_mem)  [🌏 ⬇️$vel_recv ⬆️$vel_trans]  $(dwm_alsa)  [$(print_bat)]  📆 $(print_date) [$(dwm_weather)]"
#xsetroot -name "💿 $(dwm_resources)  [🌏 ⬇️$vel_recv ⬆️$vel_trans]  $(dwm_alsa)  [$(print_bat)]  $(dwm_date)  [$(dwm_weather)]"

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
    
    xsetroot -name "💿 $(print_mem)  [🌏 ⬇️$vel_recv ⬆️$vel_trans]  $(dwm_alsa)  [$(print_bat)]  $(print_date)  $(dwm_weather)"

    sleep 1

done
