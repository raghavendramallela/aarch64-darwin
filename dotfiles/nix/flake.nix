# ~/.config/nix/flake.nix

{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
        url = "github:LnL7/nix-darwin";
        inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
  let
    configuration = {pkgs, ... }: {

        services.nix-daemon.enable = true;
        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";
        # Create /etc/zshrc that loads the nix-darwin environment.
        programs.zsh.enable = true;
        security.pam.enableSudoTouchIdAuth = true;
        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility. please read the changelog
        # before changing: `darwin-rebuild changelog`.
        system.stateVersion = 4;

        # The platform the configuration will be used on.
        # If you're on an Intel system, replace with "x86_64-darwin"
        nixpkgs.hostPlatform = "aarch64-darwin";

        # Declare the user that will be running `nix-darwin`.
        users.users.raghu = {
            name = "raghu";
            home = "/Users/raghu";
        };
        nix.configureBuildUsers = true;
        nix.useDaemon = true;
        ids.gids.nixbld = 350;

        environment.systemPackages =
        [ ];
    };

  in
  {
    darwinConfigurations."ecosystem" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
         configuration
         home-manager.darwinModules.home-manager  {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.verbose = true;
            home-manager.users.raghu = import ./home.nix;
        }
      ];
    };
  };
}
