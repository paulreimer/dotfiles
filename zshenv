### Environment variables
export FZF_DEFAULT_OPTS="--exact"

# Enable GCC colors always (including ccache)
export GCC_COLORS=1

# nixpkgs
export NIX_PATH=$HOME/.nix-defexpr/channels:nixpkgs=$HOME/Development/nixos/nixpkgs

# nix
if [ -e /home/paul/.nix-profile/etc/profile.d/nix.sh ]; then
  . /home/paul/.nix-profile/etc/profile.d/nix.sh
fi

# PATH
STD_PATH=/usr/sbin:/sbin:/usr/bin:/bin:/usr/X11/bin:/usr/games
BIN_PATH=/usr/local/bin:/usr/local/sbin

export PATH=\
:$HOME/bin\
:$BIN_PATH\
:$STD_PATH
