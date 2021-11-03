-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
local xresources = require("beautiful.xresources")
local xrdb = xresources.get_current_theme()
local lain = require("lain")

-- Wibox handling library
local wibox = require("wibox")

-- Custom Local Library: Common Functional Decoration
local deco = {
  wallpaper = require("deco.wallpaper"),
  taglist   = require("deco.taglist"),
  tasklist  = require("deco.tasklist")
}

local taglist_buttons  = deco.taglist()
local tasklist_buttons = deco.tasklist()

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- {{{ Wibar

-- Lain related
local theme = {}
theme.bg = xrdb.background
theme.fg = xrdb.foreground
theme.font = "Cascadia Code PL 9"

local markup = lain.util.markup

-- Create a textclock widget
local mytextclock = wibox.widget.textclock("%a %d.%m.%y %T", 1)
mytextclock.font = theme.font

local kblayout = awful.widget.keyboardlayout()
kblayout.widget.font = theme.font

-- calendar
local cal = lain.widget.cal({
    attach_to = { mytextclock },
    notification_preset = {
        font = theme.font,
        fg = theme.fg,
        bg = theme.bg
    }
})

-- mem
local mem = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.font(theme.font, " r-" .. mem_now.used .. "m "))
    end
})

local vol = lain.widget.alsa({
    settings = function()
        vlevel = volume_now.level
        if volume_now.status == "off" then
            vlevel = vlevel .. "m "
        else
            vlevel = vlevel .. "% "
        end
        widget:set_markup(markup.font(theme.font, "v-" .. vlevel))
    end
})

local bat = lain.widget.bat({
    settings = function()
        local perc = bat_now.perc
        if perc == "N/A" then
            widget:set_markup("")
            else
            if bat_now.ac_status == 1 then 
                perc = perc .. "c "
                else
                perc = perc .. "% "
            end
            widget:set_markup(markup.font(theme.font, "b-" .. perc))
        end
    end
})

awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  set_wallpaper(s)

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()

  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(gears.table.join(
    awful.button({ }, 1, function () awful.layout.inc( 1) end),
    awful.button({ }, 3, function () awful.layout.inc(-1) end),
    awful.button({ }, 4, function () awful.layout.inc( 1) end),
    awful.button({ }, 5, function () awful.layout.inc(-1) end)
  ))

  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist {
    screen  = s,
    filter  = function (t) return t.selected or #t:clients() > 0 end,
    buttons = taglist_buttons
  }

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist {
    screen  = s,
    filter  = awful.widget.tasklist.filter.currenttags,
    buttons = tasklist_buttons
  }

  -- Create the wibox
  s.mywibox = awful.wibar({ position = "top", screen = s })

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      s.mytaglist,
      s.mylayoutbox,
      s.mypromptbox,
    },
    s.mytasklist, -- Middle widget
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      kblayout,
      wibox.widget.systray(),
      mem,
      bat,
      vol.widget,
      mytextclock,
    },
  }
end)
-- }}}
