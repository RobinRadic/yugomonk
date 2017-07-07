local BossEncounters = LibStub:GetLibrary("LibBossEncountersYugoEdit-1.1")
local encounters = BossEncounters.zone_encounters
local triggers = BossEncounters.encounter_triggers
local criteria = BossEncounters.encounter_criteria

local Z = BossEncounters.zone_names

-------------------------------------------------------------------------------
-- Mists of Pandaria Dungeons
-------------------------------------------------------------------------------
encounters[Z.GATE_OF_THE_SETTING_SUN] = {
    "Saboteur Kip'tilak",
    "Striker Ga'dok",
    "Commander Ri'mok",
    "Raigonn",
}
triggers[Z.GATE_OF_THE_SETTING_SUN] = {
    [56906] = "Saboteur Kip'tilak",
    [56589] = "Striker Ga'dok",
    [56636] = "Commander Ri'mok",
    [56877] = "Raigonn",
}
criteria[Z.GATE_OF_THE_SETTING_SUN] = {
    ["Saboteur Kip'tilak"] = {
        [56906] = true,
    },
    ["Striker Ga'dok"] = {
        [56589] = true,
    },
    ["Commander Ri'mok"] = {
        [56636] = true,
    },
    ["Raigonn"] = {
        [56877] = true,
    },
}

encounters[Z.MOGUSHAN_PALACE] = {
    "Trial of the King",
    "Gekkan",
    "Xin the Weaponmaster",
}
triggers[Z.MOGUSHAN_PALACE] = {
    [61442] = "Trial of the King", -- Kuai the Brute
    [61444] = "Trial of the King", -- Ming the Cunning
    [61445] = "Trial of the King", -- Haiyan the Unstoppable
    [61243] = "Gekkan",
    [61398] = "Xin the Weaponmaster",
}
criteria[Z.MOGUSHAN_PALACE] = {
    ["Trial of the King"] = {
        [61442] = true, -- Kuai the Brute
        [61444] = true, -- Ming the Cunning
        [61445] = true, -- Haiyan the Unstoppable
    },
    ["Gekkan"] = {
        [61243] = true,
    },
    ["Xin the Weaponmaster"] = {
        [61398] = true,
    },
}

encounters[Z.SCARLET_HALLS] = {
    "Houndmaster Braun",
    "Armsmaster Harlan",
    "Flameweaver Koegler",
}
triggers[Z.SCARLET_HALLS] = {
    [59303] = "Houndmaster Braun",
    [58632] = "Armsmaster Harlan",
    [59150] = "Flameweaver Koegler",
}
criteria[Z.SCARLET_HALLS] = {
    ["Houndmaster Braun"] = {
        [59303] = true,
    },
    ["Armsmaster Harlan"] = {
        [58632] = true,
    },
    ["Flameweaver Koegler"] = {
        [59150] = true,
    },
}

encounters[Z.SCARLET_MONASTERY] = {
    "Thalnos the Soulrender",
    "Brother Korloff",
    "High Inquisitor Whitemane",
}
triggers[Z.SCARLET_MONASTERY] = {
    [59789] = "Thalnos the Soulrender",
    [59223] = "Brother Korloff",
    [60040] = "High Inquisitor Whitemane", -- Commander Durand
}
criteria[Z.SCARLET_MONASTERY] = {
    ["Thalnos the Soulrender"] = {
        [59789] = true,
    },
    ["Brother Korloff"] = {
        [59223] = true,
    },
    ["High Inquisitor Whitemane"] = {
        [60040] = true, -- Commander Durand
        [3977] = true, -- High Inquisitor Whitemane
    },
}

encounters[Z.SCHOLOMANCE] = {
    "Instructor Chillheart",
    "Jandice Barov",
    "Rattlegore",
    "Lilian Voss",
    "Darkmaster Gandling",
}
triggers[Z.SCHOLOMANCE] = {
    [58633] = "Instructor Chillheart",
    [59184] = "Jandice Barov",
    [59153] = "Rattlegore",
    [58722] = "Lilian Voss",
    [59080] = "Darkmaster Gandling",
}
criteria[Z.SCHOLOMANCE] = {
    ["Instructor Chillheart"] = {
        [58633] = true,
    },
    ["Jandice Barov"] = {
        [59184] = true,
    },
    ["Rattlegore"] = {
        [59153] = true,
    },
    ["Lilian Voss"] = {
        [58722] = true,
    },
    ["Darkmaster Gandling"] = {
        [59080] = true,
    },
}

encounters[Z.SHADO_PAN_MONASTERY] = {
    "Gu Cloudstrike",
    "Master Snowdrift",
    "Sha of Violence",
    "Taran Zhu",
}
triggers[Z.SHADO_PAN_MONASTERY] = {
    [56747] = "Gu Cloudstrike",
    [56541] = "Master Snowdrift",
    [56719] = "Sha of Violence",
    [56884] = "Taran Zhu",
}
criteria[Z.SHADO_PAN_MONASTERY] = {
    ["Gu Cloudstrike"] = {
        [56747] = true,
    },
    ["Master Snowdrift"] = {
        [56541] = true,
    },
    ["Sha of Violence"] = {
        [56719] = true,
    },
    ["Taran Zhu"] = {
        [56884] = true,
    },
}

encounters[Z.SIEGE_OF_NIUZAO_TEMPLE] = {
    "Vizier Jin'bak",
    "Commander Vo'jak",
    "General Pa'valak",
    "Wing Leader Ner'onok"
}
triggers[Z.SIEGE_OF_NIUZAO_TEMPLE] = {
    [61567] = "Vizier Jin'bak",
    [61634] = "Commander Vo'jak",
    [61485] = "General Pa'valak",
    [62205] = "Wing Leader Ner'onok",
}
criteria[Z.SIEGE_OF_NIUZAO_TEMPLE] = {
    ["Vizier Jin'bak"] = {
        [61567] = true,
    },
    ["Commander Vo'jak"] = {
        [61634] = true,
    },
    ["General Pa'valak"] = {
        [61485] = true,
    },
    ["Wing Leader Ner'onok"] = {
        [62205] = true,
    },
}

encounters[Z.STORMSTOUT_BREWERY] = {
    "Ook-Ook",
    "Hoptallus",
    "Yan-Zhu the Uncasked",
}
triggers[Z.STORMSTOUT_BREWERY] = {
    [56637] = "Ook-Ook",
    [56717] = "Hoptallus",
    [59479] = "Yan-Zhu the Uncasked",
}
criteria[Z.STORMSTOUT_BREWERY] = {
    ["Ook-Ook"] = {
        [56637] = true,
    },
    ["Hoptallus"] = {
        [56717] = true,
    },
    ["Yan-Zhu the Uncasked"] = {
        [59479] = true,
    },
}

encounters[Z.TEMPLE_OF_THE_JADE_SERPENT] = {
    "Wise Mari",
    "Lorewalker Stonestep",
    "Liu Flameheart",
    "Sha of Doubt",
}
triggers[Z.TEMPLE_OF_THE_JADE_SERPENT] = {
    [56448] = "Wise Mari",
    [56843] = "Lorewalker Stonestep",
    [56732] = "Liu Flameheart",
    [56439] = "Sha of Doubt",
}
criteria[Z.TEMPLE_OF_THE_JADE_SERPENT] = {
    ["Wise Mari"] = {
        [56448] = true,
    },
    ["Lorewalker Stonestep"] = {
        [56843] = true,
    },
    ["Liu Flameheart"] = {
        [56732] = true,
    },
    ["Sha of Doubt"] = {
        [56439] = true,
    },
}

-------------------------------------------------------------------------------
-- Mists of Pandaria Raids
-------------------------------------------------------------------------------
encounters[Z.HEART_OF_FEAR] = {
    "Imperial Vizier Zor'lok",
    "Blade Lord Ta'yak",
    "Garalon",
    "Wind Lord Mel'jarak",
    "Amber-Shaper Un'sok",
    "Grand Empress Shek'zeer",
}
triggers[Z.HEART_OF_FEAR] = {
    [66791] = "Imperial Vizier Zor'lok",
    [63664] = "Blade Lord Ta'yak",
    [63667] = "Garalon",
    [65501] = "Wind Lord Mel'jarak",
    [63666] = "Amber-Shaper Un'sok",
    [62837] = "Grand Empress Shek'zeer",
}
criteria[Z.HEART_OF_FEAR] = {
    ["Imperial Vizier Zor'lok"] = {
        [66791] = true,
    },
    ["Blade Lord Ta'yak"] = {
        [63664] = true,
    },
    ["Garalon"] = {
        [63667] = true,
    },
    ["Wind Lord Mel'jarak"] = {
        [65501] = true,
    },
    ["Amber-Shaper Un'sok"] = {
        [62711] = true, -- Amber Monstrosity
        [63666] = true, -- Amber-Shaper Un'sok
    },
    ["Grand Empress Shek'zeer"] = {
        [62837] = "Grand Empress Shek'zeer",
    },
}

encounters[Z.MOGUSHAN_VAULTS] = {
    "The Stone Guard",
    "Feng the Accursed",
    "Gara'jal the Spiritbinder",
    "The Spirit Kings",
    "Elegon",
    "Will of the Emperor",
}
triggers[Z.MOGUSHAN_VAULTS] = {
    [60047] = "The Stone Guard", -- Amethyst Guardian
    [60051] = "The Stone Guard", -- Cobalt Guardian
    [60043] = "The Stone Guard", -- Jade Guardian
    [59915] = "The Stone Guard", -- Jasper Guardian
    [60009] = "Feng the Accursed",
    [60143] = "Gara'jal the Spiritbinder",
    [61421] = "The Spirit Kings", -- Zian of the Endless Shadow
    [61429] = "The Spirit Kings", -- Meng the Demented
    [61423] = "The Spirit Kings", -- Qiang the Merciless
    [61427] = "The Spirit Kings", -- Subetai the Swift
    [60410] = "Elegon",
    [60400] = "Will of the Emperor", -- Jan-xi
    [60399] = "Will of the Emperor", -- Qin-xi
}
criteria[Z.MOGUSHAN_VAULTS] = {
    ["The Stone Guard"] = {
        [60047] = true, -- Amethyst Guardian
        [60051] = true, -- Cobalt Guardian
        [60043] = true, -- Jade Guardian
        [59915] = true, -- Jasper Guardian
    },
    ["Feng the Accursed"] = {
        [60009] = true,
    },
    ["Gara'jal the Spiritbinder"] = {
        [60143] = true,
    },
    ["The Spirit Kings"] = {
        [61421] = true, -- Zian of the Endless Shadow
        [61429] = true, -- Meng the Demented
        [61423] = true, -- Qiang the Merciless
        [61427] = true, -- Subetai the Swift
    },
    ["Elegon"] = {
        [60410] = true,
    },
    ["Will of the Emperor"] = {
        [60400] = true, -- Jan-xi
        [60399] = true, -- Qin-xi
    },
}

encounters[Z.TERRACE_OF_ENDLESS_SPRING] = {
    "Protectors of the Endless",
    "Tsulong",
    "Lei Shi",
    "Sha of Fear",
}
triggers[Z.TERRACE_OF_ENDLESS_SPRING] = {
    [60583] = "Protectors of the Endless", -- Protector Kaolan
    [60586] = "Protectors of the Endless", -- Elder Asani
    [60585] = "Protectors of the Endless", -- Elder Regail
    [62442] = "Tsulong",
    [62983] = "Lei Shi",
    [60999] = "Sha of Fear",
}
criteria[Z.TERRACE_OF_ENDLESS_SPRING] = {
    ["Protectors of the Endless"] = {
        [60583] = true, -- Protector Kaolan
        [60586] = true, -- Elder Asani
        [60585] = true, -- Elder Regail
    },
    ["Tsulong"] = {
        [62442] = true,
    },
    ["Lei Shi"] = {
        [62983] = true,
    },
    ["Sha of Fear"] = {
        [60999] = true,
    },
}

encounters[Z.THRONE_OF_THUNDER] = {
    "Jin'rokh the Breaker",
    "Horridon",
    "Council of Elders",
    "Tortos",
    "Megaera",
    "Ji-kun",
    "Durumu",
    "Primordius",
    "Dark Animus",
    "Iron Qon",
    "Twin Consorts",
    "Lei Shen",
    "Ra-den",               -- TODO: Fully add once NPC ID is discovered.
}
triggers[Z.THRONE_OF_THUNDER] = {
    [69465] = "Jin'rokh the Breaker",
    [68476] = "Horridon",
    [69078] = "Council of Elders", -- Sul the Sandcrawler
    [69131] = "Council of Elders", -- Frost King Malakk
    [69132] = "Council of Elders", -- High Priestess Mar'li
    [69134] = "Council of Elders", -- Kazra'jin
    [67977] = "Tortos",
    [70212] = "Megaera", -- Flaming Head
    [70235] = "Megaera", -- Frozen Head
    [70247] = "Megaera", -- Venomous Head
    [69712] = "Ji-kun",
    [68036] = "Durumu",
    [69017] = "Primordius",
    [69427] = "Dark Animus",
    [68078] = "Iron Qon",
    [68904] = "Twin Consorts", -- Suen
    [68905] = "Twin Consorts", -- Lu'lin
    [68397] = "Lei Shen",
}
criteria[Z.THRONE_OF_THUNDER] = {
    ["Jin'rokh the Breaker"] = {
        [69465] = true,
    },
    ["Horridon"] = {
        [68476] = true,
    },
    ["Council of Elders"] = {
        [69078] = true, -- Sul the Sandcrawler
        [69131] = true, -- Frost King Malakk
        [69132] = true, -- High Priestess Mar'li
        [69134] = true, -- Kazra'jin

    },
    ["Tortos"] = {
        [67977] = true,
    },
    ["Megaera"] = {
        [70212] = true, -- Flaming Head
        [70235] = true, -- Frozen Head
        [70247] = true, -- Venomous Head
    },
    ["Ji-kun"] = {
        [69712] = true,
    },
    ["Durumu"] = {
        [68036] = true,
    },
    ["Primordius"] = {
        [69017] = true,
    },
    ["Dark Animus"] = {
        [69427] = true,
    },
    ["Iron Qon"] = {
        [68078] = true,
    },
    ["Twin Consorts"] = {
        [68904] = true, -- Suen
        [68905] = true, -- Lu'lin
    },
    ["Lei Shen"] = {
        [68397] = "Lei Shen",
    },
}
--[[
-------------------------------------------------------------------------------
   -- Siege of Orgrimmar
   -------------------------------------------------------------------------------
   -- Vale of Eternal Sorrows
   [71543]    = true,    -- Immerseus
   [71475]    = true,    -- Rook Stonetoe, The Fallen Protectors
   [71479]    = true,    -- He Softfoot, The Fallen Protectors
   [71480]    = true,    -- Sun Tenderheart, The Fallen Protectors
   [72276]    = true,    -- Norushen, Amalgam of Corruption
   [71734]    = true,    -- Sha of Pride
   -- Gates of Retribution
   [72249]    = true,    -- Galakras
   [72311]  = true,  -- Varian (part of the Galakras encounter's trigger)
   [72560]  = true,  -- Lor'Themar (His hair triggers the Galakras encounter)
   [71466]    = true,    -- Iron Juggernaut
   [71859]    = true,    -- Haromm, his Darkness exceeded only by his Shamanism
   [71858]  = true,  -- Kardriss, his Shamanism exceeded only by his Darkness
   [71515]    = true,    -- General Nazgrim
   -- The Underhold
   [71454]    = true,    -- Malkorak
   [73720]    = true,    -- Mogu Spoils (Spoils of War)
   [71512]  = true,  -- Mantid Spoils (Spoils of War)
   [71529]    = true,    -- Thok the Bloodthirsty, her Thirst exceeded only by her Blood
   -- Downfall
   [71504]    = true,    -- Siegecrafter Blackfuse, his fuses exceeded only by his... wait...
   [71591]  = true,  -- Automated Shredder (Part of the Siegecrafter fight... not sure if this is the trigger or just him)
   [71152]  = true,  -- Skeer the Bloodseeker, <Paragon of the Klaxxi>
   [71153]  = true,  -- Hisek the Swarmkeeper, <Paragon of the Klaxxi>
   [71154]  = true,  -- Ka'roz the Locust, <Paragon of the Klaxxi>
   [71155]  = true,  -- Korven the Prime, <Paragon of the Klaxxi>
   [71156]  = true,  -- Kaz'tik the Manipulator, <Paragon of the Klaxxi>
   [71157]  = true,  -- Xaril The POisoned Mind, <Paragon of the Klaxxi>
   [71158]  = true,  -- Rik'kal the Dissector, <Paragon of the Klaxxi>
   [71160]  = true,  -- Iyyokuk the Lucid, <Paragon of the Klaxxi> (71159 is Ghazrooki, weird isn't it?)
   [71161]  = true,  -- Kil'ruk the Wind-Reaver, <Paragon of the Klaxxi>
   [71865]    = true,    -- Garrosh Starscream, That's right. He was a Decepticon all this time
 ]]
encounters[Z.SIEGE_OF_ORGRIMMAR] = {
    "Immerseus",
    "The Fallen Protectors",
    "Norushen",
    "Sha of Pride",
    "Galakras",
    "Iron Juggernaut",
    "Kor'kron Dark Shaman",
    "General Nazgrim",
    "Malkorok",
    "Spoils of Pandaria",
    "Thok the Bloodthirsty",
    "Siegecrafter Blackfuse",
    "Paragons of the Klaxxi",
    "Garrosh Hellscream"

}

triggers[Z.SIEGE_OF_ORGRIMMAR] = {
    [71543]    = "Immerseus",    -- Immerseus
    [71475]    = "Rook Stonetoe",    -- Rook Stonetoe, The Fallen Protectors
    [71479]    = "He Softfoot",    -- He Softfoot, The Fallen Protectors
    [71480]    = "Sun Tenderheart",    -- Sun Tenderheart, The Fallen Protectors
    [72276]    = "Norushen",    -- Norushen, Amalgam of Corruption
    [71734]    = "Sha of Pride",    -- Sha of Pride
    -- Gates of Retribution
    [72249]    = "Galakras",    -- Galakras
    [72311]  = "Varian",  -- Varian (part of the Galakras encounter's trigger)
    [72560]  = "Lor'themar",  -- Lor'Themar (His hair triggers the Galakras encounter)
    [71466]    = "Iron Juggernaut",    -- Iron Juggernaut
    [71859]    = "Haromm",    -- Haromm, his Darkness exceeded only by his Shamanism
    [71858]  = "Kardriss",  -- Kardriss, his Shamanism exceeded only by his Darkness
    [71515]    = "General Nazgrim",    -- General Nazgrim
    -- The Underhold
    [71454]    = "Malkorak",    -- Malkorak
    [73720]    = "Spoils",    -- Mogu Spoils (Spoils of War)
    [71512]  = "Spoils",  -- Mantid Spoils (Spoils of War)
    [71529]    = "Thok the Bloodthirsty",    -- Thok the Bloodthirsty, her Thirst exceeded only by her Blood

    -- Downfall
    [71504]    = "Siegecrafter Blackfuse",    -- Siegecrafter Blackfuse, his fuses exceeded only by his... wait...
    [71591]  = "Automated Shredder",  -- Automated Shredder (Part of the Siegecrafter fight... not sure if this is the trigger or just him)
    [71152]  = "Skeer the Bloodseeker",  -- Skeer the Bloodseeker, <Paragon of the Klaxxi>
    [71153]  = "Hisek the Swarmkeeper",  -- Hisek the Swarmkeeper, <Paragon of the Klaxxi>
    [71154]  = "Ka'roz the Locust",  -- Ka'roz the Locust, <Paragon of the Klaxxi>
    [71155]  = "Korven the Prime",  -- Korven the Prime, <Paragon of the Klaxxi>
    [71156]  = "Kaz'tik the Manipulator",  -- Kaz'tik the Manipulator, <Paragon of the Klaxxi>
    [71157]  = "Xaril The POisoned Mind",  -- Xaril The POisoned Mind, <Paragon of the Klaxxi>
    [71158]  = "Rik'kal the Dissector",  -- Rik'kal the Dissector, <Paragon of the Klaxxi>
    [71160]  = "Iyyokuk the Lucid",  -- Iyyokuk the Lucid, <Paragon of the Klaxxi> (71159 is Ghazrooki, weird isn't it?)
    [71161]  = "Kil'ruk the Wind-Reaver",  -- Kil'ruk the Wind-Reaver, <Paragon of the Klaxxi>
    [71865]    = "Garrosh Starscream",    -- Garrosh Starscream, That's right. He was a Decepticon all this time
}
criteria[Z.SIEGE_OF_ORGRIMMAR] = {
    ["Immerseus"] = {
        [69465] = true,
    },
    ["The Fallen Protectors"] = {
        [71475] = true,   -- Rook Stonetoe, The Fallen Protectors
        [71479]  = true,
        [71480] = true,
    },
    ["Norushen"] = {
        [72276]  = true,
    },
    ["Sha of Pride"] = {
        [71734] = true,
    },
    ["Galakras"] = {
        [72249] = true,
        [72311] = true,
        [72560] = true,
    },
    ["Iron Juggernaut"] = {
        [71466]  = true,
    },
    ["Kor'kron Dark Shaman"] = {
        [71859] = true,  -- Haromm, his Darkness exceeded only by his Shamanism
        [71858]  = true,  -- Kardriss, his Shamanism exceeded only by his Darkness
    },
    ["General Nazgrim"] = {
        [71515]  = true,
    },
    ["Malkorok"] = {
        [71454]  = true,
    },
    ["Spoils of Pandaria"] = {    -- Malkorak
        [73720] = true, -- Mogu Spoils (Spoils of War)
        [71512]  = true,
    },
    ["Thok the Bloodthirsty"] = {
        [71529]  = true,
    },
    ["Siegecrafter Blackfuse"] = {
        [71504]   = true,  -- Siegecrafter Blackfuse, his fuses exceeded only by his... wait...
        [71591]  = true,
    },
    ["Paragons of the Klaxxi"] = {  -- Automated Shredder (Part of the Siegecrafter fight... not sure if this is the trigger or just him)
        [71152]  = true, -- Skeer the Bloodseeker, <Paragon of the Klaxxi>
        [71153]  = true,  -- Hisek the Swarmkeeper, <Paragon of the Klaxxi>
        [71154]  = true, -- Ka'roz the Locust, <Paragon of the Klaxxi>
        [71155]  = true,-- Korven the Prime, <Paragon of the Klaxxi>
        [71156]  = true,  -- Kaz'tik the Manipulator, <Paragon of the Klaxxi>
        [71157]  = true, -- Xaril The POisoned Mind, <Paragon of the Klaxxi>
        [71158]   = true,  -- Rik'kal the Dissector, <Paragon of the Klaxxi>
        [71160]  = true, -- Iyyokuk the Lucid, <Paragon of the Klaxxi> (71159 is Ghazrooki, weird isn't it?)
        [71161]  = true,
    },
    ["Garrosh Hellscream"] = {
        [71865]  = true,
    },
}