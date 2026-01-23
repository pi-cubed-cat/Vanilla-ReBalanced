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