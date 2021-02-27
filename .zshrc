# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export ZSH=$HOME/.oh-my-zsh
plugins=(fast-syntax-highlighting zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

CARGO_BIN="$HOME/.cargo/bin"
HOME_BIN="$HOME/.bin"
export PATH="$HOME_BIN:$CARGO_BIN:$PATH"

alias vim=nvim
alias ls='exa --group-directories-first'
alias cat=bat

export EDITOR=vim
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -f -g ""'

#neofetch
eval "$(starship init zsh)"

