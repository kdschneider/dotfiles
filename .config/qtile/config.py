import os
import re
import socket
import subprocess
from libqtile import qtile
from libqtile.config import Click, Drag, Group, ScratchPad, DropDown, KeyChord, Key, Match, Screen
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
  Key([mod], "e", lazy.spawn("emacsclient -c -a 'emacs'"), desc='Launch Emacs'),
  
  # Rofi 
  Key([mod, "shift"], "Return", lazy.spawn("rofi -show run")),
  KeyChord([mod], "p", [
    Key([], "p", lazy.spawn("rofi -show run"))
  ]),

  # ScratchPads
  Key([mod], "t", lazy.group['scratchpad'].dropdown_toggle('terminal'))
]

# Workspaces/Groups
groups = [
  Group(
    name = "home", 
    layout = "monadtall", 
    label = "\uf004",
    position = 1
  ), 
  Group(
    name = "www", 
    layout = "monadtall", 
    label = "\uf0c2",
    position = 2,
    matches = [
      Match(wm_class = "brave-browser"),
      Match(wm_class = "qutebrowser")
    ]
  ), 
  Group(
    name = "code", 
    layout = "monadtall", 
    label = "\ufb8a",
    position = 3,
    matches = [
      Match(wm_class = "emacs")
    ]
  ), 
  Group(
    name = "terminal",
    layout = "monadtall",
    label = "\ue795",
    position = 4,
  ),
  Group(
    name = "social", 
    layout = "monadtall", 
    label = "\uf1d8",
    position = 5,
    matches = [
      Match(wm_class = "discord"),
      Match(wm_class = "telegram-desktop")
    ]
  ),
  Group(
    name = "steam",
    layout = "monadtall",
    label = "\uf11b",
    init = False,
    persist = False,
    position = 6,
    matches = [
      Match(wm_class = "Steam")
    ]
  ),

  Group(
    name = "csgo",
    layout = "full",
    label = "\ufc01",
    init = False,
    persist = False,
    position = 7,
    matches = [
      Match(wm_class = "csgo_linux64")
    ]
  ),

  Group(
    name = "zoom",
    layout = "full",
    label = "\ufcac",
    init = False,
    persist = False,
    position = 8,
    matches = [
      Match(wm_class = "zoom")
    ]
  ),
  
  Group(
    name = "settings",
    layout = "monadtall",
    label = "\uf013",
    init = False,
    persist = False,
    position = 9,
    matches = [
      Match(wm_class = "qBittorrent"),
      Match(wm_class = "org.gnome.DejaDup")
    ]
  ),

  # Scratchpads
#  ScratchPad(
#    name = "scratchpad",
#    position = 10,
#    dropdowns = [
#      DropDown(
#        name = "terminal", 
#        cmd = "alacritty",
#        height = 0.5,
#        width = 0.5,
#        x = 0.25,
#        y = 0
#      )
#    ]
#  )
]
# Allow MODKEY+[0 through 9] to bind to groups, see https://docs.qtile.org/en/stable/manual/config/groups.html
# MOD4 + index Number : Switch to Group[index]
# MOD4 + shift + index Number : Send active window to another Group
from libqtile.dgroups import simple_key_binder
dgroups_key_binder = simple_key_binder(mod)

#for i in range(1,6):
#  keys.append(Key([mod], i.name, lazy.group[i.name].toscreen()))
#  keys.append(Key([mod, "shift"], i.name, lazy.window.togroup(i.name), lazy.group[i.name].toscreen()))

layout_theme = {
  "border_width": 2,
  "margin": 15,
  "border_focus": colors[7],
  "border_normal": colors[0],
}

layouts = [
    layout.Zoomy(**layout_theme),
    layout.MonadTall(**layout_theme),
    layout.Max(**layout_theme),
]


# Screens
from libqtile.config import Screen
from libqtile import bar, widget

prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())

widget_defaults = dict(
  font = "FiraCode Nerd Font Mono",
  fontsize = 15, 
  padding = 3,
  background = colors[0],
  foreground = colors[7]
)

# screens
screens = [
  Screen(
    top = bar.Bar(
      
      # Widgets
      widgets = [
        
        widget.Spacer(length = 12),
        
        # Groups
        widget.GroupBox(
            active = colors[7]
          , block_highlight_text_color = colors[3]
          , disable_drag = True
          , highlight_color = [colors[0], colors[0]]
          , highlight_method = "line"
          , inactive = colors[7]
          , this_current_screen_border = colors[7]
          , fontsize = 20
          , padding = 10
        ),
        
        #widget.Spacer(length = 15),
        #widget.CurrentLayout(),
        #widget.Spacer(length = 15),
        #widget.WindowCount(),
        #widget.Spacer(length = 15),
        #widget.WindowName(),

        widget.Spacer(),

        widget.Cmus(
          noplay_color = colors[3],
          play_color = colors[7]
        ),

        widget.Spacer(),
        
        # Updates Widget
        widget.CheckUpdates(
          colour_have_updates = colors[7],
          colour_no_updates = colors[7],
          display_format = "{updates}",
          mouse_callbacks = {
            #"Button1": lambda: qtile.cmd_spawn("qtile run-cmd -g scratchpad -f alacritty")
            "Button1": lambda: qtile.cmd_spawn("alacritty -e yay")
          },
          update_interval = 60,
          distro = "Arch_yay"
        ),

        # Updates Widget
        widget.CheckUpdates(
          colour_have_updates = colors[7],
          colour_no_updates = colors[7],
          display_format = "\uf062",
          mouse_callbacks = {
            #"Button1": lambda: qtile.cmd_spawn("qtile run-cmd -g scratchpad -f alacritty")
            "Button1": lambda: qtile.cmd_spawn("alacritty -e yay")
          },
          update_interval = 60,
          distro = "Arch_yay",
          fontsize = 22
        ),

        widget.Spacer(length = 15),
        
        # SysTray
        widget.WidgetBox(
          widgets = [
            widget.Systray(),
            widget.Spacer(15)
          ],
          fontsize = 22,
          text_closed = "\uf6d7",
          text_open = "\ufcc1",
          close_button_location = "right",
          padding = 15
        ),
        widget.Spacer(length = 15),

        # Volume
        widget.Volume(
          volume_app = "pavucontrol"
        ),
        
        widget.TextBox(
          text = "\uf025",
          fontsize = 22 
        ),
       
        widget.Spacer(length = 15),

        # Clock
        widget.Clock(
          format = "%H:%M",
          mouse_callbacks = {
            "Button1": lambda: qtile.cmd_spawn(
              "sh" + " " + os.path.expanduser(
                "~/.config/qtile/scripts/set_gruv_dark.sh"
              )
            ),
            "Button2": lambda: qtile.cmd_spawn(
              "sh" + " " + os.path.expanduser(
                "~/.config/qtile/scripts/set_random_wallpaper.sh"
              )
            ),
            "Button3": lambda: qtile.cmd_spawn(
              "sh" + " " + os.path.expanduser(
                "~/.config/qtile/scripts/set_gruv_light.sh"
              )
            )
          }
        ),

        widget.Spacer(length = 12)
      ],

      # General Settings
      foreground = colors[5],
      background = colors[0], 
      border_color = colors[2],
      border_width = 0,
      margin = [0, 0, 0, 0],
      opacity = 1,
      size = 35 
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
follow_mouse_focus = True 
bring_front_click = True
cursor_warp = False

# Floating
floating_layout = layout.Floating(
  float_rules=[
    Match(title = "Settings"),
    # Run the utility of `xprop` to see the wm class and name of an X client.
    # default_float_rules include: utility, notification, toolbar, splash, dialog,
    # file_progress, confirm, download and error.
    *layout.Floating.default_float_rules,
    Match(title='Confirmation'),      # tastyworks exit box
    Match(title='Qalculate!'),        # qalculate-gtk
    Match(wm_class='kdenlive'),       # kdenlive
    Match(wm_class='pinentry-gtk-2'), # GPG key password entry
  ],
  **layout_theme
)
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
