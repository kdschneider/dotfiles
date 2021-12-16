#!/bin/sh

WALDIR="$HOME/pictures/wallpapers/"

wal -i $WALDIR --backend wal 

FILEPATH=$(cat "$HOME"/.cache/wal/wal)
cp "$FILEPATH" "/usr/share/wallpapers/wal"

pywal-discord
qtile shell --command "restart()"               # restart qtile
