-- Configuration --------------------------------------
AUTOTRACKER_ENABLE_DEBUG_LOGGING = true
AUTOTRACKER_ENABLE_ITEM_TRACKING = true
AUTOTRACKER_ENABLE_LOCATION_TRACKING = false
-------------------------------------------------------

-- Globals --------------------------------------------
IS_GAME_RUNNING = true
if AUTOTRACKER_ENABLE_ITEM_TRACKING then
    WEAPONS = {
        addr = 0x7E22DA,
        --BYTE 1
        [0] = {
            --["unused_1"]      = 0x01,
            ["sword_1"]       = 0x02,
            ["sword_2"]       = 0x04,
            ["sword_3"]       = 0x08,
            ["sword_4"]       = 0x10,
            ["axe_1"]         = 0x20,
            ["axe_2"]         = 0x40,
            ["axe_3"]         = 0x80
        },
        --BYTE 2
        [1] = {
            ["axe_4"]         = 0x01,
            ["spear_1"]       = 0x02,
            ["spear_2"]       = 0x04,
            ["spear_3"]       = 0x08,
            ["spear_4"]       = 0x10,
            ["bazooka"]       = 0x20,
            --["aura"]          = 0x40,
            --["regenerate"]    = 0x80
        }
    }
    AMMO = {
        addr = 0x7E2345,
        ["ammo_1"] = 0x0,
        ["ammo_2"] = 0x1,
        ["ammo_3"] = 0x2,
    }
    ALCHEMY_SPELLS = {
        addr = 0x7E2258,
        --BYTE 1
        [0] = {
            ["acid_rain"] = 0x01,
            ["atlas"] = 0x02,
            ["barrier"] = 0x04,
            ["call_up"] = 0x08,
            ["corrosion"] = 0x10,
            ["crush"] = 0x20,
            ["cure"] = 0x40,
            ["defend"] = 0x80,
        },
        --BYTE 2
        [1] = {
            ["double_drain"] = 0x01,
            ["drain"] = 0x02,
            ["energize"] = 0x04,
            ["escape"] = 0x08,
            ["explosion"] = 0x10,
            ["fireball"] = 0x20,
            ["fire_power"] = 0x40,
            ["flash"] = 0x80,
        },
        --BYTE 3
        [2] = {
            ["force_field"] = 0x01,
            ["hard_ball"] = 0x02,
            ["heal"] = 0x04,
            ["lance"] = 0x08,
            --["laser"] = 0x10,
            ["levitate"] = 0x20,
            ["lightning_storm"] = 0x40,
            ["miracle_cure"] = 0x80,
        },
        --BYTE 4
        [3] = {
            ["nitro"] = 0x01,
            ["one_up"] = 0x02,
            ["reflect"] = 0x04,
            ["regrowth"] = 0x08,
            ["revealer"] = 0x10,
            ["revive"] = 0x20,
            ["slow_burn"] = 0x40,
            ["speed"] = 0x80,
        },
        --BYTE 5
        [4] = {
            ["sting"] = 0x01,
            ["stop"] = 0x02,
            ["super_heal"] = 0x04,
            --["unused_1"] = 0x08,
            --["unused_2"] = 0x10,
            --["unused_3"] = 0x20,
            --["unused_4"] = 0x40,
            --["horace"] = 0x80,
        },
        --BYTE 6
        [5] = {
            --["camellia"] = 0x01,
            --["sidney"] = 0x02,
            --["unused_5"] = 0x04,
            --["unused_6"] = 0x08,
            --["unused_7"] = 0x10,
            --["unused_8"] = 0x20,
            --["unused_9"] = 0x40,
            --["unused_10"] = 0x80
        },
    }
    CHARMS = {
        addr = 0x7E2261,
        --BYTE 1
        [0] = {
            --["unused_1"] = 0x01,
            --["unused_2"] = 0x02,
            --["unused_3"] = 0x04,
            --["unused_4"] = 0x08,
            --["unused_5"] = 0x10,
            ["armor_polish"] = 0x20,
            ["chocobo_egg"] = 0x40,
            ["insect_incense"] = 0x80,
        },
        --BYTE 2
        [1] = {
            ["jade_disk"] = 0x01,
            ["jaguar_ring"] = 0x02,
            ["magic_gourd"] = 0x04,
            ["moxa_stick"] = 0x08,
            ["oracle_bone"] = 0x10,
            ["ruby_heart"] = 0x20,
            ["silver_sheath"] = 0x40,
            ["staff_of_life"] = 0x80,
        },    
        --BYTE 3
        [2] = {
            ["sun_stone"] = 0x01,
            ["thugs_cloak"] = 0x02,
            ["wizards_coin"] = 0x04,
            --["unused_6"] = 0x08,
            --["unused_7"] = 0x10,
            --["unused_8"] = 0x20,
            --["unused_9"] = 0x40,
            --["unused_10"] = 0x80
        }
    }
    KEY_ITEMS = {
        addr = 0x7E2264,
        --BYTE 1
        [0] = {
            --["unused_1"] = 0x01,
            --["unused_2"] = 0x02,
            --["gauge"] = 0x04,
            --["wheel"] = 0x08,
            ["queens_key"] =  0x10,
            --["energy_core"] = 0x20,
            --["unused_3"] = 0x40,
            --["unused_4"] = 0x80
        }
    }
    KEY_ITEMS_2 = { --used for given way keyitems
        addr = 0x7E22DC,
        --BYTE 0x7E22DC
        [0x0] = {        
            ["gauge"] =  0x10,
            ["wheel"] = 0x20,
        },
    }    
    KEY_ITEMS_3 = { --used for given way keyitems
        addr = 0x7E22F9,
        --BYTE 0x7E22F9
        [0x0] = {
            ["energy_core"] = 0x20,
        },
    }
    GAVE_AWAY_DES = false
    GAVE_AWAY_WHEEL = false
    GAVE_AWAY_GAUGE = false
    GAVE_AWAY_CORE = false
    HAS_DE = 0
    HAS_WHEEL = false
    HAS_GAUGE = false
    HAS_CORE = false
    AEROGLIDER_ADDR = 0x7E2355
    ROCKET_ADDR = 0x7E22DC
    BOSSES_1 = {
        addr = 0x7E225C,
        -- BYTE 0x7E225C
        [0x0] = { 
            ["aquagoth"] = 0x08,
            ["viper_commander_2"] = 0x10,
            ["mad_monk"] = 0x20,
        },
        [0x2] = {
            ["salabog"] = 0x80
        },
        --BYTE 0x7E225F
        [0x3] = {
            ["viper_commander_1"] = 0x04, --ToDo: verify
            ["vigor"] = 0x20,
        },
        --BYTE 0x7E2260
        [0x4] = {
            ["thraxx"] = 0x10,
            ["magmar"] = 0x40,
        }
    }
    BOSSES_2 = {
        addr = 0x7E22D8,
        --BYTE 0x7E22D8
        [0x0] = {
            ["rimsala"] = 0x40,
            ["megataur"] = 0x80,
        },
        --BYTE 0x7E22D9
        [0x1] = {
            ["aegis"] = 0x08,
        },
        --BYTE 0x7E22DD
        [0x5] = {
            ["verminator"] = 0x01,
            ["sterling"] = 0x02,
            ["timberdrake"] = 0x4
        },
        --BYTE 0x7E22DF
        [0x7] = {
            ["bad_boys"] = 0x01,
            ["raptors"] = 0x80
        },
        --BYTE 0x7E22E2
        [0xA] = {
            ["sons_of_sth"] = 0x40
        },
        --BYTE 0x7E22E3
        [0xB] = {
            ["tiny"] = 0x20
        },
        --BYTE 0x7E22E5
        [0xD] = {
            ["mungola"] = 0x40
        },
        --BYTE 0x7E22E6
        [0xE] = {
            ["footknight"] = 0x01,
            ["face"] = 0x80 
        },
        --BYTE 0x7E22E8
        [0x10] = {
            ["coleoptera"] = 0x40
        },
        --BYTE 0x7E22E9
        [0x11] = {
            ["mini_taur"] = 0x40
        },    
        --BYTE 0x7E22F3
        [0x1B] = {
            --["salabog"] = 0x20
        },
    }
    CARLTRON_ADDR = 0x7E22F1
    MARKET_TIMER = {
        TIMER_ADDR = 0x7E2513,
        TIMER = 0,
        TIMER_GOAL = 0xc4e0,
        TIMER_OVERFLOW = 0x3b1f,
        FRAME_COUNTER_ADDR = 0x7E0B19,
        FRAME_COUNTER = 0,
        FPS = 60.098475521,
        OVERRIDE_FLAG_ADDR = 0x7E225D,
        OVERRIDE_FLAG_OFFSET = 0x08,
        OVERRIDE_FLAG = false
    }
end
if AUTOTRACKER_ENABLE_LOCATION_TRACKING then
    --ToDo
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
function updateGameState()
    --ToDo
    IS_GAME_RUNNING = true
end

function checkConsumablesInSegmentUsingTable(segment, table)
    local addr = table.addr
    for k,v in pairs(table) do
        if k ~= "addr" then
            local readResult = segment:ReadUInt8(addr+v)            
            local obj = Tracker:FindObjectForCode(k)
            if obj then
                obj.AcquiredCount = readResult
            end
        end
    end
end

function checkFlagsInSegmentUsingTable(segment, table)
    checkFlagsInSegmentUsingTable(segment,table,0)
end

function checkFlagsInSegmentUsingTable(segment, table, checkmode)
    local addr = table.addr
    for i,byte in pairs(table) do
        if i ~= "addr" then
            local readResult = segment:ReadUInt8(addr+i)
            for k,v in pairs(byte) do
                local obj = Tracker:FindObjectForCode(k)
                if obj then
                    if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                        print(string.format("Updating obj %s with value %x from addr %x on %x using checkmode %s",k,readResult,addr+i,v, checkmode))
                    end
                    if not checkmode or checkmode == 0 then
                        obj.Active = readResult & v > 0
                    elseif checkmode == 1 then
                        obj.Active = obj.Active or readResult & v > 0
                    end
                end
            end
        end
    end
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
        checkFlagsInSegmentUsingTable(segment, ALCHEMY_SPELLS)
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

function updateCarltron(segment)
    if IS_GAME_RUNNING then
        local readResult = segment:ReadUInt16(CARLTRON_ADDR)
        local carltrons_robot = Tracker:FindObjectForCode("carltrons_robot")
        if carltrons_robot then
            carltrons_robot.Active = readResult & 0x0001 > 0
        end
    end
end

function updateKeyItems(segment)
    if IS_GAME_RUNNING then
        local readResult = segment:ReadUInt8(KEY_ITEMS.addr)
        local diamond_eyes = Tracker:FindObjectForCode("diamond_eyes")
        if diamond_eyes then            
            HAS_DE = readResult & 0x01 + readResult & 0x02
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                print(string.format("Updating diamond_eyes with value %iand gave away flag %s",HAS_DE,GAVE_AWAY_DES))
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
                else
                    local diff = (MARKET_TIMER.FRAME_COUNTER - MARKET_TIMER.TIMER) % 2^16
                    local val = MARKET_TIMER.TIMER_GOAL - diff
                    if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                        print(string.format("Updating market_timer with TIMER at %x and FRAME_COUNTER at %x  and diff %x and value %x",MARKET_TIMER.TIMER,MARKET_TIMER.FRAME_COUNTER,diff,val))
                    end
                    if val <= 0 then
                        market_timer.CurrentStage = 1
                    else
                        market_timer.CurrentStage = 0
                        if market_timer.SetOverlay then
                            local secs = math.floor(val/MARKET_TIMER.FPS)
                            local mins = math.floor(secs/60)
                            secs = secs%60
                            if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                                print(string.format("Updating market_timer overlay to %s",string.format("%d:%02d",mins,secs)))
                            end
                            market_timer.SetOverlay(string.format("%d:%02d",mins,secs))
                        end
                    end
                end
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
-------------------------------------------------------
-- Memory Watches -------------------------------------
--ScriptHost:AddMemoryWatch("CheckGameState",  , , updateGameState)
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
    ScriptHost:AddMemoryWatch("Carltron", CARLTRON_ADDR , 0x2, updateCarltron)
    ScriptHost:AddMemoryWatch("Timer", MARKET_TIMER.TIMER_ADDR , 0x2, updateTimer)
    ScriptHost:AddMemoryWatch("FrameCounter", MARKET_TIMER.FRAME_COUNTER_ADDR , 0x2, updateFrameCounter)
    ScriptHost:AddMemoryWatch("TimerDoneOverride",MARKET_TIMER.OVERRIDE_FLAG_ADDR, 0x1, updateTimerOverride )
end
if AUTOTRACKER_ENABLE_LOCATION_TRACKING then
    --ToDo
end
-------------------------------------------------------