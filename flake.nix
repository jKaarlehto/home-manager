{
  description = "home-manager config for juhanakaarlehto";
  inputs = {
    nixpkgs.url = "flake:nixpkgs/nixpkgs-unstable";
    home-manager.url = "flake:home-manager";
    home-manager.follow = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.follow = "nixpkgs";
  };
  outputs = inputs:
    let
      flakeContext = {
        inherit inputs;
      };
    in
    {
      homeConfigurations = {
        juhanakaarlehto = import ./homeConfigurations/juhanakaarlehto.nix flakeContext;
      };
      homeModules = {
        nixvim = import ./homeModules/nixvim.nix flakeContext;
      };
    };
}
