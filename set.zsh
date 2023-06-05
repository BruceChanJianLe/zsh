#!/bin/sh

# Basic auto/tab complete:
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit

# Include hidden files.
_comp_options+=(globdots)

# Vim style menu select
# ref: https://thevaluable.dev/zsh-install-configure-mouseless/
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect '^y' accept-line
bindkey -M menuselect '^l' accept-line
bindkey -M menuselect '^e' send-break

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

# Disable paste highlight
zle_highlight=('paste:none')

# Beeping is annoying
unsetopt BEEP

# Completion for aliases
unsetopt complete_aliases

# Display the completion menu after two use of the `TAB` key.
setopt AUTO_MENU

zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

