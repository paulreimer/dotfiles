#!/bin/sh

thisdir=$(dirname "$0")

for path in ${thisdir}/*; do
  file=$(basename "$path")
  ln -sf "${path}" ".${file}"
done

rm \
  ".Molokai.itermcolors" \
  ".Molokai.terminal" \
  ".Roboto Mono for Powerline.ttf"

mkdir -p ~/.ssh
touch ~/.ssh/known_hosts
