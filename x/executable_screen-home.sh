#!/usr/bin/env bash
xrandr --output eDP-1 --primary --mode 2560x1600 --pos 0x0 --rotate normal --output HDMI-1 --off --output DP-1 --off --output DP-2 --off --output DP-3 --off --output DP-4 --off --output DP-2-1 --off --output DP-2-1-5 --mode 2560x1440 --pos 2560x0 --rotate normal --output DP-2-1-6 --off --output DP-2-2 --off --output DP-2-3 --off
notify-send "Set screen layout to home"
