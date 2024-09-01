#!/usr/bin/env bash
set -eufo pipefail

if ! grep -q "ILoveCandy" /etc/pacman.conf; then
  {{ $sudo := "sudo" -}}
  {{ if or (eq .chezmoi.username "root") (eq .subsystem "msys2") -}}
  {{   $sudo = "" -}}
  {{ end -}}
  {{ $sudo }} sed -i '/^\[options\]/a ILoveCandy' /etc/pacman.conf
fi
