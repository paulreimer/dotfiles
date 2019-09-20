### ZSH configuration
autoload -U zutil
autoload -U promptinit && promptinit
prompt bart purple blue green cyan

# Renaming with globbing
autoload zmv

# Ignore common commands with common arguments
export HISTIGNORE="&:ls:[bf]g:exit:reset:clear:cd:cd ..:cd.."

# Reduce/avoid dupes in history
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_FIND_NO_DUPS

# Share zsh history across all shells
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY

# Background processes aren't killed on exit of shell
setopt AUTO_CONTINUE

setopt MENUCOMPLETE

# Just type a directory name to change to it
setopt autocd

### Completion settings
# Suggested tweaks from zsh-lovers
# http://grml.org/zsh/zsh-lovers.html
# Use completion cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Ignore SCM revision files
zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/)(CVS|.svn|.git)'
zstyle ':completion:*:cd:*' ignored-patterns '(*/)#(CVS|.svn|.git)'

# Fuzzy completion
zstyle ':completion:*' completer _expand _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Do not attempt to complete missing commands
#zstyle ':completion:*:functions' ignored-patterns '_*'

# Tweaks from
# http://recurser.com/articles/2007/07/25/os-x-zsh-shell-config/
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' menu select=1 _complete _ignored _approximate

# Do not add space after completion
#zstyle ':completion:*' add-space false

# Complete from ssh known_hosts
local _myhosts
_myhosts=( ${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*} )
zstyle ':completion:*' hosts $_myhosts

### Default shell settings
set -o vi
#export EDITOR=`command -v nvim`
export EDITOR=`command -v nvr --remote`
export GIT_EDITOR=`command -v nvim`
export KUBE_EDITOR=`command -v nvim`
export HOMEBREW_EDITOR=`command -v nvim`
export SUDO_EDITOR=`command -v nvim`
export SYSTEMD_EDITOR=`command -v nvim`
export SVN_EDITOR=`command -v nvim`

### Environment variables
export FZF_DEFAULT_OPTS="--exact"

# Enable color support of ls on macOS
export CLICOLOR=1

# Use a real tty for GPG pinentry/gpg-agent
export GPG_TTY=$(tty)

# Directory aliases
hash -d dev="$HOME/Development"

# Command aliases
#alias vi="nvim"
#alias vim="nvim"
alias ag="ag --no-heading"
alias vi="nvr --remote"
alias vim="nvr --remote"
alias xvi="xargs nvr --remote"
alias h="history 0 | ag"
alias ls="ls -Ghp"
alias p="ps aux | ag"
alias g="git clone --recursive"
alias c="noglob curl -LO"
alias k="kubectl"
alias gmoji="gitmoji -c"
alias mmv="noglob zmv -W"
alias rsync="rsync --progress"
alias cat="ccat -G String=green -G Plaintext=lightgrey -G Type=gray -G Punctuation=gray -G Keyword=darkyellow -G Decimal=fuchsia -G Comment=gray"
alias cmake="cmake -G Ninja"
alias ccmake="ccmake -G Ninja"
alias urlencode='python3 -c "import sys, urllib.parse as up; print(up.quote_plus(sys.argv[1]))"'
alias urldecode='python3 -c "import sys, urllib.parse as up; print(up.unquote_plus(sys.argv[1]))"'
alias astyle="astyle --style=allman --indent=spaces=2"

# Machine-specific environment variables

# Machine-specific directory aliases

# Machine-specific command aliases

### Functions
# Helper functions
calc()
{
  noglob echo "$(( $@ ))";
}

# Add custom diff output
diff() {
  # Reformat (uncolorized) diff output to make yanking files easier
  if [ "$1" = "-qr" -o "$1" = "-q" ]; then
    command /usr/bin/diff -qr "$@" | \
      sed \
        -e 's/^Files \(.*\) and \(.*\) differ$/Files differ: \1 \2/;' \
        -e 's/^Only in \(.*\): \(.*\)$/File only in: \1\/\2/;'
  else
    command colordiff -u "$@"
  fi
}

# Change nvim directory when cd'ing
if [[ $options[zle] = on && ! -z "$NVIM_LISTEN_ADDRESS" ]]; then
cd() {
    nvr --remote-send "<C-\><C-n>:lcd ${1:a}<cr>i"
  builtin cd "$@"
}
fi

# Execute OAuth request and extract value from response
oauth() {
  OAUTH_TOKEN_ENDPOINT="$1"
  OAUTH_CLIENT_ID="$2"
  OAUTH_CLIENT_SECRET="$3"
  OAUTH_GRANT_TYPE="${4:-refresh_token}"
  OAUTH_VALUE="$5"
  OAUTH_DESIRED_VALUE="${6:-access_token}"
  OAUTH_EXTRA_ARGS="$7"

  case "${OAUTH_GRANT_TYPE}" in
  refresh_token)
    OAUTH_PARAM="refresh_token"
    ;;
  authorization_code)
    OAUTH_PARAM="code"
    ;;
  esac

  command curl --silent \
    -X POST "${OAUTH_TOKEN_ENDPOINT}" \
    -H "Content-Type: application/x-www-form-urlencoded" \
    -d "grant_type=${OAUTH_GRANT_TYPE}&client_id=${OAUTH_CLIENT_ID}&client_secret=${OAUTH_CLIENT_SECRET}&${OAUTH_PARAM}=${OAUTH_VALUE}${OAUTH_EXTRA_ARGS}" \
      | jq .${OAUTH_DESIRED_VALUE} -r
}

# Extract access token from Google OAuth
gauth() {
  OAUTH_CLIENT_ID="$1"
  OAUTH_CLIENT_SECRET="$2"
  OAUTH_REFRESH_TOKEN="$3"

  oauth "https://www.googleapis.com/oauth2/v4/token" "$1" "$2" "refresh_token" "$3"
}

# Machine-specific functions
