#!/usr/bin/env sh
# This script stores aliases that are frequently used.

# Common
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'

# nix-darwin
alias nd='sudo darwin-rebuild switch --flake $HOME/.config/nix-darwin#$USER'
alias ndb='darwin-rebuild build --flake $HOME/.config/nix-darwin#$USER'
alias ndl='sudo darwin-rebuild --list-generations'
alias ndr='sudo darwin-rebuild rollback'
alias ndu='nix flake update --flake $HOME/.config/nix-darwin'

# Directory
# alias -g ...='../..'
# alias -g ....='../../..'
