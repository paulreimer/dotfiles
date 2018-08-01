#!/bin/sh

AUTHORITY="https://dotfiles.p-rimes.net"
D="${HOME}"

# dotfiles
test -f "${D}/.gitconfig" || curl --silent -L "${AUTHORITY}/gitconfig" -o "${D}/.gitconfig"
test -f "${D}/.htoprc" || curl --silent -L "${AUTHORITY}/htoprc" -o "${D}/.htoprc"
test -f "${D}/.screenrc" || curl --silent -L "${AUTHORITY}/screenrc" -o "${D}/.screenrc"
test -f "${D}/.vimrc" || curl --silent -L "${AUTHORITY}/vimrc" -o "${D}/.vimrc"
test -f "${D}/.zlogin" || curl --silent -L "${AUTHORITY}/zlogin" -o "${D}/.zlogin"
test -f "${D}/.zshrc" || curl --silent -L "${AUTHORITY}/zshrc" -o "${D}/.zshrc"
#test -f "${D}/.zshenv" || curl --silent -L "${AUTHORITY}/zshenv" -o "${D}/.zshenv"
