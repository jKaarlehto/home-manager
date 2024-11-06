{ inputs, ... }@flakeContext:
let
  homeModule = { config, lib, pkgs, ... }: {
    imports = [
      inputs.nixvim.homeManagerModules.nixvim
    ];
    config = {
      home = {
        homeDirectory = /Users/juhanakaarlehto;
        packages = [
          pkgs.rectangle
          pkgs.obsidian
	  pkgs.github-desktop
        ];
        sessionVariables = {
          SHELL = "${pkgs.zsh}/bin/zsh";
        };
        stateVersion = "24.11";
        username = "juhanakaarlehto";
	activation = {
      # This should be removed once
      # https://github.com/nix-community/home-manager/issues/1341 is closed.
      aliasApplications = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        app_folder="$(echo ~/Applications)/Home Manager Apps"
        home_manager_app_folder="$genProfilePath/home-path/Applications"
        $DRY_RUN_CMD rm -rf "$app_folder"
        # NB: aliasing ".../home-path/Applications" to "~/Applications/Home Manager Apps" doesn't
        #     work (presumably because the individual apps are symlinked in that directory, not
        #     aliased). So this makes "Home Manager Apps" a normal directory and then aliases each
        #     application into there directly from its location in the nix store.
        $DRY_RUN_CMD mkdir "$app_folder"
        for app in $(find "$newGenPath/home-path/Applications" -type l -exec readlink -f {} \;)
        do
          $DRY_RUN_CMD /usr/bin/osascript \
            -e "tell app \"Finder\"" \
            -e "make new alias file at POSIX file \"$app_folder\" to POSIX file \"$app\"" \
            -e "set name of result to \"$(basename $app)\"" \
            -e "end tell"
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
  };
  nixosModule = { ... }: {
    home-manager.users.juhanakaarlehto = homeModule;
  };
in
(
  (
    inputs.home-manager.lib.homeManagerConfiguration {
      modules = [
        homeModule
      ];
      pkgs = inputs.nixpkgs.legacyPackages.aarch64-darwin;
    }
  ) // { inherit nixosModule; }
)
