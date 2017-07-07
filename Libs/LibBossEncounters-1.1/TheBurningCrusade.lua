local BossEncounters = LibStub:GetLibrary("LibBossEncountersYugoEdit-1.1")
local encounters = BossEncounters.zone_encounters
local triggers = BossEncounters.encounter_triggers
local criteria = BossEncounters.encounter_criteria

local Z = BossEncounters.zone_names

encounters[Z.AUCHENAI_CRYPTS] = {
    "Shirrak the Dead Watcher",
    "Exarch Maladaar"
}
triggers[Z.AUCHENAI_CRYPTS] = {
    [18371] = "Shirrak the Dead Watcher",
    [18373] = "Exarch Maladaar"
}
criteria[Z.AUCHENAI_CRYPTS] = {
    ["Shirrak the Dead Watcher"] = {
        [18371] = true,
    },
    ["Exarch Maladaar"] = {
        [18373] = true,
    },
}

encounters[Z.MANA_TOMBS] = {
    "Pandemonius",
    "Tavarok",
    "Nexus-Prince Shaffar",
    "Yor",
}
triggers[Z.MANA_TOMBS] = {
    [18341] = "Pandemonius",
    [18343] = "Tavarok",
    [18344] = "Nexus-Prince Shaffar",
    [22930] = "Yor",
}
criteria[Z.MANA_TOMBS] = {
    ["Pandemonius"] = {
        [18341] = true,
    },
    ["Tavarok"] = {
        [18343] = true,
    },
    ["Nexus-Prince Shaffar"] = {
        [18344] = true,
    },
    ["Yor"] = {
        [22930] = true,
    },
}

encounters[Z.SETHEKK_HALLS] = {
    "Darkweaver Syth",
    "Talon King Ikiss",
    "Anzu",
}
triggers[Z.SETHEKK_HALLS] = {
    [18472] = "Darkweaver Syth",
    [18473] = "Talon King Ikiss",
    [23035] = "Anzu",
}
criteria[Z.SETHEKK_HALLS] = {
    ["Darkweaver Syth"] = {
        [18472] = true,
    },
    ["Talon King Ikiss"] = {
        [18473] = true,
    },
    ["Anzu"] = {
        [23035] = true,
    },
}

encounters[Z.SHADOW_LABYRINTH] = {
    "Ambassador Hellmaw",
    "Blackheart the Inciter",
    "Grandmaster Vorpil",
    "Murmur",
}
triggers[Z.SHADOW_LABYRINTH] = {
    [18731] = "Ambassador Hellmaw",
    [18667] = "Blackheart the Inciter",
    [18732] = "Grandmaster Vorpil",
    [18708] = "Murmur",
}
criteria[Z.SHADOW_LABYRINTH] = {
    ["Ambassador Hellmaw"] = {
        [18731] = true,
    },
    ["Blackheart the Inciter"] = {
        [18667] = true,
    },
    ["Grandmaster Vorpil"] = {
        [18732] = true,
    },
    ["Murmur"] = {
        [18708] = true,
    },
}

encounters[Z.BLACK_TEMPLE] = {
    "High Warlord Naj'entus",
    "Supremus",
    "Shade of Akama",
    "Teron Gorefiend",
    "Gurtogg Bloodboil",
    "Reliquary of Souls",
    "Mother Shahraz",
    "The Illidari Council",
    "Illidan Stormrage",
}
triggers[Z.BLACK_TEMPLE] = {
    [22887] = "High Warlord Naj'entus",
    [22898] = "Supremus",
    [22841] = "Shade of Akama",
    [22871] = "Teron Gorefiend",
    [22948] = "Gurtogg Bloodboil",
    [23418] = "Reliquary of Souls", -- Essence of Suffering
    [22947] = "Mother Shahraz",
    [22949] = "The Illidari Council", -- Gathios the Shatterer
    [22950] = "The Illidari Council", -- High Nethermancer Zerevor
    [22951] = "The Illidari Council", -- Lady Malande
    [22952] = "The Illidari Council", -- Veras Darkshadow
    [22917] = "Illidan Stormrage",
}
criteria[Z.BLACK_TEMPLE] = {
    ["High Warlord Naj'entus"] = {
        [22887] = true,
    },
    ["Supremus"] = {
        [22898] = true,
    },
    ["Shade of Akama"] = {
        [22841] = true,
    },
    ["Teron Gorefiend"] = {
        [22871] = true,
    },
    ["Gurtogg Bloodboil"] = {
        [22948] = true,
    },
    ["Reliquary of Souls"] = {
        [23420] = true, -- Essence of Anger
    },
    ["Mother Shahraz"] = {
        [22947] = true,
    },
    ["The Illidari Council"] = {
        [22949] = true, -- Gathios the Shatterer
        [22950] = true, -- High Nethermancer Zerevor
        [22951] = true, -- Lady Malande
        [22952] = true, -- Veras Darkshadow
    },
    ["Illidan Stormrage"] = {
        [22917] = true,
    },
}

encounters[Z.HYJAL_SUMMIT] = {
    "Rage Winterchill",
    "Anetheron",
    "Kaz'rogal",
    "Azgalor",
    "Archimonde",
}
triggers[Z.HYJAL_SUMMIT] = {
    [17767] = "Rage Winterchill",
    [17808] = "Anetheron",
    [17888] = "Kaz'rogal",
    [17842] = "Azgalor",
    [17968] = "Archimonde",
}
criteria[Z.HYJAL_SUMMIT] = {
    ["Rage Winterchill"] = {
        [17767] = true,
    },
    ["Anetheron"] = {
        [17808] = true,
    },
    ["Kaz'rogal"] = {
        [17888] = true,
    },
    ["Azgalor"] = {
        [17842] = true,
    },
    ["Archimonde"] = {
        [17968] = true,
    },
}

encounters[Z.OLD_HILLSBRAD_FOOTHILLS] = {
    "Lieutenant Drake",
    "Captain Skarloc",
    "Epoch Hunter",
}
triggers[Z.OLD_HILLSBRAD_FOOTHILLS] = {
    [17848] = "Lieutenant Drake",
    [17862] = "Captain Skarloc",
    [18096] = "Epoch Hunter",
}
criteria[Z.OLD_HILLSBRAD_FOOTHILLS] = {
    ["Lieutenant Drake"] = {
        [17848] = true,
    },
    ["Captain Skarloc"] = {
        [17862] = true,
    },
    ["Epoch Hunter"] = {
        [18096] = true,
    },
}

encounters[Z.THE_BLACK_MORASS] = {
    "Chrono Lord Deja",
    "Temporus",
    "Aeonus",
}
triggers[Z.THE_BLACK_MORASS] = {
    [17879] = "Chrono Lord Deja",
    [17880] = "Temporus",
    [17881] = "Aeonus",
}
criteria[Z.THE_BLACK_MORASS] = {
    ["Chrono Lord Deja"] = {
        [17879] = true,
    },
    ["Temporus"] = {
        [17880] = true,
    },
    ["Aeonus"] = {
        [17881] = true,
    },
}

encounters[Z.SERPENTSHRINE_CAVERN] = {
    "Hydross the Unstable",
    "The Lurker Below",
    "Leotheras the Blind",
    "Fathom-Lord Karathress",
    "Morogrim Tidewalker",
    "Lady Vashj",
}
triggers[Z.SERPENTSHRINE_CAVERN] = {
    [21216] = "Hydross the Unstable",
    [21217] = "The Lurker Below",
    [21215] = "Leotheras the Blind",
    [21214] = "Fathom-Lord Karathress",
    [21213] = "Morogrim Tidewalker",
    [21212] = "Lady Vashj",
}
criteria[Z.SERPENTSHRINE_CAVERN] = {
    ["Hydross the Unstable"] = {
        [21216] = true,
    },
    ["The Lurker Below"] = {
        [21217] = true,
    },
    ["Leotheras the Blind"] = {
        [21215] = true,
    },
    ["Fathom-Lord Karathress"] = {
        [21214] = true,
    },
    ["Morogrim Tidewalker"] = {
        [21213] = true,
    },
    ["Lady Vashj"] = {
        [21212] = true,
    },
}

encounters[Z.THE_SLAVE_PENS] = {
    "Mennu the Betrayer",
    "Rokmar the Crackler",
    "Quagmirran",
}
triggers[Z.THE_SLAVE_PENS] = {
    [17941] = "Mennu the Betrayer",
    [17991] = "Rokmar the Crackler",
    [17942] = "Quagmirran",
}
criteria[Z.THE_SLAVE_PENS] = {
    ["Mennu the Betrayer"] = {
        [17941] = true,
    },
    ["Rokmar the Crackler"] = {
        [17991] = true,
    },
    ["Quagmirran"] = {
        [17942] = true,
    },
}

encounters[Z.THE_STEAMVAULT] = {
    "Hydromancer Thespia",
    "Mekgineer Steamrigger",
    "Warlord Kalithresh",
}
triggers[Z.THE_STEAMVAULT] = {
    [17797] = "Hydromancer Thespia",
    [17796] = "Mekgineer Steamrigger",
    [17798] = "Warlord Kalithresh",
}
criteria[Z.THE_STEAMVAULT] = {
    ["Hydromancer Thespia"] = {
        [17797] = true,
    },
    ["Mekgineer Steamrigger"] = {
        [17796] = true,
    },
    ["Warlord Kalithresh"] = {
        [17798] = true,
    },
}

encounters[Z.THE_UNDERBOG] = {
    "Hungarfen",
    "Ghaz'an",
    "Swamplord Musel'ek",
    "The Black Stalker",
}
triggers[Z.THE_UNDERBOG] = {
    [17770] = "Hungarfen",
    [18105] = "Ghaz'an",
    [17826] = "Swamplord Musel'ek",
    [17882] = "The Black Stalker",
}
criteria[Z.THE_UNDERBOG] = {
    ["Hungarfen"] = {
        [17770] = true,
    },
    ["Ghaz'an"] = {
        [18105] = true,
    },
    ["Swamplord Musel'ek"] = {
        [17826] = true,
    },
    ["The Black Stalker"] = {
        [17882] = true,
    },
}

encounters[Z.GRUULS_LAIR] = {
    "High King Maulgar",
    "Gruul the Dragonkiller",
}
triggers[Z.GRUULS_LAIR] = {
    [18831] = "High King Maulgar", -- High King Maulgar
    [18832] = "High King Maulgar", -- Krosh Firehand
    [18834] = "High King Maulgar", -- Olm the Summoner
    [18835] = "High King Maulgar", -- Kiggler the Crazed
    [18836] = "High King Maulgar", -- Blindeye the Seer
    [19044] = "Gruul the Dragonkiller",
}
criteria[Z.GRUULS_LAIR] = {
    ["High King Maulgar"] = {
        [18831] = true, -- High King Maulgar
        [18832] = true, -- Krosh Firehand
        [18834] = true, -- Olm the Summoner
        [18835] = true, -- Kiggler the Crazed
        [18836] = true, -- Blindeye the Seer
    },
    ["Gruul the Dragonkiller"] = {
        [19044] = true,
    },
}

encounters[Z.HELLFIRE_RAMPARTS] = {
    "Watchkeeper Gargolmar",
    "Omor the Unscarred",
    "Nazan & Vazruden",
}
triggers[Z.HELLFIRE_RAMPARTS] = {
    [17306] = "Watchkeeper Gargolmar",
    [17308] = "Omor the Unscarred",
    [17537] = "Nazan & Vazruden", -- Vazruden
}
criteria[Z.HELLFIRE_RAMPARTS] = {
    ["Watchkeeper Gargolmar"] = {
        [17306] = true,
    },
    ["Omor the Unscarred"] = {
        [17308] = true,
    },
    ["Nazan & Vazruden"] = {
        [17536] = true, -- Nazan
        [17537] = true, -- Vazruden
    },
}

encounters[Z.MAGTHERIDONS_LAIR] = {
    "Magtheridon",
}
triggers[Z.MAGTHERIDONS_LAIR] = {
    [17257] = "Magtheridon",
}
criteria[Z.MAGTHERIDONS_LAIR] = {
    ["Magtheridon"] = {
        [17257] = true,
    },
}

encounters[Z.THE_BLOOD_FURNACE] = {
    "The Maker",
    "Broggok",
    "Keli'dan the Breaker",
}
triggers[Z.THE_BLOOD_FURNACE] = {
    [17381] = "The Maker",
    [17380] = "Broggok",
    [17377] = "Keli'dan the Breaker",
}
criteria[Z.THE_BLOOD_FURNACE] = {
    ["The Maker"] = {
        [17381] = true,
    },
    ["Broggok"] = {
        [17380] = true,
    },
    ["Keli'dan the Breaker"] = {
        [17377] = true,
    },
}

encounters[Z.THE_SHATTERED_HALLS] = {
    "Grand Warlock Nethekurse",
    "Blood Guard Porung",
    "Warbringer O'mrogg",
    "Warchief Kargath Bladefist",
}
triggers[Z.THE_SHATTERED_HALLS] = {
    [16807] = "Grand Warlock Nethekurse",
    [20923] = "Blood Guard Porung",
    [16809] = "Warbringer O'mrogg",
    [16808] = "Warchief Kargath Bladefist",
}
criteria[Z.THE_SHATTERED_HALLS] = {
    ["Grand Warlock Nethekurse"] = {
        [16807] = true,
    },
    ["Blood Guard Porung"] = {
        [20923] = true,
    },
    ["Warbringer O'mrogg"] = {
        [16809] = true,
    },
    ["Warchief Kargath Bladefist"] = {
        [16808] = true,
    },
}

encounters[Z.HELLFIRE_PENINSULA] = {
    "Doom Lord Kazzak",
}
triggers[Z.HELLFIRE_PENINSULA] = {
    [18728] = "Doom Lord Kazzak",
}
criteria[Z.HELLFIRE_PENINSULA] = {
    ["Doom Lord Kazzak"] = {
        [18728] = true,
    },
}

encounters[Z.SHADOWMOON_VALLEY] = {
    "Doomwalker",
}
triggers[Z.SHADOWMOON_VALLEY] = {
    [17711] = "Doomwalker",
}
criteria[Z.SHADOWMOON_VALLEY] = {
    ["Doomwalker"] = {
        [17711] = true,
    },
}

--    -------------------------------------------------------------------------------
--    -- Karazhan
--    -------------------------------------------------------------------------------
--    [15550] = true, -- Attumen the Huntsman
--    [16151] = true, -- Midnight
--    [15687] = true, -- Moroes
--    [16457] = true, -- Maiden of Virtue
--    [15691] = true, -- The Curator
--    [15688] = true, -- Terestian Illhoof
--    [16524] = true, -- Shade of Aran
--    [15689] = true, -- Netherspite
--    [15690] = true, -- Prince Malchezaar
--    [17225] = true, -- Nightbane
--    [17229] = true, -- Kil'rek
--    -- Chess event
--
--    -------------------------------------------------------------------------------
--    -- Karazhan: Servants' Quarters Beasts
--    -------------------------------------------------------------------------------
--    [16179] = true, -- Hyakiss the Lurker
--    [16181] = true, -- Rokad the Ravager
--    [16180] = true, -- Shadikith the Glider
--
--    -------------------------------------------------------------------------------
--    -- Karazhan: Opera Event
--    -------------------------------------------------------------------------------
--    [17535] = true, -- Dorothee
--    [17546] = true, -- Roar
--    [17543] = true, -- Strawman
--    [17547] = true, -- Tinhead
--    [17548] = true, -- Tito
--    [18168] = true, -- The Crone
--    [17521] = true, -- The Big Bad Wolf
--    [17533] = true, -- Romulo
--    [17534] = true, -- Julianne


encounters[Z.MAGISTERS_TERRACE] = {
    "Selin Fireheart",
    "Vexallus",
    "Priestess Delrissa",
    "Kael'thas Sunstrider",
}
triggers[Z.MAGISTERS_TERRACE] = {
    [24723] = "Selin Fireheart",
    [24744] = "Vexallus",
    [24560] = "Priestess Delrissa",
    [24664] = "Kael'thas Sunstrider",
}
criteria[Z.MAGISTERS_TERRACE] = {
    ["Selin Fireheart"] = {
        [24723] = true,
    },
    ["Vexallus"] = {
        [24744] = true,
    },
    ["Priestess Delrissa"] = {
        [24560] = true,
    },
    ["Kael'thas Sunstrider"] = {
        [24664] = true,
    },
}

encounters[Z.SUNWELL_PLATEAU] = {
    "Kalecgos & Sathrovarr",
    "Brutallus",
    "Felmyst",
    "Alythess & Sacrolash",
    "M'uru / Entropius",
    "Kil'jaeden",
}
triggers[Z.SUNWELL_PLATEAU] = {
    [24850] = "Kalecgos & Sathrovarr", -- Kalecgos
    [24882] = "Brutallus",
    [25038] = "Felmyst",
    [25165] = "Alythess & Sacrolash", -- Lady Sacrolash
    [25166] = "Alythess & Sacrolash", -- Grand Warlock Alythess
    [25741] = "M'uru / Entropius", -- M'uru
    [25315] = "Kil'jaeden",
}
criteria[Z.SUNWELL_PLATEAU] = {
    ["Kalecgos & Sathrovarr"] = {
        [24850] = true, -- Kalecgos
        [24892] = true, -- Sathrovarr the Corruptor
    },
    ["Brutallus"] = {
        [24882] = true, -- Brutallus
    },
    ["Felmyst"] = {
        [25038] = true, -- Felmyst
    },
    ["Alythess & Sacrolash"] = {
        [25165] = true, -- Lady Sacrolash
        [25166] = true, -- Grand Warlock Alythess
    },
    ["M'uru / Entropius"] = {
        [25840] = true, -- Entropius
    },
    ["Kil'jaeden"] = {
        [25315] = true, -- Kil'jaeden
    },
}

encounters[Z.THE_ARCATRAZ] = {
    "Zereketh the Unbound",
    "Dalliah the Doomsayer",
    "Wrath-Scryer Soccothrates",
    "Harbinger Skyriss",
}
encounters[Z.THE_ARCATRAZ] = {
    [20870] = "Zereketh the Unbound",
    [20885] = "Dalliah the Doomsayer",
    [20886] = "Wrath-Scryer Soccothrates",
    [20912] = "Harbinger Skyriss",
}
encounters[Z.THE_ARCATRAZ] = {
    ["Zereketh the Unbound"] = {
        [20870] = true,
    },
    ["Dalliah the Doomsayer"] = {
        [20885] = true,
    },
    ["Wrath-Scryer Soccothrates"] = {
        [20886] = true,
    },
    ["Harbinger Skyriss"] = {
        [20912] = true,
    },
}

encounters[Z.THE_BOTANICA] = {
    "Commander Sarannis",
    "High Botanist Freywinn",
    "Thorngrin the Tender",
    "Laj",
    "Warp Splinter",
}
triggers[Z.THE_BOTANICA] = {
    [17976] = "Commander Sarannis",
    [17975] = "High Botanist Freywinn",
    [17978] = "Thorngrin the Tender",
    [17980] = "Laj",
    [17977] = "Warp Splinter",
}
criteria[Z.THE_BOTANICA] = {
    ["Commander Sarannis"] = {
        [17976] = true,
    },
    ["High Botanist Freywinn"] = {
        [17975] = true,
    },
    ["Thorngrin the Tender"] = {
        [17978] = true,
    },
    ["Laj"] = {
        [17980] = true,
    },
    ["Warp Splinter"] = {
        [17977] = true,
    },
}

encounters["The Eye"] = {
    "Void Reaver",
    "Al'ar",
    "High Astromancer Solarian",
    "Kael'thas Sunstrider",
}
triggers["The Eye"] = {
    [19516] = "Void Reaver",
    [19514] = "Al'ar",
    [18805] = "High Astromancer Solarian",
    [20064] = "Kael'thas Sunstrider", -- Thaladred the Darkener
    [20060] = "Kael'thas Sunstrider", -- Lord Sanguinar
    [20062] = "Kael'thas Sunstrider", -- Grand Astromancer Capernian
    [20063] = "Kael'thas Sunstrider", -- Master Engineer Telonicus
}
criteria["The Eye"] = {
    ["Void Reaver"] = {
        [19516] = true,
    },
    ["Al'ar"] = {
        [19514] = true,
    },
    ["High Astromancer Solarian"] = {
        [18805] = true,
    },
    ["Kael'thas Sunstrider"] = {
        [19622] = true, -- Kael'thas Sunstrider
        [20064] = true, -- Thaladred the Darkener
        [20060] = true, -- Lord Sanguinar
        [20062] = true, -- Grand Astromancer Capernian
        [20063] = true, -- Master Engineer Telonicus
    },
}

encounters[Z.THE_MECHANAR] = {
    "Mechano-Lord Capacitus",
    "Nethermancer Sepethrea",
    "Pathaleon the Calculator",
}
triggers[Z.THE_MECHANAR] = {
    [19219] = "Mechano-Lord Capacitus",
    [19221] = "Nethermancer Sepethrea",
    [19220] = "Pathaleon the Calculator",
}
criteria[Z.THE_MECHANAR] = {
    ["Mechano-Lord Capacitus"] = {
        [19219] = true,
    },
    ["Nethermancer Sepethrea"] = {
        [19221] = true,
    },
    ["Pathaleon the Calculator"] = {
        [19220] = true,
    },
}
