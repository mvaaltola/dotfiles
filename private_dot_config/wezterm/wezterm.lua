local wezterm = require 'wezterm'
local opts = require 'opts'
local keybinds = require 'keybinds'
local color = require 'color'
require 'nvim'

local config = {}
if wezterm.config_builder then
    config = wezterm.config_builder()
end

opts.apply(config)
keybinds.apply(config)
color.apply(config)

return config
