SMODS.Joker:take_ownership('joker', { -- Joker (Jimbo)
	cost = 1,
}, false)

SMODS.Joker:take_ownership("greedy_joker", { -- Greedy Joker
    config = { extra = { s_mult = 4, suit = 'Diamonds' }, },
}, false)

SMODS.Joker:take_ownership("lusty_joker", { -- Lusty Joker
    config = { extra = { s_mult = 4, suit = 'Hearts' }, },
}, false)

SMODS.Joker:take_ownership("wrathful_joker", { -- Wrathful Joker
    config = { extra = { s_mult = 4, suit = 'Spades' }, },
}, false)

SMODS.Joker:take_ownership("gluttenous_joker", { -- Gluttonous Joker
    config = { extra = { s_mult = 4, suit = 'Clubs' }, },
}, false)


SMODS.Joker:take_ownership("zany", { -- Zany Joker
    config = { t_mult = 16, type = 'Three of a Kind' },
}, false)


SMODS.Joker:take_ownership("mad", { -- Mad Joker
    config = { t_mult = 12, type = 'Two Pair' },
}, false)

SMODS.Joker:take_ownership("crazy", { -- Crazy Joker
    config = { t_mult = 16, type = 'Straight' },
}, false)

SMODS.Joker:take_ownership("droll", { -- Droll Joker
    config = { t_mult = 12, type = 'Flush' },
}, false)

SMODS.Joker:take_ownership("wily", { -- Wily Joker
    config = { t_chips = 120, type = 'Three of a Kind' },
}, false)

SMODS.Joker:take_ownership("devious", { -- Devious Joker
    config = { t_chips = 120, type = 'Straight' },
}, false)

SMODS.Joker:take_ownership("crafty", { -- Crafty Joker
    config = { t_chips = 100, type = 'Flush' },
}, false)

SMODS.Joker:take_ownership('matador', { -- Matador
    cost = 6,
    config = { extra = { money = 3 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.money } }
	end,
	calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and G.GAME.current_round.hands_left == 0 and G.GAME.blind and G.GAME.blind.boss then
			G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.money
            G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
            return {
                dollars = card.ability.extra.money,
            }
		end
	end
}, false)

SMODS.Joker:take_ownership('hanging_chad', { -- Hanging Chad
    rarity = 2,
}, false)

SMODS.Joker:take_ownership('ceremonial', { -- Ceremonial Dagger
    rarity = 1,
	cost = 4,
}, false)

SMODS.Joker:take_ownership('fortune_teller', { -- Fortune Teller
	cost = 4,
}, false)

SMODS.Joker:take_ownership('ride_the_bus', { -- Ride the Bus
	cost = 4,
}, false)

SMODS.Joker:take_ownership('supernova', { -- Supernova
	cost = 4,
}, false)

SMODS.Joker:take_ownership('square', { -- Square Joker
	config = { extra = { chips = 16, chip_mod = 4 } },
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.chip_mod } }
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint and #context.full_hand == 4 then
            -- See note about SMODS Scaling Manipulation on the wiki
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS
            }
        end
        if context.joker_main and card.ability.extra.chips > 0 then
            return {
                chips = card.ability.extra.chips
            }
        end
    end,
}, false)

SMODS.Joker:take_ownership('superposition', { -- Superposition
	cost = 5,
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'c_fool', set = 'Tarot'}
		return {vars = {}}
    end,
	calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands["Straight"]) and
            #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            local ace_check = false
            for i = 1, #context.full_hand do
                if context.full_hand[i]:get_id() == 14 then
                    ace_check = true
                    break
                end
            end
            if ace_check then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        SMODS.add_card {
                            set = 'Tarot',
							key = 'c_fool',
                            key_append = 'superposition'
                        }
                        G.GAME.consumeable_buffer = 0
                        return true
                    end)
                }))
                return {
                    message = localize('k_plus_tarot'),
                    colour = G.C.SECONDARY_SET.Tarot,
                }
            end
        end
    end
}, false)

SMODS.Joker:take_ownership('baron', { -- Baron
    rarity = 2,
}, false)

SMODS.Joker:take_ownership('mime', { -- Mime
	rarity = 3,
}, false)

SMODS.Joker:take_ownership('mail', { -- Mail-In Rebate
	config = { extra = 3 },
}, false)

SMODS.Joker:take_ownership('scholar', { -- Scholar
	config = {extra = { mult = 5, chips = 20 } },
}, false)

local deck_offset = 2
SMODS.Joker:take_ownership("erosion", { -- Erosion
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra, math.max(0, card.ability.extra * (G.playing_cards and (G.GAME.starting_deck_size + deck_offset - #G.playing_cards) or deck_offset)), G.GAME.starting_deck_size + deck_offset } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = math.max(0, card.ability.extra * (G.GAME.starting_deck_size + deck_offset- #G.playing_cards))
            }
        end
    end
}, false)

SMODS.Joker:take_ownership("flower_pot", { -- Flower Pot
    config = { extra = { chips = 60 } },
	cost = 7,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local suit_list = {}
            for k, v in pairs(SMODS.Suits) do
                suit_list[k] = 0
            end
            for k, v in ipairs(context.scoring_hand) do --checking for all non-wild cards
                if not SMODS.has_any_suit(v) then
                    for kk, vv in pairs(suit_list) do
                        if v:is_suit(kk, true) and suit_list[kk] ~= 1 then 
                            suit_list[kk] = 1
                            break
                        end 
                    end
                end
            end
            for k, v in ipairs(context.scoring_hand) do --checking for all wild cards
                if SMODS.has_any_suit(v) then
                    for kk, vv in pairs(suit_list) do
                        if v:is_suit(kk, true) and suit_list[kk] ~= 1 then 
                            suit_list[kk] = 1
                            break
                        end 
                    end
                end
            end
            local suit_count = 0
            for kk, vv in pairs(suit_list) do
                if suit_list[kk] == 1 then 
                    suit_count = suit_count + 1
                end 
            end 
            if suit_count > 0 then
				return {
					chips = card.ability.extra.chips * suit_count,
				}
			end
        end
    end
}, false)

local debuff_hand_ref = Blind.debuff_hand
function Blind:debuff_hand(cards, hand, handname, check)
	if #SMODS.find_card('j_splash') > 0 then
		return nil
	else
		return debuff_hand_ref(self, cards, hand, handname, check)
	end
end

SMODS.Joker:take_ownership('splash', { -- Splash
	calculate = function(self, card, context)
        if context.press_play and not context.blueprint then
			 G.E_MANAGER:add_event(Event({
				func = function()
					for _, v in ipairs(G.play.cards) do
						v.debuff = false
					end
					return true
				end
			}))
		end
		if context.modify_scoring_hand and not context.blueprint then
            return {
                add_to_hand = true
            }
        end
    end
}, false)

SMODS.Joker:take_ownership('bootstraps', { -- Bootstraps
	config = {extra = {mult = 1, dollars = 5}},
	calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            (context.other_card:is_suit('Hearts') or context.other_card:is_suit('Diamonds')) then
            if (math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / card.ability.extra.dollars)) > 0 then
				return {
					mult = card.ability.extra.mult * math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / card.ability.extra.dollars)
				}
			end
        end
    end
}, false)

SMODS.Joker:take_ownership('loyalty_card', { -- Loyalty Card
	cost = 6,	
	config = { extra = { every = 10, loyalty_remaining = 10 } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.every,
				card.ability.extra.loyalty_remaining,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local upgrade_targets = nil
			for i=1,#context.scoring_hand do
				card.ability.extra.loyalty_remaining = card.ability.extra.loyalty_remaining - 1
                if card.ability.extra.loyalty_remaining <= 0 then
                    card.ability.extra.loyalty_remaining = card.ability.extra.every
					upgrade_targets = upgrade_targets or {}
					upgrade_targets[#upgrade_targets+1] = i
                end
            end
			if upgrade_targets then
				local _type = nil
				for i=1,#upgrade_targets do
					local _mod_list = {}
					if context.scoring_hand[upgrade_targets[i]].config.center.set == 'Default' then
						table.insert(_mod_list, 'enhance')
					end
					if not context.scoring_hand[upgrade_targets[i]].edition then
						table.insert(_mod_list, 'edition')
					end
					if not context.scoring_hand[upgrade_targets[i]].seal then 
						table.insert(_mod_list, 'seal')
					end
					_type = pseudorandom_element(_mod_list)
					if _type == 'edition' then
						local _edition = SMODS.poll_edition({ guaranteed = true, no_negative = true })
						context.scoring_hand[upgrade_targets[i]]:set_edition(_edition, false, true)
						G.E_MANAGER:add_event(Event({
							func = function()
								context.scoring_hand[upgrade_targets[i]]:juice_up()
								return true
							end
						}))
					elseif _type == 'seal' then
						local _seal = SMODS.poll_seal({ guaranteed = true })
						context.scoring_hand[upgrade_targets[i]]:juice_up()
						G.E_MANAGER:add_event(Event({
							func = function()
								context.scoring_hand[upgrade_targets[i]]:set_seal(_seal, nil, true)
								return true
							end
						}))
					elseif _type == 'enhance' then
						local _enhance = SMODS.poll_enhancement({ guaranteed = true})
						context.scoring_hand[upgrade_targets[i]]:set_ability(_enhance, nil, true)
						G.E_MANAGER:add_event(Event({
							func = function()
								context.scoring_hand[upgrade_targets[i]]:juice_up()
								return true
							end
						}))
					end
					
				end
                if _type then
					return {
						message = localize('k_upgrade_ex'),
						message_card = card
					}
				end
            end
        end
    end
}, false)

SMODS.Joker:take_ownership('raised_fist', { -- Raised Fist
	calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            local temp_Mult, temp_ID = 15, 15
            local raised_card = nil
            for i = 1, #G.hand.cards do
                if temp_ID > G.hand.cards[i].base.id and not SMODS.has_no_rank(G.hand.cards[i]) then -- the inequality got changed.
                    temp_Mult = G.hand.cards[i].base.nominal
                    temp_ID = G.hand.cards[i].base.id
                    raised_card = G.hand.cards[i]
                end
            end
            if raised_card == context.other_card then
                if context.other_card.debuff then
                    return {
                        message = localize('k_debuffed'),
                        colour = G.C.RED
                    }
                else
                    return {
                        mult = 2 * temp_Mult
                    }
                end
            end
        end
    end
}, false)

SMODS.Atlas {
    key = "newjoker",
    path = "newjoker.png",
    px = 71,
    py = 95
}

SMODS.Joker:take_ownership('8_ball', { -- 8 Ball
    atlas = 'newjoker',
    pos = { x = 1, y = 0 },
}, false)

SMODS.Joker { -- Chaos Theory
    key = 'chaostheory',
	rarity = 2,
	atlas = 'newjoker',
	pos = { x = 0, y = 0 },
	cost = 6,
	discovered = true,
	blueprint_compat = true,
	perishable_compat = false,
	eternal_compat = true,
	config = { extra = { xmult = 1, xmult_mod = 0.1, poker_hand = 'High Card' } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult_mod, card.ability.extra.xmult, localize(card.ability.extra.poker_hand, 'poker_hands') } }
	end,
	calculate = function(self, card, context)
        if context.before and context.scoring_name == card.ability.extra.poker_hand and not context.blueprint then
            card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT
            }
        end
        if context.after and context.main_eval and not context.blueprint then
            local _poker_hands = {}
            for handname, _ in pairs(G.GAME.hands) do
                if SMODS.is_poker_hand_visible(handname) and handname ~= card.ability.extra.poker_hand then
                    _poker_hands[#_poker_hands + 1] = handname
                end
            end
            card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, 'chaostheory')
        end
        if context.joker_main then
            return {
                Xmult = card.ability.extra.xmult
            }
        end
    end,
    set_ability = function(self, card, initial, delay_sprites)
        local _poker_hands = {}
        for handname, _ in pairs(G.GAME.hands) do
            if SMODS.is_poker_hand_visible(handname) and handname ~= card.ability.extra.poker_hand then
                _poker_hands[#_poker_hands + 1] = handname
            end
        end
        card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, 'chaostheory')
    end
}