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
    jq:p
    eza:p
    python-tldr:p
    starship:p
    vivid:p
)

installed=$(pacman -Qqe)

filtered=()
for pkg in "${pacman_packages[@]}"; do
  [[ $installed == *${pkg}* ]] || filtered+=("$pkg")
done
[ ${#filtered[@]} -eq 0 ] || pacman -S --noconfirm ${filtered[@]}

filtered=()
for pkg in "${pacboy_packages[@]}"; do
  [[ $installed == *${pkg%:*}* ]] || filtered+=("$pkg")
done
[ ${#filtered[@]} -eq 0 ] || pacboy -S --noconfirm ${filtered[@]}

# --assume-installed doesn't seem to work with pacboy
[[ $installed == *delta* ]] || pacman -S --noconfirm --assume-installed git ${MINGW_PACKAGE_PREFIX}-delta
