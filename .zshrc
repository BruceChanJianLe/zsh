# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

# Local setup
plug $ZDOTDIR/set.zsh
plug $ZDOTDIR/remap.zsh
plug $ZDOTDIR/prompt.zsh
plug $ZDOTDIR/aliases.zsh
plug $HOME/.bash_aliases
plug $ZDOTDIR/miniconda.zsh

# Plugin list
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "brucechanjianle/fzf-tab"
plug "brucechanjianle/zsh-copybuffer"
plug "brucechanjianle/fzf-file-source"
# plug "brucechanjianle/zsh-vim"

# Local plugin setup
plug $ZDOTDIR/zsh-autosuggestions.zsh
plug $ZDOTDIR/fzf-tab.zsh
