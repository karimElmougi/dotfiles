if status is-interactive
    bind up history-prefix-search-backward
    bind down history-prefix-search-forward
    bind ctrl-c cancel-commandline

    set -gx EDITOR nvim

    fish_add_path -g ~/.bin
    fish_add_path -g ~/.bin/neovim/bin
    fish_add_path -g ~/.cargo/bin
    fish_add_path -g ~/opt/pkg/bin
    fish_add_path -g ~/opt/pkg/sbin

    test -e /opt/homebrew/bin/brew && eval (/opt/homebrew/bin/brew shellenv fish)

    atuin init fish --disable-up-arrow | source
end
