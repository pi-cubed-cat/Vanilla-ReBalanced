SMODS.Seal:take_ownership('Blue', {
    config = { extra = { odds = 5, numerator_base = 0 }},
    loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(self, 1, self.config.extra.odds, 'trance')
		return { 
            vars = { numerator, denominator, self.config.extra.numerator_base } 
		}
	end,
    calculate = function(self, card, context)
        if context.initial_scoring_step and context.scoring_hand then
            G.GAME.last_hand_played_size = #context.scoring_hand
        end
        if context.playing_card_end_of_round and context.cardarea == G.hand and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            if SMODS.pseudorandom_probability(card.ability.seal, 'trance', 
            card.ability.seal.extra.numerator_base + (G.GAME.last_hand_played_size or 0), card.ability.seal.extra.odds) then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.0,
                    func = function()
                        if G.GAME.last_hand_played then
                            local _planet = nil
                            for k, v in pairs(G.P_CENTER_POOLS.Planet) do
                                if v.config.hand_type == G.GAME.last_hand_played then
                                    _planet = v.key
                                end
                            end
                            if _planet then
                                SMODS.add_card({ key = _planet })
                            end
                            G.GAME.consumeable_buffer = 0
                        end
                        return true
                    end
                }))
                return { message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet }
            end
        end
    end
}, false)