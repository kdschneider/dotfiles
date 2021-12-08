import os
import re
import socket
import subprocess
from libqtile import qtile
from libqtile.config import Click, Drag, Group, KeyChord, Key, Match, Screen
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from typing import List  # noqa: F401from typing import List  # noqa: F401

mod = "mod1"              # Sets mod key to SUPER/WINDOWS
myTerm = "alacritty"      # My terminal of choice
myBrowser = "brave" # My terminal of choice

# Set Colors with pywal
colors = []
cache = os.path.expanduser('~/.cache/wal/colors')
def load_colors(cache):
    with open(cache, 'r') as file:
        for i in range(8):
            colors.append(file.readline().strip())
    colors.append('#ffffff')
    lazy.reload()
load_colors(cache)


# Keys
keys = [

  ### The essentials
  Key([mod], "Return", lazy.spawn(myTerm), desc='Launches My Terminal'),
  Key([mod, "shift"], "Return", lazy.spawn("dmenu_run -p 'Run: '"), desc='Run Launcher'),
  Key([mod], "b", lazy.spawn(myBrowser), desc='Launch Browser'),
  Key([mod], "Tab", lazy.next_layout(), desc='Toggle through layouts'),
  Key([mod, "shift"], "c", lazy.window.kill(), desc='Kill active window'),
  Key([mod, "shift"], "r", lazy.restart(), desc='Restart Qtile'),
  Key([mod, "shift"], "q", lazy.shutdown(), desc='Shutdown Qtile'),
  Key(["control", "shift"], "e", lazy.spawn("emacsclient -c -a emacs"), desc='Doom Emacs'),

  ### Switch focus to specific monitor (out of three)
  Key([mod], "w", lazy.to_screen(0), desc='Keyboard focus to monitor 1'),
  Key([mod], "e", lazy.to_screen(1), desc='Keyboard focus to monitor 2'),
  Key([mod], "r", lazy.to_screen(2), desc='Keyboard focus to monitor 3'),

  ### Switch focus of monitors
  Key([mod], "period", lazy.next_screen(), desc='Move focus to next monitor'),
  Key([mod], "comma", lazy.prev_screen(), desc='Move focus to prev monitor'),

  ### Window controls
  Key([mod], "j", lazy.layout.down(), desc='Move focus down in current stack pane'),
  Key([mod], "k", lazy.layout.up(), desc='Move focus up in current stack pane'),
  Key([mod, "shift"], "j", lazy.layout.shuffle_down(), lazy.layout.section_down(),desc='Move windows down in current stack'),
  Key([mod, "shift"], "k", lazy.layout.shuffle_up(), lazy.layout.section_up(),desc='Move windows up in current stack'),
  Key([mod], "h", lazy.layout.shrink(), lazy.layout.decrease_nmaster(),desc='Shrink window (MonadTall), decrease number in master pane (Tile)'),
  Key([mod], "l", lazy.layout.grow(), lazy.layout.increase_nmaster(),desc='Expand window (MonadTall), increase number in master pane (Tile)'),
  Key([mod], "n", lazy.layout.normalize(), desc='normalize window size ratios'),
  Key([mod], "m", lazy.layout.maximize(), desc='toggle window between minimum and maximum sizes'),
  Key([mod, "shift"], "f", lazy.window.toggle_floating(), desc='toggle floating'),
  Key([mod], "f", lazy.window.toggle_fullscreen(), desc='toggle fullscreen'),

  ### Stack controls
  Key([mod, "shift"], "Tab", lazy.layout.rotate(), lazy.layout.flip(),desc='Switch which side main pane occupies (XmonadTall)'),
  Key([mod], "space", lazy.layout.next(), desc='Switch window focus to other pane(s) of stack'),
  Key([mod, "shift"], "space", lazy.layout.toggle_split(), desc='Toggle between split and unsplit sides of stack'),
  
  ### Emacs
  KeyChord(["control"],"e", [
    Key([], "e", lazy.spawn("emacsclient -c -a 'emacs'"), desc='Launch Emacs'),
    Key([], "b", lazy.spawn("emacsclient -c -a 'emacs' --eval '(ibuffer)'"), desc='Launch ibuffer inside Emacs'),
    Key([], "d", lazy.spawn("emacsclient -c -a 'emacs' --eval '(dired nil)'"), desc='Launch dired inside Emacs'),
    Key([], "i", lazy.spawn("emacsclient -c -a 'emacs' --eval '(erc)'"), desc='Launch erc inside Emacs'),
    Key([], "m", lazy.spawn("emacsclient -c -a 'emacs' --eval '(mu4e)'"), desc='Launch mu4e inside Emacs'),
    Key([], "n", lazy.spawn("emacsclient -c -a 'emacs' --eval '(elfeed)'"), desc='Launch elfeed inside Emacs'),
    Key([], "s", lazy.spawn("emacsclient -c -a 'emacs' --eval '(eshell)'"), desc='Launch the eshell inside Emacs'),
    Key([], "v", lazy.spawn("emacsclient -c -a 'emacs' --eval '(+vterm/here nil)'"), desc='Launch vterm inside Emacs')
  ]),
  
  # Rofi 
  Key([mod, "shift"], "Return", lazy.spawn("rofi -show run")),
  KeyChord([mod], "p", [
    Key([], "e", lazy.spawn("./dmscripts/dm-confedit"), desc='Choose a config file to edit'),
    Key([], "i", lazy.spawn("./dmscripts/dm-maim"), desc='Take screenshots via dmenu'),
    Key([], "k", lazy.spawn("./dmscripts/dm-kill"), desc='Kill processes via dmenu'),
    Key([], "l", lazy.spawn("./dmscripts/dm-logout"), desc='A logout menu'),
    Key([], "m", lazy.spawn("./dmscripts/dm-man"), desc='Search manpages in dmenu'),
    Key([], "o", lazy.spawn("./dmscripts/dm-bookman"), desc='Search your qutebrowser bookmarks and quickmarks'),
    Key([], "r", lazy.spawn("./dmscripts/dm-reddit"), desc='Search reddit via dmenu'),
    Key([], "s", lazy.spawn("./dmscripts/dm-websearch"), desc='Search various search engines via dmenu'),
    Key([], "p", lazy.spawn("passmenu"), desc='Retrieve passwords with dmenu')
  ])
]

# Workspaces/Groups
groups = [
    Group(" 1 ", layout='monadtall')
  , Group(" 2 ", layout='monadtall')
  , Group(" 3 ", layout='monadtall')
  , Group(" 4 ", layout='monadtall')
  , Group(" 5 ", layout='monadtall')
]

# Allow MODKEY+[0 through 9] to bind to groups, see https://docs.qtile.org/en/stable/manual/config/groups.html
# MOD4 + index Number : Switch to Group[index]
# MOD4 + shift + index Number : Send active window to another Group
from libqtile.dgroups import simple_key_binder
dgroups_key_binder = simple_key_binder(mod)

layout_theme = {
  "border_width": 2,
  "margin": 15,
  "border_focus": colors[6],
  "border_normal": colors[7]
}

layouts = [
    #layout.MonadWide(**layout_theme),
    #layout.Bsp(**layout_theme),
    #layout.Stack(stacks=2, **layout_theme),
    #layout.Columns(**layout_theme),
    #layout.RatioTile(**layout_theme),
    #layout.Tile(shift_windows=True, **layout_theme),
    #layout.VerticalTile(**layout_theme),
    #layout.Matrix(**layout_theme),
    #layout.Zoomy(**layout_theme),
    layout.MonadTall(**layout_theme),
    layout.Max(**layout_theme),
    #layout.Stack(num_stacks=2),
    #layout.RatioTile(**layout_theme),
    #layout.TreeTab(
    #     font = "Ubuntu",
    #     fontsize = 10,
    #     sections = ["FIRST", "SECOND", "THIRD", "FOURTH"],
    #     section_fontsize = 10,
    #     border_width = 2,
    #     bg_color = "1c1f24",
    #     active_bg = "c678dd",
    #     active_fg = "000000",
    #     inactive_bg = "a9a1e1",
    #     inactive_fg = "1c1f24",
    #     padding_left = 0,
    #     padding_x = 0,
    #     padding_y = 5,
    #     section_top = 10,
    #     section_bottom = 20,
    #     level_shift = 8,
    #     vspace = 3,
    #     panel_width = 200
    #     ),
    #layout.Floating(**layout_theme)
]


#colors = [["#282c34", "#282c34"], # panel background
#          ["#3d3f4b", "#434758"], # background for current screen tab
#          ["#ffffff", "#ffffff"], # font color for group names
#          ["#ff5555", "#ff5555"], # border line color for current tab
#          ["#74438f", "#74438f"], # border line color for 'other tabs' and color for 'odd widgets'
#          ["#4f76c7", "#4f76c7"], # color for the 'even widgets'
#          ["#e1acff", "#e1acff"], # window name
#          ["#ecbbfb", "#ecbbfb"]] # backbround for inactive screens

prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())

# Screens
from libqtile.config import Screen
from libqtile import bar, widget

# widget colors
widget_foreground = colors[7]

# My Widgets
mySeperator = widget.Sep(
  linewidth = 0,
  padding = 8,
)

mySystemIcon = widget.Image(
  background = colors[0],
  filename = "~/.config/qtile/icons/python-white.png",
  margin = 3,
  mouse_callbacks = {
    "Button1": lambda: qtile.cmd_spawn("sh" + " " + os.path.expanduser("~/.config/qtile/scripts/wal_dark.sh")),
    "Button3": lambda: qtile.cmd_spawn("sh" + " " + os.path.expanduser("~/.config/qtile/scripts/wal_light.sh"))
  }
)

myGroups = widget.GroupBox(
  this_current_screen_border = widget_foreground,
  active = widget_foreground,
  inactive = colors[4],
  disable_drag = True,
  highlight_method = "line",
  highlight_color = [colors[0], colors[0]]
)

myCurrentLayoutIcon = widget.CurrentLayoutIcon(
  custom_icon_paths = [os.path.expanduser("~/.config/qtile/icons")],
  padding = 0,
  scale = 0.7
)

myCurrentLayout = widget.CurrentLayout(
  padding = 5
)

myClock = widget.Clock(
  foreground = widget_foreground,
  format = "%A, %B %d - %H:%M"
)

mySpacer = widget.Spacer(
  length = bar.STRETCH
)

myVolume = widget.Volume(
  volume_app = "pavucontrol",
  foreground = widget_foreground 
)

myTray = widget.Systray()

myMusic = widget.Cmus()

# screens
screens = [
  Screen(
    top = bar.Bar(
      
      # Widgets
      widgets = [

        mySeperator,
        mySystemIcon,
        mySeperator,

        myGroups,  
        
        mySpacer,
        myMusic,

        myTray,
        mySeperator,
        widget.TextBox(
          text = "|",
          foreground = widget_foreground
        ),
        mySeperator,

        myVolume,
        myCurrentLayoutIcon,
        mySeperator,
        myClock,
        
        mySeperator
      ],

      # General Settings
      foreground = colors[5],
      background = colors[0], 
      border_color = colors[2],
      border_width = 0,
      margin = [10, 15, 0, 15],
      opacity = 1,
      size = 30
    )
  )
]

# Mouse
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_app_rules = []  # type: List
follow_mouse_focus = False 
bring_front_click = True
cursor_warp = False

# Floating
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    # default_float_rules include: utility, notification, toolbar, splash, dialog,
    # file_progress, confirm, download and error.
    *layout.Floating.default_float_rules,
    Match(title='Confirmation'),      # tastyworks exit box
    Match(title='Qalculate!'),        # qalculate-gtk
    Match(wm_class='kdenlive'),       # kdenlive
    Match(wm_class='pinentry-gtk-2'), # GPG key password entry
])
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.run([home])

# Change wm name for java
wmname = "LG3D"
