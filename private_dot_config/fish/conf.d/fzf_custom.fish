# Search directory with <c-f>
fzf_configure_bindings --directory=\cf

# Show hidden files but ignore .git
set -gx fzf_fd_opts --hidden --exclude=.git

# Use eza for dir previews
set -gx fzf_preview_dir_cmd eza --all --color=always

# Use delta for diff
set -gx fzf_diff_highlighter delta --paging=never --width=20

# Open file in editor with Ctrl+O
set -gx fzf_directory_opts --bind "ctrl-o:execute($EDITOR {} &> /dev/tty)"
