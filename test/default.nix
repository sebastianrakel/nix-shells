{ pkgs, ... }:
let ghcPkg = pkgs.haskell.compiler.ghc96;
in {
  devShells.test = pkgs.mkShell {
    buildInputs = with pkgs; [ ghcPkg cabal-install haskell-language-server ];
    shellHook = with pkgs; ''
      ${ghcPkg}/bin/ghc --version
      ${cabal-install}/bin/cabal --version
    '';
  };
}

