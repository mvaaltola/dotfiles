set -gx NPM_PACKAGES "$XDG_DATA_HOME/npm-packages"
set -gx NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npm/npmrc"
fish_add_path --path "$NPM_PACKAGES/bin"
set MANPATH $NPM_PACKAGES/share/man $MANPATH
