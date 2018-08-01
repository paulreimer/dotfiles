#!/bin/sh

AUTHORITY="https://dotfiles.p-rimes.net"
D="${HOME}"

# dotfiles
test -f "${D}/.gitconfig" || curl "${AUTHORITY}/gitconfig" -o "${D}/.gitconfig"
test -f "${D}/.htoprc" || curl "${AUTHORITY}/htoprc" -o "${D}/.htoprc"
test -f "${D}/.screenrc" || curl "${AUTHORITY}/screenrc" -o "${D}/.screenrc"
test -f "${D}/.vimrc" || curl "${AUTHORITY}/vimrc" -o "${D}/.vimrc"
test -f "${D}/.zlogin" || curl "${AUTHORITY}/zlogin" -o "${D}/.zlogin"
test -f "${D}/.zshrc" || curl "${AUTHORITY}/zshrc" -o "${D}/.zshrc"
#test -f "${D}/.zshenv" || curl "${AUTHORITY}/zshenv" -o "${D}/.zshenv"
