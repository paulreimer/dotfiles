{ pkgs, ... }:

with import <nixpkgs> {};

{
  imports = [ ./common.nix ];

  home.packages = [
    # Machine-specific packages:
    pkgs.ansible
    pkgs.arping
    pkgs.asciinema
    pkgs.astyle
    pkgs.audiofile
    pkgs.autoconf
    pkgs.automake
    pkgs.avahi
    pkgs.awscli
    pkgs.bash
    pkgs.cfssl
    pkgs.cocoapods
    pkgs.cppcheck
    pkgs.cpplint
    pkgs.cue
    pkgs.cunit
    pkgs.darwin.lsusb
    pkgs.dfu-util
    pkgs.dmd
    pkgs.dnscrypt-proxy2
    pkgs.docker-compose
    pkgs.docker-credential-gcr
    pkgs.docker-machine
    pkgs.docker-sync
    pkgs.dotnet-sdk
    pkgs.doxygen
    pkgs.drone-cli
    pkgs.eigen
    pkgs.erlangR23
    pkgs.ffmpeg-full
    pkgs.fftw
    pkgs.fftw.dev
    pkgs.flatbuffers
    pkgs.flatcc
    pkgs.fontforge
    pkgs.freenect
    pkgs.fswatch
    pkgs.gawk
    pkgs.gcsfuse
    pkgs.gdb-shared
    pkgs.gdrive
    pkgs.git-crypt
    pkgs.gleam
    pkgs.glfw
    pkgs.gn
    pkgs.gnupg
    pkgs.gnused
    pkgs.go
    pkgs.google-clasp
    pkgs.google-cloud-sdk
    pkgs.gperf
    pkgs.gradle
    pkgs.graphviz
    pkgs.grpc
    pkgs.help2man
    pkgs.html-tidy
    pkgs.icestorm
    pkgs.influxdb
    pkgs.irssi
    pkgs.jemalloc
    pkgs.just
    pkgs.kitty
    pkgs.kubectl
    pkgs.kubernetes-helm
    pkgs.leveldb
    pkgs.libftdi1
    pkgs.libmicrohttpd
    pkgs.libsamplerate
    pkgs.libtool
    pkgs.libvirt
    pkgs.libxml2
    pkgs.libxslt
    pkgs.linkerd
    pkgs.magic-wormhole
    pkgs.mercurial
    pkgs.meson
    pkgs.mosh
    pkgs.mynewt-newt
    pkgs.ncurses
    pkgs.neovim-remote
    pkgs.nextpnr
    pkgs.nim
    pkgs.niv
    pkgs.nodejs-12_x
    pkgs.ola
    pkgs.packer
    pkgs.pinentry
    pkgs.pinentry-curses
    pkgs.pinentry_mac
    pkgs.protobuf
    pkgs.pulumi-bin
    pkgs.qrencode
    pkgs.readline
    pkgs.recode
    pkgs.rustup
    pkgs.s3cmd
    pkgs.sdcc
    pkgs.sigrok-cli
    pkgs.skaffold
    pkgs.sox
    pkgs.stlink
    pkgs.taglib
    pkgs.telnet
    pkgs.terraform
    pkgs.tryton
    pkgs.trytond
    pkgs.unbound
    pkgs.verilator
    pkgs.wget
    pkgs.wireguard-go
    pkgs.wireguard-tools
    pkgs.wrk
    pkgs.wxmac
    pkgs.xmlstarlet
    pkgs.xsv
    pkgs.yarn
    pkgs.youtube-dl

    # Custom packages (from let .. in) here:
  ] ++ (
    if stdenv.isDarwin then [
      pkgs.darwin-zsh-completions
      pkgs.osxfuse
    ]
    else if stdenv.isLinux then [
      pkgs.lshw
      pkgs.pixiecore
      pkgs.strace
      pkgs.usbutils

      # sway desktop environment
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
