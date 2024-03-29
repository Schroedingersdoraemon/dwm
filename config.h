/* See LICENSE file for copyright and license details. */
#include<X11/XF86keysym.h>

/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int swallowfloating    = 1;        /* 1 means swallow floating windows by default */
static const unsigned int gappih    = 10;       /* horiz inner gap between windows */
static const unsigned int gappiv    = 10;       /* vert inner gap between windows */
static const unsigned int gappoh    = 10;       /* horiz outer gap between windows and screen edge */
static const unsigned int gappov    = 10;       /* vert outer gap between windows and screen edge */

static const int smartgaps          = 1;        /* 1 means no outer gap when there is only one window */

static const unsigned int systraypinning = 0;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayspacing = 0;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const int showsystray        = 1;     /* 0 means no systray */

static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const Bool viewontag         = True;     /* Switch view on tag switch */
static const char *fonts[]          = {
	"SauceCodePro Nerd Font Mono:size=13:antialias=true:autohint=true",
	"LXGW WenKai:size=12:antialias=true:autohint=true",
	"JoyPixels:pixelsize=15:antialias=true:autohint=true"
};

/* old dark scheme
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#343434";
//static const char col_cyan[]        = "#37474F";
*/

static const char col_gray1[]       = "#ffffff";
static const char col_gray2[]       = "#bbbbbb";
static const char col_gray3[]       = "#000000";
static const char col_gray4[]       = "#000000";
static const char col_cyan[]        = "#aaaaaa";

static const unsigned int baralpha = 0xd0;
static const unsigned int borderalpha = OPAQUE;
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
	[SchemeHid]  = { col_cyan,  col_gray1, col_cyan  },
};
static const unsigned int alphas[][3]      = {
	/*               fg      bg        border     */
	[SchemeNorm] = { OPAQUE, baralpha, borderalpha },
	[SchemeSel]  = { OPAQUE, baralpha, borderalpha },
};
static const XPoint stickyicon[]    = { {0,0}, {4,0}, {4,4}, {2,3}, {0,4}, {0,0} }; /* represents the icon as an array of vertices like in grade school math */
static const XPoint stickyiconbb    = {4,4};	/* defines the bottom right corner of the bounding box of the polygon (origin is always 0,0) */
#define STICKYICONSH boxw + (boxw * 6 / 7) 	/* defines the height of the final, scaled polygon as it will be drawn. boxw is equal to the width of the shape */

/* tagging */
//static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };
static const char *tags[] = { "", "", "", "", "", "", "ﳟ", "", "" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class     instance  title           tags mask  switch2tag  isfloating  isterminal  noswallow  monitor */
	{ "Gimp",    NULL,     NULL,           0,         0,             1,          0,           0,        -1 },
	{ "Powerword", 	NULL,     NULL,           0,         0,             1,          0,           0,        -1 },
	{ "Zathura", 	NULL, NULL, 0, 0, 0, 0, 1, -1},
	{ "Pcmanfm",    NULL,   NULL,   0,  0,  1,  0,  0,  -1 },
	{ "Nm-connection-editor",    NULL,   NULL,   0,  0,  1,  0,  0,  -1 },
	{ "Plank",   NULL,     NULL,           1 << 0,    1,             0,          0,          -1,        -1 },
	{ "firefox", NULL,     NULL,           1 << 1,    1,             0,          0,          -1,        -1 },
	{ "Brave",   NULL,     NULL,           1 << 1,    1,             0,          0,          -1,        -1 },
	{ "Surf",    NULL,     NULL,           0,         0,             0,          0,           1,        -1 },
	{ "netease-cloud-music",NULL,NULL,     1 << 3,    1,             1,          0,          -1,        -1 },
	{ "qqmusic",NULL,NULL,     	       1 << 3,    1,             1,          0,          -1,        -1 },
	{ "cmus", NULL, NULL,     	       1 << 3,    1,             0,          0,          -1,        -1 },
	{ "ieaseMusic", NULL, NULL,            1 << 3,    1,             1,          0,          -1,        -1 },
	{ "GoldenDict",  NULL,     NULL,       1 << 4,    1,             0,          0,          -1,        -1 },
	{ "qv2ray",  NULL,     NULL,           1 << 4,    1,             0,          0,          -1,        -1 },
	{ "Thunderbird",NULL,  NULL,           1 << 4,    1,             1,          0,          -1,        -1 },
	{ "SimpleScreenRecorder",NULL, NULL,   1 << 5,    1,             1,          0,          -1,        -1 },
	{ "transmission",NULL, NULL,           1 << 5,    1,             1,          0,          -1,        -1 },
	{ "qBittorrent",NULL, NULL,            1 << 5,    1,             0,          0,          -1,        -1 },
	{ "Steam",NULL, NULL,                  1 << 6,    1,             1,          0,          -1,        -1 },
	{ "baidunetdisk",NULL, NULL,           1 << 7,    1,             1,          0,          -1,        -1 },
	{ "qq.exe",  NULL,     NULL,           1 << 8,    1,             1,          0,          -1,        -1 },
	{ NULL,    "qq.exe",   NULL,           1 << 8,    1,             1,          0,          -1,        -1 },
	{ NULL,   "tim.exe",   NULL,           1 << 8,    1,             1,          0,          -1,        -1 },
	{ "electron-qq", NULL, NULL,           1 << 8,    1,             1,          0,          -1,        -1 },
	{ "icalingua",   NULL, NULL,           1 << 8,    1,             1,          0,          -1,        -1 },
	{ "Cawbird",     NULL, NULL,           1 << 8,    1,             1,          0,          -1,        -1 },
	{ "electronic-wechat",  NULL, NULL,    1 << 8,    1,             1,          0,          -1,        -1 },
	{ "Qq",          NULL, NULL,           1 << 8,    1,             1,          0,          -1,        -1 },
	{ "TelegramDesktop",NULL,NULL,         1 << 8,    1,             1,          0,          -1,        -1 },
	{ "st",      NULL,     NULL,           0,         0,             0,          1,          -1,        -1 },
	{ NULL,      NULL,     "Event Tester", 0,         0,             1,          0,           1,        -1 }, /* xev */
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
	{ "|||",      col },
};

/* Relative Path*/

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char dmenufont[]       = "SauceCodePro Nerd Font Mono:size=15";
static const char *dmenucmd[] = { "dmenu_run" };
//static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", "#37474F", "-sf", col_gray4, NULL };
static const char *termcmd[]  = { "alacritty", NULL };

static const char scratchpadname[] = "scratchpad";
static const char *scratchpadcmd[] = { "st", "-t", scratchpadname, "-g", "80x25", NULL };

static Key keys[] = {
	/* modifier                     key        function        argument */
	{ Mod1Mask,                     XK_d,      spawn,          {.v = dmenucmd } },

	{ MODKEY,                       XK_Return, spawn,          {.v = termcmd } },

	{ MODKEY,                       XK_BackSpace,  togglescratch,  {.v = scratchpadcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },

	{ MODKEY|ShiftMask,             XK_j,      rotatestack,    {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_k,      rotatestack,    {.i = -1 } },

	//{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	//{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	//
	{ MODKEY,                       XK_j,      focusstackvis,  {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstackvis,  {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_j,      focusstackhid,  {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_k,      focusstackhid,  {.i = -1 } },

	{ MODKEY|ControlMask,           XK_s,      show,           {0} },
	{ MODKEY|ControlMask,           XK_h,      hide,           {0} },

	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },

	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },

	{ MODKEY|Mod1Mask,              XK_h,      incrgaps,       {.i = +1 } },
	{ MODKEY|Mod1Mask,              XK_l,      incrgaps,       {.i = -1 } },

	{ MODKEY|Mod1Mask|ShiftMask,    XK_h,      incrogaps,      {.i = +1 } },
	{ MODKEY|Mod1Mask|ShiftMask,    XK_l,      incrogaps,      {.i = -1 } },
	{ MODKEY|Mod1Mask,              XK_y,      incrohgaps,     {.i = +1 } },
	{ MODKEY|Mod1Mask,              XK_o,      incrohgaps,     {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_y,      incrovgaps,     {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_o,      incrovgaps,     {.i = -1 } },

	{ MODKEY|Mod1Mask|ControlMask,  XK_h,      incrigaps,      {.i = +1 } },
	{ MODKEY|Mod1Mask|ControlMask,  XK_l,      incrigaps,      {.i = -1 } },
	{ MODKEY,                       XK_y,      incrihgaps,     {.i = +1 } },
	{ MODKEY,                       XK_o,      incrihgaps,     {.i = -1 } },
	{ MODKEY|ControlMask,           XK_y,      incrivgaps,     {.i = +1 } },
	{ MODKEY|ControlMask,           XK_o,      incrivgaps,     {.i = -1 } },

	{ MODKEY|Mod1Mask,              XK_0,      togglegaps,     {0} },
	{ MODKEY|Mod1Mask|ShiftMask,    XK_0,      defaultgaps,    {0} },

	{ MODKEY|ShiftMask,             XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_q,      killclient,     {0} },

	{ MODKEY|ShiftMask,             XK_j,      aspectresize,   {.i = +24} },
	{ MODKEY|ShiftMask,             XK_k,      aspectresize,   {.i = -24} },

	{ MODKEY,                       XK_s,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_n,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_c,      setlayout,      {.v = &layouts[3]} },

	{ MODKEY,                       XK_f,      togglefullscr,     {0} },
	{ MODKEY|ShiftMask,             XK_space,  setlayout,      {0} },
	{ MODKEY,                       XK_space,  togglefloating, {0} },
	{ MODKEY|ShiftMask,             XK_s,      togglesticky,   {0} },


	{ MODKEY,                       XK_Down,   moveresize,     {.v = "0x 25y 0w 0h" } },
	{ MODKEY,                       XK_Up,     moveresize,     {.v = "0x -25y 0w 0h" } },
	{ MODKEY,                       XK_Right,  moveresize,     {.v = "25x 0y 0w 0h" } },
	{ MODKEY,                       XK_Left,   moveresize,     {.v = "-25x 0y 0w 0h" } },
	{ MODKEY|ControlMask,           XK_Down,   moveresize,     {.v = "0x 0y 0w 25h" } },
	{ MODKEY|ControlMask,           XK_Up,     moveresize,     {.v = "0x 0y 0w -25h" } },
	{ MODKEY|ControlMask,           XK_Right,  moveresize,     {.v = "0x 0y 25w 0h" } },
	{ MODKEY|ControlMask,           XK_Left,   moveresize,     {.v = "0x 0y -25w 0h" } },
	{ MODKEY|ShiftMask,            XK_Up,     moveresizeedge, {.v = "t"} },
	{ MODKEY|ShiftMask,            XK_Down,   moveresizeedge, {.v = "b"} },
	{ MODKEY|ShiftMask,            XK_Left,   moveresizeedge, {.v = "l"} },
	{ MODKEY|ShiftMask,            XK_Right,  moveresizeedge, {.v = "r"} },
	{ MODKEY|ControlMask|ShiftMask, XK_Up,     moveresizeedge, {.v = "T"} },
	{ MODKEY|ControlMask|ShiftMask, XK_Down,   moveresizeedge, {.v = "B"} },
	{ MODKEY|ControlMask|ShiftMask, XK_Left,   moveresizeedge, {.v = "L"} },
	{ MODKEY|ControlMask|ShiftMask, XK_Right,  moveresizeedge, {.v = "R"} },

	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },

	TAGKEYS(                        XK_1,                      0)
		TAGKEYS(                        XK_2,                      1)
		TAGKEYS(                        XK_3,                      2)
		TAGKEYS(                        XK_4,                      3)
		TAGKEYS(                        XK_5,                      4)
		TAGKEYS(                        XK_6,                      5)
		TAGKEYS(                        XK_7,                      6)
		TAGKEYS(                        XK_8,                      7)
		TAGKEYS(                        XK_9,                      8)

		{ MODKEY|ControlMask,           XK_f,      quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	//{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button1,        togglewin,      {0} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button1,        spawn,          SHCMD("kill -35 $(pidof dwmblocks)") },
	{ ClkStatusText,        0,              Button3,        spawn,          SHCMD("kill -36 $(pidof dwmblocks)") },
	{ ClkStatusText,        0,              Button2,        spawn,          SHCMD("kill -37 $(pidof dwmblocks)") },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

