 { config, lib, pkgs, extraSpecialArgs, ... }:
 {
 
      imports = [ ../modules/nixvim/default.nix ];
    config = {
      home = {
	stateVersion = "24.11";
        username = "juhanakaarlehto";
        homeDirectory = /Users/juhanakaarlehto;
        packages = [
          pkgs.rectangle
          pkgs.obsidian
	  pkgs.nodejs_22
	  pkgs.discord
	  pkgs.google-chrome
        ];
        sessionVariables = {
          SHELL = "${pkgs.zsh}/bin/zsh";
        };

      };

      nixpkgs = {
        config = {
          allowUnfree = true;
        };
      };
      programs = {
        home-manager = {
          enable = true;
        };
        nixvim = {
          enable = true;
	  colorschemes.catppuccin.enable = true;
        };
	vscode = {
	    enable = true;
	    };
        tmux = {
          enable = true;
          extraConfig = "set-option -g default-command \"\$SHELL";
          keyMode = "vi";
          shell = "${pkgs.zsh}/bin/zsh";
        };
        zsh = {
          autocd = true;
          defaultKeymap = "viins";
          enable = true;
          initExtra = "[ -z \"\$TMUX\" ] && { tmux attach || exec tmux new-session; } && exit";
        };
      };
    };
}
