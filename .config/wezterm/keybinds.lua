local wezterm = require('wezterm')
local act = wezterm.action
local wmod = 'SHIFT|ALT'

require('scrollback')

local M = {}

wezterm.on('toggle-padding', function(window)
  local overrides = window:get_config_overrides() or {}
  if overrides.window_padding == nil then
    overrides.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
  else
    overrides.window_padding = nil
  end
  window:set_config_overrides(overrides)
end)

function M.apply(config)
    -- disable default key bindings
    config.disable_default_key_bindings = true

    config.keys = {
        { key = 'F5', mods = wmod, action = act.ReloadConfiguration },
        { key = 'k', mods = 'CTRL', action = act.ActivateCommandPalette },
        -- Tab management
        { key = 'T', mods = wmod, action = act.SpawnTab 'CurrentPaneDomain' },
        { key = 't', mods = 'ALT', action = act.SpawnTab 'CurrentPaneDomain' },
        { key = 'Tab', mods = 'SHIFT|CTRL', action = act.ActivateTabRelative(-1)},
        { key = 'Tab', mods = 'CTRL', action = act.ActivateTabRelative(1)},
        -- Pane management
        { key = 'V', mods = wmod, action = act.SplitHorizontal{ domain = 'CurrentPaneDomain' } },
        { key = 'S', mods = wmod, action = act.SplitVertical{ domain = 'CurrentPaneDomain' } },
        { key = 'Space', mods = wmod, action = act{PaneSelect={mode='SwapWithActiveKeepFocus'}}},
        { key = 'M', mods = wmod, action = act.TogglePaneZoomState },
        { key = 'H', mods = wmod, action = act.ActivatePaneDirection 'Left' },
        { key = 'J', mods = wmod, action = act.ActivatePaneDirection 'Down' },
        { key = 'K', mods = wmod, action = act.ActivatePaneDirection 'Up' },
        { key = 'L', mods = wmod, action = act.ActivatePaneDirection 'Right' },
        { key = 'Q', mods = wmod, action = act.CloseCurrentPane { confirm = true } },
        { key = 'H', mods = 'CTRL|SHIFT', action = act.AdjustPaneSize { 'Left', 5 } },
        { key = 'J', mods = 'CTRL|SHIFT', action = act.AdjustPaneSize { 'Down', 5 } },
        { key = 'K', mods = 'CTRL|SHIFT', action = act.AdjustPaneSize { 'Up', 5 } },
        { key = 'L', mods = 'CTRL|SHIFT', action = act.AdjustPaneSize { 'Right', 5 } },
        -- Clear scrollback and redraw prompt
        {
          key = 'U',
          mods = wmod,
          action = act.Multiple {
            act.ClearScrollback 'ScrollbackAndViewport',
            act.SendKey { key = 'L', mods = 'CTRL' },
          },
        },
        -- Copy/paste with Ctrl-C/V or Alt-C/V
        {
          key = 'c',
          mods = 'CTRL',
          action = wezterm.action_callback(function(window, pane)
            local has_selection = window:get_selection_text_for_pane(pane) ~= ''
            if (has_selection) then
              window:perform_action(act.CopyTo 'ClipboardAndPrimarySelection', pane)
              window:perform_action(act.ClearSelection, pane)
            else
              window:perform_action(act.SendKey{ key='c', mods='CTRL' }, pane)
            end
          end),
        },
        { key = 'c', mods = 'ALT', action = act.CopyTo 'ClipboardAndPrimarySelection' },
        { key = 'v', mods = 'ALT', action = act.PasteFrom 'Clipboard' },
        { key = 'Insert', mods = 'SHIFT', action = act.PasteFrom 'Clipboard' },
        -- Font size management   
        { key = '+', mods = wmod, action = act.IncreaseFontSize },
        { key = '_', mods = wmod, action = act.DecreaseFontSize },
        { key = ')', mods = wmod, action = act.ResetFontSize },
        -- Custom events
        { key = 'G', mods = wmod, action = act{EmitEvent='trigger-vim-with-scrollback'} },
        { key = 'P', mods = wmod, action = act{EmitEvent='toggle-padding'} },
    }
end

return M
