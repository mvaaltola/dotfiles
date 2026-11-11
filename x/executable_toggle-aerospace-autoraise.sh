#!/usr/bin/env bash
# Toggle focus-follows-mouse.enabled in ~/.aerospace.toml and reload AeroSpace.

CONFIG="$HOME/.config/aerospace/aerospace.toml"

# Read current value; default to false if the key is absent.
current=$(grep -E '^focus-follows-mouse\.enabled\s*=' "$CONFIG" | grep -o 'true\|false' | tail -1)
current="${current:-false}"

if [[ "$current" == "true" ]]; then
    next="false"
else
    next="true"
fi

if grep -qE '^focus-follows-mouse\.enabled\s*=' "$CONFIG"; then
    sed -i '' -E "s/^(focus-follows-mouse\.enabled[[:space:]]*=[[:space:]]*).*/\1${next}/" "$CONFIG"
fi

aerospace reload-config
