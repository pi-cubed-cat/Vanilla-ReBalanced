SMODS.Shader({ key = 'bisexual', path = 'bisexual.fs' })

SMODS.Edition {
	key = "bisexual",
	order = 2,
    loc_txt = {
        name = "Bisexual",
        label = "Bisexual",
        text = {
            "Creates a {C:tarot}Tarot{} card",
            "at end of round",
            "{C:inactive}(Must have room){}"
        }
    },
	weight = 3,
	shader = "bisexual",
	in_shop = true,
	extra_cost = 4,
	sound = { sound = "polychrome1", per = 1.1, vol = 0.7 },
    config = { triggered = false },
	get_weight = function(self)
		return G.GAME.edition_rate * self.weight
	end,
	calculate = function(self, card, context)
		if ((context.playing_card_end_of_round and context.cardarea == G.hand)
        or (context.main_eval and context.end_of_round and context.game_over == false and not context.blueprint)) 
        and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = function()
                    SMODS.add_card {
                        set = 'Tarot',
                        key_append = 'bisexual'
                    }
                    G.GAME.consumeable_buffer = 0
                    return true
                end
            }))
            return { message = localize('k_plus_tarot'), colour = G.C.PURPLE }
        end
	end,
}

SMODS.Atlas {
	key = "vanillarb_tags",
	path = "tags.png",
	px = 34,
	py = 34
}

SMODS.Tag {
    key = "bisexual",
    loc_txt = {
        name = "Bisexual Tag",
        text = {
            "Creates a random",
            "{C:dark_edition}Bisexual{} Joker",
            "{C:inactive}(Must have room){}"
        }
    },
    min_ante = 2,
    pos = { x = 0, y = 0 },
    atlas = "vanillarb_tags",
    config = { spawn_jokers = 1 },
    loc_vars = function(self, info_queue, tag)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_vanillarb_bisexual
        return { vars = { tag.config.spawn_jokers } }
    end,
    apply = function(self, tag, context)
        if context.type == 'immediate' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.PURPLE, function()
                for _ = 1, tag.config.spawn_jokers do
                    if G.jokers and #G.jokers.cards < G.jokers.config.card_limit then
                        SMODS.add_card {
                            set = "Joker",
                            edition = 'e_vanillarb_bisexual',
                            key_append = "vanillarb_bisexualtag",
                        }
                    end
                end
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
            return true
        end
    end
}