#!/usr/bin/env bash

for d in */; do printf "%-20s %s\n" "$d" "$(find "$d" -maxdepth 1 \( -type f -o -type l \) | wc -l)"; done
