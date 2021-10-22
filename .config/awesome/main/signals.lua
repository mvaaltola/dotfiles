-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")

-- Custom Local Library: Common Functional Decoration
require("deco.titlebar")

-- reading
-- https://awesomewm.org/apidoc/classes/signals.html

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
  -- Set the windows at the slave,
  -- i.e. put it at the end of others instead of setting it master.
  -- if not awesome.startup then awful.client.setslave(c) end

  if awesome.startup
    and not c.size_hints.user_position
    and not c.size_hints.program_position then
      -- Prevent clients from being unreachable after screen count changes.
      awful.placement.no_offscreen(c)
  end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- warp mouse to focused client
function move_mouse_onto_focused_client()
    local c = client.focus 
    gears.timer( {  timeout = 0.1,
                autostart = true,
                single_shot = true,
                callback =  function()
                    if (mouse.object_under_pointer() ~= c and c.type == "normal") then
                        local geometry = c:geometry()
                        local x = geometry.x + geometry.width/2
                        local y = geometry.y + geometry.height/2
                        mouse.coords({x = x, y = y}, true)
                    end
                end } )
end

client.connect_signal("focus", move_mouse_onto_focused_client)
client.connect_signal("swapped", move_mouse_onto_focused_client)

-- }}}
