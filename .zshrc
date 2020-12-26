CARGO_BIN="$HOME/.cargo/bin"
HOME_BIN="$HOME/.bin"
export PATH="$HOME_BIN:$CARGO_BIN:$PATH"

alias vim=nvim
alias ls=exa
alias cat=bat

export EDITOR=vim

# Syntax highlighting
source "$HOME/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"

## Completion
source "$HOME/.zsh/completion.zsh"
autoload -Uz compinit

## Cache completion if nothing changed - faster startup time
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi

## Enhanced form of menu completion called `menu selection'
zmodload -i zsh/complist

# Autosuggestions
source "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"

# history
source "$HOME/.zsh/history.zsh"

# keybinds
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line
bindkey "${terminfo[kcbt]}" reverse-menu-complete

eval "$(starship init zsh)"
neofetch

