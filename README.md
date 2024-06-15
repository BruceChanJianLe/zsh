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

1. Git worktree error

Some known issues with git bare repos, starting from zsh version 5.8.
zsh will output undesirable `fatal: this operation must be run in a work tree`.
To resolve this, please edit the file in this path.
```
sudoedit /usr/share/zsh/functions/VCS_Info/Backends/VCS_INFO_get_data_git
# Edit line: 141
gitbase=$( ${vcs_comm[cmd]} rev-parse --show-toplevel 2> /dev/null )
```
Or follow this link: https://github.com/spaceship-prompt/spaceship-prompt/discussions/1003

ref: https://askubuntu.com/questions/335210/apt-get-wildcard-with-zsh

2. Missing Custom script

This sometimes can happen inside of docker container or ssh client after moving over to zsh.
We just need to update the PATH variable in the env.
```bash
export PATH=$HOME/.local/bin:$PATH
```

3. Slow startup time

The startup time of bash is around 0.02s, and my zsh is around 0.28s before the hack.
This happens because of the `compinit` which is not needed for every time.
You can check you zsh startup time with the below command.
```bash
for i in $(seq 1 10); do /usr/bin/time zsh -i -c exit; done
```

The hack to lightning speed!
```bash
for dump in $HOME/.zcompdump(N.mh+24); do
  compinit
  touch compinit
done
compinit -C
```
Only run compinit when the zcompdump is older than a day, of course, give it
a nice little touch once you run compinit to set the time.
Startup is now amazingly 0.02s!

ref: https://stackoverflow.com/questions/62251500/zsh-can-neither-find-nor-execute-custom-user-scripts-in-bin-although-they-are
