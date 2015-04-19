local img = love.graphics.newImage

local function npc(imgFile, color)
    return {
        image = img("npc_img/" .. imgFile),
        color = color
    }
end

local npcset = {
    npc("orange_black.png"),
}

return npcset
