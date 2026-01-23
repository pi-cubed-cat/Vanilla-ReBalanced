local apply_to_run_ref = Back.apply_to_run
function Back:apply_to_run()
    G.GAME.modifiers.money_per_hand = 2
    apply_to_run_ref(self)
end

local get_starting_params_ref = get_starting_params
function get_starting_params()
    local params = get_starting_params_ref()
    params.hands = 3
    params.discards = 4
    return params
end