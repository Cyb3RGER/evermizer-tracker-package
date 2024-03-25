CURRENT_ROOM_ADDR = 0x7e0adb
CURRENT_ROOM = nil
EBON_KEEP_FLAG_ADDR = 0x7e22dd
EBON_KEEP_FLAG = false

ROOM_MAPPING =
{
    --[0x36] = {"Overview"}, --prehistoria firepits
    [0x39] = {"Overview"}, --ebon keep firepit
    [0x3a] = {"Overview"}, --nobilia firepit
    [0x04] = {"Overview"}, --crustacia firepit
    [0x46] = {"Overview"}, --prof lab
    --Prehistoria    
    [0x33] = {"Prehistoria","Southern Jungle"},
    [0x34] = {"Prehistoria","Southern Jungle"},
    [0x38] = {"Prehistoria","Southern Jungle"},
    [0x5C] = {"Prehistoria","Raptor Attack"},
    [0x25] = {"Prehistoria","Fire Eyes' Village"},
    [0x26] = {"Prehistoria","Fire Eyes' Village"},
    [0x36] = {"Prehistoria","Eastern Jungle"}, --prehistoria firepits
    [0x5B] = {"Prehistoria","Eastern Jungle"},
    [0x59] = {"Prehistoria","Quick Sand Fields"},
    [0x5a] = {"Prehistoria","Quick Sand Fields"},
    [0x67] = {"Prehistoria","Bugmuck","Outside"},
    [0x16] = {"Prehistoria","Bugmuck","Bugmaze"},
    [0x17] = {"Prehistoria","Bugmuck","Room 2"},
    [0x18] = {"Prehistoria","Bugmuck","Room 2"},
    [0x41] = {"Prehistoria","Northern Jungle"},
    [0x27] = {"Prehistoria","Mammoth Graveyard"},
    [0x69] = {"Prehistoria","Volcano Path"},
    [0x52] = {"Prehistoria","Volcano Path"},
    [0x50] = {"Prehistoria","Volcano Path"},
    [0x66] = {"Prehistoria","Swamp"},
    [0x65] = {"Prehistoria","Swamp"},
    [0x01] = {"Prehistoria","Swamp"},
    [0x3b] = {"Prehistoria","Volcano Core"},
    [0x3c] = {"Prehistoria","Volcano Core"},
    [0x3d] = {"Prehistoria","Volcano Sewers"},
    [0x3e] = {"Prehistoria","Volcano Sewers"},
    [0x3f] = {"Prehistoria","Volcano Sewers"},
    --Antiqua
    [0x1b] = {"Antiqua","Eastern Beach"},
    [0x4f] = {"Antiqua","Eastern Beach"},
    [0x2e] = {"Antiqua","Eastern Beach"},
    --[0x04] = {"Antiqua","Eastern Beach"},
    [0x53] = {"Antiqua","Crustacia"},
    [0x68] = {"Antiqua","Crustacia"},
    [0x30] = {"Antiqua","Crustacia"},
    [0x0a] = {"Antiqua","Nobilia", "Market"},
    [0x08] = {"Antiqua","Nobilia", "Market"},
    [0x09] = {"Antiqua","Nobilia", "Market"},
    [0x1d] = {"Antiqua","Nobilia", "Market"}, --ToDo: vigor fight?
    --[0x3a] = {"Antiqua","Nobilia"},
    [0x0c] = {"Antiqua","Nobilia", "Market"},
    [0x1e] = {"Antiqua","Nobilia", "Colosseum"},
    [0x1c] = {"Antiqua","Nobilia", "Colosseum"},
    [0x4c] = {"Antiqua","Nobilia", "Palace"},
    [0x0b] = {"Antiqua","Nobilia", "Palace"},
    [0x4d] = {"Antiqua","Nobilia", "Palace"},
    [0x07] = {"Antiqua","River"},
    [0x05] = {"Antiqua","Western Beach"},
    [0x2f] = {"Antiqua","Horace Camp"},
    [0x06] = {"Antiqua","Pyramid", "Outside"},
    [0x55] = {"Antiqua","Pyramid", "Lower"},
    [0x56] = {"Antiqua","Pyramid", "Upper"},
    [0x58] = {"Antiqua","Pyramid", "Upper"},
    [0x2b] = {"Antiqua","Halls of Collosia", "Outside"},
    [0x29] = {"Antiqua","Halls of Collosia", "Room 1"},
    [0x2c] = {"Antiqua","Halls of Collosia", "Room 1"},
    [0x2a] = {"Antiqua","Halls of Collosia", "Room 1"},
    [0x24] = {"Antiqua","Halls of Collosia", "Room 2"},
    [0x23] = {"Antiqua","Halls of Collosia", "Room 3"},
    [0x28] = {"Antiqua","Halls of Collosia", "Room 3"},
    [0x2d] = {"Antiqua","Halls of Collosia", "Room 4"},
    [0x64] = {"Antiqua","Tiny's Hideout"},
    [0x57] = {"Antiqua","Tiny's Hideout"},
    [0x6b] = {"Antiqua","Oglin Tunnel"},
    [0x4b] = {"Antiqua","Oglin Tunnel"},
    [0x6d] = {"Antiqua","Oglin Tunnel"},
    --Gothica
    [0x12] = {"Gothica","Ebon Keep Sewers"},
    [0x0d] = {"Gothica","Ebon Keep Interiors"},
    [0x0f] = {"Gothica","Ebon Keep Interiors"},
    [0x11] = {"Gothica","Ebon Keep Interiors"},
    [0x10] = {"Gothica","Ebon Keep Interiors"},
    [0x14] = {"Gothica","Ebon Keep Interiors"},
    --[0x39] = {"Gothica","Ebon Keep Interiors"},
    [0x0e] = {"Gothica","Ebon Keep Interiors"},
    [0x5d] = {"Gothica","Ebon Keep Interiors"},
    [0x5e] = {"Gothica","Ebon Keep Interiors"},
    [0x5f] = {"Gothica","Ebon Keep Interiors"},
    [0x60] = {"Gothica","Ebon Keep Interiors"},
    [0x13] = {"Gothica","Dark Forest 2"},
    [0x20] = {"Gothica","Dark Forest 2"},
    [0x1F] = {"Gothica","Dark Forest 1"},
    [0x22] = {"Gothica","Dark Forest 1"},
    [0x21] = {"Gothica","Dark Forest 1"},
    [0x19] = {"Gothica","Chessboard"},
    [0x1a] = {"Gothica","Chessboard"},
    [0x6e] = {"Gothica","Ivor Tower Interiors"},
    [0x6f] = {"Gothica","Ivor Tower Interiors"},
    [0x70] = {"Gothica","Ivor Tower Interiors"},
    [0x71] = {"Gothica","Ivor Tower Interiors"},
    [0x72] = {"Gothica","Ivor Tower Interiors"},
    [0x73] = {"Gothica","Dogmaze"},
    [0x78] = {"Gothica","Ivor Tower Interiors"},
    [0x77] = {"Gothica","Ivor Tower Interiors"},
    [0x79] = {"Gothica","Ivor Tower Sewers"},
    [0x7a] = {"Gothica","Ivor Tower Sewers"},
    [0x4e] = {"Gothica","Ivor Tower"},
    [0x62] = {"Gothica","Ivor Tower"},
    [0x63] = {"Gothica","Ivor Tower"},
    [0x6c] = {"Gothica","Ivor Tower South"},
    [0x76] = {"Gothica","Ivor Tower South"},
    [0x37] = {"Gothica","Gomi Tower"},
    [0x40] = {"Gothica","Gomi Tower"},
    --Omnitopia
    --[0x46] = {"Omnitopia"},
    [0x48] = {"Omnitopia", "Main District"},
    [0x44] = {"Omnitopia", "Main District"},
    [0x00] = {"Omnitopia", "Main District"},
    [0x43] = {"Omnitopia", "Main District"},
    [0x45] = {"Omnitopia", "Main District"},
    [0x47] = {"Omnitopia", "Main District"},
    [0x42] = {"Omnitopia", "Main District"},
    [0x54] = {"Omnitopia", "Main District"},
    [0x7e] = {"Omnitopia", "Boiler Room"},
    [0x49] = {"Omnitopia", "Boiler Room"},
    [0x4a] = {"Omnitopia", "Main District"},
}
