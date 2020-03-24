#!/usr/bin/env sh
set -x

eselect opengl set xorg-x11
rc-update add xdm default
