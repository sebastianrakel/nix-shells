{ pkgs, ... }: {
  devShells.node_20 = (let
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
        ];
      runScript = "bash";
      profile = ''
        export PATH=$(yarn global bin):$PATH  
      '';
    };
  in pkgs.stdenv.mkDerivation {
    name = "node-20-shell";
    nativeBuildInputs = [ fhs ];
    shellHook = ''
      exec node-20-env
      yarn global add @quasar/cli
      yarn global add @forge/cli
    '';
  });
}
