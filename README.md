# ZSH

This repo is a guide to setup your shell as zsh. Not sure if it will increase productivity, but let's give it a try.

**Step 1**

Install zsh and zsh-syntax-highlighting
```bash
sudo apt-get install zsh zsh-syntax-highlighting
```

### zmv

```zsh
touch file_{1..100}
# Change file_1 to log_1
zmv 'file_(*)' 'log_$1'
# Change log_1 to output_1.log
zmv '(*)_(*) 'output_$2.$1'
```

### Setup alias



### Setup Order of Precedence

- Aliases
- Reserved words
- Functions
- Builtins
- Commands

### More Information on Zsh

```
man zsh
```