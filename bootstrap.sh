#! /bin/bash
#
# runs in arch live installer image

set -e

REPO=ansible-arch-install

pacman -Sy --needed ansible git parted

git clone https://github.com/gdamjan/$REPO
cd $REPO
