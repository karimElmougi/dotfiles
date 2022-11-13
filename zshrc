# Disable promptinit in the static rc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export ZSH=$HOME/.oh-my-zsh
plugins=(fast-syntax-highlighting zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

if [[ `uname` == "Darwin" ]]; then
  PKGIN_BIN=/opt/pkg/bin
  PKGIN_SBIN=/opt/pkg/sbin
  export PATH="$PKGIN_BIN:$PKGIN_SBIN:$PATH"
fi

HOME_BIN=$HOME/.bin
export PATH="$HOME_BIN:$PATH"

if [ -d $HOME_BIN/zig ]; then
  ZIG_PATH=$HOME_BIN/zig
  export PATH="$ZIG_PATH:$PATH"
fi

if [ -d $HOME_BIN/neovim ]; then
  NEOVIM_PATH=$HOME_BIN/neovim/bin
  export PATH="$NEOVIM_PATH:$PATH"
fi

CARGO_BIN=$HOME/.cargo/bin
export GOPATH=$HOME/dev/go
export GOBIN=$GOPATH/bin

export PATH="$CARGO_BIN:$GOBIN:$PATH"

alias vim=nvim
alias ls='exa --group-directories-first'
alias cat=bat

export EDITOR=nvim

#neofetch
eval "$(starship init zsh)"

