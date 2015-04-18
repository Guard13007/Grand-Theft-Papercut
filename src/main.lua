local inspect = require "lib.inspect"
local serialize = require "lib.ser"

local lg = love.graphics

local tiles, tileset -- loaded in love.load

local scale = 2
local tileSize = 16 * scale

local player = {
    x = 1,
    y = 1,
    image = false --loaded after fixing image filter
}

local camera = {
    -- these are top left corner values
    x = 1,
    y = 1
}

function love.load()
    lg.setDefaultFilter("linear", "nearest", 1)
    player.image = lg.newImage("dude.png")

    tiles = require "tiles"
    tileset = require "tileset"
end

function love.draw()
    for x=camera.x,15 do
        for y=camera.y,10 do
            if tiles[x] and tiles[x][y] then
                lg.draw(tileset[tiles[x][y]], (x - camera.x) * tileSize, (y - camera.y) * tileSize, 0, scale, scale)
            end
        end
    end

    lg.draw(player.image, (player.x - camera.x) * tileSize, (player.y - camera.y) * tileSize, 0, scale, scale)
end

function love.keypressed(key, unicode)
    if key == "w" then
        player.y = player.y - 1
    elseif key == "a" then
        player.x = player.x - 1
    elseif key == "s" then
        player.y = player.y + 1
    elseif key == "d" then
        player.x = player.x + 1
    elseif key == "escape" then
        love.event.quit()
    end
end

function love.mousepressed(x, y, button)
    x = math.floor(x / tileSize) + 1
    y = math.floor(y / tileSize) + 1

    if button == "wu" then
        tiles[x][y] = tiles[x][y] - 1
        if tiles[x][y] < 0 then
            tiles[x][y] = tileset.count
        end
    elseif button == "wd" then
        tiles[x][y] = tiles[x][y] + 1
        if tiles[x][y] > tileset.count then
            tiles[x][y] = 0
        end
    end
end

function love.quit()
    love.filesystem.write("tiles.lua", serialize(tiles))
end
