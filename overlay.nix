{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  pname = "undetected-chromedriver";

  src = ./.;
  sourceRoot = ".";

  phases = [ "buildPhase" "installPhase" ];
  nativeBuildInputs = [ pkgs.python311Packages.virtualenv pkgs.unzip ];

  buildPhase = ''
    virtualenv venv
    source venv/bin/activate
    pip install .
  '';

  installPhase = ''
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
