local Gamestate = require "lib.gamestate"

local lg = love.graphics

local random = math.random

local card_tops = require "card_tops"
local card_bottoms = require "card_bottoms"
local npcset = require "npcset"

local card_back = lg.newImage("card_img/card_back.png")

local scale = 2
local tileSize = 16 * scale

local yHand, nHand = {}, {} --your hand, npc hand
local yField, nField = {}, {} -- fields, yours theirs

local previous, player, npc

local oPcards, oNcards

local fight = {}

local won = "n/a"

local function shuffle(deck)
    local newDeck = {}
    while table.getn(deck) >= 1 do
        table.insert(newDeck, table.remove(deck, random(1, table.getn(deck))))
    end
    deck = newDeck
    return newDeck
end

--fight.enter

local function draw(deck)
    -- check if there are any left first, if no, then resolve battle
    if table.getn(deck) >= 1 then
        return table.remove(deck, 1)--table.getn(deck)-1
    else
        --do maths, if win, display screen, leave
        -- else die screen, leave
        local sub = npc.attack - player.defense
        if sub > 0 then
            player.health = player.health - sub
        end
        sub = player.attack - npc.defense
        if sub > 0 then
            npc.health = npc.health - sub
        end

        if player.health < 0 then
            player.health = 0
            won = "no"
        elseif npc.health < 0 then
            npc.health = 0
            won = "yes"
        else
            player.cards = oPcards
            npc.cards = oNcards
            fight:enter(previous, player, npc)
        end
        return nil
    end
end

function fight:enter(sPrevious, cPlayer, NPC)
    previous = sPrevious
    player = cPlayer
    npc = NPC

    oPcards = player.cards
    oNcards = npc.cards

    player.cards = shuffle(player.cards)
    npc.cards = shuffle(npc.cards)

    yHand[1] = draw(player.cards)
    yHand[2] = draw(player.cards)
    yHand[3] = draw(player.cards)
    yHand[4] = draw(player.cards)
    yHand[5] = draw(player.cards)

    nHand[1] = draw(npc.cards)
    nHand[2] = draw(npc.cards)
    nHand[3] = draw(npc.cards)
    nHand[4] = draw(npc.cards)
    nHand[5] = draw(npc.cards)
end

local nSelected, selected = 0, 0
function fight:draw()
    -- cards!
    -- enemy (npc)
    lg.setColor(255, 255, 255)
    for i=1,#nHand do
        -- starting at 32x0, draw them left to right
        lg.draw(card_back, (i-1) * tileSize, 32, 0, scale, scale)
    end
    for i=1,#nField do
        lg.draw(card_bottoms[nField[i][2]].image, (i-1) * tileSize + 32, 64 + 64, math.pi, scale, scale)
        lg.draw(card_tops[nField[i][1]], (i-1) * tileSize + 32, 72 + 64 + 32-4, math.pi, scale, scale)
    end
    --you!
    for i=1,#yField do
        lg.draw(card_tops[yField[i][1]], (i-1) * tileSize, 104 + 64, 0, scale, scale)
        lg.draw(card_bottoms[yField[i][2]].image, (i-1) * tileSize, 136 + 64, 0, scale, scale)
    end
    for i=1,#yHand do
        lg.draw(card_tops[yHand[i][1]], (i-1) * tileSize, 168 + 64, 0, scale, scale)
        lg.draw(card_bottoms[yHand[i][2]].image, (i-1) * tileSize, 200 + 64, 0, scale, scale)
    end

    if selected ~= 0 then
        lg.setColor(255, 0, 0)
        lg.rectangle("line", (selected-1) * tileSize, 168 + 64, 32, 64)
    end

    -- health bars (r, g, b) red health, green attack, blue defense
    -- 4 per bar + 1 spacer = 15 + 1 extra spacer! (all this times 2)
    -- enemy (b,g,r)
    lg.setColor(0, 0, 255)
    lg.rectangle("fill", 0, 2, npc.defense * 2, 8)
    lg.setColor(0, 255, 0)
    lg.rectangle("fill", 0, 12, npc.attack * 2, 8)
    lg.setColor(255, 0, 0)
    lg.rectangle("fill", 0, 22, npc.health * 2, 8)
    --player (r,g,b)
    lg.setColor(255, 0, 0)
    lg.rectangle("fill", 0, 310, player.health * 2, 8)
    lg.setColor(0, 255, 0)
    lg.rectangle("fill", 0, 300, player.attack * 2, 8)
    lg.setColor(0, 0, 255)
    lg.rectangle("fill", 0, 290, player.defense * 2, 8)

    -- draw enemy and player last
    if npcset[npc.id].color then
        lg.setColor(npcset[npc.id].color)
    else
        lg.setColor(255, 255, 255)
    end
    lg.draw(npcset[npc.id].image, lg.getWidth() / 2 - 8 * scale + 32, 0 + 32, math.pi, scale, scale)
    lg.setColor(255, 255, 255)
    lg.draw(player.image, lg.getWidth() / 2 - 8 * scale, lg.getHeight() - tileSize, 0, scale, scale)


    --won or lost?!!
    if won == "yes" then
        lg.setColor(0, 0, 0, 100)
        lg.rectangle("fill", 0, 0, lg.getWidth(), lg.getHeight())
        lg.setColor(255, 255, 255, 255) -- TODO find out if omitting the final 255 would work, or if a lack of it could break other code
        lg.printf("YOU WON", 0, lg.getWidth(), lg.getHeight()/2, "center")
    elseif won == "no" then
        lg.setColor(0, 0, 0, 100)
        lg.rectangle("fill", 0, 0, lg.getWidth(), lg.getHeight())
        lg.setColor(255, 255, 255, 255)
        lg.printf("YOU LOST", 0, lg.getWidth(), lg.getHeight()/2, "center")
    end
end

function fight:mousepressed(x, y, button)
    if won == "yes" then
        Gamestate.switch(previous, player, npc)
    elseif won == "no" then
        love.event.quit()
    end
    if button == "l" and y > 168 + 64 and y <= 232 + 64 then
        --selecting a card from hand
        selected = math.floor(x / 32) + 1 --cards 32 pixels wide
        if yHand[selected] ~= nil then
            --enemy selects a card
            nSelected = random(1, #nHand)
        else
            selected = 0
        end
    elseif button == "l" and y >= 104 + 64 and y <= 168 + 64 and selected ~= 0 then
        --placing a card
        local card = yHand[selected]
        table.insert(yField, card)
        table.remove(yHand, selected)

        player.health = player.health + card_bottoms[card[2]].r
        player.attack = player.attack + card_bottoms[card[2]].g
        player.defense = player.defense + card_bottoms[card[2]].b

        -- now npc plays!

        local card = nHand[nSelected]
        table.insert(nField, card)
        table.remove(nHand, nSelected)

        npc.health = npc.health + card_bottoms[card[2]].r
        npc.attack = npc.attack + card_bottoms[card[2]].g
        npc.defense = npc.defense + card_bottoms[card[2]].b

        selected = 0
        nSelected = 0

        table.insert(yHand, draw(player.cards))
        table.insert(nHand, draw(npc.cards))
    end
end

return fight
