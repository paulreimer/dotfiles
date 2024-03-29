# Machine-specific environment variables
export FZF_DEFAULT_OPTS="--exact"

# Enable GCC colors always (including ccache)
export GCC_COLORS=1

# Machine-specific directory aliases

# Machine-specific command aliases

# Machine-specific functions

# nix
if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
  . "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi

# PATH
STD_PATH=/usr/sbin:/sbin:/usr/bin:/bin:/usr/X11/bin:/usr/games
BIN_PATH=/usr/local/bin:/usr/local/sbin

export PATH=\
:$HOME/bin\
:$BIN_PATH\
:$STD_PATH
