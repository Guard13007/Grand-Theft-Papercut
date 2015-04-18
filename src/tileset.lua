local img = love.graphics.newImage

local tileset = {
    [0] = img("black.png"),
    img("road.png"),
    img("road_whitestripe.png"),
    img("road_yellowstripe.png"),
    img("road_whitestripe2.png"),
    img("road_yellowstripe2.png"),
    img("road_crosswalk.png"),
    img("road_crosswalk2.png"),
    img("sidewalk.png"),
    img("sidewalk2.png"),
    img("sidewalk3.png"),
}

tileset.count = #tileset

return tileset
