#!/bin/bash

WALLPAPER="$HOME/pictures/wallpapers/gruvbox/"
COLORS="base16-gruvbox-soft"

wal -i $WALLPAPER --backend wal   # set wallpaper
wal -f $COLORS -l                 # set colors

# copy wallpaper for lightdm
FILEPATH=$(cat "$HOME"/.cache/wal/wal)
cp "$FILEPATH" "/usr/share/wallpapers/wal"

# apply to programs
pywal-discord

# restart qtile
qtile shell --command "restart()"
