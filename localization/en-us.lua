return {
    descriptions = {
        Back = {
            b_ghost = {
                text = {
                    "Start run with the",
                    "{C:attention,T:v_magic_trick}#1#{} and",
                    "{C:spectral,T:v_illusion}#2#{} vouchers,",
                    "and a {C:spectral,T:c_hex}#3#{} card",
                },
            },
            b_black = {
                text = {
                    "{C:attention}+#1#{} Joker slot",
                    "",
                    "{C:red}#2#{} discard",
                    "every round",
                },
            },
            b_anaglyph = {
                text = {
                    "Gain a {C:attention,T:tag_double}#1#",
                    "at start of run and after",
                    "defeating each {C:attention}Boss Blind{}",
                },
            },
        },
        Joker = {
            j_square = { -- Square Joker
                text = {
                    "This Joker gains {C:chips}+#2#{} Chips",
                    "if played hand has",
                    "exactly {C:attention}4{} cards",
                    "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)",
                },
            },
            j_matador = {
                text = {
                    "On {C:attention}final hand{} of", 
                    "{C:attention}Boss Blind{}, played",
                    "cards earn {C:money}$#1#{}",
                    "when scored",
                },
            },
            j_vanillarb_moltenjoker = {
                name = 'Molten Joker',
                text = {
                    "Retrigger {C:attention}Gold{}, {C:attention}Steel{},", 
                    "and {C:attention}Stone{} cards"
                }
            },
            j_vanillarb_eyepatch = {
                name = 'Eye Patch',
                text = {
                   "This Joker gains {X:mult,C:white}X#2#{} Mult",
                   "if {C:attention}poker hand{} has {C:attention}not{}",
                   "been played this {C:attention}Ante{}, resets",
                   "when {C:attention}Boss Blind{} is defeated",
                   "{C:inactive}(Currently {X:mult,C:white}X#1#{} {C:inactive}Mult){}",
                }
            },
            j_vanillarb_acecomedian = {
                name = 'Ace Comedian',
                text = {
                   "Retrigger each played",
                   "{C:attention}Ace{}, {C:attention}10{}, {C:attention}9{}, and {C:attention}8{}"
                }
            },
            j_vanillarb_lowballdraw = {
                name = 'Lowball Draw',
                text = {
                   "Earn {C:money}$#1#{} when a",
                   "{C:attention}2{} or {C:attention}7{} is drawn",
                   "to hand during Blind",
                }
            },
            j_vanillarb_bigtwo = {
                name = 'Big Two',
                text = {
                   "Each played {C:attention}2{} has a ", 
                   "{C:green}#2# in #3#{} chance to give",
                   "{X:mult,C:white}X#1#{} Mult when scored",
                },
            },
            j_vanillarb_scarletforest = {
				name = 'Scarlet Forest',
                text = {
                    "{C:attention}5th{} scoring card each hand",
                    "becomes a {C:attention}Mult Card{}",
                },
			},
            j_vanillarb_leeroooooy = {
				name = 'LEEROOOOOY!!',
                text = {
                    "{C:attention}Retrigger{} all played cards", 
                    "per {C:attention}Blind skipped{} this {C:attention}Ante",
                    "{C:inactive}(Currently {C:attention}#1#{} {C:inactive}retriggers)"
                }
            },
            j_vanillarb_hierarchy = {
                name = 'Hierarchy',
                text = {
                    "If scoring hand contains a {C:attention}King{},", 
                    "the {C:attention}first{} scoring card of",
                    "each {C:attention}rank{} gives {X:mult,C:white}X#1#{} Mult",
                }
            },
            j_vanillarb_hidenseek = {
				name = "Hide 'n Seek",
                text = {
                    "One {C:attention}secret rank{} will give",
                    "{C:money}$#1#{} and create a {C:planet}Planet{} card",
                    "when played and scoring,",
                    "rank changes after it is {C:attention}found{}",
                    "{C:inactive}(Must have room)",
                },
			},
            j_vanillarb_onbeat = {
                name = "On-beat",
                text = {
                    "Retrigger the {C:attention}third{}",
                    "and {C:attention}fifth{} scoring cards",
                }
            },
            j_vanillarb_weemini = {
                name = "Wee Mini",
                text = {
                    "This Joker gains {C:mult}+#1#{} Mult if", 
                    "scoring hand contains at least",
                    "{C:attention}two{} cards of {C:attention}different ranks{}",
                    "{C:inactive}(Currently {C:mult}+#2#{} {C:inactive}Mult){}",
                }
            },
        },
        Voucher = {
            v_hone = { -- Hone
                text = {
                    "{C:dark_edition}Foil{}, {C:dark_edition}Holographic{},",
                    "{C:dark_edition}Polychrome{}, and",
                    "{C:dark_edition}Bisexual{} cards",
                    "appear {C:attention}#1#X{} more often",
                },
            },
            v_glow_up = {
                text = { -- Glow Up
                    "{C:dark_edition}Foil{}, {C:dark_edition}Holographic{},",
                    "{C:dark_edition}Polychrome{}, and",
                    "{C:dark_edition}Bisexual{} cards",
                    "appear {C:attention}#1#X{} more often",
                },
            },
            v_magic_trick = { -- Magic Trick
                text = {
                    "{C:attention}Playing cards{} can",
                    "be purchased",
                    "from the {C:attention}shop",
                },
            },
            v_illusion = { -- Illusion
                text = {
                    "{C:spectral}Spectral cards{} can",
                    "be purchased",
                    "from the {C:attention}shop",
                },
            },
            v_tarot_tycoon = { -- Tarot Tycoon
                text = {
                    "Every shop has",
                    "an additional {C:attention}free{}",
                    "{C:tarot}Mega Arcana Pack{}",
                },
            },
            v_planet_tycoon = { -- Planet Tycoon
                text = {
                    "{C:dark_edition}Negative{} {C:planet}Planet cards{}",
                    "can be purchased",
                    "from the {C:attention}shop",
                },
            },
            v_telescope = { -- Telescope
                text = {
                    "Your most played {C:attention}poker{}",
                    "{C:attention}hand{}'s corresponding",
                    "{C:planet}Planet{} card may",
                    "appear multiple times",
                }
            },
        },
        Stake = {
            stake_blue = {
                name = "Blue Stake",
                text = {
                    "Required score scales",
                    "faster for each {C:attention}Ante",
                    "{s:0.8}Applies all previous Stakes",
                },
            },
            stake_gold = {
                name = "Gold Stake",
                text = {
                    "Win after {C:attention}Ante 10{},",
                    "face {C:attention}Showdown Boss Blinds{}",
                    "in Ante 8 and Ante 10",
                    "{s:0.8}Applies all previous Stakes",
                },
            },
            stake_orange = {
                name = "Orange Stake",
                text = {
                    "Shop can have {C:attention}Rental{} Jokers",
                    "{C:inactive,s:0.8}(Costs {C:money,s:0.8}$3{C:inactive,s:0.8} per round)",
                    "{s:0.8}Applies all previous Stakes",
                },
            },
            stake_purple = {
                name = "Purple Stake",
                text = {
                    "Shop can have {C:attention}Perishable{} Jokers",
                    "{C:inactive,s:0.8}(Debuffed after 5 Rounds)",
                    "{s:0.8}Applies all previous Stakes",
                },
            },
        },
        Tag = {
            tag_bisexual = {
                name = "Bisexual Tag",
                text = {
                    "Creates a random",
                    "{C:dark_edition}Bisexual{} Joker",
                    "{C:inactive}(Must have room){}"
                }
            },
            tag_foil = { -- Foil Tag
                text = {
                    "Creates a random",
                    "{C:dark_edition}Foil{} Joker",
                    "{C:inactive}(Must have room){}"
                }
            },
            tag_holo = { -- Holographic Tag
                text = {
                    "Creates a random",
                    "{C:dark_edition}Holographic{} Joker",
                    "{C:inactive}(Must have room){}"
                },
            },
            tag_juggle = { -- Juggle Tag
                text = {
                    "{C:attention}+#1#{} hand size",
                    "next round",
                },
            },
            tag_negative = { -- Negative Tag
                text = {
                    "Creates a random",
                    "{C:dark_edition}Negative{} Joker",
                    "{C:inactive}(Must have room){}"
                },
            },
            tag_polychrome = { -- Polychrome Tag
                text = {
                    "Creates a random",
                    "{C:dark_edition}Polychrome{} Joker",
                    "{C:inactive}(Must have room){}"
                },
            },
            tag_rare = { -- Rare Tag
                text = {
                    "Creates a random",
                    "{C:red}Rare{} Joker",
                    "{C:inactive}(Must have room){}"
                },
            },
            tag_uncommon = { -- Uncommon Tag
                text = {
                    "Creates a random",
                    "{C:green}Uncommon{} Joker",
                    "{C:inactive}(Must have room){}"
                },
            },
            tag_voucher = { -- Voucher Tag
                text = {
                    "Adds a free {C:voucher}Voucher",
                    "to the next shop",
                },
            },
        },
    }
}