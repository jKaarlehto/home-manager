{ config, lib, pkgs, ... }: {

  config = {
    home.packages = [
      pkgs.pyright
    ];

    programs.nixvim = {
      defaultEditor = true;

      opts = {
        relativenumber = true;
      };

      # Add any additional configuration here
      # extraConfigLua = ''
      #   -- Lua configuration here
      # '';
    };
  };
}
