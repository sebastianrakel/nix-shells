{
  description = "Powershell Development";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        config = {
          permittedInsecurePackages = [
            "openssl-1.1.1t"
          ];
        };
      };
    in {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          powershell
        ];
        shellHook = with pkgs; ''
          echo "pwsh: $(pwsh --version)"
        '';
      };
    });
}
