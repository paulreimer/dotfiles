# Skip all this for non-interactive shells
[[ -z "$PS1" ]] && return

autoload -U zutil
autoload -U compinit && compinit
autoload -U promptinit && promptinit
prompt bart purple blue green cyan

# Renaming with globbing
autoload zmv

# History file settings
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

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

# Add command line highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
