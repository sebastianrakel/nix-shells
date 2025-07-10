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
        export npm_config_prefix=~/.node_modules
        export PATH=$HOME/.node_modules/bin:$(yarn global bin):$PATH
        npm install -g typescript
        yarn global add typescript
        yarn global add @quasar/cli
        yarn global add @forge/cli
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
