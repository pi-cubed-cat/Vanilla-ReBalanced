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
                    "face a {C:attention}Finisher Boss Blind{}",
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