local wezterm = require 'wezterm'
local opts = require 'opts'
local keybinds = require 'keybinds'
require 'nvim'

local config = {}
if wezterm.config_builder then
    config = wezterm.config_builder()
end

opts.apply(config)
keybinds.apply(config)

return config
