SMODS.Blind:take_ownership('final_vessel', { -- Violet Vessel
    mult = 5
}, false)

SMODS.Blind:take_ownership('serpent', { -- The Serpent
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.drawing_cards and (G.GAME.current_round.hands_played ~= 0 or G.GAME.current_round.discards_used ~= 0) then
                local num_cards = math.max(3, G.hand.config.card_limit - #G.hand.cards)
                if num_cards > 0 then
                    return {
                        cards_to_draw = num_cards
                    }
                end
            end
        end
    end
}, false)