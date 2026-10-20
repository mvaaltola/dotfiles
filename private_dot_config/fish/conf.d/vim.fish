set fish_vi_force_cursor 1

set fish_cursor_default block blink
set fish_cursor_insert line blink
set fish_cursor_replace_one underscore blink
set fish_cursor_visual block
bind -M default ctrl-g edit_command_buffer
bind -M insert ctrl-g edit_command_buffer
