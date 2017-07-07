local BossEncounters = LibStub:GetLibrary("LibBossEncountersYugoEdit-1.1")
local encounters = BossEncounters.zone_encounters
local triggers = BossEncounters.encounter_triggers
local criteria = BossEncounters.encounter_criteria

local Z = BossEncounters.zone_names

-------------------------------------------------------------------------------
-- Classic Dungeons
-------------------------------------------------------------------------------

encounters[Z.BLACKFATHOM_DEEPS] = {
    "Ghamoo-ra",
    "Lady Sarevess",
    "Gelihast",
    "Lorgus Jett",
    "Baron Aquanis",
    "Twilight Lord Kelris",
    "Old Serra'kis",
    "Aku'mai",
}
triggers[Z.BLACKFATHOM_DEEPS] = {
    [4887] = "Ghamoo-ra",
    [4831] = "Lady Sarevess",
    [6243] = "Gelihast",
    [12902] = "Lorgus Jett",
    [12876] = "Baron Aquanis",
    [4832] = "Twilight Lord Kelris",
    [4830] = "Old Serra'kis",
    [4829] = "Aku'mai",
}
criteria[Z.BLACKFATHOM_DEEPS] = {
    ["Ghamoo-ra"] = {
        [4887] = true,
    },
    ["Lady Sarevess"] = {
        [4831] = true,
    },
    ["Gelihast"] = {
        [6243] = true,
    },
    ["Lorgus Jett"] = {
        [12902] = true,
    },
    ["Baron Aquanis"] = {
        [12876] = true,
    },
    ["Twilight Lord Kelris"] = {
        [4832] = true,
    },
    ["Old Serra'kis"] = {
        [4830] = true,
    },
    ["Aku'mai"] = {
        [4829] = true,
    },
}

encounters[Z.BLACKROCK_DEPTHS] = {
    "Lord Roccor",
    "Bael'Gar",
    "Houndmaster Grebmar",
    "High Interrogator Gerstahn",
    "Gorosh the Dervish",
    "Grizzle",
    "Eviscerator",
    "Ok'thor the Breaker",
    "Anub'shiah",
    "Hedrum the Creeper",
    "Pyromancer Loregrain",
    "General Angerforge",
    "Golem Lord Argelmach",
    "Ribbly Screwspigot",
    "Hurley Blackbreath",
    "Plugger Spazzring",
    "Phalanx",
    "Lord Incendius",
    "Fineous Darkvire",
    "Warder Stilgiss & Verek",
    "Dark Keeper Bethek",
    "Dark Keeper Ofgut",
    "Dark Keeper Pelver",
    "Dark Keeper Uggel",
    "Dark Keeper Vorfalk",
    "Dark Keeper Zimrel",
    "Ambassador Flamelash",
    "The Seven",
    "Magmus",
    "Princess Moira Bronzebeard",
    "Emperor Dagran Thaurissan",
}
triggers[Z.BLACKROCK_DEPTHS] = {
    [9025] = "Lord Roccor",
    [9016] = "Bael'Gar",
    [9319] = "Houndmaster Grebmar",
    [9018] = "High Interrogator Gerstahn",
    [9027] = "Gorosh the Dervish",
    [9028] = "Grizzle",
    [9029] = "Eviscerator",
    [9030] = "Ok'thor the Breaker",
    [9031] = "Anub'shiah",
    [9032] = "Hedrum the Creeper",
    [9024] = "Pyromancer Loregrain",
    [9033] = "General Angerforge",
    [8983] = "Golem Lord Argelmach",
    [9543] = "Ribbly Screwspigot",
    [9537] = "Hurley Blackbreath",
    [9499] = "Plugger Spazzring",
    [9502] = "Phalanx",
    [9017] = "Lord Incendius",
    [9056] = "Fineous Darkvire",
    [9041] = "Warder Stilgiss & Verek", -- Warder Stilgiss
    [9042] = "Warder Stilgiss & Verek", -- Verek
    [9438] = "Dark Keeper Bethek",
    [9442] = "Dark Keeper Ofgut",
    [9443] = "Dark Keeper Pelver",
    [9439] = "Dark Keeper Uggel",
    [9437] = "Dark Keeper Vorfalk",
    [9441] = "Dark Keeper Zimrel",
    [9156] = "Ambassador Flamelash",
    [9035] = "The Seven", -- Anger'rel
    [9938] = "Magmus",
    [8929] = "Princess Moira Bronzebeard",
    [9019] = "Emperor Dagran Thaurissan",
}
criteria[Z.BLACKROCK_DEPTHS] = {
    ["Lord Roccor"] = {
        [9025] = true,
    },
    ["Bael'Gar"] = {
        [9016] = true,
    },
    ["Houndmaster Grebmar"] = {
        [9319] = true,
    },
    ["High Interrogator Gerstahn"] = {
        [9018] = true,
    },
    ["Gorosh the Dervish"] = {
        [9027] = true,
    },
    ["Grizzle"] = {
        [9028] = true,
    },
    ["Eviscerator"] = {
        [9029] = true,
    },
    ["Ok'thor the Breaker"] = {
        [9030] = true,
    },
    ["Anub'shiah"] = {
        [9031] = true,
    },
    ["Hedrum the Creeper"] = {
        [9032] = true,
    },
    ["Pyromancer Loregrain"] = {
        [9024] = true,
    },
    ["General Angerforge"] = {
        [9033] = true,
    },
    ["Golem Lord Argelmach"] = {
        [8983] = true,
    },
    ["Ribbly Screwspigot"] = {
        [9543] = true,
    },
    ["Hurley Blackbreath"] = {
        [9537] = true,
    },
    ["Plugger Spazzring"] = {
        [9499] = true,
    },
    ["Phalanx"] = {
        [9502] = true,
    },
    ["Lord Incendius"] = {
        [9017] = true,
    },
    ["Fineous Darkvire"] = {
        [9056] = true,
    },
    ["Warder Stilgiss & Verek"] = {
        [9041] = true, -- Warder Stilgiss
        [9042] = true, -- Verek
    },
    ["Dark Keeper Bethek"] = {
        [9438] = true,
    },
    ["Dark Keeper Ofgut"] = {
        [9442] = true,
    },
    ["Dark Keeper Pelver"] = {
        [9443] = true,
    },
    ["Dark Keeper Uggel"] = {
        [9439] = true,
    },
    ["Dark Keeper Vorfalk"] = {
        [9437] = true,
    },
    ["Dark Keeper Zimrel"] = {
        [9441] = true,
    },
    ["Ambassador Flamelash"] = {
        [9156] = true,
    },
    ["The Seven"] = {
        [9034] = true, -- Hate'rel
        [9035] = true, -- Anger'rel
        [9036] = true, -- Vile'rel
        [9037] = true, -- Gloom'rel
        [9038] = true, -- Seeth'rel
        [9039] = true, -- Doom'rel
        [9040] = true, -- Dope'rel
    },
    ["Magmus"] = {
        [9938] = true,
    },
    ["Princess Moira Bronzebeard"] = {
        [8929] = true,
    },
    ["Emperor Dagran Thaurissan"] = {
        [9019] = true,
    },
}

encounters[Z.BLACKROCK_SPIRE] = {
    -------------------------------------------------------------------------------
    -- Upper Blackrock Spire
    -------------------------------------------------------------------------------
    "Pyroguard Emberseer",
    "Gyth",
    "Warchief Rend Blackhand",
    "The Beast",
    "General Drakkisath",
    -------------------------------------------------------------------------------
    -- Lower Blackrock Spire
    -------------------------------------------------------------------------------
    "Highlord Omokk",
    "Shadow Hunter Vosh'gajin",
    "War Master Voone",
    "Mother Smolderweb",
    "Urok Doomhowl",
    "Quartermaster Zigris",
    "Gizrul the Slavener",
    "Halycon",
    "Overlord Wyrmthalak",
}
triggers[Z.BLACKROCK_SPIRE] = {
    -------------------------------------------------------------------------------
    -- Upper Blackrock Spire
    -------------------------------------------------------------------------------
    [9816] = "Pyroguard Emberseer",
    [10339] = "Gyth",
    [10429] = "Warchief Rend Blackhand,",
    [10430] = "The Beast",
    [10363] = "General Drakkisath",
    -------------------------------------------------------------------------------
    -- Lower Blackrock Spire
    -------------------------------------------------------------------------------
    [9196] = "Highlord Omokk",
    [9236] = "Shadow Hunter Vosh'gajin",
    [9237] = "War Master Voone",
    [10596] = "Mother Smolderweb",
    [10584] = "Urok Doomhowl",
    [9736] = "Quartermaster Zigris",
    [10268] = "Gizrul the Slavener",
    [10220] = "Halycon",
    [9568] = "Overlord Wyrmthalak",
}
criteria[Z.BLACKROCK_SPIRE] = {
    -------------------------------------------------------------------------------
    -- Upper Blackrock Spire
    -------------------------------------------------------------------------------
    ["Pyroguard Emberseer"] = {
        [9816] = true,
    },
    ["Gyth"] = {
        [10339] = true,
    },
    ["Warchief Rend Blackhand"] = {
        [10429] = true,
    },
    ["The Beast"] = {
        [10430] = true,
    },
    ["General Drakkisath"] = {
        [10363] = true,
    },
    -------------------------------------------------------------------------------
    -- Lower Blackrock Spire
    -------------------------------------------------------------------------------
    ["Highlord Omokk"] = {
        [9196] = true,
    },
    ["Shadow Hunter Vosh'gajin"] = {
        [9236] = true,
    },
    ["War Master Voone"] = {
        [9237] = true,
    },
    ["Mother Smolderweb"] = {
        [10596] = true,
    },
    ["Urok Doomhowl"] = {
        [10584] = true,
    },
    ["Quartermaster Zigris"] = {
        [9736] = true,
    },
    ["Gizrul the Slavener"] = {
        [10268] = true,
    },
    ["Halycon"] = {
        [10220] = true,
    },
    ["Overlord Wyrmthalak"] = {
        [9568] = true,
    },
}

encounters[Z.BLACKWING_LAIR] = {
    "Razorgore the Untamed",
    "Vaelastrasz the Corrupt",
    "Broodlord Lashlayer",
    "Firemaw",
    "Ebonroc",
    "Flamegor",
    "Chromaggus",
    "Nefarian",
}
triggers[Z.BLACKWING_LAIR] = {
    [12435] = "Razorgore the Untamed",
    [13020] = "Vaelastrasz the Corrupt",
    [12017] = "Broodlord Lashlayer",
    [11983] = "Firemaw",
    [14601] = "Ebonroc",
    [11981] = "Flamegor",
    [14020] = "Chromaggus",
    [11583] = "Nefarian",
}
criteria[Z.BLACKWING_LAIR] = {
    ["Razorgore the Untamed"] = {
        [12435] = true,
    },
    ["Vaelastrasz the Corrupt"] = {
        [13020] = true,
    },
    ["Broodlord Lashlayer"] = {
        [12017] = true,
    },
    ["Firemaw"] = {
        [11983] = true,
    },
    ["Ebonroc"] = {
        [14601] = true,
    },
    ["Flamegor"] = {
        [11981] = true,
    },
    ["Chromaggus"] = {
        [14020] = true,
    },
    ["Nefarian"] = {
        [11583] = true,
    },
}

encounters[Z.DIRE_MAUL] = {
    "Zevrim Thornhoof",
    "Hydrospawn",
    "Lethtendris",
    "Alzzin the Wildshaper",
    "Guard Mol'dar",
    "Stomper Kreeg",
    "Guard Fengus",
    "Guard Slip'kik",
    "Captain Kromcrush",
    "King Gordok",
    "Cho'Rush the Observer",
    "Tendris Warpwood",
    "Illyanna Ravenoak",
    "Magister Kalendris",
    "Immol'thar",
    "Prince Tortheldrin",
}
triggers[Z.DIRE_MAUL] = {
    [11490] = "Zevrim Thornhoof",
    [13280] = "Hydrospawn",
    [14327] = "Lethtendris",
    [11492] = "Alzzin the Wildshaper",
    [14326] = "Guard Mol'dar",
    [14322] = "Stomper Kreeg",
    [14321] = "Guard Fengus",
    [14323] = "Guard Slip'kik",
    [14325] = "Captain Kromcrush",
    [11501] = "King Gordok",
    [14324] = "Cho'Rush the Observer",
    [11489] = "Tendris Warpwood",
    [11488] = "Illyanna Ravenoak",
    [11487] = "Magister Kalendris",
    [11496] = "Immol'thar",
    [11486] = "Prince Tortheldrin",
}
criteria[Z.DIRE_MAUL] = {
    ["Zevrim Thornhoof"] = {
        [11490] = true,
    },
    ["Hydrospawn"] = {
        [13280] = true,
    },
    ["Lethtendris"] = {
        [14327] = true,
    },
    ["Alzzin the Wildshaper"] = {
        [11492] = true,
    },
    ["Guard Mol'dar"] = {
        [14326] = true,
    },
    ["Stomper Kreeg"] = {
        [14322] = true,
    },
    ["Guard Fengus"] = {
        [14321] = true,
    },
    ["Guard Slip'kik"] = {
        [14323] = true,
    },
    ["Captain Kromcrush"] = {
        [14325] = true,
    },
    ["King Gordok"] = {
        [11501] = true,
    },
    ["Cho'Rush the Observer"] = {
        [14324] = true,
    },
    ["Tendris Warpwood"] = {
        [11489] = true,
    },
    ["Illyanna Ravenoak"] = {
        [11488] = true,
    },
    ["Magister Kalendris"] = {
        [11487] = true,
    },
    ["Immol'thar"] = {
        [11496] = true,
    },
    ["Prince Tortheldrin"] = {
        [11486] = true,
    },
}

encounters[Z.GNOMEREGAN] = {
    "Viscous Fallout",
    "Grubbis",
    "Electrocutioner 6000",
    "Crowd Pummeler 9-60",
    "Mekgineer Thermaplugg",
}
triggers[Z.GNOMEREGAN] = {
    [7079] = "Viscous Fallout",
    [7361] = "Grubbis",
    [6235] = "Electrocutioner 6000",
    [6229] = "Crowd Pummeler 9-60",
    [7800] = "Mekgineer Thermaplugg",
}
criteria[Z.GNOMEREGAN] = {
    ["Viscous Fallout"] = {
        [7079] = true,
    },
    ["Grubbis"] = {
        [7361] = true,
    },
    ["Electrocutioner 6000"] = {
        [6235] = true,
    },
    ["Crowd Pummeler 9-60"] = {
        [6229] = true,
    },
    ["Mekgineer Thermaplugg"] = {
        [7800] = true,
    },
}

encounters[Z.MARAUDON] = {
    "Noxxion",
    "Razorlash",
    "Lord Vyletongue",
    "Celebras the Cursed",
    "Landslide",
    "Tinkerer Gizlock",
    "Rotgrip",
    "Princess Theradras"
}
triggers[Z.MARAUDON] = {
    [13282] = "Noxxion",
    [12258] = "Razorlash",
    [12236] = "Lord Vyletongue",
    [12225] = "Celebras the Cursed",
    [12203] = "Landslide",
    [13601] = "Tinkerer Gizlock",
    [13596] = "Rotgrip",
    [12201] = "Princess Theradras"
}
criteria[Z.MARAUDON] = {
    ["Noxxion"] = {
        [13282] = true,
    },
    ["Razorlash"] = {
        [12258] = true,
    },
    ["Lord Vyletongue"] = {
        [12236] = true,
    },
    ["Celebras the Cursed"] = {
        [12225] = true,
    },
    ["Landslide"] = {
        [12203] = true,
    },
    ["Tinkerer Gizlock"] = {
        [13601] = true,
    },
    ["Rotgrip"] = {
        [13596] = true,
    },
    ["Princess Theradras"] = {
        [12201] = true,
    },
}

encounters[Z.MOLTEN_CORE] = {
    "Lucifron",
    "Magmadar",
    "Gehennas",
    "Garr",
    "Shazzrah",
    "Baron Geddon",
    "Golemagg the Incinerator",
    "Sulfuron Harbinger",
    "Majordomo Executus",
    "Ragnaros",
}
triggers[Z.MOLTEN_CORE] = {
    [12118] = "Lucifron",
    [11982] = "Magmadar",
    [12259] = "Gehennas",
    [12057] = "Garr",
    [12264] = "Shazzrah",
    [12056] = "Baron Geddon",
    [11988] = "Golemagg the Incinerator",
    [12098] = "Sulfuron Harbinger",
    [12018] = "Majordomo Executus",
    [11502] = "Ragnaros",
}
criteria[Z.MOLTEN_CORE] = {
    ["Lucifron"] = {
        [12118] = true,
    },
    ["Magmadar"] = {
        [11982] = true,
    },
    ["Gehennas"] = {
        [12259] = true,
    },
    ["Garr"] = {
        [12057] = true,
    },
    ["Shazzrah"] = {
        [12264] = true,
    },
    ["Baron Geddon"] = {
        [12056] = true,
    },
    ["Golemagg the Incinerator"] = {
        [11988] = true,
    },
    ["Sulfuron Harbinger"] = {
        [12098] = true,
    },
    ["Majordomo Executus"] = {
        [12018] = true,
    },
    ["Ragnaros"] = {
        [11502] = true,
    },
}

encounters[Z.ONYXIAS_LAIR] = {
    "Onyxia"
}
triggers[Z.ONYXIAS_LAIR] = {
    [10184] = "Onyxia"
}
criteria[Z.ONYXIAS_LAIR] = {
    ["Onyxia"] = {
        [10184] = true,
    }
}

encounters[Z.RAGEFIRE_CHASM] = {
    "Oggleflint",
    "Jergosh the Invoker",
    "Bazzalan",
    "Taragaman the Hungerer",
    "Zelemar the Wrathful",
}
triggers[Z.RAGEFIRE_CHASM] = {
    [11517] = "Oggleflint",
    [11518] = "Jergosh the Invoker",
    [11519] = "Bazzalan",
    [11520] = "Taragaman the Hungerer",
    [17830] = "Zelemar the Wrathful",
}
criteria[Z.RAGEFIRE_CHASM] = {
    ["Oggleflint"] = {
        [11517] = true,
    },
    ["Jergosh the Invoker"] = {
        [11518] = true,
    },
    ["Bazzalan"] = {
        [11519] = true,
    },
    ["Taragaman the Hungerer"] = {
        [11520] = true,
    },
    ["Zelemar the Wrathful"] = {
        [17830] = true,
    }
}

encounters[Z.RAZORFEN_DOWNS] = {
    "Tuten'kash",
    "Mordresh Fire Eye",
    "Glutton",
    "Amnennar the Coldbringer",
}
triggers[Z.RAZORFEN_DOWNS] = {
    [7355] = "Tuten'kash",
    [7357] = "Mordresh Fire Eye",
    [8567] = "Glutton",
    [7358] = "Amnennar the Coldbringer",
}
criteria[Z.RAZORFEN_DOWNS] = {
    ["Tuten'kash"] = {
        [7355] = true,
    },
    ["Mordresh Fire Eye"] = {
        [7357] = true,
    },
    ["Glutton"] = {
        [8567] = true,
    },
    ["Amnennar the Coldbringer"] = {
        [7358] = true,
    },
}

encounters[Z.RAZORFEN_KRAUL] = {
    "Roogug",
    "Aggem Thorncurse",
    "Death Speaker Jargba",
    "Overlord Ramtusk",
    "Agathelos the Raging",
    "Charlga Razorflank",
}
triggers[Z.RAZORFEN_KRAUL] = {
    [6168] = "Roogug",
    [4424] = "Aggem Thorncurse",
    [4428] = "Death Speaker Jargba",
    [4420] = "Overlord Ramtusk",
    [4422] = "Agathelos the Raging",
    [4421] = "Charlga Razorflank",
}
criteria[Z.RAZORFEN_KRAUL] = {
    ["Roogug"] = {
        [6168] = true,
    },
    ["Aggem Thorncurse"] = {
        [4424] = true,
    },
    ["Death Speaker Jargba"] = {
        [4428] = true,
    },
    ["Overlord Ramtusk"] = {
        [4420] = true,
    },
    ["Agathelos the Raging"] = {
        [4422] = true,
    },
    ["Charlga Razorflank"] = {
        [4421] = true,
    },
}

encounters[Z.RUINS_OF_AHNQIRAJ] = {
    "Kurinnaxx",
    "General Rajaxx",
    "Moam",
    "Buru the Gorger",
    "Ayamiss the Hunter",
    "Ossirian the Unscarred",
}
triggers[Z.RUINS_OF_AHNQIRAJ] = {
    [15348] = "Kurinnaxx",
    [15341] = "General Rajaxx",
    [15340] = "Moam",
    [15370] = "Buru the Gorger",
    [15369] = "Ayamiss the Hunter",
    [15339] = "Ossirian the Unscarred",
}
criteria[Z.RUINS_OF_AHNQIRAJ] = {
    ["Kurinnaxx"] = {
        [15348] = true,
    },
    ["General Rajaxx"] = {
        [15341] = true,
    },
    ["Moam"] = {
        [15340] = true,
    },
    ["Buru the Gorger"] = {
        [15370] = true,
    },
    ["Ayamiss the Hunter"] = {
        [15369] = true,
    },
    ["Ossirian the Unscarred"] = {
        [15339] = true,
    },
}

encounters[Z.THE_STOCKADE] = {
    "Randolph Moloch",
    "Lord Overheat",
    "Hogger",
}
triggers[Z.THE_STOCKADE] = {
    [46383] = "Randolph Moloch",
    [46264] = "Lord Overheat",
    [46254] = "Hogger",
}
criteria[Z.THE_STOCKADE] = {
    ["Randolph Moloch"] = {
        [46383] = true,
    },
    ["Lord Overheat"] = {
        [46264] = true,
    },
    ["Hogger"] = {
        [46254] = true,
    },
}

encounters[Z.STRATHOLME] = {
    -------------------------------------------------------------------------------
    -- Main Gate
    -------------------------------------------------------------------------------
    "The Unforgiven",
    "Hearthsinger Forresten",
    "Timmy the Cruel",
    "Commander Malor",
    "Willey Hopebreaker",
    "Instructor Galford",
    "Balnazzar",

    -------------------------------------------------------------------------------
    -- Service Gate
    -------------------------------------------------------------------------------
    "Baroness Anastari",
    "Nerub'enkan",
    "Maleki the Pallid",
    "Magistrate Barthilas",
    "Ramstein the Gorger",
    "Lord Aurius Rivendare",
}
triggers[Z.STRATHOLME] = {
    -------------------------------------------------------------------------------
    -- Main Gate
    -------------------------------------------------------------------------------
    [10516] = "The Unforgiven",
    [10558] = "Hearthsinger Forresten",
    [10808] = "Timmy the Cruel",
    [11032] = "Commander Malor",
    [10997] = "Willey Hopebreaker",
    [10811] = "Instructor Galford",
    [10813] = "Balnazzar",

    -------------------------------------------------------------------------------
    -- Service Gate
    -------------------------------------------------------------------------------
    [10436] = "Baroness Anastari",
    [10437] = "Nerub'enkan",
    [10438] = "Maleki the Pallid",
    [10435] = "Magistrate Barthilas",
    [10439] = "Ramstein the Gorger",
    [45412] = "Lord Aurius Rivendare",
}
criteria[Z.STRATHOLME] = {
    -------------------------------------------------------------------------------
    -- Main Gate
    -------------------------------------------------------------------------------
    ["The Unforgiven"] = {
        [10516] = true,
    },
    ["Hearthsinger Forresten"] = {
        [10558] = true,
    },
    ["Timmy the Cruel"] = {
        [10808] = true,
    },
    ["Commander Malor"] = {
        [11032] = true,
    },
    ["Willey Hopebreaker"] = {
        [10997] = true,
    },
    ["Instructor Galford"] = {
        [10811] = true,
    },
    ["Balnazzar"] = {
        [10813] = true,
    },

    -------------------------------------------------------------------------------
    -- Service Gate
    -------------------------------------------------------------------------------
    ["Baroness Anastari"] = {
        [10436] = true,
    },
    ["Nerub'enkan"] = {
        [10437] = true,
    },
    ["Maleki the Pallid"] = {
        [10438] = true,
    },
    ["Magistrate Barthilas"] = {
        [10435] = true,
    },
    ["Ramstein the Gorger"] = {
        [10439] = true,
    },
    ["Lord Aurius Rivendare"] = {
        [45412] = true,
    },
}

encounters["Temple of Ahn'Qiraj"] = {
    "The Prophet Skeram",
    "Battleguard Sartura",
    "Fankriss the Unyielding",
    "Princess Huhuran",
    "Twin Emperors",
    "C'Thun",
    "Silithid Royalty",
    "Viscidus",
    "Ouro",
}
triggers["Temple of Ahn'Qiraj"] = {
    [15263] = "The Prophet Skeram",
    [15516] = "Battleguard Sartura",
    [15510] = "Fankriss the Unyielding",
    [15509] = "Princess Huhuran",
    [15275] = "Twin Emperors", -- Emperor Vek'nilash
    [15276] = "Twin Emperors", -- Emperor Vek'lor
    [15589] = "C'Thun", -- Eye of C'Thun
    [15543] = "Silithid Royalty", -- Princess Yauj
    [15544] = "Silithid Royalty", -- Vem
    [15511] = "Silithid Royalty", -- Lord Kri
    [15299] = "Viscidus",
    [15517] = "Ouro",
}
criteria["Temple of Ahn'Qiraj"] = {
    ["The Prophet Skeram"] = {
        [15263] = true,
    },
    ["Battleguard Sartura"] = {
        [15516] = true,
    },
    ["Fankriss the Unyielding"] = {
        [15510] = true,
    },
    ["Princess Huhuran"] = {
        [15509] = true,
    },
    ["Twin Emperors"] = {
        [15275] = true, -- Emperor Vek'nilash
        [15276] = true, -- Emperor Vek'lor
    },
    ["C'Thun"] = {
        [15727] = true,
    },
    ["Silithid Royalty"] = {
        [15511] = true, -- Lord Kri
        [15543] = true, -- Princess Yauj
        [15544] = true, -- Vem
    },
    ["Viscidus"] = {
        [15299] = true,
    },
    ["Ouro"] = {
        [15517] = true,
    },
}

encounters[Z.THE_TEMPLE_OF_ATALHAKKAR] = {
    "Jammal'an the Prophet",
    "Avatar of Hakkar",
    "Shade of Eranikus",
}
triggers[Z.THE_TEMPLE_OF_ATALHAKKAR] = {
    [5710] = "Jammal'an the Prophet",
    [8440] = "Avatar of Hakkar",
    [5709] = "Shade of Eranikus",
}
criteria[Z.THE_TEMPLE_OF_ATALHAKKAR] = {
    ["Jammal'an the Prophet"] = {
        [5710] = true,
    },
    ["Avatar of Hakkar"] = {
        [8440] = true,
    },
    ["Shade of Eranikus"] = {
        [5709] = true,
    },
}

encounters[Z.ULDAMAN] = {
    "Revelosh",
    "The Lost Dwarves",
    "Ironaya",
    "Obsidian Sentinel",
    "Ancient Stone Keeper",
    "Galgann Firehammer",
    "Grimlok",
    "Archaedas",
}
triggers[Z.ULDAMAN] = {
    [6910] = "Revelosh",
    [6906] = "The Lost Dwarves", -- Baelog
    [6907] = "The Lost Dwarves", -- Eric "The Swift"
    [6908] = "The Lost Dwarves", -- Olaf
    [7228] = "Ironaya",
    [7023] = "Obsidian Sentinel",
    [7206] = "Ancient Stone Keeper",
    [7291] = "Galgann Firehammer",
    [4854] = "Grimlok",
    [2748] = "Archaedas",
}
criteria[Z.ULDAMAN] = {
    ["Revelosh"] = {
        [6910] = true,
    },
    ["The Lost Dwarves"] = {
        [6906] = true, -- Baelog
        [6907] = true, -- Eric "The Swift"
        [6908] = true, -- Olaf
    },
    ["Ironaya"] = {
        [7228] = true,
    },
    ["Obsidian Sentinel"] = {
        [7023] = true,
    },
    ["Ancient Stone Keeper"] = {
        [7206] = true,
    },
    ["Galgann Firehammer"] = {
        [7291] = true,
    },
    ["Grimlok"] = {
        [4854] = true,
    },
    ["Archaedas"] = {
        [2748] = true,
    },
}

encounters[Z.WAILING_CAVERNS] = {
    "Lady Anacondra",
    "Lord Cobrahn",
    "Kresh",
    "Lord Pythas",
    "Skum",
    "Lord Serpentis",
    "Verdan the Everliving",
    "Mutanus the Devourer",
}
triggers[Z.WAILING_CAVERNS] = {
    [3671] = "Lady Anacondra",
    [3669] = "Lord Cobrahn",
    [3653] = "Kresh",
    [3670] = "Lord Pythas",
    [3674] = "Skum",
    [3673] = "Lord Serpentis",
    [5775] = "Verdan the Everliving",
    [3654] = "Mutanus the Devourer",
}
criteria[Z.WAILING_CAVERNS] = {
    ["Lady Anacondra"] = {
        [3671] = true,
    },
    ["Lord Cobrahn"] = {
        [3669] = true,
    },
    ["Kresh"] = {
        [3653] = true,
    },
    ["Lord Pythas"] = {
        [3670] = true,
    },
    ["Skum"] = {
        [3674] = true,
    },
    ["Lord Serpentis"] = {
        [3673] = true,
    },
    ["Verdan the Everliving"] = {
        [5775] = true,
    },
    ["Mutanus the Devourer"] = {
        [3654] = true,
    },
}

encounters[Z.ZULFARRAK] = {
    "Antu'sul",
    "Theka the Martyr",
    "Witch Doctor Zum'rah",
    "Nekrum Gutchewer",
    "Hydromancer Velrath",
    "Gahz'rilla",
    "Shadowpriest Sezz'ziz",
    "Ruuzlu",
    "Chief Ukorz Sandscalp",
}
triggers[Z.ZULFARRAK] = {
    [8127] = "Antu'sul",
    [7272] = "Theka the Martyr",
    [7271] = "Witch Doctor Zum'rah",
    [7796] = "Nekrum Gutchewer",
    [7795] = "Hydromancer Velrath",
    [7273] = "Gahz'rilla",
    [7275] = "Shadowpriest Sezz'ziz",
    [7797] = "Ruuzlu",
    [7267] = "Chief Ukorz Sandscalp",
}
criteria[Z.ZULFARRAK] = {
    ["Antu'sul"] = {
        [8127] = true,
    },
    ["Theka the Martyr"] = {
        [7272] = true,
    },
    ["Witch Doctor Zum'rah"] = {
        [7271] = true,
    },
    ["Nekrum Gutchewer"] = {
        [7796] = true,
    },
    ["Hydromancer Velrath"] = {
        [7795] = true,
    },
    ["Gahz'rilla"] = {
        [7273] = true,
    },
    ["Shadowpriest Sezz'ziz"] = {
        [7275] = true,
    },
    ["Ruuzlu"] = {
        [7797] = true,
    },
    ["Chief Ukorz Sandscalp"] = {
        [7267] = true,
    },
}

