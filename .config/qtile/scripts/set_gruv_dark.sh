#!/bin/bash

WALLPAPER="$HOME/pictures/wallpapers/gruvbox/"
COLORS="base16-gruvbox-medium"

wal -i $WALLPAPER                 # set wallpaper
wal -f $COLORS                    # set colors

# copy wallpaper for lightdm
WALLPAPER_CACHE=$(cat "$HOME"/.cache/wal/wal)
cp "$WALLPAPER_CACHE" "/usr/share/wallpapers/wal"

# apply to programs
pywal-discord
cp $HOME/.cache/wal/colors-apple-music.css $HOME/.config/AppleMusic/themes/burple.css

# restart qtile
qtile shell --command "restart()"
