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
        eval "$("$BASE16_SHELL/profile_helper.sh")"

# Disable paste highlight
zle_highlight=('paste:none')

# Beeping is annoying
unsetopt BEEP

# Completion for aliases
unsetopt complete_aliases

# Insert completion on first tab even if ambiguous
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate _prefix
setopt menu_complete
