local variant = Tracker.ActiveVariantUID
IS_ITEMS_ONLY = variant:find("itemsonly")
IS_COMPACT = variant:find("itemsonly_compact")
IS_DETAILED = variant:find("detailed")
CALLBEADMIZER_MODE = 0
ENABLE_DEBUG_LOG = false

if PopVersion and ENABLE_DEBUG_LOG then
    print(string.format("PopVersion: %s", PopVersion))
end

CALL_BEAD_CHARS = {
    [0] = {
        image = "images/items/call_beads/unknown.png",
        codes = "unknown",
        disabled = false
    },
    [1] = {
        image = "images/items/call_beads/elizabeth.png",
        codes = "elizabeth",
        disabled = false
    },
    [2] = {
        image = "images/items/call_beads/horace.png",
        codes = "horace",
        disabled = false
    },
    [3] = {
        image = "images/items/call_beads/camellia.png",
        codes = "camellia",
        disabled = false
    },
    [4] = {
        image = "images/items/call_beads/sidney.png",
        codes = "sidney",
        disabled = false
    },
}
CALL_BEAD_SPELLS = {
    [0] = {
        image = "images/items/call_beads/unknown.png",
        codes = "unknown",
        disabled = false
    },
    [1] = {
        image = "images/items/call_beads/flare.gif",
        codes = "flare",
        disabled = false
    },
    [2] = {
        image = "images/items/call_beads/heat_wave.gif",
        codes = "heat_wave",
        disabled = false
    },
    [3] = {
        image = "images/items/call_beads/storm.gif",
        codes = "storm",
        disabled = false
    },
    [4] = {
        image = "images/items/call_beads/life_spark.gif",
        codes = "life_spark",
        disabled = false
    },
    [5] = {
        image = "images/items/call_beads/confound.gif",
        codes = "confound",
        disabled = false
    },
    [6] = {
        image = "images/items/call_beads/first_aid.gif",
        codes = "first_aid",
        disabled = false
    },
    [7] = {
        image = "images/items/call_beads/time_warp.gif",
        codes = "time_warp",
        disabled = false
    },
    [8] = {
        image = "images/items/call_beads/aura.gif",
        codes = "aura",
        disabled = false
    },
    [9] = {
        image = "images/items/call_beads/regenerate.gif",
        codes = "regenerate",
        disabled = false
    },
    [10] = {
        image = "images/items/call_beads/shockwave.gif",
        codes = "shockwave",
        disabled = false
    },
    [11] = {
        image = "images/items/call_beads/shield.gif",
        codes = "shield",
        disabled = false
    },
    [12] = {
        image = "images/items/call_beads/hypnotize.gif",
        codes = "hypnotize",
        disabled = false
    },
    [13] = {
        image = "images/items/call_beads/plague.gif",
        codes = "plague",
        disabled = false
    },
    [14] = {
        image = "images/items/call_beads/disrupt.gif",
        codes = "disrupt",
        disabled = false
    },
    [15] = {
        image = "images/items/call_beads/restore.gif",
        codes = "restore",
        disabled = false
    },
    [16] = {
        image = "images/items/call_beads/electra_bolt.gif",
        codes = "electra_bolt",
        disabled = false
    },
}
CALL_BEAD_CHILD_PROGRESSION_STATES = {
    [0] = {
        [0] = 0,
        [1] = 0,
        [2] = 0,
        [3] = 0,
        [4] = 0,
    },
    [1] = {
        [0] = 1,
        [1] = 2,
        [2] = 3,
        [3] = 4,
        [4] = 0,
    },
    [2] = {
        [0] = 5,
        [1] = 6,
        [2] = 7,
        [3] = 8,
        [4] = 9,
    },
    [3] = {
        [0] = 10,
        [1] = 11,
        [2] = 12,
        [3] = 13,
        [4] = 0,
    },
    [4] = {
        [0] = 14,
        [1] = 15,
        [2] = 16,
        [3] = 0,
        [4] = 0,
    }
}
CB_CHARS = {}
CB_SPELLS = {}
--scripts
ScriptHost:LoadScript("scripts/custom_items/class.lua")
ScriptHost:LoadScript("scripts/custom_items/progressiveTogglePlusWrapper.lua")
ScriptHost:LoadScript("scripts/custom_items/progressiveTogglePlus.lua")

for i = 0, 3 do
    for j = 0, 4 do
        CB_SPELLS[i * 5 + j] = ProgressiveTogglePlus("Call Bead Spell " .. (j + 1), "call_bead_spell_" ..
        (i + 1) .. "_" .. (j + 1), CALL_BEAD_SPELLS, true, false, false, 0, false)
    end
end

CB_CHARS[0] = ProgressiveTogglePlus("Elizabeth's Call Bead Spells", "call_bead_char_1", CALL_BEAD_CHARS, true, true,
    false, 0, true,
    { CB_SPELLS[0], CB_SPELLS[1], CB_SPELLS[2], CB_SPELLS[3], CB_SPELLS[4] }, true,
    {
        children = { [0] = CB_SPELLS[0], CB_SPELLS[1], CB_SPELLS[2], CB_SPELLS[3], CB_SPELLS[4] },
        states = CALL_BEAD_CHILD_PROGRESSION_STATES
    }, true)
CB_CHARS[1] = ProgressiveTogglePlus("Horace's Call Bead Spells", "call_bead_char_2", CALL_BEAD_CHARS, true, false, false,
    0, false,
    { CB_SPELLS[5], CB_SPELLS[6], CB_SPELLS[7] }, true,
    {
        children = { [0] = CB_SPELLS[5], CB_SPELLS[6], CB_SPELLS[7], CB_SPELLS[8], CB_SPELLS[9] },
        states = CALL_BEAD_CHILD_PROGRESSION_STATES
    }, true)
CB_CHARS[2] = ProgressiveTogglePlus("Camellia's Call Bead Spells", "call_bead_char_3", CALL_BEAD_CHARS, true, false,
    false, 0, false,
    { CB_SPELLS[10], CB_SPELLS[11], CB_SPELLS[12], CB_SPELLS[13], CB_SPELLS[14] }, true,
    {
        children = { [0] = CB_SPELLS[10], CB_SPELLS[11], CB_SPELLS[12], CB_SPELLS[13], CB_SPELLS[14] },
        states = CALL_BEAD_CHILD_PROGRESSION_STATES
    }, true)
CB_CHARS[3] = ProgressiveTogglePlus("Sidney's Call Bead Spells", "call_bead_char_4", CALL_BEAD_CHARS, true, false, false,
    0, false,
    { CB_SPELLS[15], CB_SPELLS[16], CB_SPELLS[17], CB_SPELLS[18], CB_SPELLS[19] }, true,
    {
        children = { [0] = CB_SPELLS[15], CB_SPELLS[16], CB_SPELLS[17], CB_SPELLS[18], CB_SPELLS[19] },
        states = CALL_BEAD_CHILD_PROGRESSION_STATES
    }, true)



ScriptHost:LoadScript("scripts/logic.lua")
--items
Tracker:AddItems("items/weapons.json")
Tracker:AddItems("items/magic.json")
Tracker:AddItems("items/keyitems.json")
Tracker:AddItems("items/charms.json")
Tracker:AddItems("items/bosses.json")
Tracker:AddItems("items/npcs.json")
Tracker:AddItems("items/settings.json")
Tracker:AddItems("items/stats.json")
Tracker:AddItems("items/keyitem_counts.json")
if not IS_ITEMS_ONLY then
    --maps
    Tracker:AddMaps("maps/maps.json")
    if IS_DETAILED then
        Tracker:AddMaps("maps/maps_detailed.json")
    end
    --locations
    Tracker:AddLocations("locations/locations.json")
    if IS_DETAILED then
        Tracker:AddLocations("locations/prehistoria.json")
        Tracker:AddLocations("locations/antiqua.json")
        Tracker:AddLocations("locations/gothica.json")
        Tracker:AddLocations("locations/omnitopia.json")
        Tracker:AddLocations("locations/sniff_spots.json")
    end
end
--layouts
Tracker:AddLayouts("layouts/settings.json")
Tracker:AddLayouts("layouts/items.json")
Tracker:AddLayouts("layouts/tracker.json")
Tracker:AddLayouts("layouts/broadcast.json")

ScriptHost:LoadScript("scripts/watches.lua")
if PopVersion then
    ScriptHost:LoadScript("scripts/autotracking.lua")
end
