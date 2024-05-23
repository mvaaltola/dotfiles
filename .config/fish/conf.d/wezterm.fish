# function __wezterm_set_user_var -a NAME VALUE -d "Set user variable for wezterm"
#   # <https://github.com/tmux/tmux/wiki/FAQ#what-is-the-passthrough-escape-sequence-and-how-do-i-use-it>
#   # Note that you ALSO need to add "set -g allow-passthrough on" to your tmux.conf
#   set UVAR $(echo -n "$VALUE" | base64)
#   printf "\033]1337;SetUserVar=%s=%s\007" "$NAME" "$UVAR"
# end
#
# __wezterm_set_user_var "invim" "0"
#
# function nvp --wraps nvim --description 'Open nvim without padding'
#   __wezterm_set_user_var "invim" "1"
#   /sbin/nvim $argv
#   __wezterm_set_user_var "invim" "0"
# end
