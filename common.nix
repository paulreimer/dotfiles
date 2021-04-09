{ pkgs, ... }:

with import <nixpkgs> {};

{
  home.packages = [
    # default packages
    pkgs.abduco
    pkgs.axel
    pkgs.bear
    pkgs.caddy
    pkgs.ccache
    pkgs.ccat
    pkgs.clang-tools
    pkgs.cmakeCurses
    pkgs.colordiff
    pkgs.coreutils
    pkgs.curl
    pkgs.dnsmasq
    pkgs.dnsutils
    pkgs.dos2unix
    pkgs.exiftool
    pkgs.entr
    pkgs.file
    pkgs.findutils
    pkgs.git
    pkgs.gnugrep
    pkgs.gnumake
    pkgs.hexedit
    pkgs.imagemagick
    pkgs.inetutils
    pkgs.ninja
    pkgs.openssh
    pkgs.parallel
    pkgs.patchelf
    pkgs.picocom
    pkgs.pstree
    pkgs.pv
    pkgs.rpl
    pkgs.safe-rm
    pkgs.screen
    pkgs.shellcheck
    pkgs.shfmt
    pkgs.silver-searcher
    pkgs.sl
    pkgs.socat
    pkgs.sqlite
    pkgs.tcpdump
    pkgs.tree
    pkgs.vimpager
    pkgs.watch
    pkgs.wdiff
    pkgs.wireshark-cli
    pkgs.xz
    pkgs.zsh
  ];

  programs.home-manager.enable = true;

  programs.command-not-found.enable = true;

  programs.direnv = {
    enable = true;
    # Requires 'keep-outputs = true' in /etc/nix/nix.conf
    enableNixDirenvIntegration = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultOptions = ["--exact"];
  };

  programs.git = {
    package = pkgs.gitAndTools.delta;
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
      pull = {
        default = "current";
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

  programs.gpg.enable = lib.mkDefault false;

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
      nim-vim
      ShowMultiBase
      sky-color-clock-vim
      swift-vim
      tabular
      tcomment_vim
      tlib_vim
      vim-addon-mw-utils
      vim-bufferline
      vim-bufkill
      vim-css-color
      vim-cue
      vim-fugitive
      vim-gitgutter
      vim-nix
      vim-snipmate
      vim-sourcetrail
      vim-terraform
      vim-textobj-comment
      vim-textobj-function
      vim-textobj-user
      zig-vim
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

    plugins = [
      {
        name = "zsh-autopair";
        file = "autopair.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "hlissner";
          repo = "zsh-autopair";
          rev = "34a8bca";
          sha256 = "1h0vm2dgrmb8i2pvsgis3lshc5b0ad846836m62y8h3rdb3zmpy1";
        };
      }
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
      {
        name = "zsh-auto-notify";
        file = "auto-notify.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "MichaelAquilina";
          repo = "zsh-auto-notify";
          rev = "0.8.0";
          sha256 = "02x7q0ncbj1bn031ha7k3n2q2vrbv1wbvpx9w2qxv9jagqnjm3bd";
        };
      }
      {
        name = "gpg-agent-zsh";
        file = "gpg-agent.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "axtl";
          repo = "gpg-agent.zsh";
          rev = "894b908";
          sha256 = "1x8rvvqwb738zj9c66mqcgxr71j9ag5604bppx373ki9p8qjsr78";
        };
      }
      {
        name = "zsh-histdb";
        file = "sqlite-history.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "larkery";
          repo = "zsh-histdb";
          rev = "7c34b55";
          sha256 = "04i8gsixjkqqq0nxmd45wp6irbfp9hy71qqxkq7f6b78aaknljwf";
        };
      }
      {
        name = "zsh-histdb-fzf";
        file = "fzf-histdb.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "paulreimer";
          repo = "zsh-histdb-fzf";
          rev = "2dca5b1";
          sha256 = "11a6fvlwydszhykx0jvpivqllvpz72wimrx8mpdfkp9caswhnw4p";
        };
      }
    ];

    envExtra = builtins.readFile ./zshenv;
  };

  qt.enable = lib.mkDefault false;

  xdg.configFile = {
    # git diff/merge tool configuration
    "git/attributes".source = ./attributes;

    # neovim
    "nvim" = {
      source = ./vim;
      recursive = true;
    };
  };

  home.file = {
    # other dotfiles:
    ".colordiffrc".source = ./colordiffrc;
    ".htoprc".source = ./htoprc;
    ".inputrc".source = ./inputrc;
  };
}
