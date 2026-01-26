SMODS.Consumable:take_ownership('black_hole', { -- Black Hole
    --hidden = false,
}, false)

--[[local use_consumeable_ref = Card.use_consumeable
function Card:use_consumeable(area, copier)
    if self.ability.name == 'Sigil' then
        return
    else
        use_consumeable_ref(self, area, copier)
    end
end]]

SMODS.Consumable:take_ownership('sigil', { -- Sigil
    config = { extra = { draw_cards = 3 }},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.draw_cards } }
    end,
    use = function(self, card, area, copier)
        local used_tarot = copier or card
        SMODS.draw_cards(card.ability.extra.draw_cards)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            func = function()
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        play_sound('tarot1')
                        used_tarot:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                for i = 1, #G.hand.cards do
                    local percent = 1.15 - (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.15,
                        func = function()
                            G.hand.cards[i]:flip()
                            play_sound('card1', percent)
                            G.hand.cards[i]:juice_up(0.3, 0.3)
                            return true
                        end
                    }))
                end
                local _suit = pseudorandom_element(SMODS.Suits, 'sigil')
                for i = 1, #G.hand.cards do
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local _card = G.hand.cards[i]
                            assert(SMODS.change_base(_card, _suit.key))
                            return true
                        end
                    }))
                end
                for i = 1, #G.hand.cards do
                    local percent = 0.85 + (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.15,
                        func = function()
                            G.hand.cards[i]:flip()
                            play_sound('tarot2', percent, 0.6)
                            G.hand.cards[i]:juice_up(0.3, 0.3)
                            return true
                        end
                    }))
                end
                return true
            end
        }))
        delay(0.5)
    end,
}, false)