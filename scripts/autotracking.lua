-- Configuration --------------------------------------
AUTOTRACKER_ENABLE_DEBUG_LOGGING = true or ENABLE_DEBUG_LOG
AUTOTRACKER_ENABLE_ITEM_TRACKING = true
AUTOTRACKER_ENABLE_LOCATION_TRACKING = true and not IS_ITEMS_ONLY
-------------------------------------------------------

-- Globals --------------------------------------------
IS_GAME_RUNNING = false
ENABLED_WATCHES = false
GAME_STATE = {
    addr = 0x7e22ab,
    value = 0x40
}
if AUTOTRACKER_ENABLE_ITEM_TRACKING then
    ScriptHost:LoadScript("scripts/autotracking/items/weapons.lua")
    ScriptHost:LoadScript("scripts/autotracking/items/alchemy.lua")
    ScriptHost:LoadScript("scripts/autotracking/items/charms.lua")
    ScriptHost:LoadScript("scripts/autotracking/items/bosses.lua")
    ScriptHost:LoadScript("scripts/autotracking/items/keyitems.lua")
    ScriptHost:LoadScript("scripts/autotracking/items/market_timer.lua")
    --ScriptHost:LoadScript("scripts/autotracking/items/call_beads.lua")
end
if AUTOTRACKER_ENABLE_LOCATION_TRACKING then
    ScriptHost:LoadScript("scripts/autotracking/locations/gourds.lua")
    ScriptHost:LoadScript("scripts/autotracking/locations/alchemy.lua")
    ScriptHost:LoadScript("scripts/autotracking/locations/mapswitching.lua")
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
ScriptHost:AddMemoryWatch("CheckGameState", 0x7e22ab  , 0x1 , updateGameState)

function enableWatches()
    if ENABLED_WATCHES then return end
    ScriptHost:AddMemoryWatch("CurrentRoom", CURRENT_ROOM_ADDR, 0x1, updateCurrentRoom)
    ScriptHost:AddMemoryWatch("EbonKeepFlag", EBON_KEEP_FLAG_ADDR, 0x1, updateEbonKeepFlag)
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
        --ScriptHost:AddMemoryWatch("CallBeadChars", CALL_BEAD_CHARS_AUTOTRACKING.addr,0x2,updateCallBeadChars)
        --ScriptHost:AddMemoryWatch("ActiveRingMenu",ACTIVE_RING_MENU_ADDR, 0x2, updateActiveRingMenu)
        --ScriptHost:AddMemoryWatch("CurrentCallBeadChar",CALL_BEAD_CHARS_MENU_ADDR, 0xc, updateCurrentCallBeadChar)
        --ScriptHost:AddMemoryWatch("CallBeadSpells",CALL_BEAD_SPELLS_MENU_ADDR, 0xe, updateCallBeadSpells)
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
    ENABLED_WATCHES = true
end

function disableWatches()
    if not ENABLED_WATCHES then return end
    ScriptHost:RemoveMemoryWatch("CurrentRoom")
    ScriptHost:RemoveMemoryWatch("EbonKeepFlag")
    if AUTOTRACKER_ENABLE_ITEM_TRACKING then
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
            print("Removing item tracker watches")
        end
        ScriptHost:RemoveMemoryWatch("Weapons")
        ScriptHost:RemoveMemoryWatch("Ammo")
        ScriptHost:RemoveMemoryWatch("Alchemy")
        ScriptHost:RemoveMemoryWatch("Charms")
        ScriptHost:RemoveMemoryWatch("KeyItems")
        ScriptHost:RemoveMemoryWatch("KeyItems2")
        ScriptHost:RemoveMemoryWatch("KeyItems3")
        ScriptHost:RemoveMemoryWatch("Aeroglider")
        ScriptHost:RemoveMemoryWatch("Rocket")
        ScriptHost:RemoveMemoryWatch("Bosses1")
        ScriptHost:RemoveMemoryWatch("Bosses2")
        ScriptHost:RemoveMemoryWatch("Timer")
        ScriptHost:RemoveMemoryWatch("FrameCounter")
        ScriptHost:RemoveMemoryWatch("TimerDoneOverride")
        --ScriptHost:RemoveMemoryWatch("CallBeadChars")
        --ScriptHost:RemoveMemoryWatch("ActiveRingMenu")
        --ScriptHost:RemoveMemoryWatch("CurrentCallBeadChar")
        --ScriptHost:RemoveMemoryWatch("CallBeadSpells")
    end
    if AUTOTRACKER_ENABLE_LOCATION_TRACKING then
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
            print("Removing location tracker watches")
        end
        for i=1,#GOURDS_WATCHES do
            ScriptHost:RemoveMemoryWatch("Gourds "..i)
        end
        for k, v in pairs(ALCHEMY_LOCATIONS_FLAGS) do
            ScriptHost:RemoveMemoryWatch("Alchemy Location Mapping "..k+1)
        end
    end
    ENABLED_WATCHES = false
    Tracker:UiHint("ActivateTab","Overview")
end

-------------------------------------------------------
