{ pkgs, ... }:

with import <nixpkgs> {};
with builtins;

{
  imports = [ ./common.nix ];

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

  programs.gpg.enable = true;

  qt.enable = true;

  xdg.configFile = {
    # kitty terminal
    "kitty/kitty.conf".source = ./kitty.conf;

    # git diff/merge tool configuration
    "git/attributes".source = ./attributes;
  };

  home.file = {
    # fzf-based launcher
    "bin/launcher".source = ./launcher;

    # vim / neovim
    ".vim/ftplugin/dart.vim".source = ./vim/ftplugin/dart.vim;
    ".vim/ftplugin/diff.vim".source = ./vim/ftplugin/diff.vim;
    ".vim/ftplugin/gitcommit.vim".source = ./vim/ftplugin/gitcommit.vim;

    # other dotfiles:
    ".colordiffrc".source = ./colordiffrc;
    ".htoprc".source = ./htoprc;
    ".inputrc".source = ./inputrc;

    # gpg
    ".gnupg/gpg-agent.conf".source = ./gpg-agent.conf;
  } // (if stdenv.isDarwin then {
    # macOS built-in key remapping (CapsLock -> F18)
    "Library/LaunchAgents/net.p-rimes.capslock_as_f18.plist".source = ./net.p-rimes.capslock_as_f18.plist;
  }
  else if stdenv.isLinux then {
    # sway tiling window manager
    ".config/sway/config".source = ./swayconfig;
  }
  else {});

  programs.zsh.envExtra = builtins.readFile ./zshenv;
}
