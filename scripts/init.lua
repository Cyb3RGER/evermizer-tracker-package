local variant = Tracker.ActiveVariantUID
local items_only = variant:find("itemsonly")
debug = false

ScriptHost:LoadScript("scripts/logic.lua")

Tracker:AddItems("items/weapons.json")
Tracker:AddItems("items/magic.json")
Tracker:AddItems("items/keyitems.json")
Tracker:AddItems("items/charms.json")
Tracker:AddItems("items/bosses.json")
Tracker:AddItems("items/npcs.json")
if not items_only then
    Tracker:AddMaps("maps/maps.json")       
    Tracker:AddLocations("locations/locations.json")
end
Tracker:AddLayouts("layouts/items.json")
Tracker:AddLayouts("layouts/tracker.json")
Tracker:AddLayouts("layouts/broadcast.json")