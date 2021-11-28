#!/usr/bin/env zsh

###############################
# EXPORT ENVIRONMENT VARIABLE #
###############################

# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"

# editor
export EDITOR="vim"
export VISUAL="vim"

# zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZPLUGDIR="$XDG_CONFIG_HOME/zsh/plugged"      # Plugin dir
export HISTFILE="$ZDOTDIR/zhistory"                 # History filepath
export HISTSIZE=10000                               # Maximum events for internal history
export SAVEHIST=10000                               # Maximum events in history file

