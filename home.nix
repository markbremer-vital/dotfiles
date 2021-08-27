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
      typora
    ];

    sessionVariables = {
      EDITOR = "nvim";
    };

    stateVersion = "21.05";
  };

  programs.git = {
    package = pkgs.gitAndTools.gitFull;
    enable = true;
    userName = "Mark Bremer";
    userEmail = "markb@vitalbio.com";
    extraConfig = {
      core.editor = "$EDITOR";
    };
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = ''
      set expandtab                     " Use spaces not tabs
      set exrc                          " Read ./.vimrc
      set fileformats=unix,dos,mac      " Choose line ending sanely
      set nowrap                        " Wrap lines by default
      set secure                        " Only allow safe things in ./.vimrc
      set number                        " Show line numbers
      set scrolloff=20                  " Scroll before we get to top/bottom of screen
      set shiftwidth=2                  " 2 space indent stops
      set showtabline=2                 " Always show the tabline
      set tabstop=2                     " 2 space indent stops
      set termguicolors                 " Use true color support in terminals
      set hidden

      " Key Remapping
      nnoremap q: <nop>
      nnoremap Q <nop>
      nnoremap <F2> :bp<CR>
      nnoremap <F3> :bn<CR>
      nnoremap <F1> <F2>
      nnoremap <F5> :bd<CR>
      nnoremap <F8> :NERDTreeToggle<CR>

      " Theme
      colorscheme gruvbox
      set background=dark

      " Airline Customizations
      set t_Co=256
      let g:airline#extensions#tabline#enabled = 1
      let g:airline_powerline_fonts=1
      let g:airline_theme='gruvbox'
    '';
    plugins = with pkgs.vimPlugins; [
      vim-nix
      gruvbox
      vim-airline
      vim-airline-themes
      nerdtree
      vim-gitgutter
    ];
  };
}
