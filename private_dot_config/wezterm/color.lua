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
    local theme_dir = wezterm.home_dir .. '/.local/state/omarchy/current/theme'
    local theme_file = theme_dir .. '/wezterm.toml'
    local theme = io.open(theme_file, 'r')
    if theme then
      local contents = theme:read('*a')
      theme:close()
      scheme_def = wezterm.serde.toml_decode(contents).colors
      config.color_schemes = { omarchy = scheme_def }
      config.color_scheme = 'omarchy'
    end
    -- Also watch for the Omarchy palette being created or replaced later.
    wezterm.add_to_config_reload_watch_list(theme_file)
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
          bg_color = theme and scheme_def.background or
            (get_appearance():find('Dark') and '#181825' or '#dddddd'),
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
