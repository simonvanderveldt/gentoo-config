#!/usr/bin/env sh
# Install motherboard specific files
BOARD_NAME_FULL=$(cat /sys/devices/virtual/dmi/id/board_name)
BOARD_NAME=${BOARD_NAME_FULL%%' '*}
BOARD_NAME=${BOARD_NAME,,}
BASEDIR=$(dirname "$0")

if [ -d "$BASEDIR/lm_sensors.$BOARD_NAME" ] ; then
    cd $BASEDIR; stow -v --no-folding --target=/ "lm_sensors.$BOARD_NAME"
fi
