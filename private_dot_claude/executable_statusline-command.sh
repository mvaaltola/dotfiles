#!/bin/bash

# Pure-inspired status line for Claude Code

input=$(cat)
cwd=$(echo "$input" | jq -r '.workspace.current_dir')
cost=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
lines_added=$(echo "$input" | jq -r '.cost.total_lines_added // 0')
lines_removed=$(echo "$input" | jq -r '.cost.total_lines_removed // 0')

BLUE='\033[0;34m'
CYAN='\033[0;36m'
GRAY='\033[0;90m'
GREEN='\033[0;32m'
RED='\033[0;31m'
RESET='\033[0m'

if [[ "$cwd" == "$HOME"* ]]; then
    display_dir="~${cwd#$HOME}"
else
    display_dir="$cwd"
fi

prompt="${BLUE}${display_dir}${RESET}"

if git -C "$cwd" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    branch=$(git -C "$cwd" rev-parse --abbrev-ref HEAD 2>/dev/null)

    if ! git -C "$cwd" diff --quiet 2>/dev/null || ! git -C "$cwd" diff --cached --quiet 2>/dev/null || [[ -n $(git -C "$cwd" ls-files --others --exclude-standard 2>/dev/null) ]]; then
        dirty="*"
    else
        dirty=""
    fi

    upstream=$(git -C "$cwd" rev-parse --abbrev-ref @{upstream} 2>/dev/null)
    if [[ -n "$upstream" ]]; then
        ahead=$(git -C "$cwd" rev-list --count ${upstream}..HEAD 2>/dev/null || echo 0)
        behind=$(git -C "$cwd" rev-list --count HEAD..${upstream} 2>/dev/null || echo 0)

        [[ $ahead -gt 0 ]] && ahead_marker="${CYAN}⇡${RESET}" || ahead_marker=""
        [[ $behind -gt 0 ]] && behind_marker="${CYAN}⇣${RESET}" || behind_marker=""
    else
        ahead_marker=""
        behind_marker=""
    fi

    prompt="${prompt} ${GRAY}${branch}${dirty}${RESET}${ahead_marker}${behind_marker}"
fi

# Second line: lines changed and cost
cost_formatted=$(printf "%.2f" "$cost")
line2=""

if [[ "$lines_added" -gt 0 || "$lines_removed" -gt 0 ]]; then
    line2="${GREEN}+${lines_added}${RESET}/${RED}-${lines_removed}${RESET} "
fi

line2="${line2}${GREEN}\$${cost_formatted}${RESET}"

printf "${prompt}\n${line2}"
