# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export ZSH=$HOME/.oh-my-zsh
plugins=(fast-syntax-highlighting zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

CARGO_BIN=$HOME/.cargo/bin
HOME_BIN=$HOME/.bin
export GOPATH=$HOME/dev/go
export GOBIN=$GOPATH/bin
export PATH="$HOME_BIN:$CARGO_BIN:$GOBIN:$PATH"

alias vim=nvim
alias ls='exa --group-directories-first'
alias cat=bat
alias open=xdg-open

export EDITOR=nvim
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -f -g ""'

#neofetch
eval "$(starship init zsh)"

