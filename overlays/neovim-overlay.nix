self: super: {
  neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (oldAttrs: rec {
    version = "0.5.0-dev";
    name = "neovim-unwrapped-${version}";

    buildInputs = oldAttrs.buildInputs ++ [ super.utf8proc super.tree-sitter ];

    src = super.pkgs.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "a282a177d3320db25fa8f854cbcdbe0bc6abde7f"; # 2021-06-26
      sha256 = "03ckzr75jf1mps0y3v9rj2jifsfapkpqyxaw1rs5ify9zdmja593";
    };
  });
}
