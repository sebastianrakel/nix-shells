{ pkgs, ... }: {
  devShells.node = (pkgs.buildFHSEnv {
    name = "nodejs";
    targetPkgs = pkgs: [ pkgs.gcc pkgs.libtool pkgs.nodejs_22 pkgs.yarn ];
    runScript = "zsh";
    profile = ''
      yarn global add @quasar/cli
      export PATH=$(yarn global bin):$PATH    
    '';
  }).env;
}
