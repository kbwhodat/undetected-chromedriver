{
  description = "A simple example package for undetected-chromedriver";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs = { self, nixpkgs, ... }:
    {
      overlays = {
        default = final: prev: import ./overlay.nix { inherit final prev; };
      };

    };
}
