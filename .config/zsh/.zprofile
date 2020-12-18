#!/bin/zsh

# Sourced on login

# Adds `~/.local/bin` to $PATH
export PATH="$PATH:$(du "$HOME/.local/bin" | cut -f2 | paste -sd ':' -)"

export EDITOR="nvim"
export TERMINAL="st"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export DOTBARE_DIR="$HOME/.config/dotfiles"

# node/npm global packages path
NPM_PACKAGES="${XDG_DATA_HOME}/npm-packages"
export PATH="$PATH:$NPM_PACKAGES/bin"
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/SHARE/man"

export PAGER="less"
export LESS="S R"
export LESSOPEN="| /usr/bin/highlight -O ansi %s 2>/dev/null"
export LESSHISTFILE="-"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"

# load .sh files from zdotdir/profile.d
if test -d $ZDOTDIR/profile.d; then
    for profile in $ZDOTDIR/localprofile.d/*.sh; do
        test -r "$profile" && . "$profile"
    done
    unset profile
fi

