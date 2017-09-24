#!/usr/bin/env sh
# Install motherboard specific files
set -x

BOARD_NAME_FULL=$(cat /sys/devices/virtual/dmi/id/board_name)
BOARD_NAME=${BOARD_NAME_FULL%%' '*}
BOARD_NAME=${BOARD_NAME,,}
BASEDIR=$(dirname "$0")

# Copy instead of symlink modules to be loaded because the home filsystem isn't
# mounted yet when the modules-load service is started
if [ -d "${BASEDIR}/lm_sensors.${BOARD_NAME}" ] ; then
  cd "${BASEDIR}"
  stow -v --no-folding --ignore "etc/modules-load.d" --target=/ "lm_sensors.${BOARD_NAME}"
  cd "lm_sensors.${BOARD_NAME}" && cp -v -r --parents "etc/modules-load.d" /
fi
