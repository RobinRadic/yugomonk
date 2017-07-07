local BossEncounters = LibStub:GetLibrary("LibBossEncountersYugoEdit-1.1")
local encounters = BossEncounters.zone_encounters
local triggers = BossEncounters.encounter_triggers
local criteria = BossEncounters.encounter_criteria

local Z = BossEncounters.zone_names

-------------------------------------------------------------------------------
-- Wrath of The Lich King Dungeons
-------------------------------------------------------------------------------
encounters[Z.AHNKAHET_THE_OLD_KINGDOM] = {
    "Prince Taldaram",
    "Elder Nadox",
    "Jedoga Shadowseeker",
    "Herald Volazj",
    "Amanitar (Heroic)",
}
triggers[Z.AHNKAHET_THE_OLD_KINGDOM] = {
    [29308] = "Prince Taldaram",
    [29309] = "Elder Nadox",
    [29310] = "Jedoga Shadowseeker",
    [29311] = "Herald Volazj",
    [30258] = "Amanitar (Heroic)",
}
criteria[Z.AHNKAHET_THE_OLD_KINGDOM] = {
    ["Prince Taldaram"] = {
        [29308] = true,
    },
    ["Elder Nadox"] = {
        [29309] = true,
    },
    ["Jedoga Shadowseeker"] = {
        [29310] = true,
    },
    ["Herald Volazj"] = {
        [29311] = true,
    },
    ["Amanitar (Heroic)"] = {
        [30258] = true,
    },
}

encounters[Z.AZJOL_NERUB ] = {
    "Krik'thir the Gatewatcher",
    "Hadronox",
    "Anub'arak",
}
triggers[Z.AZJOL_NERUB ] = {
    [28684] = "Krik'thir the Gatewatcher",
    [28921] = "Hadronox",
    [29120] = "Anub'arak",
}
criteria[Z.AZJOL_NERUB ] = {
    ["Krik'thir the Gatewatcher"] = {
        [28684] = true,
    },
    ["Hadronox"] = {
        [28921] = true,
    },
    ["Anub'arak"] = {
        [29120] = true,
    },
}

encounters[Z.THE_CULLING_OF_STRATHOLME] = {
    "Meathook",
    "Salramm the Fleshcrafter",
    "Chrono-Lord Epoch",
    "Mal'Ganis",
    "Infinite Corruptor (Heroic)",
}
triggers[Z.THE_CULLING_OF_STRATHOLME] = {
    [26529] = "Meathook",
    [26530] = "Salramm the Fleshcrafter",
    [26532] = "Chrono-Lord Epoch",
    [26533] = "Mal'Ganis",
    [32273] = "Infinite Corruptor (Heroic)",
}
criteria[Z.THE_CULLING_OF_STRATHOLME] = {
    ["Meathook"] = {
        [26529] = true,
    },
    ["Salramm the Fleshcrafter"] = {
        [26530] = true,
    },
    ["Chrono-Lord Epoch"] = {
        [26532] = true,
    },
    ["Mal'Ganis"] = {
        --[[
         TODO: Encounter is successful when he says:
        "Your journey has just begun, young prince. Gather your forces, and meet me in the arctic land of Northrend.
        It is there we shall settle the score between us. Is is there that your true destiny will unfold."
        ]]
        [26533] = true,
    },
    ["Infinite Corruptor (Heroic)"] = {
        [32273] = true,
    },
}

encounters[Z.DRAKTHARON_KEEP] = {
    "Trollgore",
    "Novos the Summoner",
    "The Prophet Tharon'ja",
    "King Dred",
}
triggers[Z.DRAKTHARON_KEEP] = {
    [26630] = "Trollgore",
    [26631] = "Novos the Summoner",
    [26632] = "The Prophet Tharon'ja",
    [27483] = "King Dred",
}
criteria[Z.DRAKTHARON_KEEP] = {
    ["Trollgore"] = {
        [26630] = true,
    },
    ["Novos the Summoner"] = {
        [26631] = true,
    },
    ["The Prophet Tharon'ja"] = {
        [26632] = true,
    },
    ["King Dred"] = {
        [27483] = true,
    },
}

encounters[Z.THE_FORGE_OF_SOULS] = {
    "Bronjahm",
    "Devourer of Souls",
}
triggers[Z.THE_FORGE_OF_SOULS] = {
    [36497] = "Bronjahm",
    [36502] = "Devourer of Souls",
}
criteria[Z.THE_FORGE_OF_SOULS] = {
    ["Bronjahm"] = {
        [36497] = true,
    },
    ["Devourer of Souls"] = {
        [36502] = true,
    },
}

encounters[Z.GUNDRAK] = {
    "Slad'ran",
    "Moorabi",
    "Gal'darah",
    "Elemental Colossus",
    "Eck the Ferocious (Heroic)",
}
triggers[Z.GUNDRAK] = {
    [29304] = "Slad'ran",
    [29305] = "Moorabi",
    [29306] = "Gal'darah",
    [29307] = "Elemental Colossus", -- Drakkari Colossus
    [29932] = "Eck the Ferocious (Heroic)",
}
criteria[Z.GUNDRAK] = {
    ["Slad'ran"] = {
        [29304] = true,
    },
    ["Moorabi"] = {
        [29305] = true,
    },
    ["Gal'darah"] = {
        [29306] = true,
    },
    ["Elemental Colossus"] = {
        [29307] = true, -- Drakkari Colossus
        [29573] = true, -- Drakkari Elemental
    },
    ["Eck the Ferocious (Heroic)"] = {
        [29932] = true,
    },
}

encounters[Z.HALLS_OF_LIGHTNING] = {
    "Ionar",
    "General Bjarngrim",
    "Volkhan",
    "Loken",
}
triggers[Z.HALLS_OF_LIGHTNING] = {
    [28546] = "Ionar",
    [28586] = "General Bjarngrim",
    [28587] = "Volkhan",
    [28923] = "Loken",
}
criteria[Z.HALLS_OF_LIGHTNING] = {
    ["Ionar"] = {
        [28546] = true,
    },
    ["General Bjarngrim"] = {
        [28586] = true,
    },
    ["Volkhan"] = {
        [28587] = true,
    },
    ["Loken"] = {
        [28923] = true,
    },
}

encounters[Z.HALLS_OF_REFLECTION] = {
    "The Lich King",
    "Falric",
    "Marwyn",
}
triggers[Z.HALLS_OF_REFLECTION] = {
    [37226] = "The Lich King", -- TODO: The encounter actually starts when Jaina/Sylvanus talk to him.
    [38112] = "Falric",
    [38113] = "Marwyn",
}
criteria[Z.HALLS_OF_REFLECTION] = {
    ["The Lich King"] = {
        [37226] = true, -- TODO: The encounter ends when the Alliance/Horde skycaptain tells the party to get on board the skyship.
    },
    ["Falric"] = {
        [38112] = true,
    },
    ["Marwyn"] = {
        [38113] = true,
    },
}

-- TODO: The Tribunal of Ages has no actual bosses, so requires special handler code.
encounters[Z.HALLS_OF_STONE] = {
    "Maiden of Grief",
    "Krystallus",
    "Sjonnir The Ironshaper",
    "The Tribunal of Ages",
}
triggers[Z.HALLS_OF_STONE] = {
    [27975] = "Maiden of Grief",
    [27977] = "Krystallus",
    [27978] = "Sjonnir The Ironshaper",
    [28234] = "The Tribunal of Ages",
}
criteria[Z.HALLS_OF_STONE] = {
    ["Maiden of Grief"] = {
        [27975] = true,
    },
    ["Krystallus"] = {
        [27977] = true,
    },
    ["Sjonnir The Ironshaper"] = {
        [27978] = true,
    },
    ["The Tribunal of Ages"] = {
        [28234] = true,
    },
}

-- TODO: Valithria needs specialized handler code. This is not a killing encounter; the party must heal her to 100%
-- TODO: The Gunship Battle needs specialized handler code. There is no actual boss.
encounters[Z.ICECROWN_CITADEL] = {
    "Lord Marrowgar",
    "Lady Deathwhisper",
    "Gunship Battle",
    "Deathbringer Saurfang",
    "Festergut",
    "Rotface",
    "Professor Putricide",
    "Blood Prince Council",
    "Blood-Queen Lana'thel",
    "Valithria Dreamwalker",
    "Sindragosa",
    "The Lich King",
}
triggers[Z.ICECROWN_CITADEL] = {
    [36612] = "Lord Marrowgar",
    [36855] = "Lady Deathwhisper",
    [37813] = "Deathbringer Saurfang",
    [36626] = "Festergut",
    [36627] = "Rotface",
    [36678] = "Professor Putricide",
    [37955] = "Blood-Queen Lana'thel",
    [37970] = "Blood Prince Council", -- Prince Valanar
    [37972] = "Blood Prince Council", -- Prince Keleseth
    [37973] = "Blood Prince Council", -- Prince Taldaram
    [36789] = "Valithria Dreamwalker",
    [37533] = "Sindragosa", -- Rimefang
    [37534] = "Sindragosa", -- Spinestalker
    [36597] = "The Lich King",
}
criteria[Z.ICECROWN_CITADEL] = {
    ["Lord Marrowgar"] = {
        [36612] = true,
    },
    ["Lady Deathwhisper"] = {
        [36855] = true,
    },
    ["Gunship Battle"] = {},
    ["Deathbringer Saurfang"] = {
        [37813] = true,
    },
    ["Festergut"] = {
        [36626] = true,
    },
    ["Rotface"] = {
        [36627] = true,
    },
    ["Professor Putricide"] = {
        [36678] = true,
    },
    ["Blood-Queen Lana'thel"] = {
        [37955] = true,
    },
    ["Blood Prince Council"] = {
        [37970] = true, -- Prince Valanar
        [37972] = true, -- Prince Keleseth
        [37973] = true, -- Prince Taldaram
    },
    ["Valithria Dreamwalker"] = {
        [36789] = true,
    },
    ["Sindragosa"] = {
        [36853] = true, -- Sindragosa
        [37533] = true, -- Rimefang
        [37534] = true, -- Spinestalker
    },
    ["The Lich King"] = {
        [36597] = true,
    },
}

encounters[Z.NAXXRAMAS] = {
    "Anub'Rekhan",
    "Grand Widow Faerlina",
    "Maexxna",
    "Noth the Plaguebringer",
    "Heigan the Unclean",
    "Loatheb",
    "Instructor Razuvious",
    "Gothik the Harvester",
    "The Four Horsemen",
    "Patchwerk",
    "Grobbulus",
    "Gluth",
    "Thaddius",
    "Sapphiron",
    "Kel'Thuzad",
}
triggers[Z.NAXXRAMAS] = {
    [15956] = "Anub'Rekhan",
    [15953] = "Grand Widow Faerlina",
    [15952] = "Maexxna",
    [15954] = "Noth the Plaguebringer",
    [15936] = "Heigan the Unclean",
    [16011] = "Loatheb",
    [16061] = "Instructor Razuvious",
    [16060] = "Gothik the Harvester",
    [16064] = "The Four Horsemen", -- Thane Korth'azz
    [16065] = "The Four Horsemen", -- Lady Blaumeux
    [30549] = "The Four Horsemen", -- Baron Rivendare
    [16063] = "The Four Horsemen", -- Sir Zeliek
    [16028] = "Patchwerk",
    [15931] = "Grobbulus",
    [15932] = "Gluth",
    [15928] = "Thaddius",
    [15989] = "Sapphiron",
    [15990] = "Kel'Thuzad",
}
criteria[Z.NAXXRAMAS] = {
    ["Anub'Rekhan"] = {
        [15956] = true,
    },
    ["Grand Widow Faerlina"] = {
        [15953] = true,
    },
    ["Maexxna"] = {
        [15952] = true,
    },
    ["Noth the Plaguebringer"] = {
        [15954] = true,
    },
    ["Heigan the Unclean"] = {
        [15936] = true,
    },
    ["Loatheb"] = {
        [16011] = true,
    },
    ["Instructor Razuvious"] = {
        [16061] = true,
    },
    ["Gothik the Harvester"] = {
        [16060] = true,
    },
    ["The Four Horsemen"] = {
        [16064] = true, -- Thane Korth'azz
        [16065] = true, -- Lady Blaumeux
        [30549] = true, -- Baron Rivendare
        [16063] = true, -- Sir Zeliek
    },
    ["Patchwerk"] = {
        [16028] = true,
    },
    ["Grobbulus"] = {
        [15931] = true,
    },
    ["Gluth"] = {
        [15932] = true,
    },
    ["Thaddius"] = {
        [15928] = true,
    },
    ["Sapphiron"] = {
        [15989] = true,
    },
    ["Kel'Thuzad"] = {
        [15990] = true,
    },
}

encounters[Z.THE_OBSIDIAN_SANCTUM] = {
    "Sartharion",
    "Vesperon",
    "Shadron",
    "Tenebron",
}
triggers[Z.THE_OBSIDIAN_SANCTUM] = {
    [28860] = "Sartharion",
    [30449] = "Vesperon",
    [30451] = "Shadron",
    [30452] = "Tenebron",
}
criteria[Z.THE_OBSIDIAN_SANCTUM] = {
    ["Sartharion"] = {
        [28860] = true,
    },
    ["Vesperon"] = {
        [30449] = true,
    },
    ["Shadron"] = {
        [30451] = true,
    },
    ["Tenebron"] = {
        [30452] = true,
    },
}

encounters[Z.PIT_OF_SARON] = {
    "Forgemaster Garfrost",
    "Ick & Krick",
    "Scourgelord Tyrannus",
}
triggers[Z.PIT_OF_SARON] = {
    [36494] = "Forgemaster Garfrost",
    [36476] = "Ick & Krick", -- Ick
    [36477] = "Ick & Krick", -- Krick
    [36658] = "Scourgelord Tyrannus"
}
criteria[Z.PIT_OF_SARON] = {
    ["Forgemaster Garfrost"] = {
        [36494] = true,
    },
    ["Ick & Krick"] = {
        [36476] = true, -- Ick
        [36477] = true, -- Krick
    },
    ["Scourgelord Tyrannus"] = {
        [36658] = true,
    },
}

encounters[Z.THE_RUBY_SANCTUM] = {
    "Zarithrian",
    "Saviana",
    "Baltharus",
    "Halion",
}
triggers[Z.THE_RUBY_SANCTUM] = {
    [39746] = "Zarithrian",
    [39747] = "Saviana",
    [39751] = "Baltharus",
    [39863] = "Halion",
}
criteria[Z.THE_RUBY_SANCTUM] = {
    ["Zarithrian"] = {
        [39746] = true,
    },
    ["Saviana"] = {
        [39747] = true,
    },
    ["Baltharus"] = {
        [39751] = true,
    },
    ["Halion"] = {
        [39863] = true,
    },
}

encounters[Z.THE_EYE_OF_ETERNITY] = {
    "Malygos",
}
triggers[Z.THE_EYE_OF_ETERNITY] = {
    [28859] = "Malygos",
}
criteria[Z.THE_EYE_OF_ETERNITY] = {
    ["Malygos"] = {
        [28859] = true,
    },
}

encounters[Z.THE_NEXUS] = {
    "Keristrasza",
    "Grand Magus Telestra",
    "Anomalus",
    "Ormorok the Tree-Shaper",
    "Commander Stoutbeard",
    "Commander Kolurg",
}
triggers[Z.THE_NEXUS] = {
    [26723] = "Keristrasza",
    [26731] = "Grand Magus Telestra",
    [26763] = "Anomalus",
    [26794] = "Ormorok the Tree-Shaper",
    [26796] = "Commander Stoutbeard",
    [26798] = "Commander Kolurg",
}
criteria[Z.THE_NEXUS] = {
    ["Keristrasza"] = {
        [26723] = true,
    },
    ["Grand Magus Telestra"] = {
        [26731] = true,
    },
    ["Anomalus"] = {
        [26763] = true,
    },
    ["Ormorok the Tree-Shaper"] = {
        [26794] = true,
    },
    ["Commander Stoutbeard"] = {
        [26796] = true,
    },
    ["Commander Kolurg"] = {
        [26798] = true,
    },
}

encounters[Z.THE_OCULUS] = {
    "Varos Cloudstrider",
    "Drakos the Interrogator",
    "Mage-Lord Urom",
    "Ley-Guardian Eregos",
}
triggers[Z.THE_OCULUS] = {
    [27447] = "Varos Cloudstrider",
    [27654] = "Drakos the Interrogator",
    [27655] = "Mage-Lord Urom",
    [27656] = "Ley-Guardian Eregos",
}
criteria[Z.THE_OCULUS] = {
    ["Varos Cloudstrider"] = {
        [27447] = true,
    },
    ["Drakos the Interrogator"] = {
        [27654] = true,
    },
    ["Mage-Lord Urom"] = {
        [27655] = true,
    },
    ["Ley-Guardian Eregos"] = {
        [27656] = true,
    },
}

encounters[Z.THE_VIOLET_HOLD] = {
    "Xevozz",
    "Lavanthor",
    "Ichoron",
    "Zuramat the Obliterator",
    "Erekem",
    "Moragg",
    "Cyanigosa",
}
triggers[Z.THE_VIOLET_HOLD] = {
    [29266] = "Xevozz",
    [29312] = "Lavanthor",
    [29313] = "Ichoron",
    [29314] = "Zuramat the Obliterator",
    [29315] = "Erekem",
    [29316] = "Moragg",
    [31134] = "Cyanigosa",
}
criteria[Z.THE_VIOLET_HOLD] = {
    ["Xevozz"] = {
        [29266] = true,
    },
    ["Lavanthor"] = {
        [29312] = true,
    },
    ["Ichoron"] = {
        [29313] = true,
    },
    ["Zuramat the Obliterator"] = {
        [29314] = true,
    },
    ["Erekem"] = {
        [29315] = true,
    },
    ["Moragg"] = {
        [29316] = true,
    },
    ["Cyanigosa"] = {
        [31134] = true,
    },
}

--    -------------------------------------------------------------------------------
--    -- Trial of the Champion
--    -------------------------------------------------------------------------------
--    -- Alliance
--    [35617] = true, -- Deathstalker Visceri <Grand Champion of Undercity>
--    [35569] = true, -- Eressea Dawnsinger <Grand Champion of Silvermoon>
--    [35572] = true, -- Mokra the Skullcrusher <Grand Champion of Orgrimmar>
--    [35571] = true, -- Runok Wildmane <Grand Champion of the Thunder Bluff>
--    [35570] = true, -- Zul'tore <Grand Champion of Sen'jin>
--
--    -- Horde
--    [34702] = true, -- Ambrose Boltspark <Grand Champion of Gnomeregan>
--    [34701] = true, -- Colosos <Grand Champion of the Exodar>
--    [34705] = true, -- Marshal Jacob Alerius <Grand Champion of Stormwind>
--    [34657] = true, -- Jaelyne Evensong <Grand Champion of Darnassus>
--    [34703] = true, -- Lana Stouthammer <Grand Champion of Ironforge>
--
--    -- Neutral
--    [34928] = true, -- Argent Confessor Paletress
--    [35119] = true, -- Eadric the Pure
--    [35451] = true, -- The Black Knight
--
--    -------------------------------------------------------------------------------
--    -- Trial of the Crusader
--    -------------------------------------------------------------------------------
--    [34796] = true, -- Gormok
--    [35144] = true, -- Acidmaw
--    [34799] = true, -- Dreadscale
--    [34797] = true, -- Icehowl
--
--    [34780] = true, -- Jaraxxus
--
--    [34461] = true, -- Tyrius Duskblade <Death Knight>
--    [34460] = true, -- Kavina Grovesong <Druid>
--    [34469] = true, -- Melador Valestrider <Druid>
--    [34467] = true, -- Alyssia Moonstalker <Hunter>
--    [34468] = true, -- Noozle Whizzlestick <Mage>
--    [34465] = true, -- Velanaa <Paladin>
--    [34471] = true, -- Baelnor Lightbearer <Paladin>
--    [34466] = true, -- Anthar Forgemender <Priest>
--    [34473] = true, -- Brienna Nightfell <Priest>
--    [34472] = true, -- Irieth Shadowstep <Rogue>
--    [34470] = true, -- Saamul <Shaman>
--    [34463] = true, -- Shaabad <Shaman>
--    [34474] = true, -- Serissa Grimdabbler <Warlock>
--    [34475] = true, -- Shocuul <Warrior>
--
--    [34458] = true, -- Gorgrim Shadowcleave <Death Knight>
--    [34451] = true, -- Birana Stormhoof <Druid>
--    [34459] = true, -- Erin Misthoof <Druid>
--    [34448] = true, -- Ruj'kah <Hunter>
--    [34449] = true, -- Ginselle Blightslinger <Mage>
--    [34445] = true, -- Liandra Suncaller <Paladin>
--    [34456] = true, -- Malithas Brightblade <Paladin>
--    [34447] = true, -- Caiphus the Stern <Priest>
--    [34441] = true, -- Vivienne Blackwhisper <Priest>
--    [34454] = true, -- Maz'dinah <Rogue>
--    [34444] = true, -- Thrakgar	<Shaman>
--    [34455] = true, -- Broln Stouthorn <Shaman>
--    [34450] = true, -- Harkzog <Warlock>
--    [34453] = true, -- Narrhok Steelbreaker <Warrior>
--
--    [35610] = true, -- Cat <Ruj'kah's Pet / Alyssia Moonstalker's Pet>
--    [35465] = true, -- Zhaagrym <Harkzog's Minion / Serissa Grimdabbler's Minion>
--
--    [34497] = true, -- Fjola Lightbane
--    [34496] = true, -- Eydis Darkbane
--    [34564] = true, -- Anub'arak (Trial of the Crusader)
--


encounters[Z.ULDUAR] = {
    "Flame Leviathan",
    "Ignis the Furnace Master",
    "Razorscale",
    "XT-002 Deconstructor",
    "Assembly of Iron",
    "Kologarn",
    "Auriaya",
    "Freya",
    "Hodir",
    "Mimiron",
    "Thorim",
    "General Vezax",
    "Yogg-Saron",
    "Algalon the Observer",
}
triggers[Z.ULDUAR] = {
    [33113] = "Flame Leviathan",
    [33118] = "Ignis the Furnace Master",
    [33186] = "Razorscale",
    [33293] = "XT-002 Deconstructor",
    [32867] = "Assembly of Iron", -- Steelbreaker
    [32927] = "Assembly of Iron", -- Runemaster Molgeim
    [32857] = "Assembly of Iron", -- Stormcaller Brundir
    [32930] = "Kologarn",
    [33515] = "Auriaya",
    [32906] = "Freya",
    [32845] = "Hodir",
    [33350] = "Mimiron",
    [32865] = "Thorim",
    [33271] = "General Vezax",
    [33288] = "Yogg-Saron",
    [32871] = "Algalon the Observer",
}
criteria[Z.ULDUAR] = {
    ["Flame Leviathan"] = {
        [33113] = true,
    },
    ["Ignis the Furnace Master"] = {
        [33118] = true,
    },
    ["Razorscale"] = {
        [33186] = true,
    },
    ["XT-002 Deconstructor"] = {
        [33293] = true,
    },
    ["Assembly of Iron"] = {
        [32867] = true, -- Steelbreaker
        [32927] = true, -- Runemaster Molgeim
        [32857] = true, -- Stormcaller Brundir
    },
    ["Kologarn"] = {
        [32930] = true,
    },
    ["Auriaya"] = {
        [33515] = true,
    },
    ["Freya"] = {
        [32906] = true,
    },
    ["Hodir"] = {
        [32845] = true,
    },
    ["Mimiron"] = {
        [33350] = true,
    },
    ["Thorim"] = {
        [32865] = true,
    },
    ["General Vezax"] = {
        [33271] = true,
    },
    ["Yogg-Saron"] = {
        [33288] = true,
    },
    ["Algalon the Observer"] = {
        [32871] = true,
    },
}

encounters[Z.UTGARDE_KEEP] = {
    "Prince Keleseth",
    "Skarvald the Constructor & Dalronn the Controller",
    "Ingvar the Plunderer",
}
triggers[Z.UTGARDE_KEEP] = {
    [23953] = "Prince Keleseth",
    [24200] = "Skarvald the Constructor & Dalronn the Controller", -- Skarvald the Constructor
    [24201] = "Skarvald the Constructor & Dalronn the Controller", -- Dalronn the Controller
    [23954] = "Ingvar the Plunderer",
}
criteria[Z.UTGARDE_KEEP] = {
    ["Prince Keleseth"] = {
        [23953] = true,
    },
    ["Skarvald the Constructor & Dalronn the Controller"] = {
        [24200] = true, -- Skarvald the Constructor
        [24201] = true, -- Dalronn the Controller
    },
    ["Ingvar the Plunderer"] = {
        [23980] = true, -- Undead form.
    },
}

encounters[Z.UTGARDE_PINNACLE] = {
    "Svala Sorrowgrave",
    "Gortok Palehoof",
    "Skadi the Ruthless",
    "King Ymiron",
}
triggers[Z.UTGARDE_PINNACLE] = {
    [26668] = "Svala Sorrowgrave",
    [26687] = "Gortok Palehoof",
    [26693] = "Skadi the Ruthless",
    [26861] = "King Ymiron",
}
criteria[Z.UTGARDE_PINNACLE] = {
    ["Svala Sorrowgrave"] = {
        [26668] = true,
    },
    ["Gortok Palehoof"] = {
        [26687] = true,
    },
    ["Skadi the Ruthless"] = {
        [26693] = true,
    },
    ["King Ymiron"] = {
        [26861] = true,
    },
}

encounters[Z.VAULT_OF_ARCHAVON] = {
    "Archavon the Stone Watcher",
    "Emalon the Storm Watcher",
    "Koralon the Flame Watcher",
    "Toravon the Ice Watcher",
}
triggers[Z.VAULT_OF_ARCHAVON] = {
    [31125] = "Archavon the Stone Watcher",
    [33993] = "Emalon the Storm Watcher",
    [35013] = "Koralon the Flame Watcher",
    [38433] = "Toravon the Ice Watcher",
}
criteria[Z.VAULT_OF_ARCHAVON] = {
    ["Archavon the Stone Watcher"] = {
        [31125] = true,
    },
    ["Emalon the Storm Watcher"] = {
        [33993] = true,
    },
    ["Koralon the Flame Watcher"] = {
        [35013] = true,
    },
    ["Toravon the Ice Watcher"] = {
        [38433] = true,
    },
}
