-- Configuration --------------------------------------
AUTOTRACKER_ENABLE_DEBUG_LOGGING = true or ENABLE_DEBUG_LOG
AUTOTRACKER_ENABLE_ITEM_TRACKING = true
AUTOTRACKER_ENABLE_LOCATION_TRACKING = true and not IS_ITEMS_ONLY
-------------------------------------------------------

-- Globals --------------------------------------------
IS_GAME_RUNNING = true
if AUTOTRACKER_ENABLE_ITEM_TRACKING then
    ScriptHost:LoadScript("scripts/autotracking/items/weapons.lua")
    ScriptHost:LoadScript("scripts/autotracking/items/alchemy.lua")
    ScriptHost:LoadScript("scripts/autotracking/items/charms.lua")
    ScriptHost:LoadScript("scripts/autotracking/items/bosses.lua")
    ScriptHost:LoadScript("scripts/autotracking/items/keyitems.lua")
    ScriptHost:LoadScript("scripts/autotracking/items/market_timer.lua")
end
if AUTOTRACKER_ENABLE_LOCATION_TRACKING then
    ScriptHost:LoadScript("scripts/autotracking/locations/gourds.lua")
    ScriptHost:LoadScript("scripts/autotracking/locations/alchemy.lua")

    if AUTOTRACKER_ENABLE_DEBUG_LOGGING and GOURDS then
        print(#GOURDS .. " bytes for gourds")
    elseif not GOURDS then
        print("GOURDS is nil")
    end
end
-------------------------------------------------------

print("")
print("Active Auto-Tracker Configuration")
print("---------------------------------------------------------------------")
print("Enable Item Tracking:        ", AUTOTRACKER_ENABLE_ITEM_TRACKING)
print("Enable Location Tracking:    ", AUTOTRACKER_ENABLE_LOCATION_TRACKING)
if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
    print("Enable Debug Logging:        ", "true")
end
print("---------------------------------------------------------------------")
print("")

-- Functions ------------------------------------------
ScriptHost:LoadScript("scripts/autotracking/utils.lua")
ScriptHost:LoadScript("scripts/autotracking/callbacks.lua")
-------------------------------------------------------

-- Memory Watches -------------------------------------
--ScriptHost:AddMemoryWatch("CheckGameState",  , , updateGameState) -- ToDo
if AUTOTRACKER_ENABLE_ITEM_TRACKING then
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
        print("Adding item tracker watches")
    end
    ScriptHost:AddMemoryWatch("Weapons", WEAPONS.addr , 0x2, updateWeapons)
    ScriptHost:AddMemoryWatch("Ammo", AMMO.addr , 0x3, updateAmmo)
    ScriptHost:AddMemoryWatch("Alchemy", ALCHEMY_SPELLS.addr , 0x6, updateAlchemy)
    ScriptHost:AddMemoryWatch("Charms", CHARMS.addr , 0x3, updateCharms)
    ScriptHost:AddMemoryWatch("KeyItems", KEY_ITEMS.addr , 0x1, updateKeyItems)
    ScriptHost:AddMemoryWatch("KeyItems2", KEY_ITEMS_2.addr , 0x1, updateKeyItems2)
    ScriptHost:AddMemoryWatch("KeyItems3", KEY_ITEMS_3.addr , 0x1, updateKeyItems3)
    ScriptHost:AddMemoryWatch("Aeroglider", AEROGLIDER_ADDR , 0x1, updateAeroglider)
    ScriptHost:AddMemoryWatch("Rocket", ROCKET_ADDR , 0x1, updateRocket)
    ScriptHost:AddMemoryWatch("Bosses1", BOSSES_1.addr , 0x5, updateBosses1)
    ScriptHost:AddMemoryWatch("Bosses2", BOSSES_2.addr , 0x20, updateBosses2)
    ScriptHost:AddMemoryWatch("Timer", MARKET_TIMER.TIMER_ADDR , 0x2, updateTimer)
    ScriptHost:AddMemoryWatch("FrameCounter", MARKET_TIMER.FRAME_COUNTER_ADDR , 0x2, updateFrameCounter)
    ScriptHost:AddMemoryWatch("TimerDoneOverride",MARKET_TIMER.OVERRIDE_FLAG_ADDR, 0x1, updateTimerOverride)
end
if AUTOTRACKER_ENABLE_LOCATION_TRACKING then
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
        print("Adding location tracker watches")
    end
    for i=1,#GOURDS_WATCHES do
        ScriptHost:AddMemoryWatch("Gourds "..i, GOURDS_WATCHES[i].addr, GOURDS_WATCHES[i].len, updateGourds)
    end
    for k, v in pairs(ALCHEMY_LOCATIONS_FLAGS) do
        ScriptHost:AddMemoryWatch("Alchemy Location Mapping "..k+1, v, 0x2, updateAlchemyMappings)
    end
end
-------------------------------------------------------
