SMODS.Atlas {
    key = "PiCubedsJokers",
    path = "picubedsjokers.png",
    px = 71,
    py = 95
}

if not picubed_is_stonelike then
	-- check if a card is a stone card or a rankless & suitless enhanced card
	function picubed_is_stonelike(card)
		if card then
			if SMODS.has_enhancement(card, 'm_stone') 
			or SMODS.has_no_rank(card) and SMODS.has_no_suit(card) and card.config.center ~= G.P_CENTERS.c_base then
				return true
			else
				return false
			end
		end
	end

	local find_collage = false
	if next(SMODS.find_mod("artbox")) then
		find_collage = true
	end

	-- change the tooltip of a joker depending on if new rankless & suitless enhancements are added (crossmod)
	function picubed_stonelike_infoqueue(info_queue)
		if not find_collage then
			local has_modded_norank = false
			for k,v in ipairs(get_current_pool("Enhanced")) do
				if v ~= 'm_stone' and G.P_CENTERS[v] and G.P_CENTERS[v].no_rank and G.P_CENTERS[v].no_suit then
					has_modded_norank = true
					break
				end
			end
			if not has_modded_norank then
				info_queue[#info_queue+1] = G.P_CENTERS.m_stone
			else
				info_queue[#info_queue + 1] = { key = "picubed_ranklesscards", set = "Other" }
			end
		else
			info_queue[#info_queue + 1] = { key = "picubed_ranklesscards", set = "Other" }
		end
	end
end

SMODS.Joker { -- Molten Joker
	key = 'moltenjoker',
	pronouns = 'they_them',
	config = { extra = { repetitions = 1 } },
	rarity = 2,
	atlas = 'PiCubedsJokers',
	pos = { x = 3, y = 0 },
	cost = 5,
	discovered = true,
	blueprint_compat = true,
	in_pool = function(self, args)
		for kk, vv in pairs(G.playing_cards or {}) do
			if SMODS.has_enhancement(vv, 'm_gold') or SMODS.has_enhancement(vv, 'm_steel') 
			or picubed_is_stonelike(vv) then
				return true
			end
		end
		return false
	end,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_gold
		info_queue[#info_queue+1] = G.P_CENTERS.m_steel
		picubed_stonelike_infoqueue(info_queue)
		return {
			vars = { card.ability.max_highlighted}
		}
	end,
	
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.repetition and not context.repetition_only then
			if SMODS.has_enhancement(context.other_card, 'm_gold')
			or SMODS.has_enhancement(context.other_card, 'm_steel') 
			or picubed_is_stonelike(context.other_card) then
				return {
					message = localize('k_again_ex'),
					repetitions = card.ability.extra.repetitions,
					card = card
				}
			end
		end
		if context.cardarea == G.hand and context.repetition and not context.repetition_only then
			if SMODS.has_enhancement(context.other_card, 'm_gold')
			or SMODS.has_enhancement(context.other_card, 'm_steel') 
			or picubed_is_stonelike(context.other_card) then
				return {
					message = localize('k_again_ex'),
					repetitions = card.ability.extra.repetitions,
					card = card
				}
			end
		end
	end
}

SMODS.Joker { -- Eye Patch
	key = 'eyepatch',
	pronouns = 'he_him',
	rarity = 2,
	atlas = 'PiCubedsJokers',
	pos = { x = 2, y = 6 },
	cost = 7,
	discovered = true,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	config = { extra = { Xmult = 1, Xmult_mod = 1/3, hand_list = {}, displ_list = {} } },
	loc_vars = function(self, info_queue, card)
		if #card.ability.extra.displ_list > 0 then
            main_end = {
                {n=G.UIT.C, config={align = "bm", padding = 0.02}, nodes={
                    {n=G.UIT.C, config={align = "m", colour = G.C.CHIPS, r = 0.05, padding = 0.05}, nodes={
                        {n=G.UIT.T, config={text = table.concat(card.ability.extra.displ_list or {}, ", "), colour = G.C.UI.TEXT_LIGHT, scale = 0.3, shadow = true}},
                    }}
                }}
            }
		else
            main_end = nil
		end
		return { vars = { 
				card.ability.extra.Xmult, 
				card.ability.extra.Xmult_mod,
			}, main_end = main_end 
		}
	end,
	add_to_deck = function(self, card, from_debuff)
		for k, v in pairs(G.handlist) do
			card.ability.extra.hand_list[v] = false
		end
	end,
	calculate = function(self, card, context)
		card.ability.extra.displ_list = {}
		for k, v in pairs(G.handlist) do
			if card.ability.extra.hand_list[v] == true then
				table.insert(card.ability.extra.displ_list, tostring(localize(v, 'poker_hands')))
			end
		end
		
		if card.ability.extra.hand_list[context.scoring_name or nil] == false and #G.hand.highlighted > 0 and not G.RESET_JIGGLES then
			G.E_MANAGER:add_event(Event({
				trigger = 'after', blocking = false, blockable = false, timer = 'REAL',
				func = (function() card:juice_up(0.1, 0.1) return true end)
			}))
		end
		
		if context.before and context.main_eval and not context.blueprint and not context.retrigger_joker then
            if card.ability.extra.hand_list[context.scoring_name] == false then
                card.ability.extra.hand_list[context.scoring_name] = true
                card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
                return {
                    message = localize('k_upgrade_ex'),
                    card = card
                }
            end
		end
		if context.joker_main then
            return {
                xmult = card.ability.extra.Xmult
            }
		end
		if context.end_of_round and not context.blueprint and G.GAME.blind.boss and card.ability.extra.Xmult > 1 then
			card.ability.extra.displ_list = {}
			for k, v in pairs(G.handlist) do
				card.ability.extra.hand_list[v] = false
			end

			card.ability.extra.Xmult = 1
			return {
                card = card,
                message = localize('k_reset'),
                colour = G.C.RED
			}
		end
	end
}

SMODS.Joker { -- Ace Comedian
    key = 'acecomedian',
    pronouns = 'they_them',
    rarity = 2,
    config = { extra = { repetitions = 1 } },
    atlas = 'PiCubedsJokers',
    pos = { x = 7, y = 1 },
    cost = 7,
    discovered = true,
    blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = true,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.repetition and not context.repetition_only then
            if 
            context.other_card:get_id() == 8 or
            context.other_card:get_id() == 9 or
            context.other_card:get_id() == 10 or
            context.other_card:get_id() == 14 then
				return {
					message = localize('k_again_ex'),
                    repetitions = card.ability.extra.repetitions,
                    card = card
				}
			end
		end
    end
}

SMODS.Joker { -- Lowball Draw
	key = 'lowballdraw',
	pronouns = 'they_them',
	rarity = 1,
	atlas = 'PiCubedsJokers',
	pos = { x = 9, y = 7 },
	cost = 6,
	discovered = true,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	config = { extra = { money = 1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.money } }
	end,
	calculate = function(self, card, context)
		local low_count = 0
		if (context.first_hand_drawn or context.hand_drawn) and G.GAME.blind.in_blind then
			for k,v in ipairs(context.hand_drawn) do
				if v:get_id() == 2 or v:get_id() == 7 then
					low_count = low_count + 1
				end
			end
			if low_count > 0 then
				local low_low_count = low_count
				low_count = 0
				return {
                    dollars = card.ability.extra.money * low_low_count,
                    card = card
				}
			end
		end
	end
}

SMODS.Joker { -- Big Two
	key = 'bigtwo',
	pronouns = 'they_them',
	config = { extra = { Xmult = 2, odds = 2 } },
	rarity = 3,
	atlas = 'PiCubedsJokers',
	pos = { x = 1, y = 9 },
	soul_pos = { x = 1, y = 11 },
	cost = 8,
	discovered = true,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'vanillarb_bigtwo')
		return { vars = { card.ability.extra.Xmult, 
			numerator, denominator } 
		}
	end,
	calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 2 then
            if SMODS.pseudorandom_probability(card, 'vanillarb_bigtwo', 1, card.ability.extra.odds) then
                return {
                    xmult = card.ability.extra.Xmult
                }
            end
        end
	end
}

SMODS.Joker { -- Scarlet Forest
    key = 'scarletforest',
    pronouns = 'they_them',
    rarity = 1,
    atlas = 'PiCubedsJokers',
    pos = { x = 5, y = 13 },
    cost = 6,
    discovered = true,
    blueprint_compat = false,
    perishable_compat = true,
    eternal_compat = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_mult
	end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint and not context.joker_retrigger then
            local has_5th = false
            for i = 1, #context.scoring_hand do
                if i == 5 and not context.scoring_hand[i].debuff then
                    context.scoring_hand[i]:set_ability('m_mult', nil, true)
                    has_5th = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            context.scoring_hand[i]:juice_up()
                            return true
                        end
                    }))
                end
            end
            if has_5th then
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT,
                    message_card = card
                }
            end
        end
    end
}

SMODS.Joker { -- LEEROOOOOY!!
	key = 'leeroooooy',
	pronouns = 'he_him',
	rarity = 2,
	atlas = 'PiCubedsJokers',
	pos = { x = 5, y = 11 },
	cost = 5,
	discovered = true,
	blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
	pools = { ["Meme"] = true },
	config = { extra = { retriggers = 0 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.retriggers } }
	end,
	calculate = function(self, card, context)
        if context.skip_blind and not context.blueprint and not context.retrigger_joker then
			card.ability.extra.retriggers = card.ability.extra.retriggers + 1
            return {
                message = localize('k_upgrade_ex')
            }
		end
		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint and not context.retrigger_joker then
            if context.beat_boss and card.ability.extra.retriggers ~= 0 then
                card.ability.extra.retriggers = 0
                return {
                    message = localize('k_reset'),
                    colour = G.C.RED
                }
            end
        end
		if context.repetition and context.cardarea == G.play and card.ability.extra.retriggers >= 1 then
            return {
                repetitions = card.ability.extra.retriggers
            }
        end
	end
}

SMODS.Joker { -- Hierarchy
	key = 'hierarchy',
	pronouns = 'he_they',
	rarity = 3,
    config = { extra = { Xmult = 1.5, has_king = false } },
	atlas = 'PiCubedsJokers',
	pos = { x = 0, y = 10 },
	cost = 8,
	discovered = true,
	blueprint_compat = true,
    perishable_compat = true,
	eternal_compat = true,
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult } }
	end,
	calculate = function(self, card, context)
        if context.before then
			for k,v in ipairs(context.scoring_hand) do
				if v:get_id() == 13 then
					card.ability.extra.has_king = true
				end
			end
		end
		if card.ability.extra.has_king and context.individual and context.cardarea == G.play and not SMODS.has_no_rank(context.other_card) then
			local is_first = false
			for k,v in ipairs(context.scoring_hand) do
				if v:get_id() == context.other_card:get_id() then
					if v == context.other_card then
						is_first = true
					end
					break
				end
			end
			if is_first then
				return {
					xmult = card.ability.extra.Xmult
				}
			end
        end
		if context.after then
			card.ability.extra.has_king = false
		end
	end
}

--Code below from Vanilla Remade mod
function reset_vanillarb_hidenseek_rank()
	G.GAME.current_round.vanillarb_hidenseek_possible_ranks = {}
    G.GAME.current_round.vanillarb_hidenseek_searched_ranks = {}
    G.GAME.current_round.vanillarb_hidenseek_card = { rank = 'None', id = 'None' }
    local valid_hidenseek_cards = {}
    for _, playing_card in ipairs(G.playing_cards) do
        if not SMODS.has_no_rank(playing_card) then
            G.GAME.current_round.vanillarb_hidenseek_possible_ranks[playing_card.base.value] = true
            valid_hidenseek_cards[#valid_hidenseek_cards + 1] = playing_card
        end
    end
    local hidenseek_card = pseudorandom_element(valid_hidenseek_cards, pseudoseed('vanillarb_hidenseek' .. G.GAME.round_resets.ante))
    if hidenseek_card then
        G.GAME.current_round.vanillarb_hidenseek_card.rank = hidenseek_card.base.value
        G.GAME.current_round.vanillarb_hidenseek_card.id = hidenseek_card.base.id
    end
end

function vanillarb_get_unsearched_ranks()
    if not G.GAME.current_round.vanillarb_hidenseek_possible_ranks then return {} end
    local searched_ranks = G.GAME.current_round.vanillarb_hidenseek_searched_ranks
    local unsearched_ranks = {}
    for k,v in pairs(G.GAME.current_round.vanillarb_hidenseek_possible_ranks) do
        if not searched_ranks[k] then
            unsearched_ranks[k] = true
        end
    end

    local loc_unsearched_ranks = {}
    for k,v in pairs(SMODS.Rank.obj_buffer) do
        if unsearched_ranks[v] then
            table.insert(loc_unsearched_ranks, localize(v, 'ranks'))
        end
    end
    return loc_unsearched_ranks
end

SMODS.Joker { -- Hide 'n Seek
    key = 'hidenseek',
    pronouns = 'he_they',
    rarity = 1,
    config = { extra = { money = 8 } },
    atlas = 'PiCubedsJokers',
    pos = { x = 9, y = 13 },
    cost = 4,
    discovered = true,
    blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = true,
    loc_vars = function(self, info_queue, card)
		local unsearched_ranks = vanillarb_get_unsearched_ranks()
        if #unsearched_ranks > 0 and next(SMODS.find_card('j_vanillarb_hidenseek')) then
            main_end = {
                {n=G.UIT.C, config={align = "bm", padding = 0.02}, nodes={
                    {n=G.UIT.C, config={align = "m", colour = G.C.RED, r = 0.05, padding = 0.05}, nodes={
                        {n=G.UIT.T, config={text = table.concat(unsearched_ranks or {}, ", "), colour = G.C.UI.TEXT_LIGHT, scale = 0.25, shadow = false}},
                    }}
                }}
            }
		else
            main_end = nil
		end
        return { vars = { card.ability.extra.money }, main_end = main_end }
	end,
    add_to_deck = function(self, card, from_debuff)
		if not next(SMODS.find_card('j_vanillarb_hidenseek')) then
            reset_vanillarb_hidenseek_rank()
        end
	end,
    calculate = function(self, card, context)
        if (context.setting_blind or context.end_of_round) and not context.blueprint and not context.joker_retrigger then
            local secret_card_remaining = false
            for k,v in ipairs(G.playing_cards) do
                if not SMODS.has_no_rank(v) and v.base.value == G.GAME.current_round.vanillarb_hidenseek_card.rank then
                    secret_card_remaining = true
                    break
                end
            end
            if not secret_card_remaining then
                reset_vanillarb_hidenseek_rank()
                return {
                    message = localize('k_reset')
                }
            end
        end
        if context.before then
            local has_secret_rank = false
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:get_id() == G.GAME.current_round.vanillarb_hidenseek_card.id then
                    has_secret_rank = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            context.scoring_hand[i]:juice_up()
                            return true
                        end
                    }))
                elseif not SMODS.has_no_rank(context.scoring_hand[i]) then
                    G.GAME.current_round.vanillarb_hidenseek_searched_ranks[context.scoring_hand[i].base.value] = true
                end
            end
            
            if has_secret_rank then
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = (function()
                            SMODS.add_card({ set = 'Planet' })
                            G.GAME.consumeable_buffer = 0
                        return true
                    end)}))
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet})
                end
                reset_vanillarb_hidenseek_rank()
                return {
                    dollars = card.ability.extra.money,
                    card = card,
                    func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.dollar_buffer = 0
                            return true
                        end
                    }))
                    end
                }
            end
        end
    end
}

SMODS.Joker { -- On-beat
	key = 'onbeat',
	pronouns = 'he_him',
	rarity = 1,
	atlas = 'PiCubedsJokers',
	pos = { x = 0, y = 5 },
	cost = 4,
	discovered = true,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	config = { extra = { repetitions = 1 } },
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.repetition and not context.repetition_only then 
			local card_pos = 1
			for i = 1, #context.scoring_hand do
				if context.scoring_hand[i] == context.other_card then
					card_pos = i
				end
			end
			if card_pos == 3 or card_pos == 5 then
				return {
					message = localize('k_again_ex'),
					repetitions = card.ability.extra.repetitions,
					card = card
				}
			end
		end
	end
}

SMODS.Joker { -- Wee Mini
	key = 'weemini',
	pronouns = 'they_them',
	rarity = 1,
	atlas = 'PiCubedsJokers',
	pos = { x = 2, y = 8 },
	cost = 4,
	discovered = true,
	blueprint_compat = true,
	perishable_compat = false,
	eternal_compat = true,
    config = { extra = { mult = 0, mult_mod = 1 }},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult_mod, card.ability.extra.mult } }
	end,
	calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local ranks_list = {}
            for _, v in ipairs(context.scoring_hand) do
                if SMODS.has_no_rank(v) then
                    ranks_list['rankless'] = true
                else
                    ranks_list[v:get_id()] = true
                end
            end
            if #ranks_list >= 2 then 
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
                return {
                    message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult_mod } }
                }
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

SMODS.Joker { --Forgery
	key = 'forgery',
	pronouns = 'he_they',
	rarity = 3,
	atlas = 'PiCubedsJokers',
	pos = { x = 6, y = 5 },
	cost = 9,
	discovered = true,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.individual then
			local card_is_kil = context.other_card
			local card_mult = 0
			if SMODS.has_no_rank(card_is_kil) then -- rankless cards
				card_mult = card_mult + 0
			else
				card_mult = card_is_kil.base.nominal or 0
			end
			card_mult = card_mult + (card_is_kil.ability.perma_bonus or 0) + (card_is_kil.ability.perma_h_chips or 0)
			if SMODS.has_enhancement(card_is_kil, 'm_bonus') then -- bonus card (vanilla)
				card_mult = card_mult + 30
			elseif SMODS.has_enhancement(card_is_kil, 'm_stone') then -- stone card (vanilla)
				card_mult = card_mult + 50
			elseif SMODS.has_enhancement(card_is_kil, 'm_akyrs_ash_card') then -- ash card (aikoyori's shenanigans)
				card_mult = card_mult + 30
			end
			if card_is_kil.edition then
				if card_is_kil.edition.key == 'e_foil' then -- foil (vanilla)
						card_mult = card_mult + 50
				elseif card_is_kil.edition.key == 'e_cry_noisy' then -- noisy (cryptid)
						card_mult = card_mult + pseudorandom('noisy') * 150
				elseif card_is_kil.edition.key == 'e_ortalab_anaglyphic' then -- anaglyphic (ortalab)
						card_mult = card_mult + 20
				elseif card_is_kil.edition.key == 'e_cry_mosaic' then -- mosaic (cryptid)
						card_mult = 2.5 * card_mult
				elseif card_is_kil.edition.key == 'e_akyrs_texelated' then -- texelated (aikoyori's shenanigans)
						card_mult = 0.8 * card_mult
				elseif card_is_kil.edition.key == 'e_bunc_glitter' then -- glitter (bunco)
						card_mult = 1.3 * card_mult
				elseif card_is_kil.edition.key == 'e_yahimod_evil' then -- evil (yahimod)
						card_mult = 1.5 * card_mult
				end
			end
			if card_is_kil.ability.perma_x_chips and card_is_kil.ability.perma_x_chips > 1 then
				card_mult = card_mult * card_is_kil.ability.perma_x_chips
			end
			if card_is_kil.ability.perma_h_x_chips and card_is_kil.ability.perma_h_x_chips > 1 then
				card_mult = card_mult * card_is_kil.ability.perma_h_x_chips
			end
			if card_mult > 0 then
				return {
					mult = card_mult
				}	
			end	 
		end
	end
}