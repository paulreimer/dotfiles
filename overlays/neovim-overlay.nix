self: super: {
  neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (oldAttrs: rec {
    version = "0.5.0-dev";
    name = "neovim-unwrapped-${version}";

    buildInputs = oldAttrs.buildInputs ++ [ super.utf8proc super.tree-sitter ];

    src = super.pkgs.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "1caf58578c6e4b30c18fa56804dd905b5472b460"; # 2021-02-20
      sha256 = "1ji77myn7h8l725d7vgrp71kswvy8k6iy45a6rab7dmxh8jpqk1j";
    };
  });
}
