#!/usr/bin/env sh
set -x

# Set locale
locale-gen
env-update

# Fix permissions for sudoers.d/wheel file
chown root:root /etc/sudoers.d/wheel

# Add user to relevant groups
usermod -a -G dialout,docker,kvm,libvirt,portage,scanner,usb,video,wheel simon
