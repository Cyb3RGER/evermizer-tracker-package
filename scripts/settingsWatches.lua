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

updateCallbeadamizer("")
if PopVersion > "0.1.0" then
    ScriptHost:AddWatchForCode("updateTurdoMode", "turdo", updateTurdoMode)
    ScriptHost:AddWatchForCode("updateStatsTracking", "stats_tracking", updateStatsTracking)
    ScriptHost:AddWatchForCode("updateCallbeadamizer", "callbeadamizer", updateCallbeadamizer)
    ScriptHost:AddWatchForCode("updateEnergyCoreFragments", "opt_energy_core_fragments", updateEnergyCoreFragmentsSetting)         
end