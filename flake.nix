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
  outputs = { nixpkgs, home-manager, nixvim, ...}@inputs:
  	let 
		system = "aarch64-darwin";		
   in {
      homeConfigurations = {
        juhanakaarlehto = home-manager.lib.homeManagerConfiguration {
	modules = [
			./homeConfigurations/juhanakaarlehto.nix
			nixvim.homeManagerModules.nixvim	
		];
      	pkgs = import nixpkgs {system = system; };

	extraSpecialArgs = {
		 };
	};
      };
    };
}
