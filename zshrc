# Disable promptinit in the static rc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export ZSH=$HOME/.oh-my-zsh
plugins=(fast-syntax-highlighting zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

pathadd() { [[ ":$PATH:" != *":$1:"* ]] && PATH="$1:$PATH" }

if [[ `uname` == "Darwin" ]]; then
  pathadd /opt/pkg/bin
  pathadd /opt/pkg/sbin
fi

HOME_BIN=$HOME/.bin
pathadd $HOME_BIN

if [ -d $HOME_BIN/zig ]; then
  pathadd $HOME_BIN/zig
fi

if [ -d $HOME_BIN/neovim ]; then
  pathadd $HOME_BIN/neovim/bin
fi

CARGO_BIN=$HOME/.cargo/bin
export GOPATH=$HOME/src/go
export GOBIN=$GOPATH/bin

pathadd $CARGO_BIN
pathadd $GOBIN

alias vim=nvim
alias ls='eza --group-directories-first'
alias cat=bat

export EDITOR=nvim

#neofetch
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

