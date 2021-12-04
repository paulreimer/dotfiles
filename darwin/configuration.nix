{ config, lib, pkgs, ... }:

{
  nix.package = pkgs.nixUnstable;

  nix.extraOptions = ''
    experimental-features = nix-command flakes ca-references
  '';

  system.defaults.NSGlobalDomain.AppleKeyboardUIMode = 3;
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
  system.keyboard.userKeyMapping = [
    {
      # From: CapsLock (0x700000039)
      HIDKeyboardModifierMappingSrc = 30064771129;
      # To: F18 (0x70000006D)
      HIDKeyboardModifierMappingDst = 30064771181;
    }
  ];

  services.skhd.enable = true;
  services.skhd.skhdConfig = ''
    # focus window
    cmd - h : yabai -m window --focus west
    cmd - j : yabai -m window --focus south
    cmd - k : yabai -m window --focus north
    cmd - l : yabai -m window --focus east

    # move window
    shift + cmd - h : yabai -m window --warp west
    shift + cmd - j : yabai -m window --warp south
    shift + cmd - k : yabai -m window --warp north
    shift + cmd - l : yabai -m window --warp east

    # make floating window fill screen
    shift + alt - up     : yabai -m window --grid 1:1:0:0:1:1

    # fast focus space
    # (done in System Preferences -> Keyboard -> Shortcuts)

    # send window to space and follow focus
    shift + cmd - 1 : yabai -m window --space  1; yabai -m space --focus 1
    shift + cmd - 2 : yabai -m window --space  2; yabai -m space --focus 2
    shift + cmd - 3 : yabai -m window --space  3; yabai -m space --focus 3
    shift + cmd - 4 : yabai -m window --space  4; yabai -m space --focus 4
    shift + cmd - 5 : yabai -m window --space  5; yabai -m space --focus 5
    shift + cmd - 6 : yabai -m window --space  6; yabai -m space --focus 6
    shift + cmd - 7 : yabai -m window --space  7; yabai -m space --focus 7
    shift + cmd - 8 : yabai -m window --space  8; yabai -m space --focus 8
    shift + cmd - 9 : yabai -m window --space  9; yabai -m space --focus 9
    shift + cmd - 0 : yabai -m window --space 10; yabai -m space --focus 10

    # toggle window fullscreen zoom
    alt - f : yabai -m window --toggle zoom-fullscreen

    # float / unfloat window and center on screen
    alt - t : yabai -m window --toggle float;\
              yabai -m window --grid 4:4:1:1:2:2

    # open launcher
    cmd - space : /Users/paulreimer/.nix-profile/bin/kitty -o font_size=16 -o remember_window_size=no -o initial_window_width=1440 -o initial_window_height=500 /Users/paulreimer/bin/launcher
  '';

  services.nix-daemon.enable = true;
  services.nix-daemon.enableSocketListener = true;

  services.yabai.enable = true;
  services.yabai.package = pkgs.yabai;
  services.yabai.config = {
    mouse_follows_focus = "on";
    focus_follows_mouse = "autofocus";
    window_placement = "second_child";
    window_topmost = "off";
    window_opacity = "off";
    window_shadow = "off";
    window_border = "off";
    split_ratio = 0.50;
    auto_balance = "off";
    layout = "bsp";
  };
  services.yabai.extraConfig = ''
    # disable tiling on workspace 1
    yabai -m config --space 1 layout float
  '';

  nix.useSandbox = true;
  nix.sandboxPaths = [ "/System/Library/Frameworks" "/System/Library/PrivateFrameworks" "/usr/lib" "/private/tmp" "/private/var/tmp" "/usr/bin/env" ];

  programs.nix-index.enable = true;

  environment.variables.LANG = "en_CA.UTF-8";

  users.nix.configureBuildUsers = true;
  users.nix.nrBuildUsers = 32;

  nix.maxJobs = 8;
}
