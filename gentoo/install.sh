#!/usr/bin/env sh
set -x

BASEDIR=$(dirname "$0")

# Set locale
locale-gen
env-update

# Set GCC version
eselect gcc set x86_64-pc-linux-gnu-9.2.0

# Fix permissions for sudoers.d file
chown root:root "${BASEDIR}/etc/sudoers.d/wheel"
