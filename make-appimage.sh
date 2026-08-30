#!/bin/sh

set -eu

ARCH=$(uname -m)
export ARCH
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=https://raw.githubusercontent.com/xyproto/zsnes/refs/heads/main/icons/128x128x32.png
export DESKTOP=https://raw.githubusercontent.com/xyproto/zsnes/refs/heads/main/linux/zsnes.desktop
export USE_HOST_DRIVERS_EXPERIMENTAL=1
export LIB_DIR=/usr/lib32

# Deploy dependencies
quick-sharun ./AppDir/bin/zsnes

# Turn AppDir into AppImage
quick-sharun --make-appimage
