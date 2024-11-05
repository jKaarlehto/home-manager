{
  description = "home-manager config for juhanakaarlehto";
  inputs = {
    nixpkgs.url = "flake:nixpkgs/nixpkgs-unstable";
    home-manager.url = "flake:home-manager";
    home-manager.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim";
    
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
