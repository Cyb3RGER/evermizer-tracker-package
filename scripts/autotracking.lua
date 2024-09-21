-- Configuration --------------------------------------
AUTOTRACKER_ENABLE_DEBUG_LOGGING = true or ENABLE_DEBUG_LOG
AUTOTRACKER_ENABLE_ITEM_TRACKING = true
AUTOTRACKER_ENABLE_LOCATION_TRACKING = true and not IS_ITEMS_ONLY
-- AUTOTRACKER_ENABLE_STAT_TRACKING = true and AUTOTRACKER_ENABLE_ITEM_TRACKING
-------------------------------------------------------

-- Globals --------------------------------------------
IS_GAME_RUNNING = false
ENABLED_WATCHES = false
GAME_STATE = {
	addr = 0x7e22ab,
	value = 0x40
}
BOY_X_ADDR = 0x7E4EA3
BOY_Y_ADDR = 0x7E4EA5

if AUTOTRACKER_ENABLE_ITEM_TRACKING then
	ScriptHost:LoadScript("scripts/autotracking/items/weapons.lua")
	ScriptHost:LoadScript("scripts/autotracking/items/alchemy.lua")
	ScriptHost:LoadScript("scripts/autotracking/items/charms.lua")
	ScriptHost:LoadScript("scripts/autotracking/items/bosses.lua")
	ScriptHost:LoadScript("scripts/autotracking/items/keyitems.lua")
	ScriptHost:LoadScript("scripts/autotracking/items/market_timer.lua")
	-- ScriptHost:LoadScript("scripts/autotracking/items/call_beads.lua")
	ScriptHost:LoadScript("scripts/autotracking/items/stats.lua")
	ScriptHost:LoadScript("scripts/autotracking/items/settings.lua")
end
if AUTOTRACKER_ENABLE_LOCATION_TRACKING then
	ScriptHost:LoadScript("scripts/autotracking/locations/gourds.lua")
	ScriptHost:LoadScript("scripts/autotracking/locations/alchemy.lua")
	ScriptHost:LoadScript("scripts/autotracking/locations/sniff_spots.lua")
	ScriptHost:LoadScript("scripts/autotracking/locations/mapswitching.lua")
end
--if AUTOTRACKER_ENABLE_ITEM_TRACKING and AUTOTRACKER_ENABLE_LOCATION_TRACKING then
--    ScriptHost:LoadScript("scripts/autotracking/keyitem_counts.lua")
--end

-------------------------------------------------------

print("")
print("Active Auto-Tracker Configuration")
print("---------------------------------------------------------------------")
print("Enable Item Tracking:        ", AUTOTRACKER_ENABLE_ITEM_TRACKING)
print("Enable Location Tracking:    ", AUTOTRACKER_ENABLE_LOCATION_TRACKING)
print("Enable Stat Tracking:        ", AUTOTRACKER_ENABLE_STAT_TRACKING)
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
ScriptHost:AddMemoryWatch("CheckGameState", 0x7e22ab, 0x1, updateGameState)
--- we update the timer obj from vigor because we use the active state of vigor as an override flag
ScriptHost:AddWatchForCode("UpdateTimerFromVigor", "vigor", updateTimerObj)

function enableWatches()
	if ENABLED_WATCHES then
		return
	end
	if not IS_ITEMS_ONLY then
		ScriptHost:AddMemoryWatch("CurrentRoom", CURRENT_ROOM_ADDR, 0x1, updateCurrentRoom)
		ScriptHost:AddMemoryWatch("Boy Position", BOY_X_ADDR, 0x4, updateBoyPos)
		ScriptHost:AddMemoryWatch("EbonKeepFlag", EBON_KEEP_FLAG_ADDR, 0x1, updateEbonKeepFlag)
	end
	if AUTOTRACKER_ENABLE_ITEM_TRACKING then
		if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
			print("Adding item tracker watches")
		end
		ScriptHost:AddMemoryWatch("Weapons", WEAPONS.addr, 0x2, updateWeapons)
		ScriptHost:AddMemoryWatch("Ammo", AMMO.addr, 0x3, updateAmmo)
		ScriptHost:AddMemoryWatch("Alchemy", ALCHEMY_SPELLS.addr, 0x6, updateAlchemy)
		ScriptHost:AddMemoryWatch("Charms", CHARMS.addr, 0x3, updateCharms)
		ScriptHost:AddMemoryWatch("KeyItems", KEY_ITEMS.addr, 0x1, updateKeyItems)
		ScriptHost:AddMemoryWatch("KeyItems2", KEY_ITEMS_2.addr, 0x1, updateKeyItems2)
		ScriptHost:AddMemoryWatch("KeyItems3", KEY_ITEMS_3.addr, 0x1, updateKeyItems3)
		ScriptHost:AddMemoryWatch("Aeroglider", AEROGLIDER_ADDR, 0x1, updateAeroglider)
		ScriptHost:AddMemoryWatch("Rocket", ROCKET_ADDR, 0x1, updateRocket)
		ScriptHost:AddMemoryWatch("Bosses1", BOSSES_1.addr, 0x5, updateBosses1)
		ScriptHost:AddMemoryWatch("Bosses2", BOSSES_2.addr, 0x20, updateBosses2)
		ScriptHost:AddMemoryWatch("Timer", MARKET_TIMER.TIMER_ADDR, 0x2, updateTimer)
		ScriptHost:AddMemoryWatch("FrameCounter", MARKET_TIMER.FRAME_COUNTER_ADDR, 0x2, updateFrameCounter)
		ScriptHost:AddMemoryWatch("TimerDoneOverride", MARKET_TIMER.OVERRIDE_FLAG_ADDR, 0x1, updateTimerOverride)
		ScriptHost:AddMemoryWatch("EnergyCoreFragments", ENERGY_CORE_FRAGMENTS_ADDR, 0x2, updateEnergyCoreFragments)
		ScriptHost:AddMemoryWatch("Settings", SETTINGS_ADDR, 0x30, updateSettings)
		ScriptHost:AddMemoryWatch("RequiredEnergyCoreFragments", REQUIRED_ENERGY_CORE_FRAGMENTS_ADDR, 0x1,
			updateRequiredEnergyCoreFragments)
		if AUTOTRACKER_ENABLE_STAT_TRACKING then
			ScriptHost:AddMemoryWatch("WeaponLevels", WEAPON_LEVELS_START_ADDR, 0x1A, updateWeaponLevels)
			ScriptHost:AddMemoryWatch("DogAttackLevel", DOG_ATTACK_LVL_ADDR, 0x2, updateDogAttackLevel)
			ScriptHost:AddMemoryWatch("AlchemyLevels", ALCHEMY_LEVELS_START_ADDR, 0x8B, updateAlchemyLevels)
			ScriptHost:AddMemoryWatch("Money", MONEY_START_ADDR, 0xB, updateMoney)
			ScriptHost:AddMemoryWatch("Boy Exp", BOY_EXP_ADDR, 0x4, updateBoyExp)
			ScriptHost:AddMemoryWatch("Boy Lvl", BOY_LVL_ADDR, 0x2, updateBoyLvl)
			ScriptHost:AddMemoryWatch("Boy Exp next Lvl", BOY_EXP_NEXT_LVL_ADDR, 0x4, updateBoyExp)
			ScriptHost:AddMemoryWatch("Dog Exp", DOG_EXP_ADDR, 0x4, updateDogExp)
			ScriptHost:AddMemoryWatch("Dog Lvl", DOG_LVL_ADDR, 0x2, updateDogLvl)
			ScriptHost:AddMemoryWatch("Dog Exp next Lvl", DOG_EXP_NEXT_LVL_ADDR, 0x4, updateDogExp)
		end
		-- ScriptHost:AddMemoryWatch("CallBeadChars", CALL_BEAD_CHARS_AUTOTRACKING.addr,0x2,updateCallBeadChars)
		-- ScriptHost:AddMemoryWatch("ActiveRingMenu",ACTIVE_RING_MENU_ADDR, 0x2, updateActiveRingMenu)
		-- ScriptHost:AddMemoryWatch("CurrentCallBeadChar",CALL_BEAD_CHARS_MENU_ADDR, 0xc, updateCurrentCallBeadChar)
		-- ScriptHost:AddMemoryWatch("CallBeadSpells",CALL_BEAD_SPELLS_MENU_ADDR, 0xe, updateCallBeadSpells)
	end
	if AUTOTRACKER_ENABLE_LOCATION_TRACKING then
		if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
			print("Adding location tracker watches")
		end
		for i = 1, #GOURDS_WATCHES do
			ScriptHost:AddMemoryWatch("Gourds " .. i, GOURDS_WATCHES[i].addr, GOURDS_WATCHES[i].len, updateGourds)
		end
		for i = 1, #SNIFF_SPOT_WATCHES do
			ScriptHost:AddMemoryWatch("Sniff Spots " .. i, SNIFF_SPOT_WATCHES[i].addr, SNIFF_SPOT_WATCHES[i].len,
				updateSniffSpots)
		end
		ScriptHost:AddMemoryWatch("Alchemy Locations", ALCHEMY_LOCATIONS_BASE_ADDR, 0x5, updateAlchemyLocations)
	end
	ENABLED_WATCHES = true
end

function disableWatches()
	if not ENABLED_WATCHES then
		return
	end
	if not IS_ITEMS_ONLY then
		ScriptHost:RemoveMemoryWatch("CurrentRoom")
		ScriptHost:RemoveMemoryWatch("Boy Position")
		ScriptHost:RemoveMemoryWatch("EbonKeepFlag")
	end
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
		ScriptHost:RemoveMemoryWatch("WeaponLevels")
		ScriptHost:RemoveMemoryWatch("DogAttackLevel")
		ScriptHost:RemoveMemoryWatch("AlchemyLevels")
		ScriptHost:RemoveMemoryWatch("Money")
		ScriptHost:RemoveMemoryWatch("Boy Exp")
		ScriptHost:RemoveMemoryWatch("Boy Lvl")
		ScriptHost:RemoveMemoryWatch("Boy Exp next Lvl")
		ScriptHost:RemoveMemoryWatch("Dog Exp")
		ScriptHost:RemoveMemoryWatch("Dog Lvl")
		ScriptHost:RemoveMemoryWatch("Dog Exp next Lvl")
		-- ScriptHost:RemoveMemoryWatch("CallBeadChars")
		-- ScriptHost:RemoveMemoryWatch("ActiveRingMenu")
		-- ScriptHost:RemoveMemoryWatch("CurrentCallBeadChar")
		-- ScriptHost:RemoveMemoryWatch("CallBeadSpells")
		ScriptHost:RemoveMemoryWatch("EnergyCoreFragments")
		ScriptHost:RemoveMemoryWatch("Settings")
		ScriptHost:RemoveMemoryWatch("RequiredEnergyCoreFragments")
	end
	if AUTOTRACKER_ENABLE_LOCATION_TRACKING then
		if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
			print("Removing location tracker watches")
		end
		for i = 1, #GOURDS_WATCHES do
			ScriptHost:RemoveMemoryWatch("Gourds " .. i)
		end
		for i = 1, #SNIFF_SPOT_WATCHES do
			ScriptHost:RemoveMemoryWatch("Sniff Spots " .. i)
		end
		ScriptHost:RemoveMemoryWatch("Alchemy Locations")
	end
	ENABLED_WATCHES = false
	if not IS_ITEMS_ONLY then
		Tracker:UiHint("ActivateTab", "Overview")
	end
end

-------------------------------------------------------
