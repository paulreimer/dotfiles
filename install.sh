#!/bin/sh

thisdir=$(dirname "$0")

for path in "${thisdir}"/*; do
  file="$(basename "$path")"
  link=".${file}"
  if [ ! -e "${link}" ]; then
    case "$file" in
    # Skip these files:
    "Molokai.itermcolors") ;;
    "Molokai.terminal") ;;
    "Monokai.xccolortheme") ;;
    "Roboto Mono for Powerline.ttf") ;;
    "screenshot.png") ;;
    "init.vim") ;;
    "kitty.conf") ;;
    # Otherwise, create a link
    *)
      echo "-> ${link}"
      ln -sn "${path}" "${link}"
      ;;
    esac
  else
    echo "Skipping ${link}"
  fi
done

# nvim config
mkdir -p ~/.config/nvim
ln -s "${thisdir}/init.vim" ~/.config/nvim/init.vim

mkdir -p ~/.config/kitty
ln -s "${thisdir}/kitty.conf" ~/.config/kitty/kitty.conf

mkdir -p ~/bin
mkdir -p ~/.ssh
touch ~/.ssh/known_hosts
