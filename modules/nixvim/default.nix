{ config, lib, pkgs, ... }: {
  imports = [
		./keymaps.nix
		./lsp.nix
				];
  config = {

    programs.nixvim = {
      defaultEditor = true;
      opts = {
        relativenumber = true;
		wrap = false;
		hlsearch = false;
		shiftwidth = 4;
		smartindent = true;  # Automatically indent new lines
        autoindent = true;   # Indent new lines based on the previous line's indent
        smarttab = true;
		encoding = "utf-8";
      };

      # Add any additional configuration here
       extraConfigLua = '' '';
    };
  };
}
