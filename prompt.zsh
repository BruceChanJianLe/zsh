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
if [ "$(lsb_release -rs)" = "18.04" ]; then
  PROMPT="%B%{$fg[green]%}%n%{$fg[cyan]%}U18🐳%{$fg[green]%}%m%{$reset_color%}:%B%{$fg[blue]%}%~%{$reset_color%}"
elif [ "$(lsb_release -rs)" = "20.04" ]; then 
  PROMPT="%B%{$fg[green]%}%n%{$fg[cyan]%}U20🐳%{$fg[green]%}%m%{$reset_color%}:%B%{$fg[blue]%}%~%{$reset_color%}"
else
  # UU for undefine
  PROMPT="%B%{$fg[green]%}%n%{$fg[cyan]%}UU🐳%{$fg[green]%}%m%{$reset_color%}:%B%{$fg[blue]%}%~%{$reset_color%}"
fi

PROMPT+="\$vcs_info_msg_0_%# "
RPROMPT=%T
