#!/bin/sh
choices="Anaconda Navigator\nQQ\nWeChat\nBaiduNetdisk\nGentoo\nShutdownGentoo"

chosen=$(echo -e $choices | dmenu -p "Enter the application：")

#For special characters, use '\' to transform
case $chosen in
    QQ)
        env LANG=zh_CN.UTF-8 WINEDEBUG=-all,+fps wine "/home/dylan/.wine/drive_c/Program Files/Tencent/QQ/Bin/QQ.exe" ;;
    WeChat)
        env LANG=zh_CN.UTF-8 WINEDEBUG=-all,+fps wine "/home/dylan/.wine/drive_c/Program Files/Tencent/WeChat/WeChat.exe" ;;
    BaiduNetdisk)
        /usr/lib/baidunetdisk/baidunetdisk --no-sandbox %U ;;
    Pamac\ Manager)
        env LANG=zh_CN.UTF-8 pamac-manager;;
    Anaconda\ Navigator)
        /opt/anaconda/bin/anaconda-navigator ;;
    Gentoo)
        vboxmanage startvm gentoo ;;
    ShutdownGentoo)
        kill $(pidof VirtualBoxVM) ;;
esac
