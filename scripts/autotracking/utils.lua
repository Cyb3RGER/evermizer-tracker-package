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
                    if not checkmode or checkmode == 0 or checkmode ==2 then
                        obj.Active = readResult & v > 0
                        if checkmode == 2 then
                            updateAlchemyLocation(k,obj.Active)
                        end
                    elseif checkmode == 1 then
                        obj.Active = obj.Active or readResult & v > 0
                    end
                end
            end
        end
    end
end