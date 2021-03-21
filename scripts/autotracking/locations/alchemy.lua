ALCHEMY_LOCATION_MAPPING = nil
    ALCHEMY_IDS = {
        [0x00] = "acid_rain",
        [0x01] = "atlas",
        [0x02] = "barrier",
        [0x03] = "call_up",
        [0x04] = "corrosion",
        [0x05] = "crush",
        [0x06] = "cure",
        [0x07] = "defend",
        [0x08] = "double_drain",
        [0x09] = "drain",
        [0x0a] = "energize",
        [0x0b] = "escape",
        [0x0c] = "explosion",
        [0x0d] = "fireball",
        [0x0e] = "fire_power",
        [0x0f] = "flash",
        [0x10] = "force_field",
        [0x11] = "hard_ball",
        [0x12] = "heal",
        [0x13] = "lance",
        --no laser
        [0x15] = "levitate",
        [0x16] = "lightning_storm",
        [0x17] = "miracle_cure",
        [0x18] = "nitro",
        [0x19] = "one_up",
        [0x1a] = "reflect",
        [0x1b] = "regrowth",
        [0x1c] = "revealer",
        [0x1d] = "revive",
        [0x1e] = "slow_burn",
        [0x1f] = "speed",
        [0x20] = "sting",
        [0x21] = "stop",
        [0x22] = "super_heal"       
    }
    ALCHEMY_LOCATIONS_FLAGS = {
        [0x00] = 0x13af2a + 2,
        [0x01] = 0x15e97f + 2,
        [0x02] = 0x15d3d7 + 1,
        [0x03] = 0x1bcec8 + 1,
        [0x04] = 0x18b2f7 + 2,
        [0x05] = 0x15ba42 + 1,
        [0x06] = 0x1683b2 + 2,
        [0x07] = 0x14e506 + 1,
        [0x08] = 0x14a682 + 6,
        [0x09] = 0x14a692 + 2,
        [0x0a] = 0x1bcf34 + 6,
        [0x0b] = 0x16db70 + 11,
        [0x0c] = 0x198793 + 2,
        [0x0d] = 0x17a2d0 + 2,
        [0x0e] = 0x17e9ed + 2,
        [0x0f] = 0x14da42 + 1,
        [0x10] = 0x19da23 + 1,
        [0x11] = 0x14a9a1 + 9,
        [0x12] = 0x13dacd + 1,
        [0x13] = 0x18e164 + 2,
        --no laser
        [0x15] = 0x13ed93 + 2,
        [0x16] = 0x1996f0 + 1,
        [0x17] = 0x14e70a + 2,
        [0x18] = 0x198793 + 11,
        [0x19] = 0x19b750 + 2,
        [0x1a] = 0x1be026 + 2,
        [0x1b] = 0x18de1b + 2,
        [0x1c] = 0x16db3b + 2,
        [0x1d] = 0x15b216 + 2,
        [0x1e] = 0x19881d + 2,
        [0x1f] = 0x149c9c + 2,
        [0x20] = 0x16e141 + 2,
        [0x21] = 0x19da2d + 1,
        [0x22] = 0x1abb91 + 2,
    }
    ALCHEMY_LOCATIONS_DETAILED = {
        [0x00] = "@Quick Sand Fields/Acid Rain Guy/Acid Rain",
        [0x01] = "@Nobilia/Atlas/",
        [0x02] = "@Nobilia/Barrier/",
        [0x03] = "@Main District/Laboratory/Call Up",
        [0x04] = "@Ivor Tower Sewers/Corrosion/",
        [0x05] = "@Eastern Beach/Blimp's Cave/Crush",
        [0x06] = "@Nobilia/Cure/",
        [0x07] = "@Fire Eyes' Village/Defend Area/Defend",
        [0x08] = "@River/Drain Cave/Double Drain",
        [0x09] = "@River/Drain Cave/Drain",
        [0x0a] = "@Main District/Laboratory/Energize",
        [0x0b] = "@Western Beach/Horace Camp/Escape",
        [0x0c] = "@Ebon Keep Interiors/Explosion / Nitro/Explosion",
        [0x0d] = "@Halls of Collosia 4/Fireball/",
        [0x0e] = "@Ivor Tower Interiors/Fire Power/",
        [0x0f] = "@Fire Eyes' Village/Fire Eyes' Hut/Flash",
        [0x10] = "@Chessboard/Below the Chessboard/Force Field",
        [0x11] = "@Bugmuck/Hard Ball Cave/Hard Ball",
        [0x12] = "@Northern Jungle/Mammoth Graveyard/Heal",
        [0x13] = "lance_npc",
        --no laser
        [0x15] = "@Volcano Path/Levitate/",
        [0x16] = "@Gomi Tower/Lightning Storm/",
        [0x17] = "@Southern Jungle/Strong Heart's Hut/Miracle Cure",
        [0x18] = "@Ebon Keep Interiors/Explosion / Nitro/Nitro",
        [0x19] = "@Dark Forest 1/One Up/",
        [0x1a] = "@Main District/Junkyard / Boiler Room/Reflect",
        [0x1b] = "@Ebon Keep/Regrowth Lady's hidden room/Regrowth",
        [0x1c] = "@Western Beach/Horace Camp/Revealer",
        [0x1d] = "@Eastern Beach/Blimp's Cave/Revive",
        [0x1e] = "@Ebon Keep Interiors/Slow Burn/",
        [0x1f] = "@Volcano Core/Speed/",
        [0x20] = "@Eastern Beach/Desert of Doom/Sting",
        [0x21] = "@Chessboard/Below the Chessboard/Stop",
        [0x22] = "@Ebon Keep Interiors/Super Heal/",
    }
    ALCHEMY_LOCATIONS_OVERWORLD = {
        [0x00] = "@Act 1/Quick Sand Fields/Acid Rain",
        [0x01] = "@Act 2/Nobilia/Atlas",
        [0x02] = "@Act 2/Nobilia/Barrier",
        [0x03] = "@Act 4/Omnitopia/Call Up",
        [0x04] = "@Act 3/Ivor Tower/Corrosion",
        [0x05] = "@Act 2/Crustacia/Crush",
        [0x06] = "@Act 2/Nobilia/Cure",
        [0x07] = "@Act 1/Fire Eyes' Village/Defend",
        [0x08] = "@Act 2/Crustacia/Double Drain",
        [0x09] = "@Act 2/Crustacia/Drain",
        [0x0a] = "@Act 4/Omnitopia/Energize",
        [0x0b] = "@Act 2/Crustacia/Escape",
        [0x0c] = "@Act 3/Ebon Keep/Explosion",
        [0x0d] = "@Act 2/Halls of Collosia/Fireball",
        [0x0e] = "@Act 3/Ivor Tower/Fire Power",
        [0x0f] = "@Act 1/Fire Eyes' Village/Flash",
        [0x10] = "@Act 3/Chessboard/Force Field",
        [0x11] = "@Act 1/Bugmuck/Hard Ball",
        [0x12] = "@Act 1/Northern Jungle/Heal",
        [0x13] = "lance_npc",
        --no laser
        [0x15] = "@Act 1/Volcano Path/Levitate",
        [0x16] = "@Act 3/Dark Forest/Lightning Storm",
        [0x17] = "@Act 1/Southern Jungle/Miracle Cure",
        [0x18] = "@Act 3/Ebon Keep/Nitro",
        [0x19] = "@Act 3/Dark Forest/One Up",
        [0x1a] = "@Act 4/Omnitopia/Reflect",
        [0x1b] = "@Act 3/Ebon Keep/Regrowth",
        [0x1c] = "@Act 2/Crustacia/Revealer",
        [0x1d] = "@Act 2/Crustacia/Revive",
        [0x1e] = "@Act 3/Ebon Keep/Slow Burn",
        [0x1f] = "@Act 1/Volcano Core/Speed",
        [0x20] = "@Act 2/Desert of Doom/Sting",
        [0x21] = "@Act 3/Chessboard/Stop",
        [0x22] = "@Act 3/Ebon Keep/Super Heal",
    }
    if IS_DETAILED then ALCHEMY_LOCATIONS = ALCHEMY_LOCATIONS_DETAILED
    else ALCHEMY_LOCATIONS = ALCHEMY_LOCATIONS_OVERWORLD
    end