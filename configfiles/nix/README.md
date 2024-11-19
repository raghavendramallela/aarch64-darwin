# Install Nix

1. (Optional) [homebrew](https://brew.sh/) installation:

- (pre-req) Install [Command Line Tools (CLT) for Xcode](https://developer.apple.com/download/):
```sh
xcode-select --install
```
- Install [homebrew](https://docs.brew.sh/Installation):
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

2. Recommended: [Determinate Systems Nix installer](https://github.com/DeterminateSystems/nix-installer?tab=readme-ov-file#determinate-nix-installer):

```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
  sh -s -- install
```

3. Copy nix configuration:
```sh
mkdir ~/.config/nix
cp flake.nix home.nix ~/.config/nix
```

4. Set up [`nix-darwin`](https://github.com/LnL7/nix-darwin):

```sh
export NIXPKGS_ALLOW_UNFREE=1
nix run nix-darwin --extra-experimental-features \
nix-command --extra-experimental-features flakes -- switch --flake ~/.config/nix --impure
```
```sh
darwin-rebuild switch --flake ~/.config/nix
```

# Uninstall Nix (UNDO):

1. Uninstall [`nix-darwin`](https://github.com/LnL7/nix-darwin?tab=readme-ov-file#uninstalling):
```sh
nix --extra-experimental-features "nix-command flakes" run nix-darwin#darwin-uninstaller
# if above doest work
# darwin-uninstaller
```
2. Uninstall Nix
```sh
/nix/nix-installer uninstall
```
