function fish_greeting
    _pure_check_for_new_release

    # Report dotfile drift found by the previous shell, then refresh the
    # cache in the background so startup doesn't wait on chezmoi
    set -l cache ~/.cache/chezmoi-status
    if test -s $cache
        set_color yellow
        echo "chezmoi: "(count <$cache)" file(s) differ from dotfiles, see chezmoi status"
        set_color normal
    end
    if command -q chezmoi
        sh -c 'mkdir -p "${1%/*}" && chezmoi status >"$1.$$" 2>/dev/null && mv "$1.$$" "$1" || rm -f "$1.$$"' _ $cache &
        disown
    end
end
