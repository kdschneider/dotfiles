#!/bin/sh

WALLPAPER="$HOME/.config/qtile/wallpaper.png"
COLORTHEME="base16-gruvbox-medium"

wal -i $WALLPAPER
wal -f $COLORTHEME

FILEPATH=$(cat "$HOME"/.cache/wal/wal)
cp "$FILEPATH" "/usr/share/wallpapers/wal"

pywal-discor.png
qtile shell --command "restart()"               # restart qtile
