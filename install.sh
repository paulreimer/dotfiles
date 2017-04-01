#!/bin/sh

thisdir=$(dirname "$0")

for path in ${thisdir}/*; do
  file=$(basename "$path")
  ln -s "${path}" ".${file}"
done
