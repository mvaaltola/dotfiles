local wezterm = require('wezterm')

local M = {}

function M.apply(config)
    config.animation_fps = 60

    config.font = wezterm.font 'JetBrains Mono'
    config.font_size = 14.0
    config.adjust_window_size_when_changing_font_size = false

    -- config.use_fancy_tab_bar = false

    config.window_decorations = 'RESIZE'
    config.hide_tab_bar_if_only_one_tab = true

    config.scrollback_lines = 100000

    config.window_padding = {
        left='2cell',
        right='1cell',
        top='1cell',
        bottom='1cell',
    }
end

return M
