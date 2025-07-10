{ pkgs, ... }: {
  devShells.node = (let
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
      runScript = "bash";
      profile = ''
        export npm_config_prefix=~/.node_modules
        export PATH=$HOME/.node_modules/bin:$(yarn global bin):$PATH
        npm install -g typescript
        yarn global add typescript
        yarn global add @quasar/cli
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
