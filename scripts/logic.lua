

function canCutBushes()
    local value = 
        Tracker:ProviderCountForCode("sword_2") +
        Tracker:ProviderCountForCode("sword_3") +
        Tracker:ProviderCountForCode("sword_4") +
        Tracker:ProviderCountForCode("axe_1") +
        Tracker:ProviderCountForCode("axe_2") +
        Tracker:ProviderCountForCode("axe_3") +
        Tracker:ProviderCountForCode("axe_4") +
        Tracker:ProviderCountForCode("spear_1") +
        Tracker:ProviderCountForCode("spear_2") +
        Tracker:ProviderCountForCode("spear_3") +
        Tracker:ProviderCountForCode("spear_4")

    if ENABLE_DEBUG_LOG then
        print("canCutBushes: value: "..value)
    end

	if (value > 0) then
		return 1
    end
    
	return 0
end

function hasNonSword()
    local value = 
        Tracker:ProviderCountForCode("axe_1") +
        Tracker:ProviderCountForCode("axe_2") +
        Tracker:ProviderCountForCode("axe_3") +
        Tracker:ProviderCountForCode("axe_4") +
        Tracker:ProviderCountForCode("spear_1") +
        Tracker:ProviderCountForCode("spear_2") +
        Tracker:ProviderCountForCode("spear_3") +
        Tracker:ProviderCountForCode("spear_4")

    if ENABLE_DEBUG_LOG then
        print("hasNonSword: value: "..value)
    end

	if (value > 0) then
		return 1
    end
    
	return 0
end

function hasBronzeAxeOrHigher()
    local value = 
        Tracker:ProviderCountForCode("axe_2") +
        Tracker:ProviderCountForCode("axe_3") +
        Tracker:ProviderCountForCode("axe_4") 

    if ENABLE_DEBUG_LOG then
        print("hasBronzeAxeOrHigher: value: "..value)
    end

	if (value > 0) then
		return 1
    end
    
	return 0
end

function hasKnightBasherOrHigher()
    local value = 
        Tracker:ProviderCountForCode("axe_3") +
        Tracker:ProviderCountForCode("axe_4") 

    if ENABLE_DEBUG_LOG then
        print("hasKnightBasherOrHigher: value: "..value)
    end

	if (value > 0) then
		return 1
    end
    
	return 0
end

function hasBronzeSpearOrHigher()
    local value = 
        Tracker:ProviderCountForCode("spear_2") +
        Tracker:ProviderCountForCode("spear_3") +
        Tracker:ProviderCountForCode("spear_4") 

    if ENABLE_DEBUG_LOG then
        print("hasBronzeSpearOrHigher: value: "..value)
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
   --ToDo
end

