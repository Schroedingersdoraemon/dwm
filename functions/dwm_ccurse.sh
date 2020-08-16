#!/bin/sh

# A dwm_bar function to show the closest appointment in calcurse
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Dependencies: calcurse

dwm_ccurse () {
    APTSFILE="$HOME/.calcurse/todo"

    if $(head -n 1 "$APTSFILE"|grep --quiet 1 "$APTSFILE");
    then
        #APPOINTMENT=$(head -n 1 "$APTSFILE" | sed -r 's/\[1\] //')
        APPOINTMENT=$(head -n 1 "$APTSFILE" | awk '{print $2}')
        printf "[💡 %s] " "$APPOINTMENT"
    else
        return 0
    fi

    #if [ "$APPOINTMENT" != "" ]; then
    #    printf "%s" "$SEP1"
    #    if [ "$IDENTIFIER" = "unicode" ]; then
    #        printf "💡 %s" "$APPOINTMENT"
    #    else
    #        printf "APT %s" "$APPOINTMENT"
    #    fi
    #    printf "%s\n" "$SEP2"
    #fi
}

dwm_ccurse
