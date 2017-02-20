#!/usr/bin/env sh
set -x

BASEDIR=$(dirname "$0")

# fix permissions for sudoers.d file
chown root:root "${BASEDIR}/etc/sudoers.d/wheel"

# Add user `simon` to the relevant groups
usermod -a -G wheel,kvm,libvirt,docker simon
