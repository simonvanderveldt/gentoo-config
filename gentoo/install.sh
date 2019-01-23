#!/usr/bin/env sh
set -x

BASEDIR=$(dirname "$0")

# fix permissions for sudoers.d file
chown root:root "${BASEDIR}/etc/sudoers.d/wheel"

# Set locale
eselect locale set en_US.utf8
env-update

# Set GCC version
eselect gcc set x86_64-pc-linux-gnu-7.3.0
