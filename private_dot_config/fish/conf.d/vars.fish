set -gx EDITOR nvim

set -gx PAGER less
set -gx LESS "S R"
set -gx LESSOPEN "| /usr/bin/highlight -O ansi %s 2>/dev/null"
set -gx LESSHISTFILE "-"
set -gx BAT_THEME "TwoDark"
set -gx SXHKD_SHELL "/usr/bin/bash"

set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_CACHE_HOME "$HOME/.cache"

set -gx DOTBARE_DIR "$XDG_CONFIG_HOME/dotfiles"
set -gx WGETRC "$XDG_CONFIG_HOME/wget/wgetrc"

set -gx KUBECONFIG "$XDG_CONFIG_HOME/kube/config.prod"
set -gx DOCKER_CONFIG "$XDG_DATA_HOME/docker"

set -gx GOPATH "$HOME/dev/go"

# Install plugins to separate dir
set -gx fisher_path "$XDG_CONFIG_HOME/fisher"

# For fish pj plugin
set -gx PROJECT_PATHS "$HOME/dev" "$HOME/dev/go/src" "$HOME/.config" "$HOME/files"
