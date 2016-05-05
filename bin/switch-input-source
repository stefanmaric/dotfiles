#!/bin/bash

# Workaround for gnome issue with iBus and input source switching.
# Uses gesettings to retrieve current configuration and uses sed to shift input sources, i.e.: change to next input source.
# Works with any input-source settings.
# You can bind a keyboard shortcut to this script.
#
# More info:
#
# * https://bugs.launchpad.net/ubuntu/+source/gnome-settings-daemon/+bug/1244158
# * https://bugzilla.gnome.org/show_bug.cgi?id=711001

gsettings set org.gnome.desktop.input-sources sources "$(gsettings get org.gnome.desktop.input-sources sources | sed -e 's/^\[\(([^)]*)\)\(.*\)\(([^)]*)\)\]$/[\3, \1\2]/g' -e 's/[, ]*\(\]$\)/\1/g')"
