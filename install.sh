#!/bin/sh

thisdir=$(dirname "$0")

for path in ${thisdir}/*; do
  file=$(basename "$path")
  ln -sf "${path}" ".${file}"
done

rm \
  ".Molokai.itermcolors" \
  ".Molokai.terminal" \
  ".Monokai.xccolortheme" \
  ".Roboto Mono for Powerline.ttf"

mkdir -p ~/bin
mkdir -p ~/.vim/bundle
mkdir -p ~/.ssh
touch ~/.ssh/known_hosts
