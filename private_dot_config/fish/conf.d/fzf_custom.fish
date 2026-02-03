# Search directory with <c-f>
fzf_configure_bindings --directory=super-f --git_log=super-g --git_status=super-s

# Show hidden files but ignore .git
set -gx fzf_fd_opts --hidden --exclude=.git

# Use eza for dir previews
set -gx fzf_preview_dir_cmd eza --all --color=always

# Use delta for diff
set -gx fzf_diff_highlighter delta --paging=never --width=20

# Open file in nvim with Ctrl+O
set -gx fzf_directory_opts --bind "ctrl-o:execute(nvim {} &> /dev/tty)"

# Jump to project dirs
function __fzfpj_bind --description 'Key binding for fzfpj'
    fzfpj
end
bind -M insert super-p 'commandline -r "__fzfpj_bind"; commandline -f execute'
