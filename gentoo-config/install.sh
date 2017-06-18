#!/usr/bin/env sh
set -x

BASEDIR=$(dirname "$0")

# fix permissions for sudoers.d file
chown root:root "${BASEDIR}/etc/sudoers.d/wheel"
