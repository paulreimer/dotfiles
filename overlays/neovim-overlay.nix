self: super: {
  neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (oldAttrs: rec {
    version = "0.4.0-dev";
    name = "neovim-unwrapped-${version}";

    src = super.pkgs.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "3e58e60"; # 2019-06-10, last commit before libluv added
      sha256 = "0gbdj3ziaxmwsivp6g6kkjbfq9r207l64pdmv6clrc6cc8d21sr7";
    };
  });
}
