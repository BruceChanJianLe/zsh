#!/usr/bin/env
# This script will install zsh and zap

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

usage() {
  cat <<EOF
  Usage: $(basename "${BASH_SOURCE[0]}") [-h] [-r] [-d]
  Script description here.
  Available options:
  -h, --help          Print this help and exit
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
  BRANCH=""
  DEPS="true"
  NEOVIM_DIR="$HOME/references/neovim.git"

  while test $# -gt 0; do
    case $1 in
      -h | --help) usage ;;
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

# Install zap (zsh plugin manager)
echo "Installing zap..."
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1 --keep

echo -e $GREEN"Successfully installed zsh! Enjoy! :)"$NOFORMAT

