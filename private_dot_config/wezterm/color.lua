local M = {}

local wezterm = require 'wezterm'

-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
local function get_appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return 'Dark'
end

local function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'Catppuccin Macchiato'
  else
    return 'Catppuccin Latte'
  end
end

function M.apply(config)
    local scheme = scheme_for_appearance(get_appearance())
    config.color_scheme = scheme
    -- config.color_scheme ='Catppuccin Macchiato'
    
    local scheme_def = wezterm.color.get_builtin_schemes()[scheme]
    config.window_background_opacity = 1.0
    config.macos_window_background_blur = 15
    config.window_frame = {
      font_size = 12,
      active_titlebar_bg = scheme_def.background,
      inactive_titlebar_bg = scheme_def.background,
    }
    config.colors = {
      tab_bar = {
        background = scheme_def.background, -- not applied on fancy tab-bar
        active_tab = {
          bg_color = scheme_def.background,
          fg_color = scheme_def.foreground,
        },
        inactive_tab = {
          bg_color = get_appearance():find('Dark') and '#181825' or '#dddddd',
          fg_color = scheme_def.foreground,
        },
        new_tab = {
          bg_color = scheme_def.background,
          fg_color = scheme_def.foreground,
        },
        new_tab_hover = {
          bg_color = scheme_def.background,
          fg_color = '#aaaaaa',
          italic = true,
        }
      }
    }
end

return M
