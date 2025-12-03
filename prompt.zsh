#!/bin/zsh

autoload -Uz vcs_info
autoload -U colors && colors

zstyle ':vcs_info:*' enable git 

precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst


zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
# https://stackoverflow.com/questions/49744179/zsh-vcs-info-how-to-indicate-if-there-are-untracked-files-in-git
+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        hook_com[staged]+='!' # signify new files with a bang
    fi
}

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats "%B%{$fg[magenta]%}(%{$fg[red]%}%m%u%c%{$fg[magenta]%}%b%{$fg[magenta]%})%{$reset_color%}"

# Bash like prompt
PROMPT="%B%{$fg[green]%}%n"

# Get Ubuntu Version
if [ -x "$(command -v lsb_release)" ]; then
  ubuntu_version=$(echo "$(lsb_release -rs) / 1" | bc)
  if [[ $ubuntu_version == 0 ]]; then
    PROMPT+="%{$fg[cyan]%}"󰣇
  else
    PROMPT+="%{$fg[cyan]%}U"$ubuntu_version
  fi
fi

# Show podman
if [[ -n "$IN_PODMAN" && "$IN_PODMAN" == "1" ]]; then
  PROMPT+=🦭
fi

# Show docker
if [[ -n "$IN_DOCKER" && "$IN_DOCKER" == "1" ]]; then
  PROMPT+=🐳
fi

# Show nix
if [[ -n "$IN_NIX_SHELL" && "$IN_NIX_SHELL" != "pure" ]]; then
  PROMPT+=❄️
fi

# Show pixi (part 1)
if [[ -n "$PIXI_IN_SHELL" && "$PIXI_IN_SHELL" == "1" ]]; then
  PROMPT+=🤖
fi

PROMPT+="%{$fg[green]%}@%m%{$reset_color%}:%B%{$fg[blue]%}%~%{$reset_color%}"

PROMPT+="\$vcs_info_msg_0_%# "
RPROMPT=%T

# Show pixi (part 2)
if [[ -n "$IN_PIXI" && "$IN_PIXI" == "1" ]]; then
  PROMPT="%B%{$fg[yellow]%}${CONDA_DEFAULT_ENV:+($CONDA_DEFAULT_ENV)}"$PROMPT
fi
