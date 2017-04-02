#!/bin/sh

thisdir=$(dirname "$0")

for path in ${thisdir}/*; do
  file=$(basename "$path")
  ln -sf "${path}" ".${file}"
done
