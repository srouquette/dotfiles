#!/usr/bin/env bash
set -eufo pipefail

[ -z "$1" ] && return 1

pacman-key --init
pacman-key --populate
pacman -Sy --noconfirm archlinux-keyring
pacman -Su --noconfirm git curl chezmoi zsh

echo "%wheel ALL=(ALL) ALL" > /etc/sudoers.d/wheel
useradd --create-home --user-group -G wheel --shell /bin/zsh $1 &> /dev/null

echo 'root password:'
passwd

echo "$1 password:"
passwd $1
