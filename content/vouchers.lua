SMODS.Voucher:take_ownership('hone', {

}, false)

SMODS.Voucher:take_ownership('glow_up', {

}, false)

SMODS.Voucher:take_ownership('magic_trick', {

}, false)

SMODS.Voucher:take_ownership('illusion', {
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.spectral_rate = 2 -- this is the same as Ghost deck
            return true
            end
        }))
    end,
}, false)

SMODS.Voucher:take_ownership('tarot_tycoon', {
    config = {},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.p_arcana_mega_1
        return { vars = {} }
    end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event {
            func = function()
                local booster = SMODS.add_booster_to_shop('p_arcana_mega_'..math.random(1,2))
                booster.ability.couponed = true
                booster:set_cost()
                return true
            end
        })
    end,
    calculate = function(self, card, context)
        if context.starting_shop then -- code from Paperback's iron cross
            G.E_MANAGER:add_event(Event {
                func = function()
                    local booster = SMODS.add_booster_to_shop('p_arcana_mega_'..math.random(1,2))
                    booster.ability.couponed = true
                    booster:set_cost()
                    return true
                end
            })
        end
    end,
}, false)

SMODS.Voucher:take_ownership('planet_tycoon', {
    config = {},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'e_negative_consumable', set = 'Edition', config = { extra = 1 } }
        return { vars = {} }
    end,
    redeem = function(self, card) -- don't turn existing cards negative
        if G.shop_jokers and G.shop_jokers.cards then
            for k,v in ipairs(G.shop_jokers.cards) do
                if v.ability.set == "Planet" and not v.tycooned then
                    v.tycooned = true
                end
            end
        end
    end,
    update = function(self, card, dt)
        if G.shop_jokers and G.shop_jokers.cards then
            for k,v in ipairs(G.shop_jokers.cards) do
                if v.ability.set == "Planet" and not v.tycooned then
                    v.tycooned = true
                    if pseudorandom(pseudoseed('planet_tycoon')) > 0.9 then
                        v:set_edition('e_negative', true)
                    end
                end
            end
        end
    end,
}, false)

local smods_showman_ref = SMODS.showman
function SMODS.showman(card_key)
    if next(SMODS.find_card('v_telescope')) then
        local _planet, _hand, _tally = nil, nil, 0
        for _, handname in ipairs(G.handlist) do
            if SMODS.is_poker_hand_visible(handname) and G.GAME.hands[handname].played > _tally then
                _hand = handname
                _tally = G.GAME.hands[handname].played
            end
        end
        if _hand then
            for _, v in pairs(G.P_CENTER_POOLS.Planet) do
                if v.config.hand_type == _hand then
                    _planet = v.key
                end
            end
        end
        return card_key == _planet
    end
    return smods_showman_ref(card_key)
end

SMODS.Voucher:take_ownership('telescope', {
    
}, false)

SMODS.Voucher:take_ownership('hieroglyph', {
    redeem = function(self, card)
        -- Apply ante change
        ease_ante(-card.ability.extra)
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante - card.ability.extra

        -- Apply discard change
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra
        ease_discard(-card.ability.extra)
    end,
}, false)

SMODS.Voucher:take_ownership('petroglyph', {
    redeem = function(self, card)
        -- Apply ante change
        ease_ante(-card.ability.extra)
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante - card.ability.extra

        -- Apply hand change
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra
        ease_hands_played(-card.ability.extra)
    end
}, false)