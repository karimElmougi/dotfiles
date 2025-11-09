if status is-interactive
    # bind up history-prefix-search-backward
    # bind down history-prefix-search-forward
    bind ctrl-c cancel-commandline

    set -gx EDITOR nvim

    eval (/opt/homebrew/bin/brew shellenv fish)

    atuin init fish | source
    starship init fish | source
end
