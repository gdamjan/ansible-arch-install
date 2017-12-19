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
    mkpart primary 2.258GiB 22GiB \
    mkpart primary 22GiB 100%

# create luks
cryptsetup luksFormat ${DISK}3
cryptsetup luksFormat ${DISK}4
cryptsetup open --type luks ${DISK}3 root
cryptsetup open --type luks ${DISK}4 home

# create filesystems
mkfs.ext4 /dev/mapper/root
mkfs.ext4 /dev/mapper/home
mkfs.vfat $BOOT

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

umount -R /mnt
