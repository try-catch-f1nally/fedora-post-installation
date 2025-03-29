#!/bin/bash

HOUR=$(date +"%H")

if [ "$HOUR" -lt 18 ]; then
  openrgb -b 0
else
  openrgb -b 20
fi

