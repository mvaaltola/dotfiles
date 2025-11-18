set -gx EDITOR nvim

set -gx PAGER page -WfC -q 90000 -z 90000
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p --color=always | page'"
# set -gx MANPAGER page -t man
set -gx DELTA_PAGER less
set -gx LESS "S R"
set -gx LESSOPEN "| /usr/bin/highlight -O ansi %s 2>/dev/null"
set -gx LESSHISTFILE "-"
set -gx BAT_THEME base16
set -gx SXHKD_SHELL "/bin/bash"

set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_CACHE_HOME "$HOME/.cache"

set -gx DOTBARE_DIR "$XDG_CONFIG_HOME/dotfiles"
set -gx WGETRC "$XDG_CONFIG_HOME/wget/wgetrc"

# For fish pj plugin
set -gx PROJECT_PATHS "$HOME/dev" "$HOME/.config"
