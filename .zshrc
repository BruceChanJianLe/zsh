# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

# Load and initialise completion system
autoload -Uz compinit
compinit

export ZDOTDIR=$HOME/.config/zsh
# Local setup
plug $ZDOTDIR/set.zsh
plug $ZDOTDIR/prompt.zsh
plug $ZDOTDIR/aliases.zsh
plug $HOME/.bash_aliases

# Plugin list
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "Aloxaf/fzf-tab"
# plug "zap-zsh/vim"

plug $ZDOTDIR/remap.zsh
plug $ZDOTDIR/zsh-autosuggestions.zsh
plug $ZDOTDIR/fzf-tab.zsh
