#!/usr/bin/env bash
# This script will install zsh and zap

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

usage() {
  cat <<EOF
  Usage: $(basename "${BASH_SOURCE[0]}") [-h] [-r] [-s]
  Script description here.
  Available options:
  -h, --help          Print this help and exit
  -a, --auto          Set true to auto select the last branch in the list (WARN) may not be a release branch
  -s, --setdefault    Set zsh as default branch
EOF
exit
}

setup_colors() {
  if [[ -t 2 ]] && [[ -z "${NO_COLOR-}" ]] && [[ "${TERM-}" != "dumb" ]]; then
    NOFORMAT='\033[0m' RED='\033[0;31m' GREEN='\033[0;32m' ORANGE='\033[0;33m' BLUE='\033[0;34m' PURPLE='\033[0;35m' CYAN='\033[0;36m' YELLOW='\033[1;33m'
  else
    NOFORMAT='' RED='' GREEN='' ORANGE='' BLUE='' PURPLE='' CYAN='' YELLOW=''
  fi
}

msg() {
  echo >&2 -e "${1-}"
}

die() {
  local msg=$1
  local code=${2-1} # default exit status 1
  msg "$msg"
  exit "$code"
}

parse_params() {
  # default values of variables set from params
  AUTO_SELECT="false"
  SET_DEFAULT_SHELL="false"
  ZAP_DIR="$HOME/reference/zap.git"

  while test $# -gt 0; do
    case $1 in
      -h | --help) usage ;;
      -a | --auto)
        shift
        if [[ $1 == "true" || $1 == "false" ]]
        then
          AUTO_SELECT=$1
        else
          die "-a only accepts true or false."
        fi
        ;;
      -s | --setdefault)
        shift
        if [[ $1 == "true" || $1 == "false" ]]
        then
          SET_DEFAULT_SHELL=$1
        else
          die "-s only accepts true or false."
        fi
        ;;
      -?*) die "Unknown option: $1" ;;
      *) break ;;
    esac
    shift
  done

  return 0
}

parse_params "$@"
setup_colors 

# Get current dir path
CURRENT_DIR="$(pwd)"

# Install zsh
sudo apt install zsh zsh-syntax-highlighting zsh-syntax-highlighting -y -qq

# Create history dir
if [ ! -d "$HOME/.cache/zsh" ]
then
  mkdir $HOME/.cache/zsh
  touch $HOME/.cache/zsh/history
else
  touch $HOME/.cache/zsh/history
fi

# Install zap (zsh plugin manager)
echo "Installing zap..."
# Checks if neovim directory already exists
if [ ! -d "$ZAP_DIR" ]
then
  mkdir -p $HOME/reference
  cd $HOME/reference
  git clone --bare https://github.com/zap-zsh/zap.git
  cd $ZAP_DIR
  git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
  git fetch
else
  cd $ZAP_DIR
  git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
  git fetch
fi

# Checkout/update master branch
if [ ! -d master ]
then
  git worktree add master master
  cd master
else
  cd master
  git pull origin master
fi

if [[ $AUTO_SELECT == "false" ]]
then
  # Display all available branches
  echo "Available releases:"
  declare -a arr
  i=0

    # Make branches name into an array
    branches=$(git for-each-ref refs  --format='%(refname)' | grep origin | cut -d/ -f4)
    for branch in $branches
    do
      arr[$i]=$branch
      let "i+=1"
    done

    # Loop through name array
    let "i-=1"
    for j in $(seq 0 $i)
    do
      echo $j")" ${arr[$j]}
    done

    # Obtain branch name
    read -p "Release version to be used: " BRANCH
    ./install.zsh --branch ${arr[$BRANCH]} --keep
  else
    declare -a arr
    i=0

    # Make branches name into an array
    branches=$(git for-each-ref refs  --format='%(refname)' | grep origin | cut -d/ -f4)
    for branch in $branches
    do
      arr[$i]=$branch
      let "i+=1"
    done
    let "i-=1"

    ./install.zsh --branch ${arr[$i]} --keep
fi

if [[ $SET_DEFAULT_SHELL == "true" ]]
then
  echo "Setting zsh as default shell..."
  chsh -s $(which zsh)
fi

echo -e $GREEN"Successfully installed zsh! Enjoy! :)"$NOFORMAT
