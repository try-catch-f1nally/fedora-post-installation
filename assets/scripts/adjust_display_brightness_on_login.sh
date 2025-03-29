#!/bin/bash

gdbus monitor -y -d org.freedesktop.login1 | while read line; do
  if echo $line | grep "{'LockedHint': <false>}"; then
    bash /usr/local/bin/adjust_display_brightness_by_time.sh
  fi
done

