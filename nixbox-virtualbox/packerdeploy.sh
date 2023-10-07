#!/bin/bash

DISTRO=plasma5
# DISTRO=minimal
ARCH=aarch64
VERSION=22.11
ISO="nixos-plasma5-22.11.3092.970402e6147-aarch64-linux.iso"
# ISO_CHECKSUM=$(curl -sL https://channels.nixos.org/nixos-${VERSION}/latest-nixos-${DISTRO}-${ARCH}-linux.iso.sha256 | grep -Eo '^[0-9a-z]{64}')
ISO_CHECKSUM="6011f3f6ee053a552edf84efe1cbaeee3dd05b727f304f8a44c4f71f60084401"

echo ${ISO_CHECKSUM}

packer build \
  -var arch=${ARCH} \
  -var builder="vmware-iso.nixbox_fusion" \
  -var version=${VERSION} \
  -var distro=${DISTRO} \
  -var iso_checksum=${ISO_CHECKSUM} \
  -only="vmware-iso.nixbox_fusion" \
  fusion-nixos.pkr.hcl

  # --on-error=abort \