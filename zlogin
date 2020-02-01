# Basic SSH-agent access for screen terminal multiplexer
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
  echo "Initialising new SSH agent..."
  (umask 066; ssh-agent > "${SSH_ENV}")
  eval "$(<${SSH_ENV})" >/dev/null
  ssh-add -t 10h;
}

# Source SSH settings, if applicable
ssh-add -l &>/dev/null
if [ "$?" = 2 ]; then
  test -r "${SSH_ENV}" && \
    eval "$(<${SSH_ENV})" >/dev/null

  ssh-add -l &>/dev/null
  if [ "$?" = 2 ]; then
    start_agent;
  fi
fi
