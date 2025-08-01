{
  description = "A calculator for Rofi/dmenu(2)";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    (flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      derivation-attrs = backend_pkg: backend_cmd:
 rec {
          pname = "menucalc";
          version = "v1.3.0";

          src = ./.;

          buildInputs = [ pkgs.makeWrapper ];
          dontBuild = true;

          installPhase = ''
            mkdir -p "$out/bin"
            install -D -m755 ./= "$out/bin/="
            mkdir -p "$out/share/man/man1"
            install -D -m644 ./=.1 "$out/share/man/man1/=.1"
            install -D -m644 ./menu-calc.1 "$out/share/man/man1/menu-calc.1"
          '';

          wrapperPath =
            pkgs.lib.makeBinPath (with pkgs; [ backend_pkg rofi xclip wl-clipboard ]);

          fixupPhase = ''
            patchShebangs $out/bin
            wrapProgram $out/bin/= --prefix PATH : "${wrapperPath}" --add-flags "--calculator=${backend_cmd}"
          '';

          meta = {
            description = "A calculator for Rofi/dmenu(2)";
            homepage = "https://github.com/sumnerevans/menu-calc";
            # maintainers = with stdenv.lib.maintainers; [ sumnerevans ];
            license = pkgs.lib.licenses.mit;
            platforms = with pkgs.lib.platforms; linux;
          };
        };
      in rec {
        packages.menucalc = pkgs.stdenv.mkDerivation (derivation-attrs pkgs.bc "bc -l");
        packages.menucalc-fend = pkgs.stdenv.mkDerivation (derivation-attrs pkgs.fend "fend");
        packages.default = packages.menucalc;

        devShells.default =
          pkgs.mkShell { packages = with pkgs; [ bc fend pre-commit shellcheck ]; };
      }));
}
