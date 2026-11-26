#!/usr/bin/env zsh
set -euo pipefail

script_dir="${0:A:h}"
project_root="${script_dir:h}"

mkdir -p "$project_root/bin" "$project_root/build"
fpc \
  -g -gl \
  "-Fu$project_root/src" \
  "-Fu$project_root/src/days" \
  "-FU$project_root/build" \
  "-FE$project_root/bin" \
  "-o$project_root/bin/aoc" \
  "$project_root/src/aoc.pas"