#!/usr/bin/env sh
# Copy udev modules because they are included in the initramfs
# And we don't want to include our home directory in the initramfs
set -x

cp -a udev/* /
