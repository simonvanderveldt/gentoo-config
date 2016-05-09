#!/usr/bin/env sh
# .stowrc doesn't do shell expansion :|
# See https://lists.gnu.org/archive/html/help-stow/2013-04/msg00008.html
set -x

stow -v --no-folding --target=/ $1
