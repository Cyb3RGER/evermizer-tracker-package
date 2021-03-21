function updateGameState()
    --ToDo
    IS_GAME_RUNNING = true
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
        checkFlagsInSegmentUsingTable(segment, ALCHEMY_SPELLS, 2)
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
            rocket.Active = readResult & 0x70 > 0
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
    for addr,gourds in pairs(GOURDS) do
        local b = AutoTracker:ReadU8(addr) -- FIXME: this may be slow in emo
        for mask,code in pairs(gourds) do
            if b&mask>0 then
                if vals[code] then vals[code] = vals[code] + 1
                else vals[code] = 1; end
            end
        end
    end
    for code,count in pairs(vals) do
        local o = Tracker:FindObjectForCode(code)
        if o then
            o.AvailableChestCount = o.ChestCount - count
        end
    end
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
    local code = ALCHEMY_LOCATIONS[ALCHEMY_LOCATION_MAPPING[name]]
    if code then
        local obj = Tracker:FindObjectForCode(code)
        if obj then
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                print(string.format("Updating alchemy location %s with state %s",name,not state and 1 or 0))
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