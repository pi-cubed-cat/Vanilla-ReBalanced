local banned_extracredit_jokers = {
    --"forklift",
    --"doublerainbow",
    "starfruit",
    "eclipse",
    "rubberducky",
    --"pocketaces",
    --"warlock",
    --"purplejoker",
    --"compost",
    --"candynecklace",
    --"yellowcard",
    "turtle",
    --"clowncollege",
    --"handbook",
    --"tengallon",
    --"montehaul",
    --"espresso",
    --"trafficlight",
    --"holdyourbreath",
    --"corgi",
    --"werewolf",
    "permanentmarker",
    --"pridefuljoker",
    --"tuxedo",
    --"farmer",
    --"ambrosia",
    "clowncar",
    --"shipoftheseus",
    "accretiondisk",
    "gofish",
    --"plushie",
    --"pyromancer",
    --"bobby",
    --"yinyang",
    --"blackjack",
    --"joty",
    --"averagealice",
    --"couponsheet",
    "hoarder",
    --"chainlightning",
    --"jokalisa",
    "badapple",
    --"passport",
    --"lucky7",
    --"alloy",
}

for i=1,#banned_extracredit_jokers do
    SMODS.Joker:take_ownership('ExtraCredit_'..banned_extracredit_jokers[i], {
        no_collection = true,
        in_pool = function() return false end
    }, true)
end

SMODS.Joker:take_ownership('ExtraCredit_handbook', {
    loc_txt = {
        ['name'] = 'Handbook',
        ['text'] = {
            [1] = "This Joker gains {C:mult}+#1#{} Mult if played",
            [2] = "{C:attention}poker hand{} has {C:attention}not{}",
            [3] = "already been played this round",
            [4] = "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
        }
    },
    config = { extra = { mult_mod = 1, mult = 0 } },
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult_mod, card.ability.extra.mult}}
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main and card.ability.extra.mult > 0 then
            return {
                --message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
                mult = card.ability.extra.mult
            }
        elseif context.cardarea == G.jokers and G.GAME.hands[context.scoring_name] and G.GAME.hands[context.scoring_name].played_this_round == 1 and not context.blueprint and context.before then 
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
            return{
                message = localize('k_upgrade_ex'),
                card = card,
                colour = G.C.MULT
            }             
        end
    end
}, true)

SMODS.Joker:take_ownership('ExtraCredit_montehaul', {
    loc_txt = {
        ['name'] = 'Monte Haul',
        ['text'] = {
            [1] = "After {C:attention}1{} round, sell this card",
            [2] = "to gain {C:attention}2{} random {C:attention}Joker Tags",
            [3] = "{C:inactive}(Currently {C:attention}#1#{C:inactive}/1)",
            [4] = "{s:0.7,C:inactive}Tags activate after exiting Shop",

        }
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'tag_foil', set = 'Tag'}
        info_queue[#info_queue+1] = {key = 'tag_holo', set = 'Tag'}
        info_queue[#info_queue+1] = {key = 'tag_polychrome', set = 'Tag'}
        info_queue[#info_queue+1] = {key = 'tag_negative', set = 'Tag'}
        info_queue[#info_queue+1] = {key = 'tag_vanillarb_bisexual', set = 'Tag'}
        info_queue[#info_queue+1] = {key = 'tag_uncommon', set = 'Tag'}
        info_queue[#info_queue+1] = {key = 'tag_rare', set = 'Tag'}
        return {vars = {card.ability.extra.monty_rounds}}
    end,
}, true)