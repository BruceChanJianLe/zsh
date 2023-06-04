#!/bin/sh

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
