#!/usr/bin/env bash
set -eufo pipefail

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay
