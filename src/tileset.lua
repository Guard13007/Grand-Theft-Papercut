local img = love.graphics.newImage

local function tile(imgFile, color)
    return {
        image = img("tile_img/" .. imgFile),
        color = color
    }
end

local tileset = {
    [0] = tile("black.png"),
    -- 1
    tile("road.png"),
    tile("road_whitestripe.png"),
    tile("road_yellowstripe.png"),
    tile("road_whitestripe2.png"),
    tile("road_yellowstripe2.png"),
    tile("road_crosswalk.png"),
    tile("road_crosswalk2.png"),
    tile("sidewalk.png"),
    tile("sidewalk2.png"),
    tile("sidewalk3.png"),
    -- 11
    tile("building_window.png", {102, 0, 255}),
    tile("roof1.png", {102, 0, 255}),
    tile("roof2.png", {102, 0, 255}),
    tile("roof3.png", {102, 0, 255}),
    tile("roof4.png", {102, 0, 255}),
    tile("roof5.png", {102, 0, 255}),
    tile("roof6.png", {102, 0, 255}),
    tile("roof7.png", {102, 0, 255}),
    tile("roof8.png", {102, 0, 255}),
    tile("roof9.png", {102, 0, 255}),
    -- 21
    tile("grass.png"),
    -- 22
    tile("road_closed.png"),
    tile("sidewalk_closed.png"),
    tile("grass_closed.png"),
    tile("sidewalk_closed2.png"),
    tile("road_closed2.png"),
}

function tileset.isWalkable(k)
    if k and k > 0 and k < 11 or k == 21 then
        return true
    else
        return false
    end
end

tileset.count = #tileset

return tileset
