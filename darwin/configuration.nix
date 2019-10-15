{ config, lib, pkgs, ... }:

{
  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 10;
  system.defaults.NSGlobalDomain.KeyRepeat = 1;
  system.defaults.NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;
  system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
  system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode2 = true;

  system.defaults.dock.autohide = true;
  system.defaults.dock.showhidden = true;
  system.defaults.dock.mru-spaces = false;

  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.finder.QuitMenuItem = true;
  system.defaults.finder.FXEnableExtensionChangeWarning = false;

  system.defaults.trackpad.Clicking = true;
  system.defaults.trackpad.TrackpadThreeFingerDrag = false;

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToControl = true;

  environment.systemPackages = [
    pkgs.darwin-zsh-completions
    pkgs.skhd
  ];

  services.skhd.enable = true;

  services.nix-daemon.enable = true;
  services.nix-daemon.enableSocketListener = true;

  nix.useSandbox = true;
  nix.sandboxPaths = [ "/System/Library/Frameworks" "/System/Library/PrivateFrameworks" "/usr/lib" "/private/tmp" "/private/var/tmp" "/usr/bin/env" ];

  programs.nix-index.enable = true;

  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;

  environment.variables.LANG = "en_CA.UTF-8";

  environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Use local nixpkgs checkout instead of channels.
  nix.nixPath = [
    "darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix"
    "darwin=$HOME/.nix-defexpr/channels/darwin"
    "nixpkgs=$HOME/Development/nixos/nixpkgs"
  ];


  users.nix.configureBuildUsers = true;
  users.nix.nrBuildUsers = 32;

  nix.maxJobs = 8;
}
