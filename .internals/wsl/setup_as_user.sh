#!/usr/bin/env bash
set -eufo pipefail

username=$1

chezmoi init srouquette --apply

export ZDOTDIR=$HOME/.config/zsh
git clone --recursive https://github.com/srouquette/zdotdir.git $ZDOTDIR
ln -sf $ZDOTDIR/home/.zshenv $HOME/.zshenv

create_symlink() {
    # return if the link already exists
    [ -L $HOME/$1 ] && return 0
    # create the link if the source exists
    [ -d /mnt/c/Users/$username/$1 ] && ln -s /mnt/c/Users/$username/$1 $HOME/$1
}

create_symlink .aws
create_symlink .ssh
