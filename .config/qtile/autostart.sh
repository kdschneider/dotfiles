#!/bin/sh

picom &
/usr/bin/emacs --daemon &
wal -R
