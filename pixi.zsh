#!/usr/bin/env sh
# This script enables pixi tab completion if exist

if command -v pixi >/dev/null 2>&1; then
  eval "$(pixi completion --shell zsh)"
fi
