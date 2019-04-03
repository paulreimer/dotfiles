# Dependencies
```
# Debian/apt-get
sudo apt-get update
sudo apt-get install screen zsh silversearcher-ag neovim python3-pip rsync htop git curl cmake colordiff

# macOS/homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install abduco arp-scan ccache ccat cmake colordiff cppcheck cquery fzf htop neovim ninja openssl@1.1 llvm clang-format pinentry-mac python3 rpl shellcheck sl ssh-copy-id the_silver_searcher tree wdiff zsh

# Windows/Chocolatey
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
choco install ag autohotkey git kitty llvm neovim quicklook wox wsl wsl-debiangnulinux
```

# Install script (creates symlinks to dotfiles)
```
git clone http://github.com/paulreimer/dotfiles
./dotfiles/install.sh
```

# Download Individual Config files
```
## dotfiles
test -f ".gitconfig" || curl --silent -L "https://dotfiles.p-rimes.net/gitconfig" -o ".gitconfig"
test -f ".htoprc" || curl --silent -L "https://dotfiles.p-rimes.net/htoprc" -o ".htoprc"

## zsh
test -f ".zlogin" || curl --silent -L "https://dotfiles.p-rimes.net/zlogin" -o ".zlogin"
test -f ".zshrc" || curl --silent -L "https://dotfiles.p-rimes.net/zshrc" -o ".zshrc"
test -d ".zsh" || git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ".zsh/zsh-syntax-highlighting"

## vim/nvim
test -f ".vimrc" || curl --silent -L "https://dotfiles.p-rimes.net/vimrc" -o ".vimrc"
test -f ".config/nvim/init.vim" || curl --create-dirs --silent -L "https://dotfiles.p-rimes.net/init.vim" -o ".config/nvim/init.vim"
test -d ".vim" || curl -fLo .vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
command -v nvim && nvim +'PlugInstall --sync' +qa

# machine-specific configuration
## (this is a macOS current workstation default):
#test -f ".zshenv" || curl --silent -L "https://dotfiles.p-rimes.net/zshenv_macos" -o ".zshenv"
## (this is a linux/BSD host default):
#test -f ".zshenv" || curl --silent -L "https://dotfiles.p-rimes.net/zshenv" -o ".zshenv"
```

# Screenshot (kitty/nvim/fzf)
![Screenshot (kitty/nvim)](screenshot.png)
