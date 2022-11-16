# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Enable colors and change prompt:
autoload -U colors && colors

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

autoload -U compinit && compinit -u
zstyle ':completion:*' menu select
# Auto complete with case insenstivity
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zmodload zsh/complist
compinit
bindkey -e
# export KEYTIMEOUT=1

# Enable searching through history
bindkey '^R' history-incremental-pattern-search-backward

### bindkey -M menuselect 'h' vi-backward-char
### bindkey -M menuselect 'k' vi-up-line-or-history
### bindkey -M menuselect 'l' vi-forward-char
### bindkey -M menuselect 'j' vi-down-line-or-history
### bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
### function zle-keymap-select {
###   if [[ ${KEYMAP} == vicmd ]] ||
###      [[ $1 = 'block' ]]; then
###     echo -ne '\e[1 q'
###   elif [[ ${KEYMAP} == main ]] ||
###        [[ ${KEYMAP} == viins ]] ||
###        [[ ${KEYMAP} = '' ]] ||
###        [[ $1 = 'beam' ]]; then
###     echo -ne '\e[5 q'
###   fi
### }
### zle -N zle-keymap-select
### zle-line-init() {
###     zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
###     echo -ne "\e[5 q"
### }
### zle -N zle-line-init
### echo -ne '\e[5 q' # Use beam shape cursor on startup.
### preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
# Not supported in the "fish" shell.
# (cat ~/.cache/wal/sequences &)

# Alternative (blocks terminal for 0-3ms)
# cat ~/.cache/wal/sequences

# To add support for TTYs this line can be optionally added.
# source ~/.cache/wal/colors-tty.sh

# Prompt
eval "$(starship init zsh)"

source $HOME/.config/zsh/alias
source $HOME/.zprofile

