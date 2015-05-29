#export PAGER=`which vimpager`
export EDITOR=`which vim`
set -o vi

alias vi="`which vim`"
#alias mvim="open -a MacVim"
#alias vi="mvim"
alias h="history -1000 | ack"
alias p="ps aux | ack"
alias mmv="noglob zmv -W"
alias diff="colordiff -u"
#alias ack -a="ack --type-set='all:match:.*' -k"
ack() {
  if [ "$1" = -a ]; then
    shift
    set -- --type-set='all:match:.*' -k "$@"
  elif [ "$1" = -ag ]; then
    shift
    set -- --type-set='all:match:.*' -k -g "$@"
  elif [ "$1" = -al ]; then
    shift
    set -- --type-set='all:match:.*' -k -l "$@"
  fi
  command ack "$@"
}

brew() {
  if [ "$1" = "cask" -a "$2" = "upgrade" ]; then
    command brew cask list | xargs brew cask install
  else
    command brew "$@"
  fi
}

alias make="make -j10"
alias compile="make -j1 1>/dev/null 2>&1 | grep error"
alias pprof="pprof --ignore='^0x([19f]|02aa)' --mean_delay"
alias urldecode='python -c "import sys, urllib as ul; print ul.unquote_plus(sys.stdin.read())"'
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.stdin.read())"'
#alias ocd='openocd -f /Volumes/paulreimer/Development/arm/stm32f4_stlink.cfg'
alias ocd='openocd -f board/stm32f4discovery.cfg'

hash -d dev="/Volumes/paulreimer/Development"
hash -d of="/Volumes/paulreimer/Development/of/HEAD"
hash -d apps="/Volumes/paulreimer/Development/of/HEAD/apps"
hash -d addons="/Volumes/paulreimer/Development/of/HEAD/addons"
hash -d my="/Volumes/paulreimer/Development/of/HEAD/apps/my"
hash -d cdn="/Volumes/paulreimer/Development/webapps/s3/cdn-p-rimes-net"

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

## Basic SSH-agent access for screen terminal multiplexer
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
  echo "Initialising new SSH agent..."
  /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
  echo succeeded
  chmod 600 "${SSH_ENV}"
  . "${SSH_ENV}" > /dev/null
  /usr/bin/ssh-add;
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

migrate-pb()
{
  old_pb=$1
  old_pb_dir=`dirname "$old_pb"`

  new_pb=$2
  new_pb_dir=`dirname "$new_pb"`

  msg_type=$3

  old_pb_file=$4
  new_pb_file=$5

  echo "protoc -I $old_pb_dir $old_pb --decode $msg_type < $old_pb_file | \
  protoc -I $new_pb_dir $new_pb --encode $msg_type > $new_pb_file"
}

arm-install()
{
  arm-none-eabi-gdb -ex "target extended :3333" -ex "monitor reset halt" -ex "file $1" -ex "load $1" -ex "monitor reset halt" -ex "continue"
}

arm-debug()
{
  arm-none-eabi-gdb -ex "target extended :3333" -ex "monitor reset halt" -ex "file $1" -ex "load $1" -ex "monitor reset halt"
}

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
rip()
{
  ffmpeg -i $1 -vcodec copy -f mpeg2video $2;
}
cdnsync()
{
  s3cmd sync --acl-public --add-header "Cache-Control: max-age=1209600, must-revalidate" ~cdn/ s3://cdn.p-rimes.net;
#  s3cmd setacl --recursive s3://cdn.p-rimes.net;
}
notify()
{
  cprowl -a df433f9d385cbe63688565cc733c2ed1c7d8af79 -n iTerm -e "$1" -d "$2"
}
slowcmd()
{
  $@;
  if [ $? -eq 0 ] ; then
    notify "$1" "Finished successfully";
  else
    notify "$1" "Failed";
  fi
}
