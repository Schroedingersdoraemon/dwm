#!/bin/sh
RUN="$(pgrep -x cmus|wc -l)"
echo $RUN

case $RUN in
    0)
        ;;
    1) cmus-remote --prev
        ;;
esac
