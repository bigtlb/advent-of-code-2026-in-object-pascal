#!/usr/bin/env zsh
set -euo pipefail

script_dir="${0:A:h}"
project_root="${script_dir:h}"

zsh "$script_dir/build.zsh"
exec "$project_root/bin/aoc" "$@"