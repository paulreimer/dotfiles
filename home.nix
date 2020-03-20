{ pkgs, ... }:

with import <nixpkgs> {};
with builtins;

{
  home.packages = [
    pkgs.abduco
    pkgs.ansible
    pkgs.asciinema
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
    pkgs.ffmpeg
    pkgs.gdb
    pkgs.git-crypt
    pkgs.gnumake
    pkgs.gn
    pkgs.gnupg
    pkgs.go
    pkgs.graphviz
    pkgs.hexedit
    pkgs.imagemagick
    pkgs.influxdb
    pkgs.just
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
    pkgs.sslscan
    pkgs.tree
    pkgs.unbound
    pkgs.vimpager
    pkgs.watch
    pkgs.wdiff
    pkgs.wrk
    pkgs.xz
    pkgs.yarn
    pkgs.youtube-dl
    pkgs.zsh

    # Custom packages (from let .. in) here:
  ] ++ (
    if stdenv.isDarwin then [
      darwin.iproute2mac
      pkgs.darwin-zsh-completions
      pkgs.osxfuse
      pkgs.skhd
    ]
    else if stdenv.isLinux then [
      pkgs.grim
      pkgs.mako
      pkgs.slurp
      pkgs.sway
      pkgs.swayidle
      pkgs.swaylock
      pkgs.wev
      pkgs.wl-clipboard
      pkgs.xwayland
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
      filt = "name-rev --refs=refs/heads/* --stdin";
      whodunnit = "blame";
      lol = "log --graph --decorate --pretty=oneline --abbrev-commit";
    };
    extraConfig = {
      color = {
        ui = true;
      };
      core = {
        excludesfile = "~/.config/git/gitignore";
      };
      difftool = {
        prompt = false;
      };
      push = {
        default = "current";
      };
      rerere = {
        enabled = true;
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
      deoplete-emoji
      deoplete-jedi
      deoplete-lsp
      deoplete-nvim
      deoplete-zsh
      DoxygenToolkit-vim
      editorconfig-vim
      file-line
      float-preview-nvim
      fzf-vim
      ir_black
      lh-brackets
      lh-vim-lib
      lightline-ale
      lightline-vim
      neoinclude
      neomake
      neosnippet
      neosnippet-snippets
      nvim-gdb
      nim-vim
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
      vim-sneak
      vim-snipmate
      vim-sourcetrail
      vim-textobj-comment
      vim-textobj-function
      vim-textobj-user
    ];
  };

  programs.zsh = {
    defaultKeymap = "viins";
    enable = true;
    enableCompletion = true;
    history = {
      extended = true;
      ignoreDups = true;
      share = true;
      save = 10000;
      size = 10000;
    };
    initExtra = builtins.readFile ./config.zsh;
    loginExtra = builtins.readFile ./zlogin;

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
      {
        name = "fzf-tab";
        file = "fzf-tab.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "a9fb33a";
          sha256 = "128y6fiprkwi18cf24xm1jhnxf9nsviky71kdllr8mb4jhqxxgkn";
        };
      }
    ];
  } // (if stdenv.isDarwin then {
    envExtra = builtins.readFile ./zshenv_macos;
  }
  else if stdenv.isLinux then {
    envExtra = builtins.readFile ./zshenv;
  }
  else {});

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
    ".htoprc".source = ./htoprc;
  } // (if stdenv.isDarwin then {
    # yabai+skhd tiling window manager
    ".skhdrc".source = ./skhdrc;
    ".yabairc".source = ./yabairc;
  }
  else if stdenv.isLinux then {
    # sway tiling window manager
    ".config/sway/config".source = ./swayconfig;
  }
  else {});
}
