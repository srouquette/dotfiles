#!/usr/bin/env bash
set -eufo pipefail

pacman_packages=(
    pactoys
    openssh
    unzip
    zsh
)
pactoys_packages=(
    delta:p
    fzf:p
    helix:p
    micro:p
    python-tldr:p
    starship:p
    vivid:p
)

for package in "${pacman_packages[@]}"; do
  if ! pacman -Q "$pkg" &>/dev/null; then
    echo echo pacman -S --noconfirm "$pkg"
  fi
done

for package in "${pactoys_packages[@]}"; do
  if ! pacboy -Q "$pkg" &>/dev/null; then
    echo pacboy -S --noconfirm "$pkg"
  fi
done
