set -gx EDITOR nvim

set -gx PAGER less
set -gx LESS "S R"
set -gx LESSOPEN "| /usr/bin/highlight -O ansi %s 2>/dev/null"
set -gx LESSHISTFILE "-"
set -gx BAT_THEME "TwoDark"

set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_CACHE_HOME "$HOME/.cache"

set -gx DOTBARE_DIR "$HOME/.config/dotfiles"
set -gx WGETRC "$HOME/.config/wget/wgetrc"

# For fish pj plugin
set -gx PROJECT_PATHS "$HOME/git" "$HOME/.config"
