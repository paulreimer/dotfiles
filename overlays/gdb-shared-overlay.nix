self: super: {
  gdb-shared = super.gdb.overrideAttrs (oldAttrs: rec {
    configureFlags = with self.stdenv.lib; [
      "--enable-targets=all" "--enable-64-bit-bfd"
      "--enable-shared"
      "--with-system-zlib"
      "--with-system-readline"

      "--with-gmp=${super.gmp.dev}"
      "--with-mpfr=${super.mpfr.dev}"
      "--with-expat" "--with-libexpat-prefix=${super.expat.dev}"
    ];
  });
}
