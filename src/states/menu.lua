local Gamestate = require "lib.gamestate"

local editor = require "states.editor"
local play = require "states.play"

local lg = love.graphics
local sw, sh = lg.getWidth(), lg.getHeight()

local menu = {}

--[[
function menu:enter()
    --lg.setNewFont(sw / 15)
end
]]

function menu:draw()
    lg.setNewFont(sw / 15)
    lg.printf("Grand Theft Papercut", 0, sh / 7, sw, "center")
    lg.setNewFont(sw / 20)
    lg.printf("Left click to play.", 0, sh * 2/3 - sh * 1/20, sw, "center")
    lg.printf("Right click to edit map.", 0, sh * 2/3 + sh * 1/20, sw, "center")
end

function menu:mousepressed(x, y, button)
    if button == "l" then
        Gamestate.switch(play)
    elseif button == "r" then
        Gamestate.switch(editor)
    end
end

function menu:keypressed(key, unicode)
    if key == "escape" then
        love.event.quit()
    end
end

return menu
