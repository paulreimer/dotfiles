{ pkgs, ... }:

{
  imports = [ ./common.nix ];

  home.packages = with pkgs; [
    # Machine-specific packages:
    ansible
    arping
    asciinema
    astyle
    audiofile
    autoconf
    automake
    avahi
    awscli
    bash
    borgbackup
    cfssl
    cocoapods
    cppcheck
    cpplint
    cue
    cunit
    darwin.lsusb
    dfu-util
    dmd
    dnscrypt-proxy2
    docker-compose
    docker-credential-gcr
    docker-machine
    docker-sync
    dotnet-sdk
    doxygen
    drone-cli
    eigen
    erlangR23
    ffmpeg-full
    fftw
    fftw.dev
    flatbuffers
    flatcc
    fontforge
    freenect
    fswatch
    gawk
    gcsfuse
    gdb-shared
    gdrive
    git-crypt
    gleam
    glfw
    gn
    gnupg
    gnused
    go
    google-clasp
    google-cloud-sdk
    gperf
    gradle
    graphviz
    grpc
    help2man
    html-tidy
    icestorm
    influxdb
    irssi
    jemalloc
    just
    kitty
    kubectl
    kubernetes-helm
    leveldb
    libftdi1
    libmicrohttpd
    libsamplerate
    libtool
    libvirt
    libxml2
    libxslt
    linkerd
    magic-wormhole
    mercurial
    meson
    mosh
    mynewt-newt
    ncurses
    neovim-remote
    nextpnr
    nim
    niv
    nodejs-12_x
    ola
    packer
    pinentry
    pinentry-curses
    pinentry_mac
    protobuf
    pulumi-bin
    pv
    qrencode
    readline
    recode
    rustup
    s3cmd
    sdcc
    shellcheck
    shfmt
    sigrok-cli
    skaffold
    sox
    stlink
    taglib
    telnet
    terraform
    tryton
    trytond
    unbound
    verilator
    wget
    wireguard-go
    wireguard-tools
    wrk
    wxmac
    xmlstarlet
    xsv
    yarn
    youtube-dl

    # Custom packages (from let .. in) here:
  ] ++ (
    if pkgs.stdenv.isDarwin then [
      darwin-zsh-completions
      osxfuse
    ]
    else if pkgs.stdenv.isLinux then [
      lshw
      pixiecore
      strace
      usbutils

      # sway desktop environment
      grim
      mako
      slurp
      sway
      swayidle
      swaylock
      wev
      wl-clipboard
      xwayland
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
  } // (if pkgs.stdenv.isDarwin then {
    # macOS-specific files
  }
  else if pkgs.stdenv.isLinux then {
    # Linux-specific files
    ".config/sway/config".source = ./swayconfig;
  }
  else {});

  programs.zsh = {
  } // (if pkgs.stdenv.isDarwin then {
    envExtra = builtins.readFile ./zshenv_macos;
  }
  else if pkgs.stdenv.isLinux then {
    envExtra = builtins.readFile ./zshenv;
  }
  else {});
}
