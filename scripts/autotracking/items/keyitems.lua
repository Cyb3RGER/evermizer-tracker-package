KEY_ITEMS = {
    addr = 0x7E2264,
    --BYTE 1
    [0] = {
        --["unused_1"] = 0x01,
        --["unused_2"] = 0x02,
        --["gauge"] = 0x04,
        --["wheel"] = 0x08,
        ["queens_key"] =  0x10,
        --["energy_core"] = 0x20,
        --["unused_3"] = 0x40,
        --["unused_4"] = 0x80
    }
}
KEY_ITEMS_2 = { --used for given way keyitems
    addr = 0x7E22DC,
    --BYTE 0x7E22DC
    [0x0] = {        
        ["gauge"] =  0x10,
        ["wheel"] = 0x20,
    },
}    
KEY_ITEMS_3 = { --used for given way keyitems
    addr = 0x7E22F9,
    --BYTE 0x7E22F9
    [0x0] = {
        ["energy_core"] = 0x20,
    },
}
GAVE_AWAY_DES = false
GAVE_AWAY_WHEEL = false
GAVE_AWAY_GAUGE = false
GAVE_AWAY_CORE = false
HAS_DE = 0
HAS_WHEEL = false
HAS_GAUGE = false
HAS_CORE = false
AEROGLIDER_ADDR = 0x7E2355
ROCKET_ADDR = 0x7E22DC