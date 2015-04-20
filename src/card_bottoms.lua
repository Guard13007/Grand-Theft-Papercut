local img = love.graphics.newImage

local function bottom(r, g, b)
    return {
        image = img("card_img/" .. r .. "x" .. g .. "x" .. b .. ".png"),
        r = r,
        g = g,
        b = b
    }
end

local card_bottoms = {
    bottom(1, 1, 1),
    bottom(1, 1, 4),
    bottom(1, 1, 12),
    bottom(1, 4, 1),
    bottom(1, 12, 1),
    bottom(4, 1, 1),
    bottom(4, 1, 8),
    bottom(4, 4, 4),
    bottom(4, 8, 1),
    bottom(8, 1, 4),
    bottom(8, 4, 1),
    bottom(12, 1, 1),
--[[
bottom("1x1x1.png"),
bottom("1x1x4.png"),
bottom("1x1x12.png"),
bottom("1x4x1.png"),
bottom("1x12x1.png"),
bottom("4x1x1.png"),
bottom("4x1x8.png"),
bottom("4x4x4.png"),
bottom("4x8x1.png"),
bottom("8x1x4.png"),
bottom("8x4x1.png"),
bottom("12x1x1.png"),
]]
}

return card_bottoms
