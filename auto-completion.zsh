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

# Enables pixi if exist
if [ -d "$HOME/.pixi/bin" ]; then
    export PATH="$HOME/.pixi/bin:$PATH"
fi

# ---------------------------------------------------------------------------
# Stored tab completions only load on the first tab, refreshes every 30 days
# ---------------------------------------------------------------------------
COMP_DIR="${ZDOTDIR:-$HOME/.config/zsh}/completions"
COMP_MAX_AGE_DAYS=30

_comp_refresh() {
  local name=$1; shift
  # not installed here - skip
  command -v "$name" >/dev/null 2>&1 || return 0

  [ -d "$COMP_DIR" ] || mkdir -p "$COMP_DIR" || return 0
  local file="$COMP_DIR/_$name"

  # Regenerate only when missing/empty, or older than COMP_MAX_AGE_DAYS.
  local -a stale=( ${file}(N.md+${COMP_MAX_AGE_DAYS}) )
  [[ -s $file && -z $stale ]] && return 0

  # Write via a temp file so an interrupted or failing generator can never
  # leave a truncated completion behind.
  if "$@" > "$file.tmp" 2>/dev/null && [ -s "$file.tmp" ]; then
    mv "$file.tmp" "$file"
  else
    rm -f "$file.tmp"
  fi
}

_comp_refresh pixi  pixi completion --shell zsh
_comp_refresh gh    gh completion -s zsh
_comp_refresh herdr herdr completion zsh

unset -f _comp_refresh

if command -v oc >/dev/null 2>&1; then
  alias occ='source <(oc completion zsh)'
fi
