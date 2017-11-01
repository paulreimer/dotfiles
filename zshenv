# directory aliases
hash -d dev="$HOME/Development"
hash -d of="$HOME/Development/of/HEAD"
hash -d apps="$HOME/Development/of/HEAD/apps"
hash -d addons="$HOME/Development/of/HEAD/addons"
hash -d my="$HOME/Development/of/HEAD/apps/myApps"
hash -d cdn="$HOME/Development/webapps/s3/cdn-p-rimes-net"
hash -d wiced="$HOME/Development/arm/WICED-SDK"
hash -d vids="/Users/Performance/Users/performance/Movies"
hash -d esp32="$HOME/Development/esp32"
hash -d wzrd="$HOME/Development/electron/wzrd"
hash -d rn="$HOME/Development/react-native"
hash -d k8s="$HOME/Development/k8s"

# environment variables
export IDF_PATH="$HOME/Development/esp32/esp-idf"
export ESPIDF="$HOME/Development/esp32/micropython-esp-idf"

export ANDROID_HOME="/usr/local/Caskroom/android-sdk/3859397,26.0.2"
export ANDROID_NDK_HOME="/usr/local/Caskroom/android-ndk/15c/android-ndk-r15c"

# PATH
STD_PATH=/usr/sbin:/sbin:/usr/bin:/bin:/usr/X11/bin
BIN_PATH=/usr/local/bin:/usr/local/sbin

##:$HOME/Development/arm/gcc-arm-none-eabi-4_9-2015q2/bin\
#:$HOME/Development/arm/gcc-arm-none-eabi-4_9-2015q3/bin\
#:$HOME/Development/lib/emscripten\

export PATH=\
:$HOME/bin\
:$HOME/Development/fuchsia/topaz/.jiri_root/bin\
:$HOME/Development/flutter/flutter/bin\
:$HOME/Development/lib/spark-2.2.0-k8s-0.4.0-bin-2.7.3/bin\
:$HOME/Development/esp32/xtensa-esp32-elf/bin\
:/usr/local/opt/curl/bin\
:/usr/local/opt/llvm/bin\
:/usr/local/opt/go/libexec/bin\
:$BIN_PATH\
:$STD_PATH

# Skip all this for non-interactive shells
[[ -z "$PS1" ]] && return

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/paulreimer/.config/yarn/global/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/paulreimer/.config/yarn/global/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/paulreimer/.config/yarn/global/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/paulreimer/.config/yarn/global/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh

## Basic SSH-agent access for screen terminal multiplexer
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
  echo "Initialising new SSH agent..."
  ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
  echo succeeded
  chmod 600 "${SSH_ENV}"
  . "${SSH_ENV}" > /dev/null
  ssh-add;
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
