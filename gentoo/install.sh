#!/usr/bin/env sh
set -x

BASEDIR=$(dirname "$0")

# Set profile
eselect profile set dantrell-gnome-3-26:default/linux/amd64/17.0/desktop/gnome/3.26

# Set locale
eselect locale set en_US.utf8
env-update

# Set GCC version
eselect gcc set x86_64-pc-linux-gnu-7.3.0

# Fix permissions for sudoers.d file
chown root:root "${BASEDIR}/etc/sudoers.d/wheel"
