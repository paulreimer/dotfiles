self: super: {
  kitty = super.kitty.overrideAttrs (oldAttrs: rec {
    version = "0.19.3";
    name = "kitty-${version}";

    src = super.pkgs.fetchFromGitHub {
      owner = "kovidgoyal";
      repo = "kitty";
      rev = "v${version}";
      sha256 = "0r49bybqy6c0n1lz6yc85py80wb40w757m60f5rszjf200wnyl6s";
    };
  });
}
