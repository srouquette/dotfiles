#!/usr/bin/env bash
set -eufo pipefail

command -v yay &>/dev/null && exit 0

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay
