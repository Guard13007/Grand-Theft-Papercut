math.randomseed(os.time()) --just to be sure
local random = math.random

-- CARDS
-- 5 tops
-- 12 bottoms

return {
    x = 9,
    y = 7,
    health = 100,
    attack = 10,
    defense = 10,
    cards = {
        {random(1, 5), random(1, 12)},
        {random(1, 5), random(1, 12)},
        {random(1, 5), random(1, 12)},
        {random(1, 5), random(1, 12)},
        {random(1, 5), random(1, 12)},
        {random(1, 5), random(1, 12)},
        {random(1, 5), random(1, 12)},
        {random(1, 5), random(1, 12)},
        {random(1, 5), random(1, 12)},
        {random(1, 5), random(1, 12)},
        {random(1, 5), random(1, 12)},
        {random(1, 5), random(1, 12)},
        {random(1, 5), random(1, 12)},
        {random(1, 5), random(1, 12)},
        {random(1, 5), random(1, 12)},
        {random(1, 5), random(1, 12)},
        {random(1, 5), random(1, 12)},
        {random(1, 5), random(1, 12)},
        {random(1, 5), random(1, 12)},
        {random(1, 5), random(1, 12)},
    },
    image = false --loaded after fixing image filter
}
