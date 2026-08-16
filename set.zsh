#!/usr/bin/env sh

# Basic auto/tab complete:
# Completion functions (see auto-completion.zsh). This must come BEFORE compinit
[ -d "$ZDOTDIR/completions" ] && fpath=("$ZDOTDIR/completions" $fpath)

autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist

# Our own dump. Needed on Debian/Ubuntu, where /etc/zsh/zshrc runs compinit
# before this file and writes $ZDOTDIR/.zcompdump without completions/ on fpath,
# hiding ours. Harmless elsewhere (macOS has no global compinit).
# (Alternative: skip_global_compinit=1 in ~/.zshenv, but that is outside this repo.)
_zcompdump=$ZDOTDIR/.zcompdump-user

# Rebuild if missing, >1 day old, or older than completions/.
# Traps: glob needs an array; zsh -nt is false when the target is missing.
_zcompdump_stale=( $_zcompdump(N.mh+24) )
if [[ ! -f $_zcompdump ]] \
  || (( $#_zcompdump_stale )) \
  || [[ -d $ZDOTDIR/completions && $ZDOTDIR/completions -nt $_zcompdump ]]; then
  compinit -d $_zcompdump
  touch $_zcompdump
else
  compinit -C -d $_zcompdump
fi
unset _zcompdump _zcompdump_stale

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
    source "$BASE16_SHELL/profile_helper.sh" && \
      export BASE16_THEME=gruvbox-dark-medium
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
