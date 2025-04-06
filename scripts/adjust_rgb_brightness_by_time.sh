#!/bin/bash

HOUR=$(date +"%H")

if [ "$HOUR" -gt 5 ] && [ "$HOUR" -lt 19 ]; then
  openrgb -b 0
else
  openrgb -b 20
fi

