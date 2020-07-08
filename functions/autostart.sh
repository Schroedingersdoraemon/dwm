run="$(pgrep autostart_pros.sh|wc -l)"
pro="$(pgrep autostart_pros)"
case $run in
    0)
        ~/prog/dwm/functions/autostart_pros.sh
        ;;
    1)
        kill $pro
        ~/prog/dwm/functions/autostart_pros.sh
        ;;
esac
