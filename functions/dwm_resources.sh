#!/bin/sh

# A dwm_bar function to display information regarding system memory, CPU temperature, and storage
# Joe Standring <git@joestandring.com>
# GNU GPLv3

dwm_resources () {
    # Used and total memory
    MEMUSED=$(free -h | awk '(NR == 2) {print $3}')
    MEMTOT=$(free -h |awk '(NR == 2) {print $2}')
    # CPU temperature
    #CPU=$(sysctl -n hw.sensors.cpu0.temp0 | cut -d. -f1)

    if [ "$IDENTIFIER" = "unicode" ]; then
        printf "%s/%s" "$MEMUSED" "$MEMTOT"
    else
        printf "%s/%s" "$MEMUSED" "$MEMTOT"
    fi

	#memfree=$(($(grep -m1 'MemAvailable:' /proc/meminfo | awk '{print $2}') / 1024))
    #echo -e "$memfree"
}

dwm_resources
