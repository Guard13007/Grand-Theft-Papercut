local img = love.graphics.newImage

local function top(imgFile, color)
    return img("card_img/" .. imgFile)
end

local card_tops = {
    top("die.png"),
    top("hal9000.png"),
    top("ludum_dare.png"),
    top("molly_hattrick.png"),
    top("playing_card.png"),
}

return card_tops
