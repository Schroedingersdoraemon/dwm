#!/bin/sh

RUN="$(pgrep -x screenkey|wc -l)"
ID="$(pgrep -x screenkey)"
case $RUN in
    0)
        notify-send -t 1000 'Screenkey started'
        screenkey
        ;;
    1)
        notify-send -t 1000 'Screenkey killed'
        kill $ID
        ;;
esac
