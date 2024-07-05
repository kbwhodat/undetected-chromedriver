self: super:

super.stdenv.mkDerivation {
  pname = "undetected-chromedriver";
  version = "0.1.0"; # Add the version if applicable

  src = ./undetected-chromedriver.tar.gz; # Specify the source

  sourceRoot = ".";

  phases = [ "unpackPhase" "installPhase" ];
  buildInputs = [ super.pkgs.tar ];

  unpackPhase = ''
    runHook preUnpack
    tar -xf $src -C $sourceRoot
    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mv $sourceRoot/undetected-chromedriver $out/bin/
    chmod +x $out/bin/undetected-chromedriver

    runHook postInstall
  '';

  meta = with super.lib; {
    description = "A package for undetected-chromedriver";
    license = licenses.mit;
    maintainers = [ maintainers.kbwhodat ]; # Use your actual maintainers list reference
  };
}
