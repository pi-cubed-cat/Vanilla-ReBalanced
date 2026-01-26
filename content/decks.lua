SMODS.Back:take_ownership('ghost', {
    config = { vouchers = { 'v_magic_trick', 'v_illusion' }, consumables = { 'c_hex' } },
    loc_vars = function(self, info_queue, back)
        return { vars = { 
            localize { type = 'name_text', key = self.config.vouchers[1], set = 'Voucher' }, 
            localize { type = 'name_text', key = self.config.vouchers[2], set = 'Voucher' }, 
            localize { type = 'name_text', key = self.config.consumables[1], set = 'Spectral' },
        } }
    end,
}, false)

SMODS.Back:take_ownership('green', {
    config = { extra_hand_bonus = 3, extra_discard_bonus = 2, no_interest = true },
}, false)

SMODS.Back:take_ownership('black', {
    config = { discards = -1, joker_slot = 1 },
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.joker_slot, self.config.discards } }
    end,
}, false)

SMODS.Back:take_ownership('anaglyph', {
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                add_tag(Tag('tag_double'))
                play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                return true
            end
        }))
    end,
}, false)