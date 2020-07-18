Self maintained dwm with some nice patches. For dwm status bar functions, cd functions (Thanks joestandring for most functions. )

<br>

### 1. Requirements

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

- For **Arch** users, please commit an issue to remind me of supplying dependencies.

<br>

### 2. Installation

Edit config.mk to match your local setup (dwm is installed into
the /usr/local namespace by default).

Afterwards enter the following command to build and install dwm

    # make clean install

<br>

### 3. Replenishment


Edit `config.h` and `dwm.c` to enable dwm and dwm-status function correctly.

