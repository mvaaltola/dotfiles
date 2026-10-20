#!/bin/bash

# Pure-inspired status line for Claude Code

input=$(cat)
cwd=$(echo "$input" | jq -r '.workspace.current_dir')
cost=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
transcript=$(echo "$input" | jq -r '.transcript_path // ""')
lines_added=$(echo "$input" | jq -r '.cost.total_lines_added // 0')
lines_removed=$(echo "$input" | jq -r '.cost.total_lines_removed // 0')
context_remaining=$(echo "$input" | jq -r '.context_window.remaining_percentage // 100')
model_name=$(echo "$input" | jq -r '.model.display_name // ""')
effort=$(echo "$input" | jq -r '.effort.level // .model.effortLevel // .effortLevel // empty')
[ -z "$effort" ] && effort=$(jq -r '.effortLevel // empty' "$HOME/.claude/settings.json" 2>/dev/null)

BLUE='\033[0;34m'
CYAN='\033[0;36m'
GRAY='\033[0;90m'
GREEN='\033[0;32m'
ORANGE='\033[38;5;208m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
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
COST_MILLI=$(printf '%.0f' "$(echo "$cost * 1000" | bc -l 2>/dev/null || echo 0)")

# Per-turn cost delta
TURN_DELTA=0
TURN_FMT=""
if [ -n "$transcript" ] && [ -f "$transcript" ]; then
  STATE_DIR="$HOME/.claude/.statusline-state"
  mkdir -p "$STATE_DIR" 2>/dev/null
  KEY=$(echo "$transcript" | shasum | awk '{print $1}')
  STATE_FILE="$STATE_DIR/$KEY"

  LAST_USER=0; LAST_COST=0; BASELINE=$COST_MILLI
  [ -f "$STATE_FILE" ] && read -r LAST_USER LAST_COST BASELINE < "$STATE_FILE"
  : "${LAST_USER:=0}"; : "${LAST_COST:=0}"; : "${BASELINE:=$COST_MILLI}"

  USER_FILTER='select(.type=="user" and ((.message.content | type == "string" and startswith("<") | not) and ((.message.content | type == "string") or ([.message.content[]?.type] | index("tool_result") | not))))'
  USER_COUNT=$(jq -c "$USER_FILTER" "$transcript" 2>/dev/null | wc -l | tr -d ' ')

  if [ "$USER_COUNT" -lt "$LAST_USER" ]; then
    LAST_USER=$USER_COUNT
    BASELINE=$COST_MILLI
  fi
  if [ "$USER_COUNT" -gt "$LAST_USER" ]; then
    BASELINE=$LAST_COST
  fi
  TURN_DELTA=$(( COST_MILLI - BASELINE ))
  [ "$TURN_DELTA" -lt 0 ] && TURN_DELTA=0
  echo "$USER_COUNT $COST_MILLI $BASELINE" > "$STATE_FILE"

  if [ "$TURN_DELTA" -lt 100 ]; then
    TURN_FMT=$(printf '%d.%d¢' $((TURN_DELTA / 10)) $((TURN_DELTA % 10)))
  elif [ "$TURN_DELTA" -lt 1000 ]; then
    TURN_FMT="$((TURN_DELTA / 10))¢"
  else
    TURN_FMT=$(printf '$%d.%02d' $((TURN_DELTA / 1000)) $(((TURN_DELTA / 10) % 100)))
  fi
fi

if   [ "$TURN_DELTA" -lt 100 ];  then TCOLOR_TURN=$GREEN
elif [ "$TURN_DELTA" -lt 500 ];  then TCOLOR_TURN=$CYAN
elif [ "$TURN_DELTA" -lt 1500 ]; then TCOLOR_TURN=$YELLOW
elif [ "$TURN_DELTA" -lt 4000 ]; then TCOLOR_TURN=$ORANGE
else                                   TCOLOR_TURN=$RED
fi

line2=""

if [[ "$lines_added" -gt 0 || "$lines_removed" -gt 0 ]]; then
    line2="${GREEN}+${lines_added}${RESET}/${RED}-${lines_removed}${RESET} "
fi

line2="${line2}${GREEN}\$${cost_formatted}${RESET}"

[ -n "$TURN_FMT" ] && line2="${line2} Δ${TCOLOR_TURN}${TURN_FMT}${RESET}"

# Context remaining with color: green >50%, yellow 20-50%, red <20%
ctx_int=${context_remaining%.*}
if [[ $ctx_int -gt 50 ]]; then
    ctx_color="$GREEN"
elif [[ $ctx_int -gt 20 ]]; then
    ctx_color="$YELLOW"
else
    ctx_color="$RED"
fi
line2="${line2} ${ctx_color}${ctx_int}%${RESET}"

if [ -n "$model_name" ]; then
    line2="${line2} ${GRAY}${model_name}${RESET}"
    if [ -n "$effort" ]; then
        case "$effort" in
            high)        effort_color="$YELLOW" ;;
            xhigh|max)   effort_color="$RED" ;;
            *)           effort_color="$GRAY" ;;
        esac
        line2="${line2} ${effort_color}(${effort})${RESET}"
    fi
fi

printf '%b\n%b' "$prompt" "$line2"
