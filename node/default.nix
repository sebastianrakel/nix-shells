{ pkgs, ... }: {
  devShells.node = (let
    nodejs_prepare = pkgs.writeShellScript "nodejs_prepare"
      (builtins.readFile ../lib/prepare_nodejs_shell.sh);

    fhs = pkgs.buildFHSEnv {
      name = "node-env";
      targetPkgs = pkgs:
        with pkgs; [
          gcc
          libtool
          nodejs_22
          yarn
          typescript-language-server
          typescript
        ];
      runScript = "zsh";
      profile = ''
        source ${nodejs_prepare} typescript @quasar/cli
      '';
    };
  in pkgs.stdenv.mkDerivation {
    name = "node-shell";
    nativeBuildInputs = [ fhs ];
    shellHook = ''
      exec node-env
    '';
  });
}
