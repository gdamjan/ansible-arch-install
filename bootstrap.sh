#! /bin/bash
#
# runs in arch live installer image

set -e

REPO=ansible-arch-install
DISK=/dev/sda
BOOT=/dev/sda1

pacman -Sy --needed ansible git parted

git clone https://github.com/gdamjan/$REPO
cd $REPO
