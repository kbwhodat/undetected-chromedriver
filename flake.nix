{
  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/24.05"; };
  outputs = { self, nixpkgs, ... }@inputs: { overlay = import ./overlay.nix; };
}
