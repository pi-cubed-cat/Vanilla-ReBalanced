SMODS.Stake:take_ownership('stake_blue', { 
    modifiers = function()
        G.GAME.modifiers.scaling = (G.GAME.modifiers.scaling or 1) + 1
    end,
}, false)

SMODS.Stake:take_ownership('stake_purple', { 
    modifiers = function()
        G.GAME.modifiers.enable_perishables_in_shop = true
    end,
}, false)

SMODS.Stake:take_ownership('stake_orange', { 
    modifiers = function()
        G.GAME.modifiers.enable_rentals_in_shop = true
    end,
}, false)

SMODS.Stake:take_ownership('stake_gold', { 
    modifiers = function()
        G.GAME.win_ante = (G.GAME.win_ante or 8) + 2 
    end,
}, false)