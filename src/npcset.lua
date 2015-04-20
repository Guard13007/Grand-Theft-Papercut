local img = love.graphics.newImage
love.graphics.setDefaultFilter("linear", "nearest", 1)

local function npc(imgFile, color)
    return {
        image = img("npc_img/" .. imgFile),
        color = color
    }
end

local npcset = {
    npc("orange_black.png"),
}

function npcset.isNPC(npcs, x, y)
    for i=1,#npcs do
        if npcs[i].x == x and npcs[i].y == y then
            return true
        end
    end
    return false
end

function npcset.isNotNPC(npcs, x, y)
    for i=1,#npcs do
        if npcs[i].x == x and npcs[i].y == y then
            return false
        end
    end
    return true
end

function npcset.NPCat(npcs, x, y)
    for i=1,#npcs do
        if npcs[i].x == x and npcs[i].y == y then
            return npcs[i]
        end
    end
    return false
end

return npcset
