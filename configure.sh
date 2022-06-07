#!/usr/bin/sh
set -e
cd "$(dirname "$0")"

meson build --prefix="$PWD/game" $@