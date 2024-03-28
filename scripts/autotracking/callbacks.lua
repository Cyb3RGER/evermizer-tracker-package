function updateGameState(segment)
    local readResult = segment:ReadUInt8(GAME_STATE.addr)
    IS_GAME_RUNNING = readResult & GAME_STATE.value > 0
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
        print(string.format("readResult: %x, Game State is %s. Enabled Watches is %s.", readResult, IS_GAME_RUNNING,
            ENABLED_WATCHES))
    end
    if (IS_GAME_RUNNING and not ENABLED_WATCHES) then
        enableWatches()
    elseif (not IS_GAME_RUNNING and ENABLED_WATCHES) then
        disableWatches()
    end
end

function updateCurrentRoom(segment)
    CURRENT_ROOM = segment:ReadUInt8(CURRENT_ROOM_ADDR)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
        print(string.format("CURRENT_ROOM is now %x", CURRENT_ROOM))
    end
    updateUI()
end

function updateUI()
    if not IS_GAME_RUNNING then
        return
    end
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
        print(string.format(
            "updating UI with: CURRENT_ROOM: 0x%x, EBON_KEEP_FLAG: %s, ROOM_MAPPING[CURRENT_ROOM]: %s, isEbonKeepOrIvorTower: %s",
            CURRENT_ROOM, EBON_KEEP_FLAG, ROOM_MAPPING[CURRENT_ROOM], CURRENT_ROOM >= 0x7b and CURRENT_ROOM <= 0x7d))
    end
    if CURRENT_ROOM >= 0x7b and CURRENT_ROOM <= 0x7d then
        if EBON_KEEP_FLAG then
            print(string.format("Setting ActivateTab to %s", "Ebon Keep"))
            Tracker:UiHint("ActivateTab", "Gothica")
            Tracker:UiHint("ActivateTab", "Ebon Keep")
        else
            print(string.format("Setting ActivateTab to %s", "Ivor Tower"))
            Tracker:UiHint("ActivateTab", "Gothica")
            Tracker:UiHint("ActivateTab", "Ivor Tower")
        end
    elseif ROOM_MAPPING[CURRENT_ROOM] then
        local mapping = ROOM_MAPPING[CURRENT_ROOM]
        print(type(mapping[1]))
        if type(mapping[1]) == "function" then
            print("has mapping func. result: ", mapping[1]())
            mapping = mapping[mapping[1]()]
        end
        for _, v in ipairs(mapping) do
            if type(v) == "string" then
                print(string.format("Setting ActivateTab to %s", v))
                Tracker:UiHint("ActivateTab", v)
            end
        end
    else
        print(string.format("In unmapped room %x", CURRENT_ROOM))
    end
end

function updateBoyPos()
    if not IS_GAME_RUNNING then
        return
    end
    if CURRENT_ROOM ~= 0x3c then
        return
    end
    local boy_x = AutoTracker:ReadU16(BOY_X_ADDR)
    local boy_y = AutoTracker:ReadU16(BOY_Y_ADDR)
    --Check if we are in Volcano Shop
    if boy_x >= 590 and boy_x <= 770 and boy_y >= 1160 and boy_y <= 1420 then
        Tracker:UiHint("ActivateTab", "Prehistoria")
        Tracker:UiHint("ActivateTab", "Northern Jungle")
    else
        -- make sure we show the right map if not
        updateUI()
    end
end

function updateEbonKeepFlag(segment)
    if not IS_GAME_RUNNING then
        return
    end
    EBON_KEEP_FLAG = segment:ReadUInt8(EBON_KEEP_FLAG_ADDR) & 0x40 > 0
    print(string.format("EBON_KEEP_FLAG is now %x", CURRENT_ROOM))
    updateUI()
end

function updateWeapons(segment)
    if IS_GAME_RUNNING then
        checkFlagsInSegmentUsingTable(segment, WEAPONS)
    end
end

function updateAmmo(segment)
    if IS_GAME_RUNNING then
        checkConsumablesInSegmentUsingTable(segment, AMMO)
    end
end

function updateAlchemy(segment)
    if IS_GAME_RUNNING then
        ALCHEMY_SPELLS_TURDO_FOUND = {}
        checkFlagsInSegmentUsingTable(segment, ALCHEMY_SPELLS, 2)
        for k, v in pairs(ALCHEMY_SPELLS_TURDO_FOUND) do
            local obj = Tracker:FindObjectForCode(k)
            if obj then
                obj.AcquiredCount = v
            end
        end
    end
end

function updateCharms(segment)
    if IS_GAME_RUNNING then
        checkFlagsInSegmentUsingTable(segment, CHARMS)
    end
end

function updateBosses1(segment)
    if IS_GAME_RUNNING then
        checkFlagsInSegmentUsingTable(segment, BOSSES_1)
    end
end

function updateBosses2(segment)
    if IS_GAME_RUNNING then
        checkFlagsInSegmentUsingTable(segment, BOSSES_2)
    end
end

function updateKeyItems(segment)
    if IS_GAME_RUNNING then
        local readResult = segment:ReadUInt8(KEY_ITEMS.addr)
        local diamond_eyes = Tracker:FindObjectForCode("diamond_eyes")
        if diamond_eyes then
            HAS_DE = (readResult & 0x01) + (readResult & 0x02)
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                print(string.format("Updating diamond_eyes with value %i and gave away flag %s", HAS_DE, GAVE_AWAY_DES))
            end
            if GAVE_AWAY_DES then
                diamond_eyes.CurrentStage = (readResult & 0x01) + 2
            else
                diamond_eyes.CurrentStage = HAS_DE
            end
        end
        local gauge = Tracker:FindObjectForCode("gauge")
        if gauge then
            HAS_GAUGE = readResult & 0x04 > 0
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                print(string.format("Updating gauge with value %s and gave away flag %s", HAS_GAUGE, GAVE_AWAY_GAUGE))
            end
            gauge.Active = HAS_GAUGE or GAVE_AWAY_GAUGE
        end
        local wheel = Tracker:FindObjectForCode("wheel")
        if wheel then
            HAS_WHEEL = readResult & 0x08 > 0
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                print(string.format("Updating wheel with value %s and gave away flag %s", HAS_WHEEL, GAVE_AWAY_WHEEL))
            end
            wheel.Active = HAS_WHEEL or GAVE_AWAY_WHEEL
        end
        local energy_core = Tracker:FindObjectForCode("energy_core")
        if energy_core then
            HAS_CORE = readResult & 0x20 > 0
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                print(
                    string.format("Updating energy_core with value %s and gave away flag %s", HAS_CORE, GAVE_AWAY_CORE))
            end
            energy_core.Active = HAS_CORE or GAVE_AWAY_CORE
        end
        checkFlagsInSegmentUsingTable(segment, KEY_ITEMS)
    end
end

function updateKeyItems2(segment)
    if IS_GAME_RUNNING then
        local readResult = segment:ReadUInt8(KEY_ITEMS_2.addr)
        local diamond_eyes = Tracker:FindObjectForCode("diamond_eyes")
        GAVE_AWAY_DES = readResult & 0x40 > 0
        if diamond_eyes then
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                print(string.format("Updating diamond_eyes with value %s and gave away flag %s", HAS_DE, GAVE_AWAY_DES))
            end
            if HAS_DE ~= diamond_eyes.CurrentStage then
                diamond_eyes.CurrentStage = HAS_DE
            end
            if HAS_DE < 2 and GAVE_AWAY_DES then
                diamond_eyes.CurrentStage = 2 + HAS_DE
            end
        end
        local gauge = Tracker:FindObjectForCode("gauge")
        if gauge then
            GAVE_AWAY_GAUGE = readResult & 0x10 > 0
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                print(string.format("Updating gauge with value %s and gave away flag %s", HAS_GAUGE, GAVE_AWAY_GAUGE))
            end
            gauge.Active = HAS_GAUGE or GAVE_AWAY_GAUGE
        end
        local wheel = Tracker:FindObjectForCode("wheel")
        if wheel then
            GAVE_AWAY_WHEEL = readResult & 0x20 > 0
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                print(string.format("Updating wheel with value %s and gave away flag %s", HAS_WHEEL, GAVE_AWAY_WHEEL))
            end
            wheel.Active = HAS_WHEEL or GAVE_AWAY_WHEEL
        end
    end
end

function updateKeyItems3(segment)
    if IS_GAME_RUNNING then
        local readResult = segment:ReadUInt8(KEY_ITEMS_3.addr)
        local energy_core = Tracker:FindObjectForCode("energy_core")
        if energy_core then
            GAVE_AWAY_CORE = readResult & 0x20 > 0
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                print(
                    string.format("Updating energy_core with value %s and gave away flag %s", HAS_CORE, GAVE_AWAY_CORE))
            end
            energy_core.Active = HAS_CORE or GAVE_AWAY_CORE
        end
    end
end

function updateAeroglider(segment)
    if IS_GAME_RUNNING then
        local readResult = segment:ReadUInt8(AEROGLIDER_ADDR)
        local aeroglider = Tracker:FindObjectForCode("aeroglider")
        if aeroglider then
            aeroglider.Active = readResult & 0x02 > 0
        end
    end
end

function updateRocket(segment)
    if IS_GAME_RUNNING then
        local readResult = segment:ReadUInt8(ROCKET_ADDR)
        local rocket = Tracker:FindObjectForCode("rocket")
        if rocket then
            rocket.Active = readResult & 0x70 == 0x70
        end
    end
end

function updateTimer(segment)
    if IS_GAME_RUNNING then
        local readResult = segment:ReadUInt16(MARKET_TIMER.TIMER_ADDR)
        MARKET_TIMER.TIMER = readResult;
        updateTimerObj()
    end
end

function updateTimerObj()
    if IS_GAME_RUNNING then
        local vigor = Tracker:FindObjectForCode("vigor") -- Also an override flag but we get this thru boss flags
        local market_timer = Tracker:FindObjectForCode("market_timer")
        if market_timer then
            local isDone = vigor.Active or MARKET_TIMER.OVERRIDE_FLAG
            local hasStarted = MARKET_TIMER.TIMER > 0
            if hasStarted then
                if isDone then
                    market_timer.CurrentStage = 2
                    if market_timer.SetOverlay then
                        market_timer:SetOverlay("")
                    end
                else
                    local diff = (MARKET_TIMER.FRAME_COUNTER - MARKET_TIMER.TIMER) % 2 ^ 16
                    local val = MARKET_TIMER.TIMER_GOAL - diff
                    if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                        print(string.format(
                            "Updating market_timer with TIMER at %x and FRAME_COUNTER at %x  and diff %x and value %x",
                            MARKET_TIMER.TIMER, MARKET_TIMER.FRAME_COUNTER, diff, val))
                    end
                    if val <= 0 then
                        market_timer.CurrentStage = 2
                        if market_timer.SetOverlay then
                            market_timer:SetOverlay("")
                        end
                    else
                        market_timer.CurrentStage = 1
                        if market_timer.SetOverlay then
                            local secs = math.floor(val / MARKET_TIMER.FPS)
                            local mins = math.floor(secs / 60)
                            secs = secs % 60
                            if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                                print(string.format("Updating market_timer overlay to %s",
                                    string.format("%d:%02d", mins, secs)))
                            end
                            market_timer:SetOverlay(string.format("%d:%02d", mins, secs))
                        end
                    end
                end
            else
                market_timer.CurrentStage = 0
                market_timer:SetOverlay("")
            end
        end
    end
end

function updateFrameCounter(segment)
    if IS_GAME_RUNNING then
        local readResult = segment:ReadUInt16(MARKET_TIMER.FRAME_COUNTER_ADDR)
        MARKET_TIMER.FRAME_COUNTER = readResult;
        updateTimerObj()
    end
end

function updateTimerOverride(segment)
    if IS_GAME_RUNNING then
        local readResult = segment:ReadUInt8(MARKET_TIMER.OVERRIDE_FLAG_ADDR)
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
            print(string.format("Updating MARKET_TIMER.OVERRIDE_FLAG with %x", readResult))
        end
        MARKET_TIMER.OVERRIDE_FLAG = readResult & MARKET_TIMER.OVERRIDE_FLAG_OFFSET > 0;
        updateTimerObj()
    end
end

function updateLocWithVals(overworld_mapping, detailed_mapping)
    if not IS_GAME_RUNNING then
        return
    end
    local vals = {}
    addValsFromTable(vals, overworld_mapping)
    if IS_DETAILED then
        addValsFromTable(vals, detailed_mapping)
    end
    for code, count in pairs(vals) do
        local o = Tracker:FindObjectForCode(code)
        if o then
            o.AvailableChestCount = o.ChestCount - count
        end
    end
end

function updateGourds(segment)
    updateLocWithVals(GOURDS_OVERWORLD, GOURDS_DETAILED)
end

function updateSniffSpots(segment)
    updateLocWithVals(SNIFF_MAPPING_OVERWORLD, SNIFF_MAPPING_DETAILED)
end

function addValsFromTable(vals, table)
    for addr, codes in pairs(table) do
        local b = AutoTracker:ReadU8(addr) -- FIXME: this may be slow in emo
        for mask, code in pairs(codes) do
            if b & mask > 0 then
                if vals[code] then
                    vals[code] = vals[code] + 1
                else
                    vals[code] = 1;
                end
            end
        end
    end
    return vals
end

function updateAlchemyLocations(segment)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
        print(string.format("updateAlchemyLocations"));
    end
    if not IS_GAME_RUNNING then
        return
    end
    if IS_DETAILED then
        for addr, locs in pairs(ALCHEMY_LOCATIONS_DETAILED) do
            local readResult = segment:ReadUInt8(addr)
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                print(string.format("updateAlchemyLocations: Checking addr %x, readResult %x", addr, readResult));
            end
            for mask, code in pairs(locs) do
                local o = Tracker:FindObjectForCode(code)
                if o then
                    if code:sub(1, 1) == "@" then
                        if readResult & mask > 0 then
                            o.AvailableChestCount = 0;
                        else
                            o.AvailableChestCount = o.ChestCount
                        end
                    else
                        o.Active = readResult & mask > 0;
                    end
                end
            end
        end
    end
    for addr, locs in pairs(ALCHEMY_LOCATIONS_OVERWORLD) do
        local readResult = segment:ReadUInt8(addr)
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
            print(string.format("updateAlchemyLocations: Checking addr %x, readResult %x", addr, readResult));
        end
        for mask, code in pairs(locs) do
            local o = Tracker:FindObjectForCode(code)
            if o then
                if code:sub(1, 1) == "@" then
                    if readResult & mask > 0 then
                        o.AvailableChestCount = 0;
                    else
                        o.AvailableChestCount = o.ChestCount
                    end
                else
                    o.Active = readResult & mask > 0;
                end
            end
        end
    end
end

function updateCallBeadChars(segment)
    if IS_GAME_RUNNING then
        checkFlagsInSegmentUsingTable(segment, CALL_BEAD_CHARS_AUTOTRACKING, 3)
    end
end

function updateActiveRingMenu(segment)
    if not IS_GAME_RUNNING then
        return
    end
    local readResult = segment:ReadUInt16(ACTIVE_RING_MENU_ADDR)
    IS_CALL_BEAD_SPELLS_MENU = readResult + 0x7e0000 == CALL_BEAD_SPELLS_MENU_ADDR
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
        print(string.format("IS_CALL_BEAD_SPELLS_MENU set to %s", IS_CALL_BEAD_SPELLS_MENU))
    end
    updateCurrentCallBeadChar(nil)
    updateCallBeadSpells(nil)
end

function updateCurrentCallBeadChar(segment)
    if not IS_GAME_RUNNING or not IS_CALL_BEAD_SPELLS_MENU then
        return
    end
    local currentSelection = AutoTracker:ReadUInt16(CALL_BEAD_CHARS_MENU_ADDR + 2)
    local readResult = AutoTracker:ReadUInt16(CALL_BEAD_CHARS_MENU_ADDR + 4 + currentSelection * 2)
    CURRENT_CALL_BEAD_CHAR = CALL_BEAD_MENU_ITEM_OFFSETS[readResult]
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
        print(string.format("CURRENT_CALL_BEAD_CHAR set to %s", CURRENT_CALL_BEAD_CHAR))
    end
end

function updateCallBeadSpells(segment)
    if not IS_GAME_RUNNING or not IS_CALL_BEAD_SPELLS_MENU or not CURRENT_CALL_BEAD_CHAR or CALLBEADMIZER_MODE ~= 2 then
        return
    end
    local ringMenuSize = AutoTracker:ReadUInt16(CALL_BEAD_SPELLS_MENU_ADDR)
    if ringMenuSize < 3 or ringMenuSize > 5 then
        return
    end
    for i = 0, 4 do
        local obj = CB_SPELLS[(CURRENT_CALL_BEAD_CHAR - 1) * 5 + i]
        if obj then
            if i > ringMenuSize - 1 then
                if obj:getState() ~= 0 then
                    obj:setState(0)
                    obj:setActive(false)
                end
            else
                local readResult = AutoTracker:ReadUInt16(CALL_BEAD_SPELLS_MENU_ADDR + 4 + i * 2)
                if CALL_BEAD_MENU_ITEM_OFFSETS[readResult] then
                    if obj:getState() ~= CALL_BEAD_MENU_ITEM_OFFSETS[readResult] then
                        obj:setState(CALL_BEAD_MENU_ITEM_OFFSETS[readResult])
                        obj:setActive(true)
                    end
                else
                    if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                        print(string.format("Unknown index %s in CALL_BEAD_MENU_ITEM_OFFSETS", readResult))
                    end
                end
            end
        else
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                print(string.format("Unknown index %s in CB_SPELLS", (CURRENT_CALL_BEAD_CHAR - 1) * 5 + i))
            end
        end
    end
    CURRENT_CALL_BEAD_CHAR = nil
end

function updateWeaponLevels(segment)
    for k in pairs(WEAPON_LEVELS) do
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
            print(string.format("called updateWeaponLevels for %s: %x", k, WEAPON_LEVELS[k]))
        end
        local readResultLow = AutoTracker:ReadUInt8(WEAPON_LEVELS[k])
        local readResultHigh = AutoTracker:ReadUInt8(WEAPON_LEVELS[k] + 1)
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
            print(
                string.format("read results for %s weapon level: 0x%x high 0x%x low", k, readResultHigh, readResultLow))
        end
        local obj = Tracker:FindObjectForCode(k)
        if obj then
            local low = math.floor(readResultLow / 256 * 100)
            local high = readResultHigh
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                print(string.format("set weapon level for %s to %s:%00.f", k, high, low))
            end
            local str = string.format("%d:%d", high, low)
            obj:SetOverlay(str)
        end
    end
end

function updateDogAttackLevel(segment)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
        print(string.format("called updateDogAttackLevel"))
    end
    local readResultLow = AutoTracker:ReadUInt8(DOG_ATTACK_LVL_ADDR)
    local readResultHigh = AutoTracker:ReadUInt8(DOG_ATTACK_LVL_ADDR + 1)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
        print(string.format("read results for dog attack level: 0x%x high 0x%x low", readResultHigh, readResultLow))
    end
    local obj = Tracker:FindObjectForCode("dog")
    if obj then
        local low = math.floor(readResultLow / 256 * 100)
        local high = readResultHigh
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
            print(string.format("set weapon level for %s to %s:%00.f", k, high, low))
        end
        local str = string.format("%d:%d", high, low)
        obj:SetOverlay(str)
    end
end

function updateAlchemyLevels(segment)
    for i = 1, #ALCHEMY_NAMES do
        local obj = Tracker:FindObjectForCode(ALCHEMY_NAMES[i])
        if obj then
            local lowAddr = ALCHEMY_LEVELS_START_ADDR + 2 * (i - 1)
            local highAddr = lowAddr + 0x46
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                print(string.format("called updateAlchemyLevels for %d %s: %x low, %x high", i, ALCHEMY_NAMES[i],
                    lowAddr, highAddr))
            end
            local readResultLow = AutoTracker:ReadUInt16(lowAddr)
            local readResultHigh = AutoTracker:ReadUInt16(highAddr)
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                print(string.format("read results for %s alchemy level: 0x%x high 0x%x low", ALCHEMY_NAMES[i],
                    readResultHigh, readResultLow))
            end
            local low = readResultLow
            local high = readResultHigh
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                print(string.format("set alchemy level for %s to %s:%00.f", ALCHEMY_NAMES[i], high, low))
            end
            local str = string.format("%d:%d", high, low)
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                print(string.format("alchemy level: PopVersion: %s, PopVersion >= 0.18.0: %s", PopVersion,
                    PopVersion >= "0.18.0"))
            end
            if PopVersion and PopVersion >= "0.18.0" then
                if string.len(str) > 5 then
                    str = string.format("%d\n:%d", high, low)
                end
                obj:SetOverlayFontSize(10)
            else
                if string.len(str) > 5 then
                    obj:SetOverlayFontSize(math.floor(12 * (1 - (string.len(str) - 5) * 0.05)))
                else
                    obj:SetOverlayFontSize(10)
                end
            end
            obj:SetOverlay(str)
        end
    end
end

function updateMoney(segment)
    for i = 1, #MONEY_TYPES do
        local obj = Tracker:FindObjectForCode(MONEY_TYPES[i])
        if obj then
            local addr = MONEY_START_ADDR + 3 * (i - 1)
            local readResultLow16 = AutoTracker:ReadUInt16(addr)
            local readResultHigh8 = AutoTracker:ReadUInt8(addr + 2)
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                print(string.format("read results for %s amount: 0x%x low16 0x%x high8", MONEY_TYPES[i],
                    readResultLow16, readResultHigh8))
            end
            local amount = readResultLow16 + readResultHigh8 * 0x10000
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                print(string.format("set amount for %s to %i", MONEY_TYPES[i], amount))
            end
            local str = string.format("%i", amount)
            obj:SetOverlay(str)
            if string.len(str) > 5 then
                obj:SetOverlayFontSize(10)
                if string.len(str) > 6 then
                    obj:SetOverlayFontSize(9)
                end
            else
                obj:SetOverlayFontSize(12)
            end
        end
    end
end

function updateBoyExp(segment)
    local obj = Tracker:FindObjectForCode("boy_exp")
    local exp
    if obj then
        local readResultLow = AutoTracker:ReadUInt16(BOY_EXP_ADDR)
        local readResultHigh = AutoTracker:ReadUInt16(BOY_EXP_ADDR + 2)
        exp = readResultLow + readResultHigh * 65536
        obj:SetOverlay(string.format("Exp: %i", exp))
    end
    local objNext = Tracker:FindObjectForCode("boy_exp_next_lvl")
    if objNext then
        local readResultLowNext = AutoTracker:ReadUInt16(BOY_EXP_NEXT_LVL_ADDR)
        local readResultHighNext = AutoTracker:ReadUInt16(BOY_EXP_NEXT_LVL_ADDR + 2)
        local nextExp = (readResultLowNext + readResultHighNext * 65536) - exp
        objNext:SetOverlay(string.format("to next: %i", nextExp))
    end
end

function updateBoyLvl(segment)
    local obj = Tracker:FindObjectForCode("boy_lvl")
    if obj then
        local readResult = AutoTracker:ReadUInt16(BOY_LVL_ADDR)
        obj:SetOverlay(string.format("Level: %i", readResult))
    end
end

function updateDogExp(segment)
    local obj = Tracker:FindObjectForCode("dog_exp")
    local exp
    if obj then
        local readResultLow = AutoTracker:ReadUInt16(DOG_EXP_ADDR)
        local readResultHigh = AutoTracker:ReadUInt16(DOG_EXP_ADDR + 2)
        exp = readResultLow + readResultHigh * 65536
        obj:SetOverlay(string.format("Exp: %i", exp))
    end
    local objNext = Tracker:FindObjectForCode("dog_exp_next_lvl")
    if objNext then
        local readResultLowNext = AutoTracker:ReadUInt16(DOG_EXP_NEXT_LVL_ADDR)
        local readResultHighNext = AutoTracker:ReadUInt16(DOG_EXP_NEXT_LVL_ADDR + 2)
        local nextExp = (readResultLowNext + readResultHighNext * 65536) - exp
        objNext:SetOverlay(string.format("to next: %i", nextExp))
    end
end

function updateDogLvl(segment)
    local obj = Tracker:FindObjectForCode("dog_lvl")
    if obj then
        local readResult = AutoTracker:ReadUInt16(DOG_LVL_ADDR)
        obj:SetOverlay(string.format("Level: %i", readResult))
    end
end

function updateEnergyCoreFragments(segment)
    if Tracker:ProviderCountForCode("opt_energy_core_fragments") <= 0 then
        return
    end
    local obj = Tracker:FindObjectForCode("energy_core_fragments")
    if obj then
        local readResult = AutoTracker:ReadUInt16(ENERGY_CORE_FRAGMENTS_ADDR)
        obj.AcquiredCount = readResult
    end
end
