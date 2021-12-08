#!/bin/sh

wal -i ~/.config/wallpapers/ --iterative        # set wallpaper
qtile shell --command "restart()"               # restart qtile
