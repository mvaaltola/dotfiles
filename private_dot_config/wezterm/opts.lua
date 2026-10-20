local wezterm = require('wezterm')

local M = {}

function M.apply(config)
    config.animation_fps = 60

    config.font = wezterm.font 'Oxygen Mono'
    -- Cursive italics from Victor Mono
    config.font_rules = {
        {
            intensity = 'Normal',
            italic = true,
            font = wezterm.font { family = 'Victor Mono', style = 'Italic' },
        },
        {
            intensity = 'Bold',
            italic = true,
            font = wezterm.font { family = 'Victor Mono', weight = 'Bold', style = 'Italic' },
        },
    }
    config.font_size = 14.0
    config.adjust_window_size_when_changing_font_size = false

    -- config.use_fancy_tab_bar = false

    config.window_decorations = 'RESIZE'
    config.hide_tab_bar_if_only_one_tab = true

    config.scrollback_lines = 500000
    config.enable_kitty_keyboard = true

    config.window_padding = {
        left='2cell',
        right='1cell',
        top='1cell',
        bottom='1cell',
    }
end

return M
