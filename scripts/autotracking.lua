-- Configuration --------------------------------------
AUTOTRACKER_ENABLE_DEBUG_LOGGING = true or ENABLE_DEBUG_LOG
AUTOTRACKER_ENABLE_ITEM_TRACKING = true
AUTOTRACKER_ENABLE_LOCATION_TRACKING = true and not IS_ITEMS_ONLY
-------------------------------------------------------

-- Globals --------------------------------------------
IS_GAME_RUNNING = true
CURRENT_ROOM_ADDR = 0x7e0adb
CURRENT_ROOM = nil
EBON_KEEP_FLAG_ADDR = 0x7e22dd
EBON_KEEP_FLAG = false
ROOM_MAPPING =
{
    [0x36] = {"Overview"}, --prehistoria firepits
    [0x39] = {"Overview"}, --ebon keep firepit
    [0x3a] = {"Overview"}, --nobilia firepit
    [0x04] = {"Overview"}, --crustacia firepit
    [0x46] = {"Overview"}, --prof lab
    --Prehistoria
    [0x33] = {"Prehistoria","Southern Jungle"},
    [0x34] = {"Prehistoria","Southern Jungle"},
    [0x38] = {"Prehistoria","Southern Jungle"},
    [0x25] = {"Prehistoria","Fire Eyes' Village"},
    [0x26] = {"Prehistoria","Fire Eyes' Village"},
    [0x5c] = {"Prehistoria","Fire Eyes' Village"},
    [0x59] = {"Prehistoria","Quick Sand Fields"},
    [0x5a] = {"Prehistoria","Quick Sand Fields"},
    [0x5b] = {"Prehistoria","Quick Sand Fields"},
    [0x67] = {"Prehistoria","Bugmuck"},
    [0x16] = {"Prehistoria","Bugmuck"},
    [0x17] = {"Prehistoria","Bugmuck"},
    [0x18] = {"Prehistoria","Bugmuck"},
    [0x27] = {"Prehistoria","Northern Jungle"},
    [0x41] = {"Prehistoria","Northern Jungle"},
    [0x69] = {"Prehistoria","Volcano Path"},
    [0x52] = {"Prehistoria","Volcano Path"},
    [0x50] = {"Prehistoria","Volcano Path"},
    [0x66] = {"Prehistoria","Swamp"},
    [0x65] = {"Prehistoria","Swamp"},
    [0x01] = {"Prehistoria","Swamp"},
    [0x3c] = {"Prehistoria","Volcano Core"},
    [0x3b] = {"Prehistoria","Volcano Core"},
    [0x3d] = {"Prehistoria","Volcano Sewers"},
    [0x3e] = {"Prehistoria","Volcano Sewers"},
    [0x3f] = {"Prehistoria","Volcano Sewers"},
    --Antiqua
    [0x1b] = {"Antiqua","Eastern Beach"},
    [0x4f] = {"Antiqua","Eastern Beach"},
    [0x2e] = {"Antiqua","Eastern Beach"},
    --[0x04] = {"Antiqua","Eastern Beach"},
    [0x53] = {"Antiqua","Crustacia"},
    [0x68] = {"Antiqua","Crustacia"},
    [0x30] = {"Antiqua","Crustacia"},
    [0x0a] = {"Antiqua","Nobilia"},
    [0x08] = {"Antiqua","Nobilia"},
    [0x09] = {"Antiqua","Nobilia"},
    [0x1e] = {"Antiqua","Nobilia"},
    [0x1d] = {"Antiqua","Nobilia"},
    [0x4c] = {"Antiqua","Nobilia"},
    [0x0b] = {"Antiqua","Nobilia"},
    [0x4d] = {"Antiqua","Nobilia"},
    --[0x3a] = {"Antiqua","Nobilia"},
    [0x0c] = {"Antiqua","Nobilia"},
    [0x1c] = {"Antiqua","Nobilia"},
    [0x07] = {"Antiqua","River"},
    [0x05] = {"Antiqua","Western Beach"},
    [0x2f] = {"Antiqua","Western Beach"},
    [0x55] = {"Antiqua","Pyramid (lower)"},
    [0x56] = {"Antiqua","Pyramid (upper)"},
    [0x58] = {"Antiqua","Pyramid (upper)"},
    [0x2b] = {"Antiqua","Halls of Collosia 1"},
    [0x29] = {"Antiqua","Halls of Collosia 1"},
    [0x2c] = {"Antiqua","Halls of Collosia 1"},
    [0x2a] = {"Antiqua","Halls of Collosia 1"},
    [0x24] = {"Antiqua","Halls of Collosia 2"},
    [0x23] = {"Antiqua","Halls of Collosia 3"},
    [0x28] = {"Antiqua","Halls of Collosia 3"},
    [0x2d] = {"Antiqua","Halls of Collosia 4"},
    [0x64] = {"Antiqua","Tiny's Hideout"},
    [0x57] = {"Antiqua","Tiny's Hideout"},
    [0x6b] = {"Antiqua","Oglin Tunnel"},
    [0x4b] = {"Antiqua","Oglin Tunnel"},
    [0x6d] = {"Antiqua","Oglin Tunnel"},
    --Gothica
    [0x12] = {"Gothica","Ebon Keep Sewers"},
    [0x0d] = {"Gothica","Ebon Keep Interiors"},
    [0x0f] = {"Gothica","Ebon Keep Interiors"},
    [0x11] = {"Gothica","Ebon Keep Interiors"},
    [0x10] = {"Gothica","Ebon Keep Interiors"},
    [0x14] = {"Gothica","Ebon Keep Interiors"},
    --[0x39] = {"Gothica","Ebon Keep Interiors"},
    [0x0e] = {"Gothica","Ebon Keep Interiors"},
    [0x5d] = {"Gothica","Ebon Keep Interiors"},
    [0x5e] = {"Gothica","Ebon Keep Interiors"},
    [0x5f] = {"Gothica","Ebon Keep Interiors"},
    [0x60] = {"Gothica","Ebon Keep Interiors"},
    [0x13] = {"Gothica","Dark Forest"},
    [0x20] = {"Gothica","Dark Forest"},
    [0x1F] = {"Gothica","Dark Forest"},
    [0x22] = {"Gothica","Dark Forest"},
    [0x21] = {"Gothica","Dark Forest"},
    [0x19] = {"Gothica","Chessboard"},
    [0x1a] = {"Gothica","Chessboard"},
    [0x6e] = {"Gothica","Ivor Tower Interiors"},
    [0x6f] = {"Gothica","Ivor Tower Interiors"},
    [0x70] = {"Gothica","Ivor Tower Interiors"},
    [0x71] = {"Gothica","Ivor Tower Interiors"},
    [0x72] = {"Gothica","Ivor Tower Interiors"},
    [0x73] = {"Gothica","Ivor Tower Interiors"},
    [0x78] = {"Gothica","Ivor Tower Interiors"},
    [0x77] = {"Gothica","Ivor Tower Interiors"},
    [0x79] = {"Gothica","Ivor Tower Sewers"},
    [0x7a] = {"Gothica","Ivor Tower Sewers"},
    [0x4e] = {"Gothica","Ivor Tower"},
    [0x62] = {"Gothica","Ivor Tower"},
    [0x63] = {"Gothica","Ivor Tower"},
    [0x6c] = {"Gothica","Ivor Tower South"},
    [0x76] = {"Gothica","Ivor Tower South"},
    [0x37] = {"Gothica","Gomi's Tower"},
    [0x40] = {"Gothica","Gomi's Tower"},
    --Omnitopia
    --[0x46] = {"Omnitopia"},
    [0x48] = {"Omnitopia"},
    [0x44] = {"Omnitopia"},
    [0x00] = {"Omnitopia"},
    [0x43] = {"Omnitopia"},
    [0x45] = {"Omnitopia"},
    [0x47] = {"Omnitopia"},
    [0x42] = {"Omnitopia"},
    [0x54] = {"Omnitopia"},
    [0x7e] = {"Omnitopia"},
    [0x49] = {"Omnitopia"},
    [0x4a] = {"Omnitopia"},
}
if AUTOTRACKER_ENABLE_ITEM_TRACKING then
    ScriptHost:LoadScript("scripts/autotracking/items/weapons.lua")
    ScriptHost:LoadScript("scripts/autotracking/items/alchemy.lua")
    ScriptHost:LoadScript("scripts/autotracking/items/charms.lua")
    ScriptHost:LoadScript("scripts/autotracking/items/bosses.lua")
    ScriptHost:LoadScript("scripts/autotracking/items/keyitems.lua")
    ScriptHost:LoadScript("scripts/autotracking/items/market_timer.lua")
    ScriptHost:LoadScript("scripts/autotracking/items/call_beads.lua")
end
if AUTOTRACKER_ENABLE_LOCATION_TRACKING then
    ScriptHost:LoadScript("scripts/autotracking/locations/gourds.lua")
    ScriptHost:LoadScript("scripts/autotracking/locations/alchemy.lua")
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
    ScriptHost:AddMemoryWatch("CallBeadChars", CALL_BEAD_CHARS_AUTOTRACKING.addr,0x2,updateCallBeadChars)
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
