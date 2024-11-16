{ config, lib, pkgs, ... }: {
  
  imports = [ ./keymaps.nix ];
  config = {
    home.packages = [
      pkgs.pyright #LSP 
    ];

    programs.nixvim = {
      defaultEditor = true;

      opts = {
        relativenumber = true;
	nowrap = true;
	nohlsearch = true;
	tabstop = 4;
	smartindent = true;  # Automatically indent new lines
        autoindent = true;   # Indent new lines based on the previous line's indent
        smarttab = true;

      };

      # Add any additional configuration here
       extraConfigLua = '' '';
    };
  };
}
