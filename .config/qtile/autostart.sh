#!/bin/sh

# first thing: start VPN!
mullvad-vpn &

# visuals
picom &
wal -R &
feh --bg-tile "$(< "${HOME}/.cache/wal/wal")"

# start emacs as a daemon (performance!)
/usr/bin/emacs --daemon &

