#!/bin/sh

picom &
/usr/bin/emacs --daemon &
nitrogen --restore &

