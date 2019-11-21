#!/bin/sh

cd "$(dirname "$0")/dockerfiles"

[ $# -eq 0 ] && set -- *

for tag; do
  docker build -t "shellspec/schilytools:$tag" - < "$tag"
done
