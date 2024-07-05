{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  pname = "undetected-chromedriver";

  sourceRoot = ".";

  phases = [ "buildPhase" "installPhase" ];
  buildInputs = [ pkgs.tar ];

  installPhase = ''
    tar -xf undetected-chromedriver.tar.gz
    mkdir -p $out/bin
    mv undetected-chromedriver $out/bin/
    chmod +x $out/bin/undetected-chromedriver
  '';

  meta = with pkgs.lib; {
    description = "undetected-chromedriver";
    license = licenses.mit;
    maintainers = [ "kbwhodat" ];
  };
}
