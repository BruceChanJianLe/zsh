#!/bin/sh

# Basic auto/tab complete:
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist

for dump in $ZDOTDIR/.zcompdump(N.mh+24); do
  compinit
  touch $ZDOTDIR/.zcompdump
done
compinit -C

# Include hidden files.
_comp_options+=(globdots)

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# How to not source base16
# TERMINAL=$(basename "/"$(ps -o cmd -f -p $(cat /proc/$(echo $$)/stat | cut -d \  -f 4) | tail -1 | sed 's/ .*$//'))
# if [[ ! "$TERMINAL" == "python" ]]; then
  # Base16 Shell
  BASE16_SHELL="$HOME/.config/base16-shell/"
  [ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
    source "$BASE16_SHELL/profile_helper.sh"
  base16_gruvbox-dark-medium
  # export BASE16_THEME=gruvbox-dark-medium
# fi

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

# Beautiful colorings for gtest :D
export GTEST_COLOR=1
