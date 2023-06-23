#!/bin/sh

# Basic auto/tab complete:
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit

# Include hidden files.
_comp_options+=(globdots)

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
   [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
       source "$BASE16_SHELL/profile_helper.sh"

# Disable paste highlight
zle_highlight=('paste:none')

# Beeping is annoying
unsetopt BEEP

# Completion for aliases
unsetopt complete_aliases

# Display the completion menu after two use of the `TAB` key.
setopt AUTO_MENU

# Define completers
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

