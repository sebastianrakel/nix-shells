{ pkgs, ... }:
let
  packages = [ pkgs.dotnet-sdk_9 ];
  customFhs = (pkgs.buildFHSEnv {
    name = "dotnet dev env";
    targetPkgs = packages;
  });
in {
  devShells.dotnet_9 = pkgs.mkShell {
    inputsFrom = [ customFhs ];
    packages = packages;

    shellHook = "";
  };
}

