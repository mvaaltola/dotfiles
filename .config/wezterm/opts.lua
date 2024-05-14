local wezterm = require('wezterm')

local M = {}

function M.apply(config)
    config.animation_fps = 60

    config.font = wezterm.font 'CaskaydiaCove NFM'
    config.font_size = 10.0
    config.adjust_window_size_when_changing_font_size = false

    config.window_decorations = 'RESIZE'
    config.hide_tab_bar_if_only_one_tab = true

    config.scrollback_lines = 100000
end

return M
