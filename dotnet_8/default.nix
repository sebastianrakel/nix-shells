{ pkgs, ... }:
let
  packages = [ pkgs.dotnet-sdk_8 ];
  customFhs = (pkgs.buildFHSEnv {
    name = "dotnet dev env";
    targetPkgs = packages;
  });
in {
  devShells.dotnet_8 = pkgs.mkShell {
    inputsFrom = [ customFhs ];
    packages = packages;

    shellHook = "";
  };
}

