{
  description = "Portable Neovim (Lazy.nvim) dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            neovim
            git
            tmux
            ripgrep
            fd
            gcc
            gnumake
            nodejs_20
            python3
            unzip  # Required for mason to install some tools like stylua
          ];

          shellHook = ''
            export XDG_CONFIG_HOME=$PWD
            echo "Using Neovim config from $PWD/nvim"
          '';
        };
      });
}
