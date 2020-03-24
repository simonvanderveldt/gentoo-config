#!/usr/bin/env sh
set -x

# Set locale
locale-gen
env-update

# Set GCC version
eselect gcc set x86_64-pc-linux-gnu-9.2.0

# Fix permissions for sudoers.d/wheel file
chown root:root /etc/sudoers.d/wheel
