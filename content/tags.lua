SMODS.Tag:take_ownership("uncommon", { -- Uncommon Tag
    config = { spawn_jokers = 1 },
    apply = function(self, tag, context)
        if context.type == 'immediate' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.GREEN, function()
                for _ = 1, tag.config.spawn_jokers do
                    if G.jokers and #G.jokers.cards < G.jokers.config.card_limit then
                        SMODS.add_card {
                            set = "Joker",
                            rarity = "Uncommon",
                            key_append = "uta"
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
}, false)


SMODS.Tag:take_ownership("rare", { -- Rare Tag
    config = { spawn_jokers = 1 },
    apply = function(self, tag, context)
        if context.type == 'immediate' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.RED, function()
                for _ = 1, tag.config.spawn_jokers do
                    if G.jokers and #G.jokers.cards < G.jokers.config.card_limit then
                        SMODS.add_card {
                            set = "Joker",
                            rarity = "Rare",
                            key_append = "rta"
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
}, false)

SMODS.Tag:take_ownership("negative", { -- Negative Tag
    config = { spawn_jokers = 1 },
    apply = function(self, tag, context)
        if context.type == 'immediate' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.DARK_EDITION, function()
                for _ = 1, tag.config.spawn_jokers do
                    if G.jokers and #G.jokers.cards < G.jokers.config.card_limit then
                        SMODS.add_card {
                            set = "Joker",
                            edition = 'e_negative',
                            key_append = "nta",
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
}, false)

SMODS.Tag:take_ownership("foil", { -- Foil Tag
    config = { spawn_jokers = 1 },
    apply = function(self, tag, context)
        if context.type == 'immediate' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.DARK_EDITION, function()
                for _ = 1, tag.config.spawn_jokers do
                    if G.jokers and #G.jokers.cards < G.jokers.config.card_limit then
                        SMODS.add_card {
                            set = "Joker",
                            edition = 'e_foil',
                            key_append = "fta",
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
}, false)


SMODS.Tag:take_ownership('holo', { -- Holographic Tag
    config = { spawn_jokers = 1 },
    apply = function(self, tag, context)
        if context.type == 'immediate' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.DARK_EDITION, function()
                for _ = 1, tag.config.spawn_jokers do
                    if G.jokers and #G.jokers.cards < G.jokers.config.card_limit then
                        SMODS.add_card {
                            set = "Joker",
                            edition = 'e_holo',
                            key_append = "hta",
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
}, false)

SMODS.Tag:take_ownership('polychrome', { -- Polychrome Tag
    config = { spawn_jokers = 1 },
    apply = function(self, tag, context)
        if context.type == 'immediate' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.DARK_EDITION, function()
                for _ = 1, tag.config.spawn_jokers do
                    if G.jokers and #G.jokers.cards < G.jokers.config.card_limit then
                        SMODS.add_card {
                            set = "Joker",
                            edition = 'e_polychrome',
                            key_append = "pta",
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
}, false)

SMODS.Tag:take_ownership('juggle', { -- Juggle Tag

}, false)

SMODS.Tag:take_ownership('orbital', { -- Orbital Tag
    config = { levels = 4 },
}, false)

local set_cost_ref = Card.set_cost
function Card:set_cost()
    set_cost_ref(self)
    if self.from_tag and self.ability.couponed then
        self.cost = 0
    end
end


SMODS.Tag:take_ownership('voucher', { -- Voucher Tag
    apply = function(self, tag, context)
        if context.type == 'voucher_add' then
            tag:yep('+', G.C.SECONDARY_SET.Voucher, function()
                local voucher = SMODS.add_voucher_to_shop()
                voucher.from_tag = true
                voucher.ability.couponed = true
                voucher:set_cost()
                return true
            end)
            tag.triggered = true
        end
    end
}, false)