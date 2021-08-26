{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
  home = {
    username = "mark";
    homeDirectory = "/home/mark";
    
    file = {
      ".bashrc".source = ./bashrc;
      ".gitconfig".source = ./gitconfig;
    };

    packages = with pkgs; [
      firefox
      slack
      zoom-us
      unzip
      screen
      vscodium
    ];

    sessionVariables = {
      EDITOR = "nvim";
    };

    stateVersion = "21.05";
  };

  programs = {
    git = {
      package = pkgs.gitAndTools.gitFull;
      enable = true;
      userName = "Mark Bremer";
      userEmail = "markb@vitalbio.com";
      extraConfig = {
        core.editor = "$EDITOR";
      };
    };

    neovim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [
        vim-airline
      ];
    };
  };

  xdg.configFile = {
    "nvim/init.vim".source = ./nvim/init.vim;
  };
}
