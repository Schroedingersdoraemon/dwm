#!/bin/sh

# A dwm_bar function to read the battery level and status
# Joe Standring <git@joestandring.com>
# GNU GPLv3

get_time() {
    echo $(acpi -b | awk '{print $5}')
#
#	# parses acpitool's battery info for the remaining charge of all batteries and sums them up
#	sum_remaining_charge=$(acpitool -B | grep -E 'Remaining capacity' | awk '{print $4}' | grep -Eo "[0-9]+" | paste -sd+ | bc);
#
#	# finds the rate at which the batteries being drained at
#	present_rate=$(acpitool -B | grep -E 'Present rate' | awk '{print $4}' | grep -Eo "[0-9]+" | paste -sd+ | bc);
#
#	# divides current charge by the rate at which it's falling, then converts it into seconds for `date`
#	seconds=$(bc <<< "scale = 10; ($sum_remaining_charge / $present_rate) * 3600");
#
#	# prettifies the seconds into h:mm:ss format
#	pretty_time=$(date -u -d @${seconds} +%T);
#
#	echo $pretty_time;
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



dwm_battery(){

#	if $(acpi -b | grep --quiet Discharging)
#    then
#	    echo "$(get_battery_charging_status) $(get_battery_combined_percent)%";
#    else
        if $(acpi -b|grep --quiet 100)
        then
	        echo "$(get_battery_charging_status) $(get_battery_combined_percent)%";
        else
            if $(acpi -b|grep --quiet Discharging)
            then
                echo "$(get_battery_charging_status) $(get_battery_combined_percent)%, $(get_time)";
            else
	            echo "⚡ $(get_battery_charging_status) $(get_battery_combined_percent)% $(get_time)";
            fi
        fi
	#fi

}

#dwm_battery () {
#    CAPACITY=$(cat /sys/class/power_supply/BAT0/capacity)
#    STATUS=$(cat /sys/class/power_supply/BAT0/status)
#    # online 1 = charging, online 0 = Discharging
#    AC=$(cat /sys/class/power_supply/AC/online)
#
#    printf "%s" "$SEP1"
#    if [ "$IDENTIFIER" = "unicode" ]; then
#        if [ "$AC" = "0" ]; then
#            printf "🔋 %s%%" "$CAPACITY"
#        fi
#        
#        if [ "$AC" = "1" && "$CAPACITY" != "100" ]
#            printf "⚡🔌 %s%%" "$CAPACITY"
#        elif[ "$AC" = "1" && "$CAPACITY" = "100" ]
#            printf "🔌 %s%%" "$CAPACITY"
#            break
#        fi
#    else
#        printf "BAT %s%% %s" "$CAPACITY"
#    fi
#    printf "%s\n" "$SEP2"
#}

dwm_battery
#print_bat
