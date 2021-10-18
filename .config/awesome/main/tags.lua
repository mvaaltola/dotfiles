-- Standard awesome library
local awful = require("awful")

local _M = {}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function _M.get ()
  local tags = {}
  tags = {
    settings = {
      { names  = { "1", "2", "3", "4", "5", "6", "7", "8", "9" },
        layout = RC.layouts[1]
      },
      { names  = { "1", "2", "3", "4", "5", "6", "7", "8", "9" },
        layout = RC.layouts[3]
      }
    }
  }

  awful.screen.connect_for_each_screen(function(s)
    -- Each screen has its own tag table.
    tags[s] = awful.tag(tags.settings[s.index].names, s, tags.settings[s.index].layout)
  end)
  
  return tags
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })
