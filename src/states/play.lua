--local Gamestate = require "lib.gamestate"
local inspect = require "lib.inspect" -- DEBUG (not being used)
local serialize = require "lib.ser"
local cron = require "lib.cron"

local lg = love.graphics
local lk = love.keyboard

local tiles, tileset -- loaded on initialization

local scale = 2
local tileSize = 16 * scale

local player = require "player"
local camera = require "camera"

local play = {}

function play:init()
    lg.setDefaultFilter("linear", "nearest", 1)
    player.image = lg.newImage("dude.png")

    tiles = require "tiles"
    tileset = require "tileset"
end

function play:draw()
    for x=camera.x,camera.x+14 do
        for y=camera.y,camera.y+9 do
            if tiles[x] and tiles[x][y] then
                if tileset[tiles[x][y]].color then
                    lg.setColor(tileset[tiles[x][y]].color)
                else
                    lg.setColor(255, 255, 255)
                end
                lg.draw(tileset[tiles[x][y]].image, (x - camera.x) * tileSize, (y - camera.y) * tileSize, 0, scale, scale)
            end
        end
    end

    lg.setColor(255, 255, 255)
    lg.draw(player.image, (player.x - camera.x) * tileSize, (player.y - camera.y) * tileSize, 0, scale, scale)
end

local movement, lastKeys = false, {}
local function move()
    local moved

    if lk.isDown("w") and lastKeys[1] == "w" and tileset.isWalkable(tiles[player.x][player.y-1]) then
        player.y = player.y - 1
        moved = true
    end
    if lk.isDown("a") and lastKeys[1] == "a" and tiles[player.x-1] and tileset.isWalkable(tiles[player.x-1][player.y]) then
        player.x = player.x - 1
        moved = true
    end
    if lk.isDown("s") and lastKeys[1] == "s" and tileset.isWalkable(tiles[player.x][player.y+1]) then
        player.y = player.y + 1
        moved = true
    end
    if lk.isDown("d") and lastKeys[1] == "d" and tiles[player.x+1] and tileset.isWalkable(tiles[player.x+1][player.y]) then
        player.x = player.x + 1
        moved = true
    end

    if moved then
        if math.abs(player.x - camera.x) < 5 then
            camera.x = camera.x - 1
        elseif math.abs(player.x - camera.x) > 9 then
            camera.x = camera.x + 1
        elseif math.abs(player.y - camera.y) < 3 then
            camera.y = camera.y - 1
        elseif math.abs(player.y - camera.y) > 6 then
            camera.y = camera.y + 1
        end

        movement = cron.after(1/5, move)
    end
end

function play:update(dt)
    if movement then movement:update(dt) end
end

function play:keypressed(key, unicode)
    table.insert(lastKeys, 1, key) -- we save the last key pressed

    if key == "escape" then
        love.event.quit()
    end

    move()
end

function play:keyreleased(key)
    --find key in lastKeys and remove it
    for i=#lastKeys,1,-1 do
        if lastKeys[i] == key then
            table.remove(lastKeys, i)
        end
    end
end

function play:quit()
    player.image = false -- so serialize doesn't freak out
    love.filesystem.write("player.lua", serialize(player))
    love.filesystem.write("camera.lua", serialize(camera))
end

return play
