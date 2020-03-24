#!/usr/bin/env sh
set -x

# Fix ownership because collectd runs as user "collectd"
chgrp collectd /etc/collectd.conf

# Enable service
rc-update add collectd default
