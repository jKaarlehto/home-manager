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
      };
      {
  # Install MacOS applications to the user environment if the targetPlatform is Darwin
  home.file."Applications/home-manager".source = let
  apps = pkgs.buildEnv {
    name = "home-manager-applications";
    paths = config.home.packages;
    pathsToLink = "/Applications";
  };
  in mkIf pkgs.stdenv.targetPlatform.isDarwin "${apps}/Applications";
}


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
