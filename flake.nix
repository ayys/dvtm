{
  description = "ayys's fork of dvtm";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flakeutils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self, nixpkgs, flakeutils }:
      flakeutils.lib.eachDefaultSystem (system:
        let pkgs = nixpkgs.legacyPackages.${system}; in
        {
          packages = rec {
            dvtm = pkgs.stdenv.mkDerivation {
              name = "dvtm";
              src = ./.;
              buildInputs = [
                pkgs.gcc  pkgs.ncurses
              ];
              buildPhase = ''
          make
        '';
              installPhase = ''
          TERMINFO="$out" make install DESTDIR="$out" PREFIX=""
        '';
            };
            default = dvtm;
          };
          apps = rec {
            dvtm = flakeutils.lib.mkApp { drv = self.packages.${system}.dvtm; };
            default = dvtm;
          };
        }
      );
}
