{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {

	config.home {
		packages = [
		pkgs.pyright
		];
	}
	programs.nixvim = {
		
		defaultEditor = true;
		relativenumber = true;
		#extraConfigLua

	}

}
