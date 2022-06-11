#!/usr/bin/env sh
set -x

# Set locale
locale-gen
env-update

# Set GCC version
eselect gcc set x86_64-pc-linux-gnu-11.2.0

# Fix permissions for sudoers.d/wheel file
chown root:root /etc/sudoers.d/wheel

# Add user to relevant groups
usermod -a -G dialout,docker,kvm,libvirt,portage,scanner,usb,video,wheel simon
