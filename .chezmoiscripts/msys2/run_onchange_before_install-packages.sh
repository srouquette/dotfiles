#!/usr/bin/env bash
set -eufo pipefail

# noteworthy cli editors: micro:p helix:p

pacman_packages=(
    pactoys
    openssh
    unzip
    zsh
)
pacboy_packages=(
    bat:p
    fzf:p
    lsd:p
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

# --assume-installed doesn't seem to work with pacboy
[[ $installed == *delta* ]] || pacman -S --noconfirm --assume-installed git ${MINGW_PACKAGE_PREFIX}-delta
