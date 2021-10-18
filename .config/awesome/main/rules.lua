-- Standard awesome library
local awful     = require("awful")
-- Theme handling library
local beautiful = require("beautiful")

local _M = {}

screen_width = awful.screen.focused().geometry.width
screen_height = awful.screen.focused().geometry.height

-- reading
-- https://awesomewm.org/apidoc/libraries/awful.rules.html

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function _M.get(clientkeys, clientbuttons)
  local rules = {

    -- All clients will match this rule.
    { rule = { },
      properties = {
        border_width = beautiful.border_width,
        border_color = beautiful.border_normal,
        focus     = awful.client.focus.filter,
        raise     = true,
        keys      = clientkeys,
        buttons   = clientbuttons,
        screen    = awful.screen.preferred,
        placement = awful.placement.no_overlap+awful.placement.no_offscreen
      }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      },
      properties = { 
        floating = true 
      }
    },

    -- Add titlebars only to and dialogs
    { rule_any = {
        type = { "dialog" } -- removed "normal"
      }, 
      properties = { 
        titlebars_enabled = true
      }
    },

    -- Scratchpads
    -- Terminal scratchpad
    { rule_any = {
        instance = { "scratchpad" },
        class = { "scratchpad" },
      },
      properties = {
        skip_taskbar = false,
        floating = true,
        ontop = false,
        minimized = true,
        sticky = false,
        width = screen_width * 0.4,
        height = screen_height * 0.4
      },
      callback = function (c)
        awful.placement.centered(c, {honor_padding = true, honor_workarea = true})
        gears.timer.delayed_call(function()
            c.urgent = false
        end)
      end
    },

    -- Obsidian scratchpad
    { rule_any = {
        instance = { "obsidian" },
        class = { "obsidian" },
      },
      properties = {
        skip_taskbar = false,
        floating = true,
        ontop = false,
        minimized = true,
        sticky = false,
        width = 900,
        height = 800
        -- width = screen_width * 0.5,
        -- height = screen_height * 0.5
      },
      callback = function (c)
        awful.placement.centered(c, {honor_padding = true, honor_workarea = true})
        gears.timer.delayed_call(function()
            c.urgent = false
        end)
      end
    },

    -- Rambox scratchpad
    { rule_any = {
        instance = { "ramboxpro" },
        class = { "ramboxpro" },
      },
      properties = {
        skip_taskbar = false,
        floating = true,
        ontop = false,
        minimized = true,
        sticky = false,
        width = 1200,
        height = 900
        -- width = screen_width * 0.5,
        -- height = screen_height * 0.5
      },
      callback = function (c)
        awful.placement.centered(c, {honor_padding = true, honor_workarea = true})
        gears.timer.delayed_call(function()
            c.urgent = false
        end)
      end
    },

    -- Mailspring scratchpad
    { rule_any = {
        instance = { "Mailspring" },
        class = { "Mailspring" },
      },
      properties = {
        skip_taskbar = false,
        floating = true,
        ontop = false,
        minimized = true,
        sticky = false,
        width = screen_width * 0.6,
        height = screen_height * 0.5
      },
      callback = function (c)
        awful.placement.centered(c, {honor_padding = true, honor_workarea = true})
        gears.timer.delayed_call(function()
            c.urgent = false
        end)
      end
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },

  }

  return rules
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })
