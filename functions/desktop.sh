choices="QQ\nWeChat\nBaiduNetdisk"

chosen=$(echo -e $choices | dmenu -p "Enter the application：")

case $chosen in
    QQ)
        env LANG=zh_CN.UTF-8 wine "/home/dylan/.wine/drive_c/Program Files (x86)/Tencent/QQ/Bin/QQ.exe" ;;
    WeChat)
        env LANG=zh_CN.UTF-8 wine "/home/dylan/.wine/drive_c/Tencent/WeChat/WeChat.exe" ;;
    BaiduNetdisk)
        /usr/lib/baidunetdisk/baidunetdisk --no-sandbox %U ;;
esac
