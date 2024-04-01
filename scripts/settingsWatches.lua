function updateTurdoMode(code)
    local val = Tracker:ProviderCountForCode("turdo_on") > 0
    if val then
        Tracker:AddLayouts("layouts/items_turdo.json")
    else
        Tracker:AddLayouts("layouts/items.json")
    end
    ScriptHost:LoadScript("scripts/autotracking/items/alchemy.lua")
end

function updateStatsTracking(code)
    AUTOTRACKER_ENABLE_STAT_TRACKING = (Tracker:ProviderCountForCode("stats_tracking_on") > 0) and
        AUTOTRACKER_ENABLE_ITEM_TRACKING
    if AUTOTRACKER_ENABLE_STAT_TRACKING then
        Tracker:AddLayouts("layouts/items_stats.json")
    else
        Tracker:AddLayouts("layouts/items.json")
    end
    for k, v in ipairs(ALCHEMY_NAMES) do
        local obj = Tracker:FindObjectForCode(v)
        if obj then
            obj:SetOverlay("")
        end
    end
    for k, v in pairs(WEAPON_LEVELS) do
        local obj = Tracker:FindObjectForCode(k)
        if obj then
            obj:SetOverlay("")
        end
    end
    disableWatches()
    enableWatches()
end

-- function updateKeyitemCountTracking(code)
--     AUTOTRACKER_ENABLE_KEYITEM_COUNT_TRACKING = (Tracker:ProviderCountForCode("keyitem_count_tracking") > 0) and
--                                            AUTOTRACKER_ENABLE_ITEM_TRACKING and AUTOTRACKER_ENABLE_LOCATION_TRACKING
--     if AUTOTRACKER_ENABLE_KEYITEM_COUNT_TRACKING then
--         Tracker:AddLayouts("layouts/items_stats.json")
--     else
--         Tracker:AddLayouts("layouts/items.json")
--     end
--     for k, v in ipairs(ALCHEMY_NAMES) do
--         local obj = Tracker:FindObjectForCode(v)
--         if obj then
--             obj:SetOverlay("")
--         end
--     end
--     for k, v in pairs(WEAPON_LEVELS) do
--         local obj = Tracker:FindObjectForCode(k)
--         if obj then
--             obj:SetOverlay("")
--         end
--     end
--     disableWatches()
--     enableWatches()
-- end

function updateCallbeadamizer(code)
    local val = Tracker:ProviderCountForCode("callbeadamizer_on") + Tracker:ProviderCountForCode("callbeadamizer_chaos")
    CALLBEADMIZER_MODE = val
    for i = 0, 3 do
        CB_CHARS[i]:setProperty("enableChildToggle", val == 0)
        CB_CHARS[i]:setProperty("enableChildProgression", val < 2)
        CB_CHARS[i]:setActive(i == 0)
        if val == 0 or val == 2 then
            CB_CHARS[i]:setState(i + 1)
            CB_CHARS[i]:setProperty("disableProgessive", true)
        else
            CB_CHARS[i]:setState(0)
            CB_CHARS[i]:setProperty("disableProgessive", false)
        end
    end
    if val == 0 then
        for i = 0, 3 do
            for j = 0, 4 do
                -- CB_SPELLS[i*5+j]:setProperty("active",CB_CHARS[i]:getProperty("active"))
                CB_SPELLS[i * 5 + j]:setProperty("disableProgessive", true)
                if CB_CHARS[i]:getState() ~= 2 or j < 3 then
                    CB_SPELLS[i * 5 + j]:setProperty("disableToggle", true)
                end
            end
        end
    else
        for i = 0, 3 do
            for j = 0, 4 do
                CB_SPELLS[i * 5 + j]:setActive(false)
                CB_SPELLS[i * 5 + j]:setState(0)
                CB_SPELLS[i * 5 + j]:setProperty("disableProgessive", val == 1)
                CB_SPELLS[i * 5 + j]:setProperty("disableToggle", false)
            end
        end
    end
end

function updateEnergyCoreFragmentsSetting()
    if Tracker:ProviderCountForCode("opt_energy_core_fragments") > 0 then
        updateEnergyCoreFragments()
    end
end

function updatePoolDistribution()
    print("updatePoolDistribution", "called")
    local alchemizer = Tracker:FindObjectForCode("opt_alchemizer")
    local boss_drops = Tracker:FindObjectForCode("opt_boss_drops")
    local gourdomizer = Tracker:FindObjectForCode("opt_gourdomizer")
    local sniffamizer = Tracker:FindObjectForCode("opt_sniffamizer")
    local pool = Tracker:FindObjectForCode("opt_pool")
    local energy_core = Tracker:FindObjectForCode("opt_energy_core")
    local gourd_keyitems = Tracker:FindObjectForCode("gourd_keyitems")
    local boss_keyitems = Tracker:FindObjectForCode("boss_keyitems")
    local alchemy_keyitems = Tracker:FindObjectForCode("alchemy_keyitems")
    local sniff_keyitems = Tracker:FindObjectForCode("sniff_keyitems")
    if not gourdomizer or not boss_drops or not alchemizer or not pool or not energy_core or not gourd_keyitems or
        not boss_keyitems or not alchemy_keyitems or not sniff_keyitems or not sniffamizer then
        print("updatePoolDistribution", "didn't find all objects")
        return
    end
    if alchemizer.CurrentStage ~= 2 or (alchemizer.CurrentStage == 2 and (pool.CurrentStage == 0 or boss_drops.CurrentStage ~= 2 and gourdomizer.CurrentStage ~= 2 and sniffamizer.CurrentStage ~= 2)) then
        alchemy_keyitems:SetOverlay("2")
    elseif pool.CurrentStage == 2 and boss_drops.CurrentStage == 2 then
        alchemy_keyitems:SetOverlay("0")
    else
        alchemy_keyitems:SetOverlay("?")
    end
    if boss_drops.CurrentStage ~= 2 or (boss_drops.CurrentStage == 2 and (pool.CurrentStage == 0 or alchemizer.CurrentStage ~= 2 and gourdomizer.CurrentStage ~= 2 and sniffamizer.CurrentStage ~= 2)) then
        boss_keyitems:SetOverlay("11")
    elseif pool.CurrentStage == 2 then
        local count = 11
        if alchemizer.CurrentStage == 2 then
            count = count + 2
        end
        if gourdomizer.CurrentStage == 2 then
            count = count + 4
            if energy_core.CurrentStage == 1 then
                count = count + 1
            end
        end
        boss_keyitems:SetOverlay(tostring(count))
    elseif pool.CurrentStage == 1 then
        boss_keyitems:SetOverlay("?")
    end
    if gourdomizer.CurrentStage ~= 2 or (gourdomizer.CurrentStage == 2 and (pool.CurrentStage == 0 or alchemizer.CurrentStage ~= 2 and boss_drops.CurrentStage ~= 2 and sniffamizer.CurrentStage ~= 2)) then
        if energy_core.CurrentStage == 1 then
            gourd_keyitems:SetOverlay("5")
        else
            gourd_keyitems:SetOverlay("4")
        end
    elseif pool.CurrentStage == 2 and boss_drops.CurrentStage == 2 then
        gourd_keyitems:SetOverlay("0")
    else
        gourd_keyitems:SetOverlay("?")
    end
    if sniffamizer.CurrentStage ~= 2 or pool.CurrentStage ~= 1 then
        sniff_keyitems:SetOverlay("0")
    else
        sniff_keyitems:SetOverlay("?")
    end
end

updateCallbeadamizer("")
updatePoolDistribution()
if PopVersion > "0.1.0" then
    ScriptHost:AddWatchForCode("updateTurdoMode", "turdo", updateTurdoMode)
    ScriptHost:AddWatchForCode("updateStatsTracking", "stats_tracking", updateStatsTracking)
    ScriptHost:AddWatchForCode("updateCallbeadamizer", "callbeadamizer", updateCallbeadamizer)
    ScriptHost:AddWatchForCode("updateEnergyCoreFragments", "opt_energy_core_fragments",
        updateEnergyCoreFragmentsSetting)
    ScriptHost:AddWatchForCode("updatePoolDistribution1", "opt_gourdomizer", updatePoolDistribution)
    ScriptHost:AddWatchForCode("updatePoolDistribution2", "opt_boss_drops", updatePoolDistribution)
    ScriptHost:AddWatchForCode("updatePoolDistribution3", "opt_alchemizer", updatePoolDistribution)
    ScriptHost:AddWatchForCode("updatePoolDistribution4", "opt_pool", updatePoolDistribution)
    ScriptHost:AddWatchForCode("updatePoolDistribution5", "opt_energy_core", updatePoolDistribution)
    ScriptHost:AddWatchForCode("updatePoolDistribution6", "opt_sniffamizer", updatePoolDistribution)
end
