```
#!/bin/sh

# deps
# debian/apt-get
# sudo apt-get install screen zsh silversearcher-ag neovim python3-pip rsync htop git curl

# dotfiles
test -f ".gitconfig" || curl --silent -L "https://dotfiles.p-rimes.net/gitconfig" -o ".gitconfig"
test -f ".htoprc" || curl --silent -L "https://dotfiles.p-rimes.net/htoprc" -o ".htoprc"
#test -f ".screenrc" || curl --silent -L "https://dotfiles.p-rimes.net/screenrc" -o ".screenrc"
#test -f ".tmux.conf" || curl --silent -L "https://dotfiles.p-rimes.net/tmux.conf" -o ".tmux.conf"

# zsh
test -f ".zlogin" || curl --silent -L "https://dotfiles.p-rimes.net/zlogin" -o ".zlogin"
test -f ".zshrc" || curl --silent -L "https://dotfiles.p-rimes.net/zshrc" -o ".zshrc"
test -d ".zsh" || git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ".zsh/zsh-syntax-highlighting"

# vim/nvim
test -f ".vimrc" || curl --silent -L "https://dotfiles.p-rimes.net/vimrc" -o ".vimrc"
test -f ".config/nvim/init.vim" || curl --create-dirs --silent -L "https://dotfiles.p-rimes.net/init.vim" -o ".config/nvim/init.vim"
test -d ".vim" || curl -fLo .vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
command -v nvim && nvim +'PlugInstall --sync' +qa

# machine-specific configuration
# (this is a macOS current workstation default):
#test -f ".zshenv" || curl --silent -L "https://dotfiles.p-rimes.net/zshenv_macos" -o ".zshenv"
# (this is a linux/BSD host default):
#test -f ".zshenv" || curl --silent -L "https://dotfiles.p-rimes.net/zshenv" -o ".zshenv"
```