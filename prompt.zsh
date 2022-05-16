#!/bin/sh

## autoload vcs and colors
autoload -Uz vcs_info
autoload -U colors && colors

# enable only git 
zstyle ':vcs_info:*' enable git 

# setup a hook that runs before every ptompt. 
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

# add a function to check for untracked files in the directory.
# from https://github.com/zsh-users/zsh/blob/master/Misc/vcs_info-examples
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        # This will show the marker if there are any untracked files in repo.
        # If instead you want to show the marker only if there are untracked
        # files in $PWD, use:
        #[[ -n $(git ls-files --others --exclude-standard) ]] ; then
        hook_com[staged]+='!' # signify new files with a bang
    fi
}

# Notes
# =====
# %s: The current version control system, like git or svn.
# %r: The name of the root directory of the repository
# %S: The current path relative to the repository root directory
# %b: Branch information, like master
# %m: In case of Git, show information about stashes
# %u: Show unstaged changes in the repository
# %c: Show staged changes in the repository
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats " %{$fg[green]%}(%{$fg[red]%}%m%u%c%%{$fg[green]%}%b%{$fg[green]%})"

# format our main prompt for hostname current folder, and permissions.
PROMPT="%B%{$fg[green]%}%n@%m%{$reset_color%}:%B%F{195}%c%{$reset_color%}"
PROMPT+="%B\$vcs_info_msg_0_"
PROMPT+="%{$reset_color%}%(!:#:$) "

# Reference Links:
# https://arjanvandergaag.nl/blog/customize-zsh-prompt-with-vcs-info.html
# https://stevelosh.com/blog/2010/02/my-extravagant-zsh-prompt/
# https://en.wikipedia.org/wiki/ANSI_escape_code
# https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html#Conditional-Substrings-in-Prompts
# https://github.com/zsh-users/zsh/blob/master/Functions/Misc/colors
# https://scriptingosx.com/2019/07/moving-to-zsh-06-customizing-the-zsh-prompt/
