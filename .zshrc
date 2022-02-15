#!/usr/bin/env zsh

autoload -U compinit; compinit

#--------#
# EXPORT #
#--------#

export TERM="xterm-256color"                      # getting proper colors
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
export EDITOR="vim"
export VISUAL="emacsclient -c -a emacs"
export SHELL="zsh"

# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# pfetch
export PF_INFO="ascii title os kernel shell uptime pkgs memory"
export PF_COL1="4"
export PF_COL2="5"
export PF_COL3="3"

#---------#
# OPTIONS #
# --------#

# Enable vi mode
bindkey -v

# Navigation
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_SILENT
setopt CORRECT
setopt CDABLE_VARS
setopt EXTENDED_GLOB
setopt PROMPT_SUBST 

unsetopt BEEP

# History
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY


#---------#
# ALIASES #
#---------#

alias dts='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# vim & emacs
# vim and emacs
alias vim="nvim"
alias em="/usr/bin/emacs -nw"
alias emacs="emacsclient -c -a 'emacs'"

# Doom Emacs
alias doomsync="$HOME/.emacs.d/bin/doom sync"
alias doomupgrade="$HOME/.emacs.d/bin/doom upgrade"
alias doomdoctor="$HOME/.emacs.d/bin/doom doctor"
alias doompurge="$HOME/.emacs.d/bin/doom purge"
alias doomclean="$HOME/.emacs.d/bin/doom clean"
alias doombuild="$HOME/.emacs.d/bin/doom build"

# Changing "ls" to "exa"
alias ls='exa -al --color=always --group-directories-first' # my preferred listing
alias la='exa -a --color=always --group-directories-first'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first'  # long format
alias lt='exa -aT --color=always --group-directories-first' # tree listing

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'


#---------#
# PLUGINS #
# --------#

# antibody
alias abdate="antibody bundle < ~/.config/zsh/zsh_plugins.txt > ~/.config/zsh/zsh_plugins.sh"
source $HOME/.config/zsh/zsh_plugins.sh


#------#
# PATH #
#------#

export PATH="$HOME/.local/bin:$PATH"


#---------#
# AUTORUN #
# --------#

# set colors with pywal
(cat ~/.cache/wal/sequences &)
source ~/.cache/wal/colors-tty.sh # tty support

neofetch
eval "$(starship init zsh)"

