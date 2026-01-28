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