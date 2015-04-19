local Gamestate = require "lib.gamestate"

local menu = require "states.menu"

Gamestate.registerEvents()
Gamestate.switch(menu)
