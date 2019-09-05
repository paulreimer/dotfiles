# Default shell settings
#export EDITOR=`command -v nvim`
export EDITOR=`command -v nvr --remote`
export GIT_EDITOR=`command -v nvim`
export KUBE_EDITOR=`command -v nvim`
export HOMEBREW_EDITOR=`command -v nvim`
export SUDO_EDITOR=`command -v nvim`
export SYSTEMD_EDITOR=`command -v nvim`
export SVN_EDITOR=`command -v nvim`
set -o vi

# Additional autocompletion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Command aliases
#alias vi="nvim"
#alias vim="nvim"
alias ag="ag --no-heading"
alias vi="nvr --remote"
alias vim="nvr --remote"
alias h="history 0 | ag"
alias ls="ls -Ghp"
alias p="ps aux | ag"
alias g="git clone --recursive"
alias c="noglob curl -LO"
alias gmoji="gitmoji -c"
alias k="kubectl"
alias mmv="noglob zmv -W"
alias rsync="rsync --progress"
alias cat="ccat -G String=green -G Plaintext=lightgrey -G Type=gray -G Punctuation=gray -G Keyword=darkyellow -G Decimal=fuchsia -G Comment=gray"
alias cmake="cmake -G Ninja"
alias ccmake="ccmake -G Ninja"
alias urlencode='python3 -c "import sys, urllib.parse as up; print(up.quote_plus(sys.argv[1]))"'
alias urldecode='python3 -c "import sys, urllib.parse as up; print(up.unquote_plus(sys.argv[1]))"'
alias astyle="astyle --style=allman --indent=spaces=2"

# Helper functions
calc()
{
  noglob echo "$(( $@ ))";
}
calc_hex()
{
  echo 'printf "%#08x\\n",' "$@" > /tmp/tmp.calc;
  /usr/bin/gdb -q -n -batch -x /tmp/tmp.calc;
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
cd() {
  nvr --remote-send "<C-\><C-n>:lcd ${1:a}<cr>i"
  builtin cd "$@"
}

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
