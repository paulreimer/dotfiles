# Default shell settings
export EDITOR=`which nvim`
set -o vi

# Additional autocompletion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
which kubectl 1>/dev/null && source <(kubectl completion zsh)
which gcloud 1>/dev/null && source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
which gcloud 1>/dev/null && source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'

# Command aliases
alias vi="`which nvim`"
alias vim="`which nvim`"
alias h="history 0 | ag"
alias ls="ls -Ghp"
alias p="ps aux | ag"
alias mmv="noglob zmv -W"
alias diff="colordiff -u"
alias less="less -r"
alias rsync="rsync --progress"
alias cat="ccat -G String=green -G Plaintext=lightgrey -G Type=gray -G Punctuation=gray -G Keyword=darkyellow -G Decimal=fuchsia -G Comment=darkgray"

# Machine-specific command aliases
alias astyle="astyle --style=allman --indent=spaces=2"
alias rtlsdr_scanner="python -m rtlsdr_scanner"

alias make="make -j10"
alias burritotime='say -v "Good News" "burrito time burrito time burrito time burrito time burrito time burrito time"'

alias jupyter-qtconsole='/usr/local/miniconda3/envs/intelpy/bin/jupyter-qtconsole --ConsoleWidget.font_family="Roboto Mono for Powerline" --ConsoleWidget.font_size=11 --style monokai'
alias spark-submit='/Users/paulreimer/Development/ops/spark/bin/spark-submit --deploy-mode cluster --master k8s://http://127.0.0.1:8001 --kubernetes-namespace spark --conf spark.kubernetes.driver.docker.image=gcr.io/p-rimes-net/spark-driver-py:v2.2.0-kubernetes-0.5.0 --conf spark.kubernetes.executor.docker.image=gcr.io/p-rimes-net/spark-executor-py:v2.2.0-kubernetes-0.5.0 --conf spark.kubernetes.initcontainer.docker.image=gcr.io/p-rimes-net/spark-init:v2.2.0-kubernetes-0.5.0'

# Environment variables
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export FZF_DEFAULT_OPTS="--exact"

# Enable color support of ls on macOS
export CLICOLOR=1

# Use a real tty for GPG pinentry/gpg-agent
export GPG_TTY=$(tty)

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
cdnsync()
{
  s3cmd sync --acl-public --add-header "Cache-Control: max-age=1209600, must-revalidate" ~cdn/ s3://cdn.p-rimes.net;
}

# Add custom sub-commands to brew
brew() {
  # Add support for `brew cask upgrade`, install via:
  # `brew tap buo/cask-upgrade`
  if [ "$1" = "cask" -a "$2" = "upgrade" ]; then
    command brew cu -a -f
  else
    command brew "$@"
  fi
}
