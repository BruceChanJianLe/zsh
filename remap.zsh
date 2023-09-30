#!/bin/sh

# Issues with missing default bindkey
source $ZDOTDIR/default_bindkeys.zsh

# Vim style menu select
# ref: https://thevaluable.dev/zsh-install-configure-mouselessk
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect '^y' accept-line
bindkey -M menuselect '^l' accept-line
bindkey -M menuselect '^e' send-break
bindkey -s '^f' "tmux-sessionizer\n"
bindkey -s '^j' "hyperjump\r"

# Get current prompt text
# Can use this plugin in the future https://github.com/guillaumeboehm/zsh-copybuffer
# get_prompt_text() {
#   if which xclip &>/dev/null; then
#     echo $BUFFER | xargs echo -n | xclip -selection clipboard
#   else
#     echo "xclip is not found. Please make sure you have installed xclip."
#   fi
# }
#
# zle -N get_prompt_text
#
# bindkey '^g' get_prompt_text

# FZF
# bindkey '^R' fzf-history-widget


# ./ for executables
# function dotcomplete() {
#   if [[ $BUFFER =~ ^'\.'$ ]]; then
#     BUFFER='./'
#     CURSOR=2
#     zle list-choices
#   else
#     zle expand-or-complete
#   fi
# }
#
# bindkey '^I' dotcomplete
# zle -N dotcomplete
