#export PAGER=`which vimpager`
export EDITOR=`which vim`
set -o vi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias vi="`which vim`"
alias h="history 0 | ag"
alias p="ps aux | ag"
alias mmv="noglob zmv -W"
alias diff="colordiff -u"
alias less="less -r"
alias rsync="rsync --progress"

alias make="make -j10"
alias burritotime='say -v "Good News" "burrito time burrito time burrito time burrito time burrito time burrito time"'

hash -d dev="/Users/paulreimer/Development"
hash -d of="/Users/paulreimer/Development/of/HEAD"
hash -d apps="/Users/paulreimer/Development/of/HEAD/apps"
hash -d addons="/Users/paulreimer/Development/of/HEAD/addons"
hash -d my="/Users/paulreimer/Development/of/HEAD/apps/myApps"
hash -d cdn="/Users/paulreimer/Development/webapps/s3/cdn-p-rimes-net"
hash -d wiced="/Users/paulreimer/Development/arm/WICED-SDK"
hash -d vids="/Users/Performance/Users/performance/Movies"
hash -d esp32="/Users/paulreimer/Development/arm/ESP32_RTOS_SDK"

export DOCKER_HOST="tcp://192.168.10.10:2375"

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

export FZF_DEFAULT_OPTS="--exact"

export IDF_PATH="/Users/paulreimer/Development/esp32/pycom-esp-idf"

## Basic SSH-agent access for screen terminal multiplexer
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
  echo "Initialising new SSH agent..."
  /usr/local/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
  echo succeeded
  chmod 600 "${SSH_ENV}"
  . "${SSH_ENV}" > /dev/null
  /usr/local/bin/ssh-add;
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

calc()
{
  noglob echo "$(( $@ ))";
}
calc_hex()
{
  #awk "BEGIN{ print $@ }";
  echo 'printf "%#08x\\n",' "$@" > /tmp/tmp.calc;
  /usr/bin/gdb -q -n -batch -x /tmp/tmp.calc;
}
cdnsync()
{
  s3cmd sync --acl-public --add-header "Cache-Control: max-age=1209600, must-revalidate" ~cdn/ s3://cdn.p-rimes.net;
#  s3cmd setacl --recursive s3://cdn.p-rimes.net;
}

function __clean-cask {
    caskBasePath="/usr/local/Caskroom"
    local cask="$1"
    local caskDirectory="$caskBasePath/$cask"
    local versionsToRemove="$(ls -r $caskDirectory | sed 1,1d)"
    if [[ -n $versionsToRemove ]]; then
        while read versionToRemove ; do
            echo "Removing $cask $versionToRemove..."
            rm -rf "$caskDirectory/$versionToRemove"
        done <<< "$versionsToRemove"
    fi
}

#call this command to cleanup all, or you can specify cask name
function cask-retire {
  if [[ $# -eq 0 ]]; then
      while read cask; do
          __clean-cask "$cask"
      done <<< "$(brew cask list)"
  else
      clean-cask "$1"
  fi
}

function cask-upgrade {
    for app in $(brew cask list); do cver="$(brew cask info "${app}" | head -n 1 | cut -d " " -f 2)"; ivers=$(ls -1 "/usr/local/Caskroom/${app}/.metadata/" | tr '\n' ' ' | sed -e 's/ $//'); aivers=(${ivers}); nvers=$(echo ${#aivers[@]}); echo "[*] Found ${app} in cask list. Latest available version is ${cver}. You have installed version(s): ${ivers}"; if [[ ${nvers} -eq 1 ]]; then echo "${ivers}" | grep -q "^${cver}$" && { echo "[*] Latest version already installed :) Skipping changes ..."; continue; }; fi; echo "[+] Fixing from ${ivers} to ${cver} ..."; brew cask uninstall "${app}" --force; brew cask install "${app}"; done
}

brew() {
  if [ "$1" = "cask" -a "$2" = "upgrade" ]; then
    cask-upgrade
  elif [ "$1" = "cask" -a "$2" = "cleanup" ]; then
    command brew cask cleanup && cask-retire
  else
    command brew "$@"
  fi
}
