#!/usr/bin/env sh

# Keybindings
bindkey '^y' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
HISTSIZE=10000
SAVEHIST=$HISTSIZE # Save history same as history size
HISTFILE=~/.cache/zsh/history
HISTDUP=erase # Erase any duplicates in history

setopt appendhistory # Appends history behind rather than over-writting
# setopt sharehistory # Shares history with all other shells
setopt hist_ignore_space # Add a space before your command to avoid being save to hist
setopt hist_ignore_all_dups # Ignore all duplicates in history
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups # Prevent duplicates being shown in search
