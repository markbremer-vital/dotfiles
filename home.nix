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
      typora
      rustup
      gnumake
      ctags
      glibc.dev
      ripgrep
      file
      binutils
      gdbgui
      cargo-generate
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
      vim-toml
    ];
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = (with pkgs.vscode-extensions; [
      matklad.rust-analyzer
      tamasfe.even-better-toml
    ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "nord-visual-studio-code";
        publisher = "arcticicestudio";
        version = "0.18.0";
        sha256 = "1caism5qa62pgyggxyary2nv9xyqyym62x02kzxdar5n3xwsk3jj";
      }
      {
        name = "rust";
        publisher = "rust-lang";
        version = "0.7.8";
        sha256 = "039ns854v1k4jb9xqknrjkj8lf62nfcpfn0716ancmjc4f0xlzb3";
      }
      {
        name = "cortex-debug";
        publisher = "marus25";
        version = "0.4.4";
        sha256 = "0m2ylpq1r8fryjhj7ycr2grdybidr14l2qj7mz2fp8c5iypyalyq";
      }
    ];

    # vscode settings.json is made read-only and controlled via this section; editing settings
    # in the ui will reveal what to copy over here.
    userSettings = {
      # theme
      "workbench.colorTheme" = "Nord";
    };
  };
}
