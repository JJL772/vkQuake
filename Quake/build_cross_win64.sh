#!/bin/sh
set -e
# Change this script to meet your needs and/or environment.

cd "$(dirname "$0")"

TARGET=x86_64-w64-mingw32
PREFIX=/opt/cross_win64

PATH="$PREFIX/bin:$PATH"
export PATH

MAKE_CMD=make

CC="$TARGET-gcc"
AS="$TARGET-as"
RANLIB="$TARGET-ranlib"
AR="$TARGET-ar"
WINDRES="$TARGET-windres"
STRIP="$TARGET-strip"
export PATH CC AS AR RANLIB WINDRES STRIP

exec $MAKE_CMD CC=$CC AS=$AS RANLIB=$RANLIB AR=$AR WINDRES=$WINDRES STRIP=$STRIP -f Makefile.w64 $*
