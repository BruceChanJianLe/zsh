# ZSHELL

## Installing plugin manager
Install zap, the minimal zsh plugin manager.

```
git clone https://github.com/zap-zsh/zap # Step1
./install.zsh --branch release-v1        # Step2
```

## Setting Default Shell

```
chsh -s $(which zsh)
```

## Create History File
```
mkdir ~/.cache/zsh
cd ~/.cache/zsh/
touch history
```

## ZSH Configuration Files

File | Login | Interactive | Non-interactive
--- | --- | --- | ---
/etc/zshenv | X | X | X
~/.zshenv | X | X | X 
/etc/zprofile | X* | | 
~/.zprofile | X* | | |
/etc/zshrc | | X* | |
~/.zshrc | | X* | |
/etc/zlogin | X* | | |
~/.zlogin | X* | | |

* if the NO_RCS option is not set

Summary:
- Global changes (for every shell session) go in one of the zshenv files
- Put customizations for user-level Interactive shells in ~/.zshrc
  - This file can be synced or shared

## Prerequisite

Ensure that zsh and fzf are installed.

## Wildcard

As zsh takes wildcard differently from bash, use the following when you want zsh to pass the wildcard to the command instead of expanding it.

```sh
sudo apt install network-manager-pptp\*
```

## Issues

Some known issues with git bare repos, starting from zsh version 5.8.
zsh will output undesirable `fatal: this operation must be run in a work tree`.
To resolve this, please edit the file in this path.
```
sudo -e vi /usr/share/zsh/functions/VCS_Info/Backends/VCS_INFO_get_data_git
# Edit line: 141
gitbase=$( ${vcs_comm[cmd]} rev-parse --show-toplevel 2> /dev/null )
```
Or follow this link: https://github.com/spaceship-prompt/spaceship-prompt/discussions/1003

ref: https://askubuntu.com/questions/335210/apt-get-wildcard-with-zsh
