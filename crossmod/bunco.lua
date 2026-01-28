SMODS.PokerHand:take_ownership('bunc_Spectrum', { -- Spectrum
    visible = false,
    no_collection = true,
    evaluate = function(parts)
        return false
    end
}, true)

SMODS.PokerHand:take_ownership('bunc_Straight Spectrum', { -- Straight Spectrum
    visible = false,
    no_collection = true,
    evaluate = function(parts)
        return false
    end
}, true)

SMODS.PokerHand:take_ownership('bunc_Spectrum House', { -- Spectrum House
    visible = false,
    no_collection = true,
    evaluate = function(parts)
        return false
    end
}, true)

SMODS.PokerHand:take_ownership('bunc_Spectrum Five', { -- Spectrum Five
    visible = false,
    no_collection = true,
    evaluate = function(parts)
        return false
    end
}, true)

SMODS.PokerHand:take_ownership('bunc_Deal', { -- Deal
    visible = false,
    no_collection = true,
    evaluate = function(parts)
        return false
    end
}, true)

local banned_bunco_jokers= {
    'cassette',
    --'mosaic',
    'voxel',
    'crop_circles',
    'xray',
    'dread',
    'prehistoric',
    'linocut',
    'ghost_print',
    'loan_shark',
    --'basement',
    'shepherd',
    'knight',
    'jmjb',
    --'dogs_playing_poker',
    --'righthook',
    'fiendish',
    'carnival',
    'sledgehammer',
    --'doorhanger',
    'fingerprints',
    --'zero_shapiro',
    'nil_bill',
    'bierdeckel',
    'registration_plate',
    'slothful',
    'neon',
    'gameplan',
    'conquest',
    'hierarchy_of_needs',
    'dwarven',
    --'aristocrat',
    'metallurgist',
    'juggalo',
    'head_in_the_clouds',
    'headshot',
    'trigger_finger',
    'hopscotch',
    'pawn',
    'puzzle_board',
    'vandalism',
    'protester',
    'doodle',
    'disproportionality',
    'running_joke',
    --'on_broadway',
    'rasta',
    'critic',
    'cellphone',
    --'wino',
    'bounty_hunter',
    'mousetrap',
    --'the_joker',
    --'tangram',
    'domino',
    'glue_gun',
    'taped',
    'rubber_band_ball',
    'headache',
    'games_collector',
    --'jumper',
    'stylophone',
    'kite_experiment',
    'robot',
    'hardtack',
    'pica',
    'zealous',
    'lurid',
    'envious',
    'proud',
    'wishalloy',
    'unobtanium',
    'dynasty',
    'magic_wand',
    'starfruit',
    'fondue',
    'myopia',
    'astigmatism',
    'roygbiv',
    'rigoletto',
}

for i=1,#banned_bunco_jokers do
    SMODS.Joker:take_ownership('bunc_'..banned_bunco_jokers[i], {
        no_collection = true,
        in_pool = function() return false end
    }, true)
end

local banned_bunco_consumables= {
    'adjustment',
    'art',
    'universe',
    'lust',
    'sky',
    'abyss',
    'quaoar',
    'haumea',
    'sedna',
    'makemake',
    'cleanse',
    'the_8',
    'the_i',
    'the_o',
    'the_t',
    'the_s',
    'the_z',
    'the_j',
    'the_l',
    'the_slash',
}

for i=1,#banned_bunco_consumables do
    SMODS.Consumable:take_ownership('bunc_'..banned_bunco_consumables[i], {
        no_collection = true,
        in_pool = function() return false end
    }, true)
end

--[[SMODS.ConsumableType:take_ownership('Polymino', {
    no_collection = true,
}, true)]]

local banned_bunco_blinds= {
    --'paling',
    --'umbrella',
    --'tine',
    --'swing',
    --'miser',
    'gate',
    --'flame',
    --'mask',
    --'bulwark',
    --'knoll',
    --'stone',
    'sand',
    --'blade',
    --'claw',
    'veil',
    --'cadaver',
    --'wind',
    --'prince',
    'depths',
    'chasm',
    'final_crown',
    --'final_trident',
    --'final_tower',
    --'final_dagger',
    --'final_shield',
}

for i=1,#banned_bunco_blinds do
    SMODS.Blind:take_ownership('bunc_'..banned_bunco_blinds[i], {
        no_collection = true,
        in_pool = function() return false end
    }, true)
end