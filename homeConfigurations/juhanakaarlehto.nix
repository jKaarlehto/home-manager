 { config, lib, pkgs, extraSpecialArgs, ... }:
 {
    config = {
      home = {
	stateVersion = "24.11";
        username = "juhanakaarlehto";
        homeDirectory = /Users/juhanakaarlehto;
        packages = [
          pkgs.rectangle
          pkgs.obsidian
	  pkgs.nodejs_22
        ];
        sessionVariables = {
          SHELL = "${pkgs.zsh}/bin/zsh";
        };

	activation = {
    	  aliasApplications = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      	  app_folder=$(echo ~/Applications);
     	  for app in $(find "$genProfilePath/home-path/Applications" -type l); do
            $DRY_RUN_CMD rm -f $app_folder/$(basename $app)
            $DRY_RUN_CMD /usr/bin/osascript -e "tell app \"Finder\"" -e "make new alias file at POSIX file \"$app_folder\" to POSIX file \"$app\"" -e "set name of result to \"$(basename $app)\"" -e "end tell"
	  done
 	'';
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
