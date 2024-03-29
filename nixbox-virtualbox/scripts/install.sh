#!/bin/sh -e

packer_http=$(cat .packer_http)

# Partition disk
cat <<FDISK | fdisk /dev/sda
n




a
w

FDISK

# Create filesystem
mkfs.ext4 -j -L nixos /dev/sda1

# Mount filesystem
mount LABEL=nixos /mnt

# Setup system
nixos-generate-config --root /mnt

# vagrant
curl -sf "$packer_http/vagrant.nix" > /mnt/etc/nixos/vagrant.nix
curl -sf "$packer_http/vagrant-hostname.nix" > /mnt/etc/nixos/vagrant-hostname.nix
curl -sf "$packer_http/vagrant-network.nix" > /mnt/etc/nixos/vagrant-network.nix
curl -sf "$packer_http/builders/$PACKER_BUILDER_TYPE.nix" > /mnt/etc/nixos/hardware-builder.nix
curl -sf "$packer_http/plasma5/plasma5.nix" > /mnt/etc/nixos/plasma5.nix
curl -sf "$packer_http/configuration.nix" > /mnt/etc/nixos/configuration.nix


### Install ###
nixos-install

### Cleanup ###
curl "$packer_http/installcleanup.sh" | nixos-enter
