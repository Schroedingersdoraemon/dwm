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

### 3. Customization

**Bold fonts** indicate the need of modification

Patches added:

- alpha
    - allow dwm to have translucent effect
    u
- **autostart**
    - open your dwm.c
    - find autostart function
    - to run a script at startup as below:
    ```shell
    void
    runAutostart(void) {
        system("cd path/to/your/script; ./autostart.sh &");
    }
    ```
- awesomebar
    - changes the taskbar to be more like awesome
- aspectresize
    - resize the window with its aspect retio remain constant
    - **Note** only works in supporting layout like *NULL*
- columns
    - like tilling mode but no gaps
- fullscreen(abandoned on 2020-08-29)
    - apply the monocle layout
    - hide the bar
    - current client goes fullscreen
- actualfullscr(applied on 2020-08-29)
    - toggle the current client to actual fullscreen
- hide vacant tags
    - prevents dwm from drawing tags with no clients
- moveresize
    - to resize current client with arrow keys
- noborder
    - forgot to write, never mind
- pertag
    - keeps layout, mwfact, barpos and nmaster per tag
- view on tag
    - before patch:
        - move a client to tag 2
        - return back to tag1
    - after:
        - move a client to tag 2
        - stay there
- rotatestack
    - stack rotation moves a client from the bottom to the top of the stack
- scratchpad
    - spawn or restore a floating terminal window, useful to do some temprory typing
- systray
    - system tray implementation

- switch to tag
    - switch to a certain tag when a certain program is opened

### 4. Replenishment
Things you need to modify in configuration
- config.h
    - fonts[] = { "**FONT TO USE**:size=**SIZE**" }
    - dmenufont [] = { "**FONT TO USE**:size=**SIZE**" }
        - delete if you don't use dmenu
    - dmenucmd[] = { "dmenu_run", NULL };
    - termcmd[]  = { "**YOUR TERMINAL EMULATOR**", NULL };
    - roficmd[]  = { "rofi", "-show", "run", NULL };
        - delete if you don't use rofi
    - scrshotcmd[] = {"flameshot", "full", "-p", "**PATH/TO/SCREENSHOTS**", NULL};
    - scrshotselectcmd[] = {"flameshot", "gui", NULL};
        - install flameshot
    - upvol[]   = { "**PATH/TO/SCRIPT**",  NULL };
    - downvol[] = { "**PATH/TO/SCRIPT**",  NULL };
    - mutevol[] = { "**PATH/TO/SCRIPT**",  NULL };
        - the three scripts can be found in repo: **dwm**/functions
    - cmustoggle [] = {}
    - cmusnext[] = {}
    - cmusprev[] = {}
        - delete the threem *cmus* script if you do not use cmus
    - lockscreencmd = { "**COMMAND TO LOCK SCREEN**" }
    - Key keys[] = {}
        - just modify shortcuts as you like

- dwm.c
    - autostart
    ```c
    void
    runAutostart(void) {
        system("cd PATH/TO/DWM/FUNCTIONS; ./autostart.sh &");
        //pertinent function can be found in my github
        //Schroedingersdoraemon/dwm/functions
    }
    ```
