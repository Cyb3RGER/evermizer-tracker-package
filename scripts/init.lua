local variant = Tracker.ActiveVariantUID
local items_only = variant:find("itemsonly")
local compact = variant:find("itemsonly_compact")
local detailed = variant:find("detailed")
debug = false

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
if not items_only then
    --maps
    Tracker:AddMaps("maps/maps.json")   
    --locations
    if detailed then
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

ScriptHost:LoadScript("scripts/autotracking.lua")