# overlay.nix

self: super: {
  undetected-chromedriver = self.python3Packages.buildPythonApplication rec {
    pname = "undetected_chromedriver";
    version = "0.1.0";
    src = ./.; # Replace with the correct path or URL

    nativeBuildInputs = [ self.python3Packages.setuptools self.python3Packages.pip ];
    propagatedBuildInputs = with self.python3Packages; [ requests websockets selenium ];  # Add other dependencies here

    meta = with self.lib; {
      description = "A package for undetected-chromedriver";
      license = licenses.mit;
      maintainers = [ "kbwhodat" ];  # Use your actual maintainers list reference
    };
  };
}
