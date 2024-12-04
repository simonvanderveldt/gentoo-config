#!/usr/bin/env sh
set -x

# Sync first to ensure profiles from (new) overlays are present
emerge --sync

eselect profile set default/linux/amd64/23.0/split-usr/desktop/gnome
