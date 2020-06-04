RUN="$(pgrep -x screenkey|wc -l)"
ID="$(pgrep -x screenkey)"
case $RUN in
    0)
        screenkey
        ;;
    1)
        kill $ID
        ;;
esac
