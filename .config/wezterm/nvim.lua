local wezterm = require('wezterm')

wezterm.on('user-var-changed', function(window, pane, name, value)
  wezterm.log_info('var', name, value)
  local overrides = window:get_config_overrides() or {}
  if name == "invim" and value == "1" then
    overrides.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
  else
    overrides.window_padding = nil
  end
  window:set_config_overrides(overrides)
end)

