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
        --["call_bead_char_2"] = 0x80,
    },
    --BYTE 6
    [5] = {
        --["call_bead_char_3"] = 0x01,
        --["call_bead_char_4"] = 0x02,
        --["unused_5"] = 0x04,
        --["unused_6"] = 0x08,
        --["unused_7"] = 0x10,
        --["unused_8"] = 0x20,
        --["unused_9"] = 0x40,
        --["unused_10"] = 0x80
    },
}

ALCHEMY_SPELLS_TURDO = {
    ["turd_ball_1"] = {
        "acid_rain",
        "corrosion",
        "drain",
        "flash",
        "hard_ball",
        "slow_burn"
    },
    ["turd_ball_2"] = {
        "crush",
        "double_drain",
        "fireball",
        "lance",
        "sting",
    },
    ["turd_ball_3"] = {
        "explosion",
        "fire_power",
        "lightning_storm",
        "nitro"
    }
}

ALCHEMY_SPELLS_TURDO_FOUND = {}