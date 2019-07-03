{ pkgs, ... }:

with import <nixpkgs> {};
with builtins;

let
  ccat = buildGoModule rec {
    name = "ccat";
    version = "1.1.0";

    src = fetchFromGitHub {
      owner = "jingweno";
      repo = "ccat";
      rev = "v${version}";
      sha256 = "1mpysig5lvjjjwvs22pz0nj3vh77d77n1l4hch8qmqh5chp3z911";
    };

    modSha256 = "09i0mdlfd58nypga71554cmclngjsc0k7axayjp4k3mh7c0ybbv1";

    subPackages = [ "." ];

    meta = with lib; {
      description = "Colorizing `cat`";
      homepage = https://github.com/jingweno/ccat;
      license = licenses.mit;
      maintainers = with maintainers; [ jingweno ];
      platforms = platforms.linux ++ platforms.darwin;
    };
  };
in
{
  home.packages = [
    pkgs.abduco
    pkgs.bear
    pkgs.ccache
    pkgs.cmake
    pkgs.colordiff
    pkgs.cppcheck
    pkgs.curl
    pkgs.doxygen
    pkgs.exiftool
    pkgs.gdb
    pkgs.git-crypt
    pkgs.gnumake
    pkgs.graphviz
    pkgs.hexedit
    pkgs.influxdb
    pkgs.kitty
    pkgs.libftdi1
    pkgs.ninja
    pkgs.nodejs
    pkgs.openssh
    pkgs.parallel
    pkgs.pinentry
    pkgs.pstree
    pkgs.python
    pkgs.rpl
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
    # Packages with overrides in config.nix:
    pkgs.neovim-unwrapped

    # Custom packages (from let .. in) here:
    ccat
  ];

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
      "difftool \"nbdime\"" = {
        cmd = "git-nbdifftool diff \\\"$LOCAL\\\" \\\"$REMOTE\\\" \\\"$BASE\\\"";
      };
      "mergetool \"nbdime\"" = {
        cmd = "git-nbmergetool merge \\\"$BASE\\\" \\\"$LOCAL\\\" \\\"$REMOTE\\\" \\\"$MERGED\\\"";
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
    configure = {
      customRC = builtins.readFile ./config.vim;
      plug.plugins = with pkgs.vimPlugins; [
        ale
        dart-vim-plugin
        deoplete-jedi
        deoplete-lsp
        deoplete-nvim
        DoxygenToolkit-vim
        editorconfig-vim
        file-line
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
        sky-color-clock-vim
        tabular
        tcomment_vim
        vim-bufferline
        vim-bufkill
        vim-css-color
        vim-fugitive
        vim-gitgutter
        vim-nix
        vim-sourcetrail
        vim-textobj-comment
        vim-textobj-function
        vim-textobj-user
      ];
    };
  };

  qt.enable = true;

  home.file = {
    # git diff/merge tool configuration
    ".config/git/attributes".source = ./attributes;

    # kitty terminal
    ".config/kitty/kitty.conf".source = ./kitty.conf;

    # zsh
    ".zlogin".source = ./zlogin;
    ".zshenv".source = ./zshenv;
    ".zshrc".source = ./zshrc;
    ".zsh/zsh-syntax-highlighting".source = fetchFromGitHub {
       owner = "zsh-users";
       repo = "zsh-syntax-highlighting";
       rev = "d766243";
       sha256 = "01cwhkssyxj4c7hyr1pmn6r11274h7qw3ihdflj5r0fil0chh7hi";
    };

    # vim / neovim
    ".config/nvim/init.vim".source = ./init.vim;
    ".vim/ftplugin/dart.vim".source = ./vim/ftplugin/dart.vim;
    ".vim/ftplugin/diff.vim".source = ./vim/ftplugin/diff.vim;
    ".vim/ftplugin/gitcommit.vim".source = ./vim/ftplugin/gitcommit.vim;

    # Utility apps dotfiles:
    ".colordiffrc".source = ./colordiffrc;
    ".screenrc".source = ./screenrc;
  };
}
