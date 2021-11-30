#!/usr/bin/env zsh

autoload -U compinit; compinit


#--------#
# EXPORT #
#--------#

export TERM="xterm-256color"                      # getting proper colors
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
export EDITOR="vim"
export VISUAL="emacsclient -c -a emacs"


#---------#
# OPTIONS #
# --------#

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

alias dts='/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME'

# vim & emacs
# vim and emacs
alias vim="vim"
alias em="/usr/bin/emacs -nw"
alias emacs="emacsclient -c -a 'emacs'"
alias doomsync="~/.emacs.d/bin/doom sync"
alias doomdoctor="~/.emacs.d/bin/doom doctor"
alias doomupgrade="~/.emacs.d/bin/doom upgrade"
alias doompurge="~/.emacs.d/bin/doom purge"

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

pfetch
