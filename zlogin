# Default shell settings
#export EDITOR=`command -v nvim`
export EDITOR=`command -v nvr --remote`
set -o vi

# Additional autocompletion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Command aliases
#alias vi="nvim"
#alias vim="nvim"
alias vi="nvr --remote"
alias vim="nvr --remote"
alias h="history 0 | ag"
alias ls="ls -Ghp"
alias p="ps aux | ag"
alias g="git clone --recursive"
alias gmoji="gitmoji -c"
alias k="kubectl"
alias mmv="noglob zmv -W"
alias rsync="rsync --progress"
alias cat="ccat -G String=green -G Plaintext=lightgrey -G Type=gray -G Punctuation=gray -G Keyword=darkyellow -G Decimal=fuchsia -G Comment=darkgray"
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
