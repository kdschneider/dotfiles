#!/bin/sh

WALDIR="$HOME/.config/wallpapers/"

wal -i $WALDIR --saturate 0.3 --iterative        # set wallpaper

FILEPATH=$(cat "$HOME"/.cache/wal/wal)
cp "$FILEPATH" "/usr/share/wallpapers/wal"

pywal-discord
qtile shell --command "restart()"               # restart qtile
