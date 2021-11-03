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
                if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                    print(string.format("Updating obj %s with value %x from addr %x on %x using checkmode %s",k,readResult,addr+i,v, checkmode))
                end
                if not checkmode or checkmode == 0 or checkmode == 2 then
                    if checkmode == 2 then
                        local found = false
                        for k2,v2 in pairs(ALCHEMY_SPELLS_TURDO) do
                            for _,v3 in pairs(v2) do
                                if (k == v3) then
                             
                                    if not ALCHEMY_SPELLS_TURDO_FOUND[k2] then ALCHEMY_SPELLS_TURDO_FOUND[k2] = 0 end
                                    if readResult & v > 0 then
                                        if AUTOTRACKER_ENABLE_DEBUG_LOGGING then
                                            print(string.format("Found active turdo spell %s for %s",k,k2))
                                        end
                                        ALCHEMY_SPELLS_TURDO_FOUND[k2] = ALCHEMY_SPELLS_TURDO_FOUND[k2] + 1
                                    end
                                    found = true
                                    break
                                end
                            end
                            if found then break end
                        end
                    end
                    local obj = Tracker:FindObjectForCode(k)
                    if obj then
                        obj.Active = readResult & v > 0
                    end
                elseif checkmode == 1 then
                    local obj = Tracker:FindObjectForCode(k)
                    if obj then
                        obj.Active = obj.Active or readResult & v > 0
                    end
                elseif checkmode == 3 then
                    local obj = Tracker:FindObjectForCode(k)
                    if obj then
                        obj.ItemState:setActive(readResult & v > 0)
                    end
                end
            end
        end
    end
end
