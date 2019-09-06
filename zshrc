# History file settings
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

# Load autocompletion here if it is not already loaded
autoload -U compinit && compinit

# Additional autocompletion
command -v kubectl 1>/dev/null && source <(kubectl completion zsh)
#command -v gcloud 1>/dev/null && source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
command -v gcloud 1>/dev/null && source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'

# Add command line highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
source $HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Direnv
_direnv_hook() {
  eval "$("/usr/local/bin/direnv" export zsh)";
}
typeset -ag precmd_functions;
if [[ -z ${precmd_functions[(r)_direnv_hook]} ]]; then
  precmd_functions+=_direnv_hook;
fi

# Additional autocompletion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Additional zsh configuration
[ -f ~/.config.zsh ] && source ~/.config.zsh
