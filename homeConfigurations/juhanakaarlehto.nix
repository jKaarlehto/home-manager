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
        ];
        sessionVariables = {
          SHELL = "${pkgs.zsh}/bin/zsh";
        };
        stateVersion = "24.11";
        username = "juhanakaarlehto";
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
