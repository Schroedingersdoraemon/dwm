Self maintained dwm with some nice patches. For dwm status bar functions, cd functions (Thanks joestandring for most functions. )

<br>

### 1. Prerequisites

- For **Ubuntu** users, you may executate as below
```linux
sudo apt install libx11-dev libxft-dev libxinerama-dev libx11-xcb-dev libxcb-res0-dev
```
to install these packages:

    1. libx11-dev       X11 client-side library
    2. libxft-dev       FreeType-based font drawing library for X
    3. libxinerama-dev  X11 Xinerama extension library
    4. libx11-xcb-dev   Xlib/XCB interface library
    5. libxcb-res0-dev  X C Binding, res extension

<br>

- For **Arch** users, please execute:
```bash
sudo pacman -S libxft libxinerama
```

    1. libxft           FreeType-based font drawing library for X
    2. libxinerama      X11 Xinerama extension library
Optional:
```bash
sudo pacman -S xclip nerd-fonts-source-code-pro ttf-joypixels alsa-utils polkit-gnome flameshot network-manager-applet
```
    1. xclip                          for emoji selecting script
    2. nerd-fonts-source-code-pro     dwm font
    3. ttf-joypixels                  emoji support
    4. alsa-utils                     media key binding
    5. polkit-gome                    legacy polkit authentication agent
    6. picom                          X compositor
    7. flameshot                      screenshot
    8. network-manager-applet         applet for nm

<br>

### 2. Installation

Edit config.mk to match your local setup (dwm is installed into
the /usr/local namespace by default).

Afterwards enter the following command to build and install dwm

    # make clean install

<br>


### 3. Replenishment

Things you **must** modify in configuration

- #### config.h
    -       *termcmd[]  = { "st", NULL };
            // your preferred terminal emulator, default is st.
            For my personal st, please visit https://github.com/Schroedingersdoraemon/st
    -       *scratchpadcmd[] = { "st", "-t", scratchpadname, "-g", "80x25", NULL };
            // scratchpad terminal
    -       *emojicmd[] = { "/home/dylan/prog/dwm/functions/emoji.sh" };
            // change the path of the emoji script
    -       *dmenudesktopcmd[] = { "/home/dylan/prog/dwm/functions/desktop.sh" };
            // change the path of the desktoprun script

- #### dwm.c
    -       void runAutostart(void) {
	            system("~/prog/dwm/functions/autostart.sh &");
            }
            //the path of your autostart script

- #### for emoji support, please install [libxft-bgra](https://github.com/uditkarode/libxft-bgra), which is already in [AUR](https://aur.archlinux.org)
