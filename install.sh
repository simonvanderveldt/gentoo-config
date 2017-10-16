#!/usr/bin/env sh
# .stowrc doesn't do shell expansion :|
# See https://lists.gnu.org/archive/html/help-stow/2013-04/msg00008.html
set -x

if [ -z "$1" ] ; then
  echo "No argument supplied, exiting"
  exit 1
fi

stow -v --no-folding --ignore install.sh --target=/ "${1}"

# Run package specific install script if it exists
if [ -x "${1}/install.sh" ]; then
  "${1}/install.sh"
fi
