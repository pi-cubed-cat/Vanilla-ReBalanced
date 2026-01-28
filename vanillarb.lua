assert(SMODS.load_file("content/bisexual.lua"))()
assert(SMODS.load_file("content/vouchers.lua"))()
assert(SMODS.load_file("content/decks.lua"))()
assert(SMODS.load_file("content/stakes.lua"))()
assert(SMODS.load_file("content/starting_params.lua"))()
assert(SMODS.load_file("content/vanilla_jokers.lua"))()
if not next(SMODS.find_mod("picubedsjokers")) then
    assert(SMODS.load_file("content/picubed_jokers.lua"))()
end
assert(SMODS.load_file("content/blinds.lua"))()
assert(SMODS.load_file("content/enhancements.lua"))()
assert(SMODS.load_file("content/spectrals.lua"))()
assert(SMODS.load_file("content/stickers.lua"))()
assert(SMODS.load_file("content/boosterpacks.lua"))()
assert(SMODS.load_file("content/seals.lua"))()
assert(SMODS.load_file("content/tags.lua"))()

if next(SMODS.find_mod("Bunco")) then
    assert(SMODS.load_file("crossmod/bunco.lua"))()
end
if next(SMODS.find_mod("extracredit")) then
    assert(SMODS.load_file("crossmod/extracredit.lua"))()
end