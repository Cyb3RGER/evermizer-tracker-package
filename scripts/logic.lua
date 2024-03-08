function canCutBushes()
    local value = Tracker:ProviderCountForCode("sword_2") + Tracker:ProviderCountForCode("sword_3") +
                      Tracker:ProviderCountForCode("sword_4") + Tracker:ProviderCountForCode("axe_1") +
                      Tracker:ProviderCountForCode("axe_2") + Tracker:ProviderCountForCode("axe_3") +
                      Tracker:ProviderCountForCode("axe_4") + Tracker:ProviderCountForCode("spear_1") +
                      Tracker:ProviderCountForCode("spear_2") + Tracker:ProviderCountForCode("spear_3") +
                      Tracker:ProviderCountForCode("spear_4")

    if ENABLE_DEBUG_LOG then
        print("canCutBushes: value: " .. value)
    end

    if (value > 0) then
        return 1
    end

    return 0
end

function hasNonSword()
    local value = Tracker:ProviderCountForCode("axe_1") + Tracker:ProviderCountForCode("axe_2") +
                      Tracker:ProviderCountForCode("axe_3") + Tracker:ProviderCountForCode("axe_4") +
                      Tracker:ProviderCountForCode("spear_1") + Tracker:ProviderCountForCode("spear_2") +
                      Tracker:ProviderCountForCode("spear_3") + Tracker:ProviderCountForCode("spear_4")

    if ENABLE_DEBUG_LOG then
        print("hasNonSword: value: " .. value)
    end

    if (value > 0) then
        return 1
    end

    return 0
end

function hasBronzeAxeOrHigher()
    local value = Tracker:ProviderCountForCode("axe_2") + Tracker:ProviderCountForCode("axe_3") +
                      Tracker:ProviderCountForCode("axe_4")

    if ENABLE_DEBUG_LOG then
        print("hasBronzeAxeOrHigher: value: " .. value)
    end

    if (value > 0) then
        return 1
    end

    return 0
end

function hasKnightBasherOrHigher()
    local value = Tracker:ProviderCountForCode("axe_3") + Tracker:ProviderCountForCode("axe_4")

    if ENABLE_DEBUG_LOG then
        print("hasKnightBasherOrHigher: value: " .. value)
    end

    if (value > 0) then
        return 1
    end

    return 0
end

function hasBronzeSpearOrHigher()
    local value = Tracker:ProviderCountForCode("spear_2") + Tracker:ProviderCountForCode("spear_3") +
                      Tracker:ProviderCountForCode("spear_4")

    if ENABLE_DEBUG_LOG then
        print("hasBronzeSpearOrHigher: value: " .. value)
    end

    if (value > 0) then
        return 1
    end

    return 0
end

function _true()
    return 1
end

function _false()
    return 0
end

function hasAllEnergyCoreFragments()
    -- ToDo
end

function bossLocationVisible(isVanillaProg)
    if isVanillaProg == nil then
        isVanillaProg = 0
    else
        isVanillaProg = tonumber(isVanillaProg)
    end
    local boss_drops = Tracker:FindObjectForCode("opt_boss_drops")
    local pool = Tracker:FindObjectForCode("opt_pool")
    local hide_junk = Tracker:FindObjectForCode("opt_hide_junk")

    local value = hide_junk.CurrentStage == 0 or boss_drops.CurrentStage == 0 and isVanillaProg == 1 or
                      boss_drops.CurrentStage ~= 0

    if ENABLE_DEBUG_LOG then
        print(string.format("bossLocationVisible: value: %s, isVanillaProg: %s",value,isVanillaProg))
    end
    if value then
        return 1
    end
    return 0
end

function gourdLocationVisible()
    local boss_drops = Tracker:FindObjectForCode("opt_boss_drops")
    local gourdomizer = Tracker:FindObjectForCode("opt_gourdomizer")
    local pool = Tracker:FindObjectForCode("opt_pool")
    local hide_junk = Tracker:FindObjectForCode("opt_hide_junk")

    local value = gourdomizer.CurrentStage ~= 0 and
                      (hide_junk.CurrentStage == 0 or gourdomizer.CurrentStage == 1 or gourdomizer.CurrentStage == 2 and
                          not (pool.CurrentStage == 2 and boss_drops.CurrentStage == 2))

    if ENABLE_DEBUG_LOG then
        print(string.format("gourdLocationVisible: value: %s",value))
    end
    if value then
        return 1
    end
    return 0
end

function gourdVanillaLocationVisible(isVanillaProg)    
    if isVanillaProg == nil then
        isVanillaProg = 0
    else
        isVanillaProg = tonumber(isVanillaProg)
    end
    local gourdomizer = Tracker:FindObjectForCode("opt_gourdomizer")
    local hide_junk = Tracker:FindObjectForCode("opt_hide_junk")

    local value = gourdomizer.CurrentStage == 0 and (hide_junk.CurrentStage == 0 or isVanillaProg == 1)

    if ENABLE_DEBUG_LOG then
        print(string.format("gourdVanillaLocationVisible: value: %s, isVanillaProg: %s",value,isVanillaProg))
    end
    if value then
        return 1
    end
    return 0
end

function alchemyLocationVisible()
    local alchemizer = Tracker:FindObjectForCode("opt_alchemizer")
    local boss_drops = Tracker:FindObjectForCode("opt_boss_drops")
    local pool = Tracker:FindObjectForCode("opt_pool")
    local hide_junk = Tracker:FindObjectForCode("opt_hide_junk")

    local value = alchemizer.CurrentStage ~= 0 and
                      (hide_junk.CurrentStage == 0 or alchemizer.CurrentStage == 1 or alchemizer.CurrentStage == 2 and
                          not (pool.CurrentStage == 2 and boss_drops.CurrentStage == 2))
    if ENABLE_DEBUG_LOG then
        print(string.format("alchemyLocationVisible: value: %s",value))
    end
    if value then
        return 1
    end
    return 0
end

function alchemyVanillaLocationVisible(isVanillaProg)
    if isVanillaProg == nil then
        isVanillaProg = 0
    else
        isVanillaProg = tonumber(isVanillaProg)
    end
    local alchemizer = Tracker:FindObjectForCode("opt_alchemizer")
    local hide_junk = Tracker:FindObjectForCode("opt_hide_junk")

    local value = alchemizer.CurrentStage == 0 and (hide_junk.CurrentStage == 0 or isVanillaProg == 1)
    if ENABLE_DEBUG_LOG then
        print(string.format("alchemyVanillaLocationVisible: value: %s, isVanillaProg: %s",value,isVanillaProg))
    end
    if value then
        return 1
    end
    return 0
end

