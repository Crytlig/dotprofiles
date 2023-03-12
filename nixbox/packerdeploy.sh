#!/bin/bash

DISTRO=plasma5
# DISTRO=minimal
ARCH=aarch64
VERSION=22.11
ISO_CHECKSUM=$(curl -sL https://channels.nixos.org/nixos-${VERSION}/latest-nixos-${DISTRO}-${ARCH}-linux.iso.sha256 | grep -Eo '^[0-9a-z]{64}')

echo ${ISO_CHECKSUM}

packer build \
  -var arch=${ARCH} \
  -var builder="vmware-iso.nixbox_fusion" \
  -var version=${VERSION} \
  -var distro=${DISTRO} \
  -var iso_checksum=${ISO_CHECKSUM} \
  -only="vmware-iso.nixbox_fusion" \
  --on-error=abort \
  fusion-nixos.pkr.hcl
