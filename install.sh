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

mkdir -p ~/bin
mkdir -p ~/.ssh
touch ~/.ssh/known_hosts
