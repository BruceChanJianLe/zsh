# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

export ZSHDIR=$HOME/.config/zsh
# Local setup
plug $ZSHDIR/set.zsh
plug $ZSHDIR/prompt.zsh
plug $ZSHDIR/aliases.zsh
plug $HOME/.bash_aliases

# Plugin list
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "brucechanjianle/fzf-tab"
plug "brucechanjianle/zsh-copybuffer"
# plug "zap-zsh/vim"

# Local plugin setup
plug $ZSHDIR/remap.zsh
plug $ZSHDIR/zsh-autosuggestions.zsh
plug $ZSHDIR/fzf-tab.zsh
