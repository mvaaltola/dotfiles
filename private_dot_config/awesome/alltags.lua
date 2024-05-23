local awful = require("awful")

local state = false
function ToggleAllTags()
    local screen = awful.screen.focused()
    if (state == false)
        then
            Current_tag = awful.screen.focused().selected_tags
            for i = 1,9 do
                local tag = screen.tags[i]
                if #tag:clients() > 0
                    then
                        tag.selected = true
                    end
            end
            awful.layout.set(awful.layout.suit.fair)
            state = true
        else
            state = false
            awful.layout.set(awful.layout.suit.tile)
            for i = 1,9 do
                local tag = screen.tags[i]
                for _, v in ipairs(Current_tag) do
                    if tag==v then
                        tag.selected = true
                    else
                        tag.selected = false
                    end
                end
        end
    end
end
