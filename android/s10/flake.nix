{
  description = "A Nix flake for flashing a Samsung Galaxy S10";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        config = {
          # Некоторые пакеты могут требовать это разрешение
          allowUnfree = true;
        };
      };
    in {
      # Команда `nix develop` активирует эту среду.
      devShells.default = import ./shell.nix {inherit pkgs;};
    });
}
