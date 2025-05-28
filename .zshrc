# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

# zmodload zsh/zprof # Uncomment for profiling

# Local setup
plug $ZDOTDIR/set.zsh
plug $ZDOTDIR/remap.zsh
plug $ZDOTDIR/prompt.zsh
plug $ZDOTDIR/aliases.zsh
plug $HOME/.bash_aliases

# Plugin list
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "brucechanjianle/fzf-tab"
plug "brucechanjianle/zsh-copybuffer"
plug "brucechanjianle/fzf-file-source"
plug "Tarrasch/zsh-autoenv"
# plug "brucechanjianle/zsh-vim"

# Local plugin setup
plug $ZDOTDIR/zsh-autosuggestions.zsh
plug $ZDOTDIR/fzf-tab.zsh

# zprof # Uncomment for profiling

# ohtoware
export CC="/usr/lib/ccache/gcc"
export CXX="/usr/lib/ccache/g++"
export CCACHE_DIR="$HOME/.cache/ccache/"
export PATH=/usr/local/cuda/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
