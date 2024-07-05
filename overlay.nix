{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  pname = "undetected-chromedriver";

  src = ./.;
  sourceRoot = ".";

  phases = [ "buildPhase" "installPhase" ];

  buildPhase = ''
    # virtualenv venv
    # source venv/bin/activate
    pip install .
  '';

  installPhase = ''
    mkdir -p $out/bin
    mv chromedriver $out/bin/
    chmod +x $out/bin/chromedriver
  '';

  meta = with pkgs.lib; {
    description = "undetected-chromedriver";
    license = licenses.mit;
    maintainers = [ "kbwhodat" ];
  };
}
