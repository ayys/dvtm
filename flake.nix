{
  description = "ayys's fork of dvtm";

  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in
    {
      defaultPackage.x86_64-linux = pkgs.stdenv.mkDerivation {
        name = "dvtm";
        src = ./.;
        buildInputs = [
          pkgs.gcc pkgs.ncurses
        ];
        buildPhase = ''
          make
        '';
        installPhase = ''
          TERMINFO="$out" make install DESTDIR="$out" PREFIX=""
        '';
      };

    };
}
