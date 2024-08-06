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
    local boss_drops = Tracker:FindObjectForCode("opt_boss_drops").CurrentStage
    local hide_junk = Tracker:FindObjectForCode("opt_hide_junk").CurrentStage

    local value = hide_junk == 0 or boss_drops ~= 0 or isVanillaProg == 1

    if ENABLE_DEBUG_LOG then
        print(string.format("bossLocationVisible: value: %s, isVanillaProg: %s", value, isVanillaProg))
    end
    if value then
        return 1
    end
    return 0
end

function gourdLocationVisible(hideOnEasy)
    if hideOnEasy == nil then
        hideOnEasy = 0
    else
        hideOnEasy = tonumber(hideOnEasy)
    end
    local boss_drops = Tracker:FindObjectForCode("opt_boss_drops").CurrentStage
    local gourdomizer = Tracker:FindObjectForCode("opt_gourdomizer").CurrentStage
    local pool = Tracker:FindObjectForCode("opt_pool").CurrentStage
    local hide_junk = Tracker:FindObjectForCode("opt_hide_junk").CurrentStage
    local difficulty = Tracker:FindObjectForCode("opt_difficulty").CurrentStage

    local value = gourdomizer ~= 0 and
        (hide_junk == 0 or (gourdomizer == 1 or gourdomizer == 2 and not (pool == 2 and boss_drops == 2)) and (hideOnEasy == 0 or difficulty ~= 0))

    if ENABLE_DEBUG_LOG then
        print(string.format("gourdLocationVisible: value: %s, hideOnEasy: %s", value, hideOnEasy))
    end
    if value then
        return 1
    end
    return 0
end

function gourdVanillaLocationVisible(isVanillaProg, hideOnEasy)
    if isVanillaProg == nil then
        isVanillaProg = 0
    else
        isVanillaProg = tonumber(isVanillaProg)
    end
    if hideOnEasy == nil then
        hideOnEasy = 0
    else
        hideOnEasy = tonumber(hideOnEasy)
    end
    local gourdomizer = Tracker:FindObjectForCode("opt_gourdomizer").CurrentStage
    local hide_junk = Tracker:FindObjectForCode("opt_hide_junk").CurrentStage
    local energy_core = Tracker:FindObjectForCode("opt_energy_core").CurrentStage
    local difficulty = Tracker:FindObjectForCode("opt_difficulty").CurrentStage

    local value = gourdomizer == 0 and (hide_junk == 0 or ((isVanillaProg == 1 or energy_core == 2) and (hideOnEasy == 0 or difficulty ~= 0)))

    if ENABLE_DEBUG_LOG then
        print(string.format("gourdVanillaLocationVisible: value: %s, isVanillaProg: %s, hideOnEasy: %s", value, isVanillaProg, hideOnEasy))
    end
    if value then
        return 1
    end
    return 0
end

function alchemyLocationVisible()
    local alchemizer = Tracker:FindObjectForCode("opt_alchemizer").CurrentStage
    local boss_drops = Tracker:FindObjectForCode("opt_boss_drops").CurrentStage
    local pool = Tracker:FindObjectForCode("opt_pool").CurrentStage
    local hide_junk = Tracker:FindObjectForCode("opt_hide_junk").CurrentStage

    local value = alchemizer ~= 0 and
    (hide_junk == 0 or alchemizer == 1 or alchemizer == 2 and not (pool == 2 and boss_drops == 2))
    if ENABLE_DEBUG_LOG then
        print(string.format("alchemyLocationVisible: value: %s", value))
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
    local alchemizer = Tracker:FindObjectForCode("opt_alchemizer").CurrentStage
    local hide_junk = Tracker:FindObjectForCode("opt_hide_junk").CurrentStage

    local value = alchemizer == 0 and (hide_junk == 0 or isVanillaProg == 1)
    if ENABLE_DEBUG_LOG then
        print(string.format("alchemyVanillaLocationVisible: value: %s, isVanillaProg: %s", value, isVanillaProg))
    end
    if value then
        return 1
    end
    return 0
end

-- sniff spots are always junk in vanilla
-- if hide_junk is on sniff spots should be visible only when
-- - sniffamzier is pooled and
-- - the pool strategy is not bosses and
-- - - any other pool is included
-- if hide_junk is off sniff spots should always show
-- if hideOnEasy is 1 and difficulty is easy then this should be hidden
function sniffLocationVisible(hideOnEasy)
    if hideOnEasy == nil then
        hideOnEasy = 0
    else
        hideOnEasy = tonumber(hideOnEasy)
    end
    local alchemizer = Tracker:FindObjectForCode("opt_alchemizer").CurrentStage
    local boss_drops = Tracker:FindObjectForCode("opt_boss_drops").CurrentStage
    local gourdomizer = Tracker:FindObjectForCode("opt_gourdomizer").CurrentStage
    local sniffamizer = Tracker:FindObjectForCode("opt_sniffamizer").CurrentStage
    local pool = Tracker:FindObjectForCode("opt_pool").CurrentStage
    local hide_junk = Tracker:FindObjectForCode("opt_hide_junk").CurrentStage
    local difficulty = Tracker:FindObjectForCode("opt_difficulty").CurrentStage

    local value = hide_junk == 0 or
        (hide_junk == 1 and sniffamizer == 2 and pool ~= 2 and (alchemizer == 2 or boss_drops == 2 or gourdomizer == 2) and (hideOnEasy == 0 or difficulty ~= 0))
    if ENABLE_DEBUG_LOG then
        print(string.format("sniffLocationVisible: value: %s", value))
    end
    if value then
        return 1
    end
    return 0
end
