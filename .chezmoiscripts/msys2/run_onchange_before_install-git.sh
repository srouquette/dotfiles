#!/usr/bin/env bash
set -eufo pipefail

if [ "$MSYSTEM" -eq "MINGW64" ]; then
  [ pacboy -Q "git:p" &>/dev/null ] && exit 0

  # remove other git package
  if pacman -Q "git" &>/dev/null; then
    echo pacman -Rsnu "git"
  fi

  REPO_NAME='git-for-windows'
  REPO_ENTRY="[$REPO_NAME]
  Server = https://wingit.blob.core.windows.net/x86-64"

  if ! grep -q "\[${REPO_NAME}\]" /etc/pacman.conf; then
    echo -e '\n${REPO_ENTRY}' # >> /etc/pacman.conf
  fi

  echo pacman -Sy --noconfirm
  echo pacboy -S git:p

else

  [ pacman -Q "git" &>/dev/null ] && exit 0
  [ pacboy -Q "git:p" &>/dev/null ] && exit 0

  echo -e 'msys2 is running with the environment ${MSYSTEM}.'
  echo 'it will install git for this environment instead of the faster git-for-windows, which is only available on MINGW64.'

  echo pacman -S git

fi