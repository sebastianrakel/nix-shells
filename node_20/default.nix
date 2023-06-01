{ pkgs, ... }:
let
  packages = [ pkgs.gcc pkgs.libtool pkgs.nodejs_20 pkgs.yarn ];
  nodeFhs = (pkgs.buildFHSEnv {
    name = "nodejs dev env";
    targetPkgs = packages;
    runScript = "bash";
  });
in {
  devShells.node_20 = pkgs.mkShell {
    inputsFrom = [ nodeFhs ];
    packages = packages;

    shellHook = ''
      PATH=$(yarn global bin):$PATH
      yarn global add @quasar/cli
    '';
  };
}

