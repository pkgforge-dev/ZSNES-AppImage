#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    nasm     \
    python   \
    sdl3

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano libdecor-mini

echo "Building ZSNES..."
echo "---------------------------------------------------------------"
REPO="https://github.com/xyproto/zsnes"
VERSION="$(git ls-remote "$REPO" HEAD | cut -c 1-9 | head -1)"
git clone "$REPO" ./zsnes
git -C ./zsnes apply patches/fix-gui-wallpaper-click-crash.patch
echo "$VERSION" > ~/version

mkdir -p ./AppDir/bin
cd ./zsnes
make -j$(nproc) BITS=64 WITH_OPENGL=
mv -v zsnes ../AppDir/bin
