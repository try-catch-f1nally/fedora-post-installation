#!/bin/bash

if [ "$(gsettings get org.gnome.desktop.input-sources sources)" = "[('xkb', 'us'), ('xkb', 'ru')]" ]; then
    gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('xkb', 'ua')]"
else
    gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('xkb', 'ru')]"
fi

