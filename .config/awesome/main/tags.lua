-- Standard awesome library
local awful = require("awful")

local _M = {}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function _M.get ()
  local tags = {}
  local names = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }

  awful.screen.connect_for_each_screen(function(s)
    -- Each screen has its own tag table.

    local geom = s.geometry
    local layout = RC.layouts[1]
    if geom["width"]<geom["height"] then layout = RC.layouts[3] end

    tags[s] = awful.tag(names, s, layout)
  end)
  
  return tags
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })
