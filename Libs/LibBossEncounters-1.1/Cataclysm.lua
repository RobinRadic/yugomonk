local BossEncounters = LibStub:GetLibrary("LibBossEncountersYugoEdit-1.1")
local encounters = BossEncounters.zone_encounters
local triggers = BossEncounters.encounter_triggers
local criteria = BossEncounters.encounter_criteria

local Z = BossEncounters.zone_names

-------------------------------------------------------------------------------
-- Cataclysm Dungeons
-------------------------------------------------------------------------------
encounters[Z.BLACKROCK_CAVERNS] = {
    "Rom'ogg Bonecrusher",
    "Corla, Herald of Twilight",
    "Karsh Steelbender",
    "Beauty",
    "Ascendant Lord Obsidius",
}
triggers[Z.BLACKROCK_CAVERNS] = {
    [39665] = "Rom'ogg Bonecrusher",
    [39679] = "Corla, Herald of Twilight",
    [39698] = "Karsh Steelbender",
    [39700] = "Beauty",
    [39705] = "Ascendant Lord Obsidius",
}
criteria[Z.BLACKROCK_CAVERNS] = {
    ["Rom'ogg Bonecrusher"] = {
        [39665] = true,
    },
    ["Corla, Herald of Twilight"] = {
        [39679] = true,
    },
    ["Karsh Steelbender"] = {
        [39698] = true,
    },
    ["Beauty"] = {
        [39700] = true,
    },
    ["Ascendant Lord Obsidius"] = {
        [39705] = true,
    },
}

encounters[Z.GRIM_BATOL] = {
    "General Umbriss",
    "Forgemaster Throngus",
    "Drahga Shadowburner",
    "Erudax",
}
triggers[Z.GRIM_BATOL] = {
    [39625] = "General Umbriss",
    [40177] = "Forgemaster Throngus",
    [40319] = "Drahga Shadowburner",
    [40484] = "Erudax",
}
criteria[Z.GRIM_BATOL] = {
    ["General Umbriss"] = {
        [39625] = true,
    },
    ["Forgemaster Throngus"] = {
        [40177] = true,
    },
    ["Drahga Shadowburner"] = {
        [40319] = true,
    },
    ["Erudax"] = {
        [40484] = true,
    },
}

encounters[Z.HALLS_OF_ORIGINATION] = {
    "Rajh",
    "Temple Guardian Anhuur",
    "Earthrager Ptah",
    "Isiset",
    "Ammunae",
    "Setesh",
    "Anraphet",
}
triggers[Z.HALLS_OF_ORIGINATION] = {
    [39378] = "Rajh",
    [39425] = "Temple Guardian Anhuur",
    [39428] = "Earthrager Ptah",
    [39587] = "Isiset",
    [39731] = "Ammunae",
    [39732] = "Setesh",
    [39788] = "Anraphet",
}
criteria[Z.HALLS_OF_ORIGINATION] = {
    ["Rajh"] = {
        [39378] = true,
    },
    ["Temple Guardian Anhuur"] = {
        [39425] = true,
    },
    ["Earthrager Ptah"] = {
        [39428] = true,
    },
    ["Isiset"] = {
        [39587] = true,
    },
    ["Ammunae"] = {
        [39731] = true,
    },
    ["Setesh"] = {
        [39732] = true,
    },
    ["Anraphet"] = {
        [39788] = true,
    },
}

encounters[Z.LOST_CITY_OF_THE_TOLVIR] = {
    "High Prophet Barim",
    "Lockmaw",
    "General Husam",
    "Siamat",
    "Augh",
}
triggers[Z.LOST_CITY_OF_THE_TOLVIR] = {
    [43612] = "High Prophet Barim",
    [43614] = "Lockmaw",
    [44577] = "General Husam",
    [44819] = "Siamat",
    [49045] = "Augh",
}
criteria[Z.LOST_CITY_OF_THE_TOLVIR] = {
    ["High Prophet Barim"] = {
        [43612] = true,
    },
    ["Lockmaw"] = {
        [43614] = true,
    },
    ["General Husam"] = {
        [44577] = true,
    },
    ["Siamat"] = {
        [44819] = true,
    },
    ["Augh"] = {
        [49045] = true,
    },
}

encounters[Z.SHADOWFANG_KEEP] = {
    "Baron Silverlaine",
    "Commander Springvale",
    "Baron Ashbury",
    "Lord Walden",
    "Lord Godfrey",
}
triggers[Z.SHADOWFANG_KEEP] = {
    [3887] = "Baron Silverlaine",
    [4278] = "Commander Springvale",
    [46962] = "Baron Ashbury",
    [46963] = "Lord Walden",
    [46964] = "Lord Godfrey",
}
criteria[Z.SHADOWFANG_KEEP] = {
    ["Baron Silverlaine"] = {
        [3887] = true,
    },
    ["Commander Springvale"] = {
        [4278] = true,
    },
    ["Baron Ashbury"] = {
        [46962] = true,
    },
    ["Lord Walden"] = {
        [46963] = true,
    },
    ["Lord Godfrey"] = {
        [46964] = true,
    },
}

encounters[Z.THE_DEADMINES] = {
    "Foe Reaper 5000",
    "Glubtok",
    "Helix Gearbreaker",
    "Admiral Ripsnarl",
    "\"Captain\" Cookie",
    "Vanessa VanCleef (Heroic)",
}
triggers[Z.THE_DEADMINES] = {
    [43778] = "Foe Reaper 5000",
    [47162] = "Glubtok",
    [47296] = "Helix Gearbreaker",
    [47626] = "Admiral Ripsnarl",
    [47739] = "\"Captain\" Cookie",
    [49541] = "Vanessa VanCleef (Heroic)",
}
criteria[Z.THE_DEADMINES] = {
    ["Foe Reaper 5000"] = {
        [43778] = true,
    },
    ["Glubtok"] = {
        [47162] = true,
    },
    ["Helix Gearbreaker"] = {
        [47296] = true,
    },
    ["Admiral Ripsnarl"] = {
        [47626] = true,
    },
    ["\"Captain\" Cookie"] = {
        [47739] = true,
    },
    ["Vanessa VanCleef (Heroic)"] = {
        [49541] = true,
    },
}

encounters[Z.THE_STONECORE] = {
    "Ozruk",
    "High Priestess Azil",
    "Slabhide",
    "Corborus",
}
triggers[Z.THE_STONECORE] = {
    [42188] = "Ozruk",
    [42333] = "High Priestess Azil",
    [43214] = "Slabhide",
    [43438] = "Corborus",
}
criteria[Z.THE_STONECORE] = {
    ["Ozruk"] = {
        [42188] = true,
    },
    ["High Priestess Azil"] = {
        [42333] = true,
    },
    ["Slabhide"] = {
        [43214] = true,
    },
    ["Corborus"] = {
        [43438] = true,
    },
}

encounters[Z.THE_VORTEX_PINNACLE] = {
    "Altairus",
    "Asaad",
    "Grand Vizier Ertan",
}
triggers[Z.THE_VORTEX_PINNACLE] = {
    [43873] = "Altairus",
    [43875] = "Asaad",
    [43878] = "Grand Vizier Ertan",
}
criteria[Z.THE_VORTEX_PINNACLE] = {
    ["Altairus"] = {
        [43873] = true,
    },
    ["Asaad"] = {
        [43875] = true,
    },
    ["Grand Vizier Ertan"] = {
        [43878] = true,
    },
}

encounters[Z.THRONE_OF_THE_TIDES] = {
    "Lady Naz'jar",
    "Ozumat",
    "Commander Ulthok",
    "Mindbender Ghur'sha",
}
triggers[Z.THRONE_OF_THE_TIDES] = {
    [40586] = "Lady Naz'jar",
    [40655] = "Ozumat",
    [40765] = "Commander Ulthok",
    [40825] = "Mindbender Ghur'sha", -- Erunak Stonespeaker
}
criteria[Z.THRONE_OF_THE_TIDES] = {
    ["Lady Naz'jar"] = {
        [40586] = true,
    },
    ["Ozumat"] = {
        [40655] = true,
    },
    ["Commander Ulthok"] = {
        [40765] = true,
    },
    ["Mindbender Ghur'sha"] = {
        [40788] = true,
    },
}

encounters[Z.ZULAMAN] = {
    "Akil'zon",
    "Nalorakk",
    "Jan'alai",
    "Halazzi",
    "Hex Lord Malacrass",
    "Daakara",
}
triggers[Z.ZULAMAN] = {
    [23574] = "Akil'zon",
    [23576] = "Nalorakk",
    [23578] = "Jan'alai",
    [23577] = "Halazzi",
    [24239] = "Hex Lord Malacrass",
    [23863] = "Daakara",
}
criteria[Z.ZULAMAN] = {
    ["Akil'zon"] = {
        [23574] = true,
    },
    ["Nalorakk"] = {
        [23576] = true,
    },
    ["Jan'alai"] = {
        [23578] = true,
    },
    ["Halazzi"] = {
        [23577] = true,
    },
    ["Hex Lord Malacrass"] = {
        [24239] = true,
    },
    ["Daakara"] = {
        [23863] = true,
    },
}

encounters[Z.ZULGURUB] = {
    "High Priest Venoxis",
    "Bloodlord Mandokir",
    "High Priestess Kilnara",
    "Zanzil",
    "Jin'do the Godbreaker",
    -------------------------------------------------------------------------------
    -- Cache of Madness (Random boss)
    -------------------------------------------------------------------------------
    "Hazza'rah",
    "Renataki",
    "Wushoolay",
    "Gri'lek",
}
triggers[Z.ZULGURUB] = {
    [52155] = "High Priest Venoxis",
    [52151] = "Bloodlord Mandokir",
    [52059] = "High Priestess Kilnara",
    [52053] = "Zanzil",
    [52148] = "Jin'do the Godbreaker",
    -------------------------------------------------------------------------------
    -- Cache of Madness (Random boss)
    -------------------------------------------------------------------------------
    [52271] = "Hazza'rah",
    [52269] = "Renataki",
    [52286] = "Wushoolay",
    [52258] = "Gri'lek",
}
criteria[Z.ZULGURUB] = {
    ["High Priest Venoxis"] = {
        [52155] = true,
    },
    ["Bloodlord Mandokir"] = {
        [52151] = true,
    },
    ["High Priestess Kilnara"] = {
        [52059] = true,
    },
    ["Zanzil"] = {
        [52053] = true,
    },
    ["Jin'do the Godbreaker"] = {
        [52148] = true,
    },
    -------------------------------------------------------------------------------
    -- Cache of Madness (Random boss)
    -------------------------------------------------------------------------------
    ["Hazza'rah"] = {
        [52271] = true,
    },
    ["Renataki"] = {
        [52269] = true,
    },
    ["Wushoolay"] = {
        [52286] = true,
    },
    ["Gri'lek"] = {
        [52258] = true,
    },
}

-------------------------------------------------------------------------------
-- Cataclysm Raids
-------------------------------------------------------------------------------
encounters[Z.BARADIN_HOLD] = {
    "Alizabal",
    "Argaloth",
    "Occu'thar",
}
triggers[Z.BARADIN_HOLD] = {
    [55869] = "Alizabal",
    [47120] = "Argaloth",
    [52363] = "Occu'thar,"
}
criteria[Z.BARADIN_HOLD] = {
    ["Alizabal"] = {
        [55869] = true,
    },
    ["Argaloth"] = {
        [47120] = true,
    },
    ["Occu'thar"] = {
        [52363] = true,
    }
}

encounters[Z.THE_BASTION_OF_TWILIGHT] = {
    "Cho'gall",
    "Sanctum of the Ascended",
    "Halfus Wyrmbreaker",
    "Twilight Enclave",
    "Sinestra (Heroic)",
}
triggers[Z.THE_BASTION_OF_TWILIGHT] = {
    [43324] = "Cho'gall",
    [43686] = "Sanctum of the Ascended", -- Ignacious
    [43687] = "Sanctum of the Ascended", -- Feludius
    [43688] = "Sanctum of the Ascended", -- Arion
    [43689] = "Sanctum of the Ascended", -- Terrastra
    [44600] = "Halfus Wyrmbreaker",
    [45213] = "Sinestra (Heroic)",
    [45992] = "Twilight Enclave", -- Valiona
    [45993] = "Twilight Enclave", -- Theralion
}
criteria[Z.THE_BASTION_OF_TWILIGHT] = {
    ["Cho'gall"] = {
        [43324] = true,
    },
    ["Sanctum of the Ascended"] = {
        [43735] = true, -- Elementium Monstrosity
    },
    ["Halfus Wyrmbreaker"] = {
        [44600] = true,
    },
    ["Sinestra (Heroic)"] = {
        [45213] = true,
    },
    ["Twilight Enclave"] = {
        [45992] = true, -- Valiona
        [45993] = true, -- Theralion
    },
}

encounters[Z.BLACKWING_DESCENT] = {
    "Vault of the Shadowflame",
    "Maloriak",
    "Atramedes",
    "Magmaw",
    "Omnitron Defense System",
    "Chimaeron",
}
triggers[Z.BLACKWING_DESCENT] = {
    [41270] = "Vault of the Shadowflame", -- Onyxia
    [41378] = "Maloriak",
    [41442] = "Atramedes",
    [41570] = "Magmaw",
    [42166] = "Omnitron Defense System", -- Arcanotron
    [42178] = "Omnitron Defense System", -- Magmatron
    [42179] = "Omnitron Defense System", -- Electron
    [42180] = "Omnitron Defense System", -- Toxitron
    [43296] = "Chimaeron",
}
criteria[Z.BLACKWING_DESCENT] = {
    ["Vault of the Shadowflame"] = {
        [41376] = true, -- Nefarian
    },
    ["Maloriak"] = {
        [41378] = true,
    },
    ["Atramedes"] = {
        [41442] = true,
    },
    ["Magmaw"] = {
        [41570] = true,
    },
    ["Omnitron Defense System"] = {
        [42166] = true, -- Arcanotron
        [42178] = true, -- Magmatron
        [42179] = true, -- Electron
        [42180] = true, -- Toxitron
    },
    ["Chimaeron"] = {
        [43296] = true,
    },
}

encounters[Z.DRAGON_SOUL] = {
    "Morchok",
    "Warlord Zon'ozz",
    "Yor'sahj the Unsleeping",
    "Hagara the Stormbinder",
    "Ultraxion",
    "Warmaster Blackhorn",
    "Spine of Deathwing",
    "Madness of Deathwing"
}
triggers[Z.DRAGON_SOUL] = {
    [55265] = "Morchok",
    [55308] = "Warlord Zon'ozz",
    [55312] = "Yor'sahj the Unsleeping",
    [55689] = "Hagara the Stormbinder",
    [55294] = "Ultraxion",
    [56427] = "Warmaster Blackhorn",
    [53879] = "Spine of Deathwing",
    [56173] = "Madness Deathwing"
}
criteria[Z.DRAGON_SOUL] = {
    ["Morchok"] = {
        [55265] = true,
    },
    ["Warlord Zon'ozz"] = {
        [55308] = true,
    },
    ["Yor'sahj the Unsleeping"] = {
        [55312] = true,
    },
    ["Hagara the Stormbinder"] = {
        [55689] = true,
    },
    ["Ultraxion"] = {
        [55294] = true,
    },
    ["Warmaster Blackhorn"] = {
        [56427] = true,
    },
    ["Spine of Deathwing"] = {
        [53879] = true,
    },
    ["Madness Deathwing"] = {
        [56173] = true,
    }
}

encounters[Z.END_TIME] = {
    "Echo of Baine",
    "Echo of Jaina",
    "Echo of Sylvanas",
    "Echo of Tyrande",
    "Murozond",
}
triggers[Z.END_TIME] = {
    [54431] = "Echo of Baine",
    [54445] = "Echo of Jaina",
    [54123] = "Echo of Sylvanas",
    [54544] = "Echo of Tyrande",
    [54432] = "Murozond",
}
criteria[Z.END_TIME] = {
    ["Echo of Baine"] = {
        [54431] = true,
    },
    ["Echo of Jaina"] = {
        [54445] = true,
    },
    ["Echo of Sylvanas"] = {
        [54123] = true,
    },
    ["Echo of Tyrande"] = {
        [54544] = true,
    },
    ["Murozond"] = {
        [54432] = true,
    },
}

encounters[Z.FIRELANDS] = {
    "Beth'tilac",
    "Lord Rhyolith",
    "Alysrazor",
    "Shannox",
    "Baleroc",
    "Majordomo Staghelm",
    "Ragnaros",
}
triggers[Z.FIRELANDS] = {
    [52498] = "Beth'tilac",
    [52558] = "Lord Rhyolith",
    [52530] = "Alysrazor",
    [53691] = "Shannox",
    [53494] = "Baleroc",
    [52571] = "Majordomo Staghelm",
    [52409] = "Ragnaros",
}
criteria[Z.FIRELANDS] = {
    ["Beth'tilac"] = {
        [52498] = true,
    },
    ["Lord Rhyolith"] = {
        [52558] = true,
    },
    ["Alysrazor"] = {
        [52530] = true,
    },
    ["Shannox"] = {
        [53691] = true,
    },
    ["Baleroc"] = {
        [53494] = true,
    },
    ["Majordomo Staghelm"] = {
        [52571] = true,
    },
    ["Ragnaros"] = {
        [52409] = true,
    },
}

encounters[Z.HOUR_OF_TWILIGHT] = {
    "Archbishop Benedictus",
    "Arcurion",
    "Asira Dawnslayer",
}
triggers[Z.HOUR_OF_TWILIGHT] = {
    [54938] = "Archbishop Benedictus",
    [54590] = "Arcurion",
    [54968] = "Asira Dawnslayer",
}
criteria[Z.HOUR_OF_TWILIGHT] = {
    ["Archbishop Benedictus"] = {
        [54938] = true,
    },
    ["Arcurion"] = {
        [54590] = true,
    },
    ["Asira Dawnslayer"] = {
        [54968] = true,
    },
}

encounters[Z.THRONE_OF_THE_FOUR_WINDS] = {
    "Conclave of Wind",
    "Al'Akir",
}
triggers[Z.THRONE_OF_THE_FOUR_WINDS] = {
    [45870] = "Conclave of Wind", -- Anshal
    [45871] = "Conclave of Wind", -- Nezir
    [45872] = "Conclave of Wind", -- Rohash
    [46753] = "Al'Akir",
}
criteria[Z.THRONE_OF_THE_FOUR_WINDS] = {
    ["Conclave of Wind"] = {
        [45870] = true, -- Anshal
        [45871] = true, -- Nezir
        [45872] = true, -- Rohash
    },
    ["Al'Akir"] = {
        [46753] = true,
    },
}

encounters[Z.WELL_OF_ETERNITY] = {
    "Peroth'arn",
    "Queen Azshara",
    "Mannoroth and Varo'then",
}
triggers[Z.WELL_OF_ETERNITY] = {
    [55085] = "Peroth'arn",
    [54853] = "Queen Azshara",
    [55419] = "Mannoroth and Varo'then", -- Captain Varo'then
}
criteria[Z.WELL_OF_ETERNITY] = {
    ["Peroth'arn"] = {
        [55085] = true,
    },
    ["Queen Azshara"] = {
        [54853] = true,
    },
    ["Mannoroth and Varo'then"] = {
        [55419] = true, -- Captain Varo'then
        [54969] = true, -- Mannoroth
    },
}
