# Directory aliases

# PATH
STD_PATH=/usr/sbin:/sbin:/usr/bin:/bin:/usr/X11/bin:/usr/games
BIN_PATH=/usr/local/bin:/usr/local/sbin

export PATH=\
:$HOME/bin\
:$BIN_PATH\
:$STD_PATH

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

# Skip all this for non-interactive shells
[[ -z "$PS1" ]] && return

# Machine-specific command aliases
#alias make="make -j N"
alias open="xdg-open"

# direnv
_direnv_hook() {
  eval "$(direnv export zsh)";
}
typeset -ag precmd_functions;
if [[ -z ${precmd_functions[(r)_direnv_hook]} ]]; then
  precmd_functions+=_direnv_hook;
fi

## Basic SSH-agent access for screen terminal multiplexer
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
  echo "Initialising new SSH agent..."
  ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
  echo succeeded
  chmod 600 "${SSH_ENV}"
  . "${SSH_ENV}" > /dev/null
  ssh-add -c;
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
  . "${SSH_ENV}" > /dev/null
  ps ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
    start_agent;
  }
else
  start_agent;
fi
