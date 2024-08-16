#!/usr/bin/env bash
set -eufo pipefail

# exit if git is already installed
pacboy -Qqs git:x &>/dev/null && exit 0

# remove the git package from the main repo
pacman -Qqs ^git$ &>/dev/null && pacman -Rsnc --noconfirm git

# install pactoys, for pacboy, if it wasn't already installed
pacman -Qqs pactoys &>/dev/null || pacman -S --noconfirm pactoys

# add git-for-windows repo (custom build)
REPO_NAME='git-for-windows'
REPO_ENTRY="[$REPO_NAME]
Server = https://wingit.blob.core.windows.net/x86-64"

if ! grep -q "\[${REPO_NAME}\]" /etc/pacman.conf; then
  echo -e "\n${REPO_ENTRY} " >> /etc/pacman.conf
  pacman -Sy --noconfirm
fi

pacboy -S --noconfirm git:x
