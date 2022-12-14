# Add to path
fish_add_path --path "$HOME/x"
fish_add_path --path "$HOME/.local/bin"
fish_add_path --path "$HOME/dev/go/bin"

if status is-interactive
    # Commands to run in interactive sessions can go here
    
    # Load wal terminal colors
    cat "$HOME/.cache/wal/sequences" &

    # Set vim keybinds
    fish_vi_key_bindings

end
