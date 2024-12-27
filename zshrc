zmodload zsh/zprof
# Disable promptinit in the static rc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

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

eval "$(starship init zsh)"
zprof
