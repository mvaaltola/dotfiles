local wezterm = require('wezterm')
local act = wezterm.action
local wmod = 'SHIFT|SUPER'

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
        -- Close pane, reload, command palette
        { key = 'q', mods = 'CMD', action = act.CloseCurrentPane { confirm = true } },
        { key = 'F5', mods = wmod, action = act.ReloadConfiguration },
        { key = 'p', mods = wmod, action = act.ActivateCommandPalette },
        -- Scrolling
        { key = 'j', mods = 'SUPER', action = act.ScrollByLine(1) },
        { key = 'k', mods = 'SUPER', action = act.ScrollByLine(-1) },
        { key = 'h', mods = 'SUPER', action = act.ScrollToPrompt(-1) },
        { key = 'l', mods = 'SUPER', action = act.ScrollToPrompt(1) },
        { key = 'PageUp', mods = 'SUPER', action = act.ScrollByPage(-1) },
        { key = 'PageDown', mods = 'SUPER', action = act.ScrollByPage(1) },
        -- Claude SHIFT-ENTER
        {key="Enter", mods="SHIFT", action=wezterm.action{SendString="\x1b\r"}},
        -- Tab management
        { key = 'T', mods = wmod, action = act.SpawnTab 'CurrentPaneDomain' },
        { key = 'Tab', mods = 'SHIFT|CTRL', action = act.ActivateTabRelative(-1)},
        { key = 'Tab', mods = 'CTRL', action = act.ActivateTabRelative(1)},
        -- Pane management
        -- Splitting and swapping
        { key = 'V', mods = wmod, action = act.SplitHorizontal{ domain = 'CurrentPaneDomain' } },
        { key = 'S', mods = wmod, action = act.SplitVertical{ domain = 'CurrentPaneDomain' } },
        { key = 'Space', mods = wmod, action = act{PaneSelect={mode='SwapWithActiveKeepFocus'}}},
        -- Zoom pane (M for monocle)
        { key = 'M', mods = wmod, action = act.TogglePaneZoomState },
        -- Navigate panes
        { key = 'H', mods = wmod, action = act.ActivatePaneDirection 'Left' },
        { key = 'J', mods = wmod, action = act.ActivatePaneDirection 'Down' },
        { key = 'K', mods = wmod, action = act.ActivatePaneDirection 'Up' },
        { key = 'L', mods = wmod, action = act.ActivatePaneDirection 'Right' },
        -- Close pane
        -- { key = 'Q', mods = wmod, action = act.CloseCurrentPane { confirm = true } },
        -- Resize pane with ctrl-shift-hjkl
        { key = 'H', mods = 'CTRL|SHIFT', action = act.AdjustPaneSize { 'Left', 5 } },
        { key = 'J', mods = 'CTRL|SHIFT', action = act.AdjustPaneSize { 'Down', 5 } },
        { key = 'K', mods = 'CTRL|SHIFT', action = act.AdjustPaneSize { 'Up', 5 } },
        { key = 'L', mods = 'CTRL|SHIFT', action = act.AdjustPaneSize { 'Right', 5 } },
        -- Open scrollback in vim
        { key = 'G', mods = wmod, action = act{EmitEvent='trigger-vim-with-scrollback'} },
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
        { key = 'c', mods = 'SUPER', action = act.CopyTo 'ClipboardAndPrimarySelection' },
        { key = 'v', mods = 'SUPER', action = act.PasteFrom 'Clipboard' },
        { key = 'Insert', mods = 'SHIFT', action = act.PasteFrom 'Clipboard' },
        -- Font size management - leader +-, reset with leader 0
        { key = '+', mods = wmod, action = act.IncreaseFontSize },
        { key = '_', mods = wmod, action = act.DecreaseFontSize },
        { key = ')', mods = wmod, action = act.ResetFontSize },
        -- Toggle padding with custom event
        -- { key = 'P', mods = wmod, action = act{EmitEvent='toggle-padding'} },
	-- Rename tabs
	{
	  key = 'R',
	  mods = wmod,
	  action = act.PromptInputLine {
	    description = 'Enter new name for tab',
	    action = wezterm.action_callback(function(window, pane, line)
	      -- line will be `nil` if they hit escape without entering anything
	      -- An empty string if they just hit enter
              -- Or the actual line of text they wrote
	      if line then
	        window:active_tab():set_title(line)
	      end
	    end),
	  },
	},
    }
end

return M
