#!/usr/bin/env bash
set -eufo pipefail

pacman_packages=(
    pactoys
    openssh
    unzip
    zsh
)
pacboy_packages=(
    delta:p
    fzf:p
    helix:p
    micro:p
    python-tldr:p
    starship:p
    vivid:p
)

installed=$(pacman -Qqe)

for pkg in "${pacman_packages[@]}"; do
  [[ $installed == *${pkg}* ]] || pacman -S --noconfirm $pkg
done

for pkg in "${pacboy_packages[@]}"; do
  [[ $installed == *${pkg%:*}* ]] || pacboy -S --noconfirm $pkg
done
