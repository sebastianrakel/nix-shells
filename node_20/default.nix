{ pkgs, ... }: {
  devShells.node_20 = (let
    nodejs_prepare = pkgs.writeShellScript "nodejs_prepare"
      (builtins.readFile ../lib/prepare_nodejs_shell.sh);

    fhs = pkgs.buildFHSEnv {
      name = "node-20-env";
      targetPkgs = pkgs:
        with pkgs; [
          gcc
          libtool
          nodejs_22
          yarn
          typescript-language-server
          typescript
          nodejs_prepare
        ];
      runScript = "zsh";
      profile = ''
        source ${nodejs_prepare} typescript @forge/cli
      '';
    };
  in pkgs.stdenv.mkDerivation {
    name = "node-20-shell";
    nativeBuildInputs = [ fhs ];
    shellHook = ''
      exec node-20-env
    '';
  });
}
