#!/usr/bin/env sh
# This script setup auto completion

# Enables miniconda if exist
MINICONDA_PATH=$HOME/miniconda3/etc/profile.d/conda.sh
test -f $MINICONDA_PATH && source $MINICONDA_PATH


# Enables micromamba
# Please use it along with nix https://github.com/brucechanjianle/micromamba
export MAMBA_EXE='/nix/store/qgmx5z2bd6i3q0vpz4qgipajf5wdwnf8-micromamba-1.5.8/bin/micromamba';

# Only init if micromamba exist
if [ -x "$MAMBA_EXE" ]; then
  # !! Contents within this block are managed by 'mamba init' !!
  export MAMBA_ROOT_PREFIX="$HOME/micromamba";
  # export MAMBA_ROOT_PREFIX="$HOME/reference/lightweight-fine-tuning-foundation-model.git/master/.micromamba";
  __mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
  if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
  else
    alias micromamba="$MAMBA_EXE"  # Fallback on help from mamba activate
  fi
  unset __mamba_setup
  # <<< mamba initialize <<<
fi

# Enables pixi tab completion if exist
if command -v pixi >/dev/null 2>&1; then
  eval "$(pixi completion --shell zsh)"
fi
