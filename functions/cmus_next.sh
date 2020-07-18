#!/bin/sh
RUN="$(pgrep -x cmus|wc -l)"

case $RUN in
    0)
        ;;
    1) cmus-remote --next
        ;;
esac
