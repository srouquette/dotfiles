#!/usr/bin/env bash
set -eufo pipefail

if ! grep -q "ILoveCandy" /etc/pacman.conf; then
  sed -i '/^\[options\]/a ILoveCandy' /etc/pacman.conf
fi
