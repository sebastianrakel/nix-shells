{
  description =
    "Sebastians - Nix Shells";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, flake-utils, nixpkgs }:
    {
      templates = rec {
        powershell = {
          path = ./powershell;
          description = "Powershell development environment";
        };
      };
    };
}
