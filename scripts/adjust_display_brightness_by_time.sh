#!/bin/bash

HOUR=$(date +"%H")

if [ "$HOUR" -gt 5 ] && [ "$HOUR" -lt 19 ]; then
  ddcutil setvcp -d 1 10 70
  ddcutil setvcp -d 2 10 70
else
  ddcutil setvcp -d 1 10 40
  ddcutil setvcp -d 2 10 40
fi

