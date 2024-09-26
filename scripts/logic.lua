function oob()
    local stage = Tracker:FindObjectForCode("oob").CurrentStage
    if stage == 2 then
        return _and_combine_access(AccessibilityLevel.Normal, canCutBushes())
    elseif stage == 1 then
        return _and_combine_access(AccessibilityLevel.SequenceBreak, canCutBushes())
    else
        return _and_combine_access(AccessibilityLevel.None, canCutBushes())
    end
end

function seq_breaks()
    local stage = Tracker:FindObjectForCode("seq_breaks").CurrentStage
    if stage == 2 then
        return _and_combine_access(AccessibilityLevel.Normal, canCutBushes())
    elseif stage == 1 then
        return _and_combine_access(AccessibilityLevel.SequenceBreak, canCutBushes())
    else
        return _and_combine_access(AccessibilityLevel.None, canCutBushes())
    end
end

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
        return AccessibilityLevel.Normal
    end

    return AccessibilityLevel.None
end

function hasNonSword()
    local oob_val = oob()
    if oob_val == AccessibilityLevel.Normal then
        return oob_val
    end

    local value = Tracker:ProviderCountForCode("axe_1") + Tracker:ProviderCountForCode("axe_2") +
        Tracker:ProviderCountForCode("axe_3") + Tracker:ProviderCountForCode("axe_4") +
        Tracker:ProviderCountForCode("spear_1") + Tracker:ProviderCountForCode("spear_2") +
        Tracker:ProviderCountForCode("spear_3") + Tracker:ProviderCountForCode("spear_4")

    if ENABLE_DEBUG_LOG then
        print("hasNonSword: value: " .. value)
    end

    if (value > 0) then
        return AccessibilityLevel.Normal
    end

    return _or_combine_access(oob_val, AccessibilityLevel.None)
end

function volcano_entered()
    local oob_val = oob()
    if oob_val == AccessibilityLevel.Normal then
        return oob_val
    end
    local seq_breaks_val = seq_breaks()
    local levitate = Tracker:ProviderCountForCode("levitate") > 0
    local levitate_val = AccessibilityLevel.None
    if levitate then
        levitate_val = AccessibilityLevel.Normal
    end
    local combined_val
    combined_val = _and_combine_access(levitate_val, canCutBushes())
    combined_val = _or_combine_access(combined_val, seq_breaks_val)
    combined_val = _or_combine_access(combined_val, oob_val)
    return combined_val
end

function hasRealBronzeAxeOrHigher()
    local value = Tracker:ProviderCountForCode("axe_2") + Tracker:ProviderCountForCode("axe_3") +
        Tracker:ProviderCountForCode("axe_4")

    if ENABLE_DEBUG_LOG then
        print("hasBronzeAxeOrHigher: value: " .. value)
    end

    if (value > 0) then
        return AccessibilityLevel.Normal
    end

    return AccessibilityLevel.None
end

function hasBronzeAxeOrHigher()
    local oob_val = oob()
    if oob_val == AccessibilityLevel.Normal then
        return oob_val
    end
    return _or_combine_access(oob_val, hasRealBronzeAxeOrHigher())
end

function knight_basher()
    local oob_val = oob()
    if oob_val == AccessibilityLevel.Normal then
        return oob_val
    end

    local value = Tracker:ProviderCountForCode("axe_3")

    if ENABLE_DEBUG_LOG then
        print("knight_basher: value: " .. value)
    end

    if (value > 0) then
        return AccessibilityLevel.Normal
    end

    return _or_combine_access(oob_val, AccessibilityLevel.None)
end

function hasKnightBasherOrHigher()
    local oob_val = oob()
    if oob_val == AccessibilityLevel.Normal then
        return oob_val
    end

    local value = Tracker:ProviderCountForCode("axe_3") + Tracker:ProviderCountForCode("axe_4")

    if ENABLE_DEBUG_LOG then
        print("hasKnightBasherOrHigher: value: " .. value)
    end

    if (value > 0) then
        return AccessibilityLevel.Normal
    end

    return _or_combine_access(oob_val, AccessibilityLevel.None)
end

function revealer()
    local seq_breaks_val = seq_breaks()
    local oob_val = oob()
    local combined_val = _or_combine_access(seq_breaks_val, oob_val)
    if combined_val == AccessibilityLevel.Normal then
        return combined_val
    end

    local value = Tracker:ProviderCountForCode("revealer") > 0

    if ENABLE_DEBUG_LOG then
        print("revealer: value: " .. value)
    end

    if value then
        return AccessibilityLevel.Normal
    end

    return AccessibilityLevel.SequenceBreak
end

function pyramid()
    local oob_val = oob()
    if oob_val == AccessibilityLevel.Normal then
        return oob_val
    end
    local seq_breaks_val = seq_breaks()
    local revealer_val = revealer()
    local aegis = Tracker:ProviderCountForCode("aegis") > 0
    local aegis_val = AccessibilityLevel.None
    if aegis then
        aegis_val = AccessibilityLevel.Normal
    end
    local combined_val
    combined_val = _or_combine_access(aegis_val, revealer_val)
    combined_val = _and_combine_access(combined_val, canCutBushes())
    combined_val = _or_combine_access(combined_val, seq_breaks_val)
    combined_val = _or_combine_access(combined_val, oob_val)
    return combined_val
end

function oglin_access()
    local oob_val = oob()
    if oob_val == AccessibilityLevel.Normal then
        return oob_val
    end

    local value = Tracker:ProviderCountForCode("aegis") > 0
    if value then
        return AccessibilityLevel.Normal
    end

    return _or_combine_access(oob_val, AccessibilityLevel.None)
end

function queens_key()
    local oob_val = oob()
    if oob_val == AccessibilityLevel.Normal then
        return oob_val
    end
    local value = Tracker:ProviderCountForCode("queens_key") > 0
    if value then
        return AccessibilityLevel.Normal
    end
    return _or_combine_access(oob_val, AccessibilityLevel.None)
end

function energy_core_access()
    local oob_val = oob()
    if oob_val == AccessibilityLevel.Normal then
        return oob_val
    end
    local value = Tracker:ProviderCountForCode("aeroglider") > 0
    if value then
        return AccessibilityLevel.Normal
    end
    return _or_combine_access(oob_val, AccessibilityLevel.None)
end

function east_crustacia_chests_access()
    local oob_val = oob()
    if oob_val == AccessibilityLevel.Normal then
        return oob_val
    end
    local value = Tracker:ProviderCountForCode("levitate") > 0
    if value then
        return AccessibilityLevel.Normal
    end
    return _or_combine_access(oob_val, AccessibilityLevel.None)
end

function gauge_access()
    local oob_val = oob()
    if oob_val == AccessibilityLevel.Normal then
        return oob_val
    end
    local value = Tracker:ProviderCountForCode("magmar") > 0
    if value then
        return AccessibilityLevel.Normal
    end
    return _or_combine_access(oob_val, AccessibilityLevel.None)
end

function _or_combine_access(a, b)
    if a == AccessibilityLevel.Normal or b == AccessibilityLevel.Normal then
        return AccessibilityLevel.Normal
    elseif a == AccessibilityLevel.SequenceBreak or b == AccessibilityLevel.SequenceBreak then
        return AccessibilityLevel.SequenceBreak
    else
        return AccessibilityLevel.None
    end
end

function _and_combine_access(a, b)
    if a == AccessibilityLevel.Normal and b == AccessibilityLevel.Normal then
        return AccessibilityLevel.Normal
    elseif a == AccessibilityLevel.None or b == AccessibilityLevel.None then
        return AccessibilityLevel.None
    else
        return AccessibilityLevel.SequenceBreak
    end
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
    if not EVERMIZER_VERSION or not SETTING_FLAGS then
        return AccessibilityLevel.SequenceBreak
    end
    if EVERMIZER_VERSION < 049 or SETTING_FLAGS & 1 == 1 then
        return AccessibilityLevel.SequenceBreak
    end
    local current = Tracker:FindObjectForCode("energy_core_fragments").AcquiredCount
    local required = Tracker:FindObjectForCode("required_energy_core_fragments").AcquiredCount
    if current >= required then
        return AccessibilityLevel.Normal
    end
    return AccessibilityLevel.None
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

    local value = gourdomizer == 0 and
        (hide_junk == 0 or ((isVanillaProg == 1 or energy_core == 2) and (hideOnEasy == 0 or difficulty ~= 0)))

    if ENABLE_DEBUG_LOG then
        print(string.format("gourdVanillaLocationVisible: value: %s, isVanillaProg: %s, hideOnEasy: %s", value,
            isVanillaProg, hideOnEasy))
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
