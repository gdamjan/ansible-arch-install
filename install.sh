#! /bin/bash
#
# runs in arch live installer image

set -e

DISK=/dev/sda
BOOT=/dev/sda1

# mirrorlist
# ???

# create partitions
parted -s $DISK -- \
    mklabel gpt \
    mkpart ESP fat32 2MiB 258MiB \
    set 1 boot on \
    mkpart primary linux-swap 258MiB 2.258GiB \
    mkpart primary 2.258GiB 22.5GiB \
    mkpart primary 22.5GiB 100%

# create luks

# create filesystems
mkfs.ext4 /dev/mapper/root
mkfs.ext4 /dev/mapper/home

# mount root,boot,home
mount /dev/mapper/root /mnt
mkdir -p /mnt/{home,boot}
mount /dev/mapper/home /mnt/home
mount $BOOT /mnt/boot

# arch basics
pacstrap -i /mnt pacman

ansible-playbook ./install.yml


enter hostname
enter username/password

setup bootloader
