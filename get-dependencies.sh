#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    libdecor \
    python   \
    sdl2

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Comment this out if you need an AUR package
#make-aur-package PACKAGENAME

# If the application needs to be manually built that has to be done down here
echo "Making nightly build of ZSNES 2..."
echo "---------------------------------------------------------------"
REPO="https://github.com/xyproto/zsnes"
VERSION="$(git ls-remote "$REPO" HEAD | cut -c 1-9 | head -1)"
git clone "$REPO" ./zsnes
echo "$VERSION" > ~/version

mkdir -p ./AppDir/bin
cd ./zsnes
make -j$(nproc)
mv -v zsnes ../AppDir/bin
