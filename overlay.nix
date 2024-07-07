self: super:
{

  undetected-chromedriver = self.python3Packages.buildPythonPackage rec {
    pname = "undetected_chromedriver";
    version = "3.5.5";
    format = "setuptools";

    src = self.fetchFromGitHub {
      owner = "ultrafunkamsterdam";
      repo = "undetected-chromedriver";
      rev = "0aa5fbe252370b4cb2b95526add445392cad27ba";
      hash = "sha256-Qe+GrsUPnhjJMDgjdUCloapjj0ggFlm/Dr42WLcmb1o=";
    };

    buildInputs = [
      self.chromedriver
      self.python3Packages.setuptools 
      self.python3Packages.pip
    ];

    shellHook = ''
      pip install selenium-profiles
    '';

    propagatedBuildInputs = with self.python3Packages; [ requests websockets blinker ];

    postConfigure = ''
      substituteInPlace undetected_chromedriver/patcher.py \
        --replace "os.makedirs(self.data_path, exist_ok=True)" "print('test 1')" \
        --replace "os.makedirs(self.zip_path, mode=0o755, exist_ok=True)" "print('test 2')"
      substituteInPlace undetected_chromedriver/__init__.py \
        --replace "driver_executable_path=None," "driver_executable_path='$out/bin/chromedriver',"
    '';

    postFixup = ''
      mkdir -p mutableChromedriverBin
      cp ${self.chromedriver}/bin/* mutableChromedriverBin/
      chmod +w mutableChromedriverBin/chromedriver
      ${self.python3}/bin/python3 ${./patchChromedriver.py} mutableChromedriverBin/chromedriver
      mkdir -p $out/bin
      cp mutableChromedriverBin/* $out/bin/
    '';

    pythonImportsCheck = [
      "undetected_chromedriver"
    ];

    meta = with self.lib; {
      homepage = "https://github.com/UltrafunkAmsterdam/undetected-chromedriver";
      changelog = "https://github.com/ultrafunkamsterdam/undetected-chromedriver/blob/master/README.md";
      license = licenses.gpl3Only;
      description = ''
        Selenium.webdriver.Chrome replacement with compatibility for Brave, and other Chromium based browsers.
      '';
      sourceProvenance = [ sourceTypes.binaryNativeCode ];
      maintainers = with maintainers; [ "liammurphy14" "toasteruwu" ];
    };
  };
}
