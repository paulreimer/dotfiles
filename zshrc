# Skip all this for non-interactive shells
[[ -z "$PS1" ]] && return

autoload -U zutil
autoload -U compinit
compinit
autoload -U promptinit
promptinit
prompt bart purple blue green cyan

# Renaming with globbing
autoload zmv

# Zsh settings for history
export HISTIGNORE="&:ls:[bf]g:exit:reset:clear:cd:cd ..:cd.."
export HISTFILE=~/.zsh_history
export HISTSIZE=1000
export SAVEHIST=1000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS

# Background processes aren't killed on exit of shell
setopt AUTO_CONTINUE

setopt MENUCOMPLETE

setopt autocd

# Enable color support of ls
if [[ "$TERM" != "dumb" ]]; then
  if [[ -x `which dircolors` ]]; then
    eval `dircolors -b`
    alias 'ls=ls --color=auto'
  fi
fi

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

# Complete PIDS with menu
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always

#http://ubuntuforums.org/showthread.php?t=1322512
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
#zstyle ':completion:*:*:kill:*:processes' command 'ps --forest -A -o pid,user,command'
zstyle ':completion:*:*:kill:*:processes' command 'pstree'
zstyle ':completion:*:processes-names' command 'ps axho command'

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

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
