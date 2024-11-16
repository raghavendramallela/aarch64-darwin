# home.nix
# home-manager switch

{ config, pkgs, ... }:

{
  home.username = "raghu";
  home.homeDirectory = "/Users/raghu";
  home.stateVersion = "23.05"; # Please read the comment before changing.

# Makes sense for user specific applications that shouldn't be available system-wide
  home.packages = [
    pkgs.neovim
    pkgs.starship
    pkgs.nushell
    pkgs.nodejs_22
    pkgs.python3
    pkgs.chruby
    pkgs.ruby
    pkgs.git
    pkgs.go
    pkgs.gh
    pkgs.bat
    pkgs.kind
    pkgs.google-chrome
    pkgs.fastfetch
    pkgs.iterm2
    pkgs.kubectl
    pkgs.direnv
    pkgs.spotify
    pkgs.vscode
    # pkgs.bitwarden-cli
  ];
#export NIXPKGS_ALLOW_UNFREE=1 && nix run nix-darwin --extra-experimental-features nix-command --extra-experimental-features flakes -- switch --flake ~/.config/nix --impure && darwin-rebuild switch --flake ~/.config/nix --impure
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
  };

  home.sessionVariables = {
  };

  home.sessionPath = [
    "/run/current-system/sw/bin"
      "$HOME/.nix-profile/bin"
  ];
  programs.home-manager.enable = true;
  programs.zsh = {
    enable = true;
    initExtra = ''
      # Add any additional configurations here
      export PATH=/run/current-system/sw/bin:$HOME/.nix-profile/bin:$PATH
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi
    '';
  };
}
