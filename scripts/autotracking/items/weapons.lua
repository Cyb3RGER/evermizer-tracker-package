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

WEAPON_LEVELS_START_ADDR = 0x7E0ADF
WEAPON_LEVELS = {
    ["sword_1"]       = 0x7E0ADF,
    ["sword_2"]       = 0x7E0AE1,
    ["sword_3"]       = 0x7E0AE3,
    ["sword_4"]       = 0x7E0AE5,
    ["axe_1"]         = 0x7E0AE7,
    ["axe_2"]         = 0x7E0AE9,
    ["axe_3"]         = 0x7E0AEB,
    ["axe_4"]         = 0x7E0AED,
    ["spear_1"]       = 0x7E0AEF,
    ["spear_2"]       = 0x7E0AF1,
    ["spear_3"]       = 0x7E0AF3,
    ["spear_4"]       = 0x7E0AF5,
    ["bazooka"]       = 0x7E0AF7,
}
WEAPON_LEVEL_SIZE = 0x2