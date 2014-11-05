#!/bin/bash

CURRENT=$(gsettings get org.gnome.desktop.input-sources sources)
US="[('xkb', 'us')]"

if [ "$CURRENT" == "$US" ]; then
	gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'latam')]"
else
	gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us')]"
fi
