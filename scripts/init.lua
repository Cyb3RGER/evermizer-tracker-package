local variant = Tracker.ActiveVariantUID
IS_ITEMS_ONLY = variant:find("itemsonly")
IS_COMPACT = variant:find("itemsonly_compact")
IS_DETAILED = variant:find("detailed")
ENABLE_DEBUG_LOG = false

--scripts
ScriptHost:LoadScript("scripts/logic.lua")
--items
Tracker:AddItems("items/weapons.json")
Tracker:AddItems("items/magic.json")
Tracker:AddItems("items/keyitems.json")
Tracker:AddItems("items/charms.json")
Tracker:AddItems("items/bosses.json")
Tracker:AddItems("items/npcs.json")
Tracker:AddItems("items/settings.json")
if not IS_ITEMS_ONLY then
    --maps
    Tracker:AddMaps("maps/maps.json")
    --locations
    if IS_DETAILED then
        Tracker:AddLocations("locations/prehistoria.json")
        Tracker:AddLocations("locations/antiqua.json")
        Tracker:AddLocations("locations/gothica.json")
        Tracker:AddLocations("locations/omnitopia.json")
    else
        Tracker:AddLocations("locations/locations.json")
    end    
end
--layouts
Tracker:AddLayouts("layouts/settings.json")
Tracker:AddLayouts("layouts/items.json")
Tracker:AddLayouts("layouts/tracker.json")
Tracker:AddLayouts("layouts/broadcast.json")

if PopVersion then
    ScriptHost:LoadScript("scripts/autotracking.lua")
end