SMODS.Enhancement:take_ownership('mult', { -- Mult Cards
    config = { mult = 5 },
}, false)

SMODS.Enhancement:take_ownership('wild', { -- Wild Cards

}, false)

local game_update_ref = Game.update
function Game:update(dt)
    game_update_ref(self, dt)
    if G.playing_cards then
        for _, v in ipairs(G.playing_cards) do
            if v.debuff then
                if SMODS.has_enhancement(v, 'm_wild') then
                    v.debuff = false
                end
            end
        end
    end
end

local debuff_card_ref = Blind.debuff_card
function Blind:debuff_card(card, from_blind)
    if not SMODS.has_enhancement(card, 'm_wild') then
        debuff_card_ref(self, card, from_blind)
    end
end

SMODS.Enhancement:take_ownership('stone', { -- Stone Cards
    config = { bonus = 75 },
}, false)