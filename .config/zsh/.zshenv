#!/bin/zsh

# Sourced everytime unlike .zprofile

export VWDIR="${HOME}/mikael@vaalto.la/notes/vimwiki"

# load .sh files from zdotdir/localprofile.d
if test -d $ZDOTDIR/localprofile.d; then
    for profile in $ZDOTDIR/localprofile.d/*.sh; do
        test -r "$profile" && . "$profile"
    done
    unset profile
fi

