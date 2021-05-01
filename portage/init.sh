#!/usr/bin/env sh
set -x

# Sync first to ensure profiles from (new) overlays are present
emerge --sync

eselect profile set dantrell-gnome-3-38:default/linux/amd64/17.0/desktop/gnome/3.38
