# Add to path
fish_add_path --path "$HOME/x"
fish_add_path --path "$HOME/.local/bin"
fish_add_path --path "$HOME/dev/go/bin"
fish_add_path --path "/opt/homebrew/bin"

if status is-interactive
    # Commands to run in interactive sessions can go here
    
    # Set vim keybinds
    fish_vi_key_bindings

    zoxide init fish | source

end

# mise activate fish | source
fish_add_path ~/.local/share/mise/shims
source "$(npm root -g)/@mapbox/mbxcli/bin/mbx.fish"
