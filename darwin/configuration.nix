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

  nixpkgs.overlays = [
    (self: super: {
      darwin-zsh-completions = super.runCommandNoCC "darwin-zsh-completions-0.0.0"
        { preferLocalBuild = true; }
        ''
          mkdir -p $out/share/zsh/site-functions
          cat <<-'EOF' > $out/share/zsh/site-functions/_darwin-rebuild
          #compdef darwin-rebuild
          #autoload
          _nix-common-options
          local -a _1st_arguments
          _1st_arguments=(
            'switch:Build, activate, and update the current generation'\
            'build:Build without activating or updating the current generation'\
            'check:Build and run the activation sanity checks'\
            'changelog:Show most recent entries in the changelog'\
          )
          _arguments \
            '--list-generations[Print a list of all generations in the active profile]'\
            '--rollback[Roll back to the previous configuration]'\
            {--switch-generation,-G}'[Activate specified generation]'\
            '(--profile-name -p)'{--profile-name,-p}'[Profile to use to track current and previous system configurations]:Profile:_nix_profiles'\
            '1:: :->subcmds' && return 0
          case $state in
            subcmds)
              _describe -t commands 'darwin-rebuild subcommands' _1st_arguments
            ;;
          esac
          EOF
        '';
    })
  ];

  users.nix.configureBuildUsers = true;
  users.nix.nrBuildUsers = 32;

  nix.maxJobs = 8;
}
