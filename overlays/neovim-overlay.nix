self: super: {
  neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (oldAttrs: rec {
    version = "0.5.0";
    name = "neovim-unwrapped-${version}";

    buildInputs = oldAttrs.buildInputs ++ [ super.utf8proc super.tree-sitter ];

    src = super.pkgs.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "v0.5.0";
      sha256 = "0lgbf90sbachdag1zm9pmnlbn35964l3khs27qy4462qzpqyi9fi";
    };
  });
}
