#!/usr/bin/env sh
# This script enables micromamba
# Please use it along with nix https://github.com/brucechanjianle/micromamba

export MAMBA_EXE='/nix/store/qgmx5z2bd6i3q0vpz4qgipajf5wdwnf8-micromamba-1.5.8/bin/micromamba';

# Only init if micromamba exist
if [ -x "$MAMBA_EXE" ]; then
  # !! Contents within this block are managed by 'mamba init' !!
  export MAMBA_ROOT_PREFIX="$HOME/micromamba";
  __mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
  if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
  else
    alias micromamba="$MAMBA_EXE"  # Fallback on help from mamba activate
  fi
  unset __mamba_setup
  # <<< mamba initialize <<<
fi
