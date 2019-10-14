{ pkgs, ... }:

with import <nixpkgs> {};
with builtins;

{
  home.packages = [
    pkgs.abduco
    pkgs.bear
    pkgs.ccache
    pkgs.ccat
    pkgs.clang-tools
    pkgs.cmake
    pkgs.colordiff
    pkgs.cppcheck
    pkgs.curl
    pkgs.dos2unix
    pkgs.doxygen
    pkgs.exiftool
    pkgs.entr
    pkgs.gdb
    pkgs.git-crypt
    pkgs.gnumake
    pkgs.gn
    pkgs.gnupg
    pkgs.graphviz
    pkgs.hexedit
    pkgs.imagemagick
    pkgs.influxdb
    pkgs.kitty
    pkgs.libftdi1
    pkgs.mercurial
    pkgs.meson
    pkgs.ncurses
    pkgs.neovim-remote
    pkgs.neovim-unwrapped
    pkgs.ninja
    pkgs.nodejs
    pkgs.openssh
    pkgs.parallel
    pkgs.pinentry
    pkgs.pstree
    pkgs.pv
    pkgs.rpl
    pkgs.rustup
    pkgs.screen
    pkgs.shellcheck
    pkgs.shfmt
    pkgs.silver-searcher
    pkgs.sl
    pkgs.socat
    pkgs.sqlite
    pkgs.tree
    pkgs.unbound
    pkgs.watch
    pkgs.wdiff
    pkgs.yarn
    pkgs.zsh

    # Custom packages (from let .. in) here:
  ] ++ (
    if stdenv.isDarwin then [
      darwin.iproute2mac
      pkgs.darwin-zsh-completions
      pkgs.osxfuse
      pkgs.skhd
    ]
    else []
  );


  programs.home-manager.enable = true;

  programs.command-not-found.enable = true;

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultOptions = ["--exact"];
  };

  programs.git = {
    package = pkgs.gitAndTools.gitFull;
    enable = true;
    userName = "Paul Reimer";
    userEmail = "paul@p-rimes.net";
    signing = {
      key = "65D1D89E6BBF95E7";
      signByDefault = true;
    };
    aliases = {
      ls = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate";
      ll = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate --numstat";
      lnc = "log --pretty=format:\"%h\\\\ %s\\\\ [%cn]\"";
      lds = "log --pretty=format:\"%C(yellow)%h\\\\ %ad%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate --date=short";
      ld = "log --pretty=format:\"%C(yellow)%h\\\\ %ad%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate --date=relative";
      le = "log --oneline --decorate";
      filelog = "log -u";
      dl = "\"!git ll -1\"";
      dlc = "diff --cached HEAD^";
      logtree = "log --graph --oneline --decorate --all --color";
    };
    extraConfig = {
      color = {
        ui = true;
      };
      difftool = {
        prompt = false;
      };
      submodule = {
        recurse = true;
      };
      "diff \"daff-csv\"" = {
        command = "daff diff --git";
      };
      "merge \"daff-csv\"" = {
        name = "daff tabular merge";
        driver = "daff merge --output %A %O %A %B";
      };
      "diff \"jupyternotebook\"" = {
        command = "git-nbdiffdriver diff";
      };
      "merge \"jupyternotebook\"" = {
        command = "git-nbmergedriver merge %O %A %B %L %P";
      };
    };
  };

  programs.htop = {
    enable = true;
    treeView = true;
  };

  programs.jq.enable = true;

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = builtins.readFile ./config.vim;
    plugins = with pkgs.vimPlugins; [
      ale
      csv
      dart-vim-plugin
      deoplete-jedi
      deoplete-lsp
      deoplete-nvim
      DoxygenToolkit-vim
      editorconfig-vim
      file-line
      float-preview-nvim
      fzf-vim
      ir_black
      LanguageClient-neovim
      lh-brackets
      lh-vim-lib
      lightline-ale
      lightline-vim
      neoinclude
      neomake
      neosnippet
      neosnippet-snippets
      ShowMultiBase
      sky-color-clock-vim
      tabular
      tcomment_vim
      tlib_vim
      vim-addon-mw-utils
      vim-bufferline
      vim-bufkill
      vim-css-color
      vim-fugitive
      vim-gitgutter
      vim-nix
      vim-snipmate
      vim-sourcetrail
      vim-textobj-comment
      vim-textobj-function
      vim-textobj-user
    ];
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    history = {
      #autocd = true;
      extended = true;
      ignoreDups = true;
      share = true;
      save = 10000;
      size = 10000;
    };
    initExtra = builtins.readFile ./config.zsh;
    loginExtra = builtins.readFile ./zlogin;
    envExtra = builtins.readFile ./zshenv;
    #envExtra = builtins.readFile ./zshenv_macos;

    plugins = [
      {
        name = "zsh-syntax-highlighting";
        file = "zsh-syntax-highlighting.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.6.0";
          sha256 = "0zmq66dzasmr5pwribyh4kbkk23jxbpdw4rjxx0i7dx8jjp2lzl4";
        };
      }
    ];
  };

  qt.enable = true;

  home.file = {
    # kitty terminal
    ".config/kitty/kitty.conf".source = ./kitty.conf;

    # fzf-based launcher
    "bin/launcher".source = ./launcher;

    # vim / neovim
    ".config/nvim/init.vim".source = ./init.vim;
    ".vim/ftplugin/dart.vim".source = ./vim/ftplugin/dart.vim;
    ".vim/ftplugin/diff.vim".source = ./vim/ftplugin/diff.vim;
    ".vim/ftplugin/gitcommit.vim".source = ./vim/ftplugin/gitcommit.vim;

    # git diff/merge tool configuration
    ".config/git/attributes".source = ./attributes;

    # other dotfiles:
    ".colordiffrc".source = ./colordiffrc;
    ".screenrc".source = ./screenrc;
  };
}
