{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    # firefox
    # audacity
    # iterm2
    # mailspring
    # obs-studio
    # vlc
    # transmission
    # alacritty
    ffmpeg
    mp4v2
    neovim
    vimPlugins.vim-plug
    go
    gopls
    gh
    texlive.combined.scheme-full
    git
    ag
    elixir
    rustup
    exa
    tokei
    bat
    bat-extras.batman
    bat-extras.batgrep
    bat-extras.batdiff
    bat-extras.batwatch
    bat-extras.prettybat
    bottom
    du-dust
    fd
    ripgrep
    starship
    tealdeer
    delta
    zsh
    oh-my-zsh
    zsh-fast-syntax-highlighting
    zsh-autosuggestions
  ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
