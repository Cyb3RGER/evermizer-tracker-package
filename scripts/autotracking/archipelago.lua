ScriptHost:LoadScript("scripts/autotracking/item_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/location_mapping.lua")

IS_CONNECTED = false

AP_CLEARED_LOCATIONS = {}
AP_COLLECTED_ITEMS = {}

Archipelago:AddClearHandler("clear handler", onClear)
Archipelago:AddItemHandler("item handler", onItem)
Archipelago:AddLocationHandler("location handler", onLocation)
--Archipelago:AddScoutHandler("scout handler", onScout)
--Archipelago:AddBouncedHandler("bounce handler", onBounce)

function onClear()   
    AP_CLEARED_LOCATIONS = {}
    AP_COLLECTED_ITEMS = {} 
end

function onItem(index, item_id, item_name)
    
end

function onLocation(location_id, location_name)
    
end

