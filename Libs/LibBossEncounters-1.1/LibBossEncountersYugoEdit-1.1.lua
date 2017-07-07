local _G = getfenv(0)
local LibStub, table, string = _G.LibStub, _G.table, _G.string
local tonumber, type, pairs, ipairs = _G.tonumber, _G.type, _G.pairs, _G.ipairs

_G.assert(LibStub, "LibBossEncounters-1.1 requires LibStub")

local AceEvent = LibStub("AceEvent-3.0")
_G.assert(AceEvent, "LibBossEncounters-1.1 requires AceEvent-3.0")

local MAJOR, MINOR = "LibBossEncountersYugoEdit-1.1", 6
local BossEncounters = LibStub:NewLibrary(MAJOR, MINOR)

if not BossEncounters then
    return
end

-------------------------------------------------------------------------------
-- Data
-------------------------------------------------------------------------------
-- These tables are populated by the various era files.
local ZoneEncounters = {}
BossEncounters.zone_encounters = ZoneEncounters

local EncounterTriggers = {}
BossEncounters.encounter_triggers = EncounterTriggers

local EncounterCriteria = {}
BossEncounters.encounter_criteria = EncounterCriteria

BossEncounters_Data = {
    ["BossEncounters_Encounters"] = ZoneEncounters,
    ["BossEncounters_Triggers"] = EncounterTriggers,
    ["BossEncounters_Criteria"] = EncounterCriteria,
}

-- Populated in OnEmbedEnable
local BossIDs = {}

-------------------------------------------------------------------------------
-- Private Helpers
-------------------------------------------------------------------------------
local function _len(table)
    local count = 0

    for _, _ in pairs(table) do
        count = count + 1
    end

    return count
end

local _unitID
do
    local UnitTypes = {
        ["player"] = 0,
        ["object"] = 1,
        ["npc"] = 3,
        ["pet"] = 4,
        ["vehicle"] = 5
    }

    local UnitTypeBitmask = 0x007

    function _unitID(guid)
        local unit_type = _G.bit.band(tonumber(guid:sub(1, 5)), UnitTypeBitmask)

        if unit_type ~= UnitTypes.player or unit_type ~= UnitTypes.object or unit_type ~= UnitTypes.pet then
            return tonumber(guid:sub(-12, -9), 16)
        end
    end
end -- do-block

local function _clearActiveEncounter()
    BossEncounters.active_encounter = nil
    BossEncounters.active_encounter_criteria = nil
    table.wipe(BossEncounters.dead_list)
end

local function _setActiveEncounter(encounter_name)
    local active_encounter = BossEncounters.active_encounter
    if active_encounter == encounter_name then
        return
    end

    if active_encounter then
        BossEncounters:SendMessage("ENCOUNTER_FAILED", active_encounter)
        _clearActiveEncounter()
    end

    local criteria = {}
    for k, v in pairs(BossEncounters.active_criteria[encounter_name]) do
        criteria[k] = v
    end

    BossEncounters.active_encounter = encounter_name
    BossEncounters.active_encounter_criteria = criteria
    BossEncounters:SendMessage("ENCOUNTER_STARTED", encounter_name)
end

local function _checkForSuccess()
    if _len(BossEncounters.active_encounter_criteria) > 0 then
        return
    end

    BossEncounters:SendMessage("ENCOUNTER_SUCCESSFUL", BossEncounters.active_encounter)
    _clearActiveEncounter()
end

local function _checkForWipe()
    if _len(BossEncounters.dead_list) ~= _len(BossEncounters.current_group_members) then
        return
    end

    BossEncounters:SendMessage("ENCOUNTER_FAILED", BossEncounters.active_encounter)
    _clearActiveEncounter()
end

local function _processCombatLogEvent(_, timestamp, event, hide_caster, source_guid, source_name, source_flags, source_raid_flags, dest_guid, dest_name, dest_flags, dest_raid_flags)
    local group_members, triggers = BossEncounters.current_group_members, BossEncounters.active_triggers
    local dest_id = _unitID(dest_guid)

    local encounter_name = triggers[_unitID(source_guid)] or triggers[dest_id]
    local in_group = group_members[source_guid] or group_members[dest_guid]
    if event ~= "PARTY_KILL" and encounter_name and in_group then
        _setActiveEncounter(encounter_name)
    end

    if not BossEncounters.active_encounter then
        return
    end

    if event == "UNIT_DIED" and BossEncounters.active_encounter_criteria[dest_id] then
        BossEncounters.active_encounter_criteria[dest_id] = nil
        _checkForSuccess()
    end

    local dead_list = BossEncounters.dead_list
    if event == "UNIT_DIED" and group_members[dest_guid] then
        dead_list[source_guid] = nil
        dead_list[dest_guid] = true
    else
        dead_list[source_guid] = nil
        dead_list[dest_guid] = nil
    end

    _checkForWipe()
end

local function _processZoneChange()
    local zone_label = BossEncounters.zone_labels[_G.GetRealZoneText()]
    BossEncounters.active_triggers = EncounterTriggers[zone_label]
    BossEncounters.active_criteria = EncounterCriteria[zone_label]

    if BossEncounters.active_triggers then
        BossEncounters:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", _processCombatLogEvent)
    else
        BossEncounters:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    end
end

local function _processGroupChange()
    local is_raid = _G.IsInRaid()
    local unit_type = is_raid and "raid" or "party"
    local number_in_group = is_raid and _G.GetNumGroupMembers() or _G.GetNumSubgroupMembers()

    local group_members = BossEncounters.current_group_members
    table.wipe(group_members)

    for i = 1, number_in_group do
        group_members[_G.UnitGUID(unit_type .. i)] = true
    end

    group_members[_G.UnitGUID("player")] = true
end
-------------------------------------------------------------------------------
-- Public API
-------------------------------------------------------------------------------
function BossEncounters:IsBossID(mob_id)
    print('bossenc', mob_id, BossIDs[tonumber(mob_id)])
    return BossIDs[tonumber(mob_id)]
end

function BossEncounters:EncountersByZone(zone_name)
    return ZoneEncounters[BossEncounters.zone_labels[zone_name]]
end

function BossEncounters:GetInstances()
    return BossEncounters.zone_names
end

-------------------------------------------------------------------------------
-- Embedding and Upgrading
-------------------------------------------------------------------------------
function BossEncounters:OnEmbedInitialize(addon)
    if not self.current_group_members then
        self.current_group_members = {}
        self.dead_list = {}
    end
end

function BossEncounters:OnEmbedEnable(addon)
    self:RegisterEvent("ZONE_CHANGED", _processZoneChange)
    self:RegisterEvent("ZONE_CHANGED_INDOORS", _processZoneChange)
    self:RegisterEvent("ZONE_CHANGED_NEW_AREA", _processZoneChange)
    self:RegisterEvent("GROUP_ROSTER_UPDATE", _processGroupChange)

    _processGroupChange()
    _processZoneChange()

    for instance_name in pairs(EncounterCriteria) do
        local instance = EncounterCriteria[instance_name]

        for encounter_name in pairs(instance) do
            local encounter = instance[encounter_name]

            for idnum, _ in pairs(encounter) do
                BossIDs[idnum] = encounter_name
            end
        end
    end

    for instance_name in pairs(EncounterTriggers) do
        for idnum, encounter_name in pairs(EncounterTriggers[instance_name]) do
            if type(idnum) == "number" then
                BossIDs[idnum] = encounter_name
            end
        end
    end
end

BossEncounters.embeds = BossEncounters.embeds or {}

local mixins = {
    "IsBossID",
    "EncountersByZone",
    "GetInstances"
}

function BossEncounters:Embed(target)
    for _, v in pairs(mixins) do
        target[v] = self[v]
    end
    self.embeds[target] = true
    return target
end

for addon in pairs(BossEncounters.embeds) do
    BossEncounters:Embed(addon)
end

AceEvent:Embed(BossEncounters)

local TownCrier = LibStub:GetLibrary("TownCrier-1.0", true)

if TownCrier then
    TownCrier:Embed(BossEncounters)
end

BossEncounters.zone_names = {
    HELLFIRE_PENINSULA = _G.GetMapNameByID(465),
    SHADOWMOON_VALLEY = _G.GetMapNameByID(473),
    THE_NEXUS = _G.GetMapNameByID(520),
    THE_CULLING_OF_STRATHOLME = _G.GetMapNameByID(521),
    AHNKAHET_THE_OLD_KINGDOM = _G.GetMapNameByID(522),
    UTGARDE_KEEP = _G.GetMapNameByID(523),
    UTGARDE_PINNACLE = _G.GetMapNameByID(524),
    HALLS_OF_LIGHTNING = _G.GetMapNameByID(525),
    HALLS_OF_STONE = _G.GetMapNameByID(526),
    THE_EYE_OF_ETERNITY = _G.GetMapNameByID(527),
    THE_OCULUS = _G.GetMapNameByID(528),
    ULDUAR = _G.GetMapNameByID(529),
    GUNDRAK = _G.GetMapNameByID(530),
    THE_OBSIDIAN_SANCTUM = _G.GetMapNameByID(531),
    VAULT_OF_ARCHAVON = _G.GetMapNameByID(532),
    AZJOL_NERUB = _G.GetMapNameByID(533),
    DRAKTHARON_KEEP = _G.GetMapNameByID(534),
    NAXXRAMAS = _G.GetMapNameByID(535),
    THE_VIOLET_HOLD = _G.GetMapNameByID(536),
    THE_FORGE_OF_SOULS = _G.GetMapNameByID(601),
    PIT_OF_SARON = _G.GetMapNameByID(602),
    HALLS_OF_REFLECTION = _G.GetMapNameByID(603),
    ICECROWN_CITADEL = _G.GetMapNameByID(604),
    THE_RUBY_SANCTUM = _G.GetMapNameByID(609),
    RAGEFIRE_CHASM = _G.GetMapNameByID(680),
    ZULFARRAK = _G.GetMapNameByID(686),
    THE_TEMPLE_OF_ATALHAKKAR = _G.GetMapNameByID(687),
    BLACKFATHOM_DEEPS = _G.GetMapNameByID(688),
    THE_STOCKADE = _G.GetMapNameByID(690),
    GNOMEREGAN = _G.GetMapNameByID(691),
    ULDAMAN = _G.GetMapNameByID(692),
    MOLTEN_CORE = _G.GetMapNameByID(696),
    DIRE_MAUL = _G.GetMapNameByID(699),
    BLACKROCK_DEPTHS = _G.GetMapNameByID(704),
    THE_SHATTERED_HALLS = _G.GetMapNameByID(710),
    RUINS_OF_AHNQIRAJ = _G.GetMapNameByID(717),
    ONYXIAS_LAIR = _G.GetMapNameByID(718),
    BLACKROCK_SPIRE = _G.GetMapNameByID(721),
    AUCHENAI_CRYPTS = _G.GetMapNameByID(722),
    SETHEKK_HALLS = _G.GetMapNameByID(723),
    SHADOW_LABYRINTH = _G.GetMapNameByID(724),
    THE_BLOOD_FURNACE = _G.GetMapNameByID(725),
    THE_UNDERBOG = _G.GetMapNameByID(726),
    THE_STEAMVAULT = _G.GetMapNameByID(727),
    THE_SLAVE_PENS = _G.GetMapNameByID(728),
    THE_BOTANICA = _G.GetMapNameByID(729),
    THE_MECHANAR = _G.GetMapNameByID(730),
    THE_ARCATRAZ = _G.GetMapNameByID(731),
    MANA_TOMBS = _G.GetMapNameByID(732),
    THE_BLACK_MORASS = _G.GetMapNameByID(733),
    OLD_HILLSBRAD_FOOTHILLS = _G.GetMapNameByID(734),
    LOST_CITY_OF_THE_TOLVIR = _G.GetMapNameByID(747),
    WAILING_CAVERNS = _G.GetMapNameByID(749),
    MARAUDON = _G.GetMapNameByID(750),
    BARADIN_HOLD = _G.GetMapNameByID(752),
    BLACKROCK_CAVERNS = _G.GetMapNameByID(753),
    BLACKWING_DESCENT = _G.GetMapNameByID(754),
    BLACKWING_LAIR = _G.GetMapNameByID(755),
    THE_DEADMINES = _G.GetMapNameByID(756),
    GRIM_BATOL = _G.GetMapNameByID(757),
    THE_BASTION_OF_TWILIGHT = _G.GetMapNameByID(758),
    HALLS_OF_ORIGINATION = _G.GetMapNameByID(759),
    RAZORFEN_DOWNS = _G.GetMapNameByID(760),
    RAZORFEN_KRAUL = _G.GetMapNameByID(761),
    SCARLET_MONASTERY = _G.GetMapNameByID(762),
    SHADOWFANG_KEEP = _G.GetMapNameByID(764),
    STRATHOLME = _G.GetMapNameByID(765),
    THRONE_OF_THE_TIDES = _G.GetMapNameByID(767),
    THE_STONECORE = _G.GetMapNameByID(768),
    THE_VORTEX_PINNACLE = _G.GetMapNameByID(769),
    THRONE_OF_THE_FOUR_WINDS = _G.GetMapNameByID(773),
    HYJAL_SUMMIT = _G.GetMapNameByID(775),
    GRUULS_LAIR = _G.GetMapNameByID(776),
    MAGTHERIDONS_LAIR = _G.GetMapNameByID(779),
    SERPENTSHRINE_CAVERN = _G.GetMapNameByID(780),
    ZULAMAN = _G.GetMapNameByID(781),
    SUNWELL_PLATEAU = _G.GetMapNameByID(789),
    ZULGURUB = _G.GetMapNameByID(793),
    BLACK_TEMPLE = _G.GetMapNameByID(796),
    HELLFIRE_RAMPARTS = _G.GetMapNameByID(797),
    MAGISTERS_TERRACE = _G.GetMapNameByID(798),
    FIRELANDS = _G.GetMapNameByID(800),
    WELL_OF_ETERNITY = _G.GetMapNameByID(816),
    HOUR_OF_TWILIGHT = _G.GetMapNameByID(819),
    END_TIME = _G.GetMapNameByID(820),
    DRAGON_SOUL = _G.GetMapNameByID(824),
    TEMPLE_OF_THE_JADE_SERPENT = _G.GetMapNameByID(867),
    SCARLET_HALLS = _G.GetMapNameByID(871),
    GATE_OF_THE_SETTING_SUN = _G.GetMapNameByID(875),
    STORMSTOUT_BREWERY = _G.GetMapNameByID(876),
    SHADO_PAN_MONASTERY = _G.GetMapNameByID(877),
    MOGUSHAN_PALACE = _G.GetMapNameByID(885),
    TERRACE_OF_ENDLESS_SPRING = _G.GetMapNameByID(886),
    SIEGE_OF_NIUZAO_TEMPLE = _G.GetMapNameByID(887),
    MOGUSHAN_VAULTS = _G.GetMapNameByID(896),
    HEART_OF_FEAR = _G.GetMapNameByID(897),
    SCHOLOMANCE = _G.GetMapNameByID(898),
    THRONE_OF_THUNDER = _G.GetMapNameByID(930),
    SIEGE_OF_ORGRIMMAR = _G.GetMapNameByID(953),
}

BossEncounters.zone_labels = {}

for label, name in pairs(BossEncounters.zone_names) do
    BossEncounters.zone_labels[name] = label
end

_processZoneChange()

