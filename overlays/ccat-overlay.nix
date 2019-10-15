self: super: {
  ccat = super.buildGoPackage rec {
    pname = "ccat";
    version = "1.1.0";

    src = super.fetchFromGitHub {
      owner = "jingweno";
      repo = "ccat";
      rev = "v${version}";
      sha256 = "1mpysig5lvjjjwvs22pz0nj3vh77d77n1l4hch8qmqh5chp3z911";
    };

    modSha256 = "09i0mdlfd58nypga71554cmclngjsc0k7axayjp4k3mh7c0ybbv1";

    goPackagePath = "github.com/jingweno/ccat";

    subPackages = [ "." ];

    meta = with super.lib; {
      description = "Colorizing `cat`";
      homepage = https://github.com/jingweno/ccat;
      license = licenses.mit;
      maintainers = with maintainers; [ jingweno ];
      platforms = platforms.unix;
    };
  };
}
