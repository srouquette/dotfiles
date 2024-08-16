#!/usr/bin/env bash
set -eufo pipefail

# noteworthy cli editors: micro:p helix:p

pacman_packages=(
  pactoys
  openssh
  unzip
  zsh
  ${MINGW_PACKAGE_PREFIX}-bat
  ${MINGW_PACKAGE_PREFIX}-fzf
  ${MINGW_PACKAGE_PREFIX}-jq
  ${MINGW_PACKAGE_PREFIX}-eza
  ${MINGW_PACKAGE_PREFIX}-python-tldr
  ${MINGW_PACKAGE_PREFIX}-starship
  ${MINGW_PACKAGE_PREFIX}-vivid
)

installed=$(pacman -Qqe)

filtered=()
for pkg in "${pacman_packages[@]}"; do
  [[ $installed == *${pkg}* ]] || filtered+=("$pkg")
done
[ ${#filtered[@]} -eq 0 ] || pacman -S --noconfirm --assume-installed git ${filtered[@]}
