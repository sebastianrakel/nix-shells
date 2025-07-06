{ pkgs, ... }: {
  devShells.node = (let
    fhs = pkgs.buildFHSEnv {
      name = "node-env";
      targetPkgs = pkgs: with pkgs; [ gcc libtool nodejs_22 yarn ];
      runScript = "bash";
      profile = ''
        export PATH=$(yarn global bin):$PATH  
      '';
    };
  in pkgs.stdenv.mkDerivation {
    name = "node-shell";
    nativeBuildInputs = [ fhs ];
    shellHook = ''
      exec node-env
      yarn global add @quasar/cli
    '';
  });
}
