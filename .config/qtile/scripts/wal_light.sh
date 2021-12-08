#!/bin/sh

wal -i ~/.config/wallpapers/ -l --iterative     # set wallpaper
qtile shell --command "restart()"               # restart qtile
