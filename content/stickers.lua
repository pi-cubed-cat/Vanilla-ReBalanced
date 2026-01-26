SMODS.Sticker:take_ownership("perishable", { -- Perishable sticker
    --[[calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.individual then
            if card.ability.perish_tally == 1 then
                card:set_edition('e_negative')
            end
            card:calculate_perishable()
        end
    end]]
}, false)

local calculate_perishable_ref = Card.calculate_perishable
function Card:calculate_perishable()
    if self.ability.perishable and self.ability.perish_tally > 0 then
        if self.ability.perish_tally <= 1 then
            G.E_MANAGER:add_event(Event({
                func = function()
                    self:set_edition('e_negative', nil, true)
                    return true
                end
            }))
        end
    end
    calculate_perishable_ref(self)
end

SMODS.Sticker:take_ownership("perishable", { -- Perishable sticker
    in_pool = false,
}, true)

SMODS.Stake:take_ownership('gold', { -- Gold stake (anti-bunco)
    applied_stakes = {'orange'},
    above_stake = 'orange'
})

SMODS.Stake:take_ownership('bunco_cyan', { -- Cyan stake (anti-bunco)
    should_apply = function(self, card, center, area, bypass_roll)
        return false
    end
})

SMODS.Stake:take_ownership('bunco_pink', { -- Pink stake (anti-bunco)
    should_apply = function(self, card, center, area, bypass_roll)
        return false
    end
})

SMODS.Stake:take_ownership('bunco_magenta', { -- Magenta stake (anti-bunco)
    should_apply = function(self, card, center, area, bypass_roll)
        return false
    end
})