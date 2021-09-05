function updateGameState(segment)
    local readResult = segment:ReadUInt8(GAME_STATE.addr)
    IS_GAME_RUNNING = readResult & GAME_STATE.value > 0
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
        print(string.format("readResult: %x, Game State is %s. Enabled Watches is %s.",readResult, IS_GAME_RUNNING, ENABLED_WATCHES))
    end
    if (IS_GAME_RUNNING and not ENABLED_WATCHES)  then
        enableWatches()
    elseif (not IS_GAME_RUNNING and ENABLED_WATCHES) then
        disableWatches()
    end

end

function updateCurrentRoom(segment)
    CURRENT_ROOM = segment:ReadUInt8(CURRENT_ROOM_ADDR)
    print(string.format("CURRENT_ROOM is now %x", CURRENT_ROOM))
    updateUI()
end

function updateUI()
    if not IS_GAME_RUNNING then return end
    if CURRENT_ROOM >= 0x7b and CURRENT_ROOM <= 0x7d then
        if EBON_KEEP_FLAG then
            print(string.format("Setting ActivateTab to %s", "Ebon Keep"))
            Tracker:UiHint("ActivateTab","Ebon Keep")
        else
            print(string.format("Setting ActivateTab to %s", "Ivor Tower"))
            Tracker:UiHint("ActivateTab","Ivor Tower")
        end
    elseif ROOM_MAPPING[CURRENT_ROOM] then
        if #ROOM_MAPPING[CURRENT_ROOM] == 2 then
            print(string.format("Setting ActivateTab to %s", ROOM_MAPPING[CURRENT_ROOM][2]))
            Tracker:UiHint("ActivateTab",ROOM_MAPPING[CURRENT_ROOM][2])
        end
        print(string.format("Setting ActivateTab to %s", ROOM_MAPPING[CURRENT_ROOM][1]))
        Tracker:UiHint("ActivateTab",ROOM_MAPPING[CURRENT_ROOM][1])
    else
        print(string.format("In unmapped room %x",CURRENT_ROOM))
    end
end

function updateEbonKeepFlag(segment)
    if not IS_GAME_RUNNING then return end
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
        for k,v in pairs(ALCHEMY_SPELLS_TURDO_FOUND) do
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
                print(string.format("Updating diamond_eyes with value %i and gave away flag %s",HAS_DE,GAVE_AWAY_DES))
            end
            if GAVE_AWAY_DES then
                diamond_eyes.CurrentStage = readResult & 0x01 + 2
            else
                diamond_eyes.CurrentStage = HAS_DE
            end
            
        end
        local gauge = Tracker:FindObjectForCode("gauge")
        if gauge then
            HAS_GAUGE = readResult & 0x04 > 0
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                print(string.format("Updating gauge with value %s and gave away flag %s",HAS_GAUGE,GAVE_AWAY_GAUGE))
            end
            gauge.Active = HAS_GAUGE or GAVE_AWAY_GAUGE
        end
        local wheel = Tracker:FindObjectForCode("wheel")
        if wheel then
            HAS_WHEEL = readResult & 0x08 > 0
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                print(string.format("Updating wheel with value %s and gave away flag %s",HAS_WHEEL,GAVE_AWAY_WHEEL))
            end
            wheel.Active = HAS_WHEEL or GAVE_AWAY_WHEEL
        end
        local energy_core = Tracker:FindObjectForCode("energy_core")
        if energy_core then
            HAS_CORE = readResult & 0x20 > 0
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                print(string.format("Updating energy_core with value %s and gave away flag %s",HAS_CORE,GAVE_AWAY_CORE))
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
        if diamond_eyes then
            GAVE_AWAY_DES = readResult & 0x40 > 0
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                print(string.format("Updating diamond_eyes with value %s and gave away flag %s",HAS_DE,GAVE_AWAY_DES))
            end
            if HAS_DE ~= diamond_eyes.CurrentStage then
                diamond_eyes.CurrentStage = HAS_DE
            end
            if HAS_DE <= 2 and GAVE_AWAY_DES then
                diamond_eyes.CurrentStage = 2 + HAS_DE
            end
        end
        local gauge = Tracker:FindObjectForCode("gauge")
        if gauge then
            GAVE_AWAY_GAUGE = readResult & 0x10 > 0
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                print(string.format("Updating gauge with value %s and gave away flag %s",HAS_GAUGE,GAVE_AWAY_GAUGE))
            end
            gauge.Active = HAS_GAUGE or GAVE_AWAY_GAUGE
        end
        local wheel = Tracker:FindObjectForCode("wheel")
        if wheel then
            GAVE_AWAY_WHEEL = readResult & 0x20 > 0
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                print(string.format("Updating wheel with value %s and gave away flag %s",HAS_WHEEL,GAVE_AWAY_WHEEL))
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
                print(string.format("Updating energy_core with value %s and gave away flag %s",HAS_CORE,GAVE_AWAY_CORE))
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
        local vigor = Tracker:FindObjectForCode("vigor") --Also an override flag but we get this thru boss flags
        local market_timer = Tracker:FindObjectForCode("market_timer")
        if market_timer then
            local isDone = vigor.Active or MARKET_TIMER.OVERRIDE_FLAG
            local hasStarted = MARKET_TIMER.TIMER > 0
            market_timer.Active = hasStarted or isDone
            if hasStarted then
                if isDone then
                    market_timer.CurrentStage = 1
                    if market_timer.SetOverlay then
                        market_timer:SetOverlay("")
                    end
                else
                    local diff = (MARKET_TIMER.FRAME_COUNTER - MARKET_TIMER.TIMER) % 2^16
                    local val = MARKET_TIMER.TIMER_GOAL - diff
                    if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                        print(string.format("Updating market_timer with TIMER at %x and FRAME_COUNTER at %x  and diff %x and value %x",MARKET_TIMER.TIMER,MARKET_TIMER.FRAME_COUNTER,diff,val))
                    end
                    if val <= 0 then
                        market_timer.CurrentStage = 1
                        if market_timer.SetOverlay then
                            market_timer:SetOverlay("")
                        end
                    else
                        market_timer.CurrentStage = 0
                        if market_timer.SetOverlay then
                            local secs = math.floor(val/MARKET_TIMER.FPS)
                            local mins = math.floor(secs/60)
                            secs = secs%60
                            if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                                print(string.format("Updating market_timer overlay to %s",string.format("%d:%02d",mins,secs)))
                            end
                            market_timer:SetOverlay(string.format("%d:%02d",mins,secs))
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
            print(string.format("Updating MARKET_TIMER.OVERRIDE_FLAG with %x",readResult))
        end
        MARKET_TIMER.OVERRIDE_FLAG = readResult & MARKET_TIMER.OVERRIDE_FLAG_OFFSET > 0;
        updateTimerObj()
    end
end

function updateGourds(segment)
    if not IS_GAME_RUNNING then return end
    local vals = {}
    addGourdValsFromTable(vals, GOURDS_OVERWORLD)
    if IS_DETAILED then
        addGourdValsFromTable(vals, GOURDS_DETAILED) 
    end
    for code,count in pairs(vals) do
        local o = Tracker:FindObjectForCode(code)
        if o then
            o.AvailableChestCount = o.ChestCount - count
        end
    end
end

function addGourdValsFromTable(vals, table)
    for addr,gourds in pairs(table) do
        local b = AutoTracker:ReadU8(addr) -- FIXME: this may be slow in emo
        for mask,code in pairs(gourds) do
            if b&mask>0 then
                if vals[code] then vals[code] = vals[code] + 1
                else vals[code] = 1; end
            end
        end
    end
    return vals
end

function updateAlchemyLocations()
    if not IS_GAME_RUNNING or not ALCHEMY_LOCATION_MAPPING then return end
    for k,v in pairs(ALCHEMY_IDS) do
        local obj = Tracker:FindObjectForCode(v)
        if obj then
            updateAlchemyLocation(v,obj.Active)
        end
    end
end

function updateAlchemyLocation(name, state)
    if not IS_GAME_RUNNING or not ALCHEMY_LOCATION_MAPPING then return end
    getAndUpdateAlchemyLocation(ALCHEMY_LOCATIONS_OVERWORLD[ALCHEMY_LOCATION_MAPPING[name]], state)
    if IS_DETAILED then
        getAndUpdateAlchemyLocation(ALCHEMY_LOCATIONS_DETAILED[ALCHEMY_LOCATION_MAPPING[name]], state) 
    end
end

function getAndUpdateAlchemyLocation(code, state)
    if code then
        local obj = Tracker:FindObjectForCode(code)
        if obj then
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                print(string.format("Updating alchemy location %s with state %s",code,not state and 1 or 0))
            end
            if string.find(code,"@") then
                obj.AvailableChestCount = not state and 1 or 0
            else
                obj.Active = state
            end
        end
    end
end

function updateAlchemyMappings(segment)
    if not IS_GAME_RUNNING then return end
    ALCHEMY_LOCATION_MAPPING = {}
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
        print("Alchemy mapping:")
    end
    for k, v in pairs(ALCHEMY_LOCATIONS_FLAGS) do
        local readResult = AutoTracker:ReadU16(v) -- FIXME: this may be slow in emo (how cares really?)
        local name = ALCHEMY_IDS[readResult]
        if not name then
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                print("",string.format("invalid id found %x at addr %x",readResult,0x80000+v))
            end
            ALCHEMY_LOCATION_MAPPING = nil
            return
        end
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
            print("",string.format("%s is at %x",name,k))
        end
        ALCHEMY_LOCATION_MAPPING[name] = k
    end
    updateAlchemyLocations()
end

function updateCallBeadChars(segment)
    if IS_GAME_RUNNING then
        checkFlagsInSegmentUsingTable(segment, CALL_BEAD_CHARS_AUTOTRACKING, 3)
    end
end

function updateActiveRingMenu(segment)
    if not IS_GAME_RUNNING then return end
    local readResult = segment:ReadUInt16(ACTIVE_RING_MENU_ADDR)
    IS_CALL_BEAD_SPELLS_MENU = readResult+0x7e0000 == CALL_BEAD_SPELLS_MENU_ADDR
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
        print(string.format("IS_CALL_BEAD_SPELLS_MENU set to %s", IS_CALL_BEAD_SPELLS_MENU))
    end    
    updateCurrentCallBeadChar(nil)
    updateCallBeadSpells(nil)
end

function updateCurrentCallBeadChar(segment)
    if not IS_GAME_RUNNING or not IS_CALL_BEAD_SPELLS_MENU then return end
    local currentSelection = AutoTracker:ReadUInt16(CALL_BEAD_CHARS_MENU_ADDR+2)
    local readResult = AutoTracker:ReadUInt16(CALL_BEAD_CHARS_MENU_ADDR+4+currentSelection*2)
    CURRENT_CALL_BEAD_CHAR = CALL_BEAD_MENU_ITEM_OFFSETS[readResult]
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
        print(string.format("CURRENT_CALL_BEAD_CHAR set to %s", CURRENT_CALL_BEAD_CHAR))
    end
end

function updateCallBeadSpells(segment)
    if not IS_GAME_RUNNING or not IS_CALL_BEAD_SPELLS_MENU or not CURRENT_CALL_BEAD_CHAR or CALLBEADMIZER_MODE ~= 2 then return end
    local ringMenuSize = AutoTracker:ReadUInt16(CALL_BEAD_SPELLS_MENU_ADDR)
    if ringMenuSize < 3 or ringMenuSize > 5 then return end
    for i = 0, 4 do
        local obj = CB_SPELLS[(CURRENT_CALL_BEAD_CHAR-1)*5+i]
        if obj then        
            if i > ringMenuSize-1 then
                if obj:getState() ~= 0 then
                    obj:setState(0)
                    obj:setActive(false)
                end
            else
                local readResult = AutoTracker:ReadUInt16(CALL_BEAD_SPELLS_MENU_ADDR+4+i*2)
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
                print(string.format("Unknown index %s in CB_SPELLS", (CURRENT_CALL_BEAD_CHAR-1)*5+i))
            end
        end
        
    end
    CURRENT_CALL_BEAD_CHAR = nil
end