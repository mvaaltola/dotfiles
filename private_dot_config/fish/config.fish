if status is-interactive
    # Commands to run in interactive sessions can go here

    # Set vim keybinds
    fish_vi_key_bindings

    zoxide init fish | source

end

# mise activate fish | source
fish_add_path ~/.local/share/mise/shims
if command -q npm
    set -l mbx_fish "$(npm root -g)/@mapbox/mbxcli/bin/mbx.fish"
    if test -f "$mbx_fish"
        source "$mbx_fish"
    end
end
