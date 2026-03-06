#!/bin/bash
input=$(cat)
message=$(echo "$input" | python3 -c "import sys,json; print(json.load(sys.stdin).get('message','Claude Code'))")
title=$(echo "$input" | python3 -c "import sys,json; print(json.load(sys.stdin).get('title','Claude Code'))")
osascript -e "display notification \"$message\" with title \"$title\" sound name \"default\""
