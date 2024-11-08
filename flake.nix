{
  description = "home-manager config for juhanakaarlehto";
  inputs = {
    nixpkgs.url = "flake:nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "flake:home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
