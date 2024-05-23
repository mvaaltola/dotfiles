# Show hidden files but ignore .git
set -gx fzf_fd_opts --hidden --exclude=.git

# Use eza for dir previews
set -gx fzf_preview_dir_cmd eza --all --color=always

# Use delta for diff
set -gx fzf_diff_highlighter delta --paging=never --width=20

# Open file in editor with Ctrl+O
set -gx fzf_directory_opts --bind "ctrl-o:execute($EDITOR {} &> /dev/tty)"

# cd to $PROJECT_PATHS with Ctrl-F
function fzfpj -d "Jump to project directory with fzf"
    set -f file_paths_selected (fd -t d -d 1 . $PROJECT_PATHS 2>/dev/null | fzf --tac)
    if test $status -eq 0
        commandline --function repaint
        commandline "cd $file_paths_selected && eza"
        commandline -f execute
    end
    commandline --function repaint
end
bind --mode insert \cf fzfpj
