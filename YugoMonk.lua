if select(2, UnitClass("player")) == 'MONK' then
local Yugo = Yugo
local YugoMonk = LibStub("AceAddon-3.0"):NewAddon("YugoMonk", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0" );
YugoMonk:SetDefaultModuleLibraries("AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0")
YugoMonk:SetDefaultModuleState(false)

local Spells = Spells
local StatusBar = StatusBar
local Player = Player
local Frames = Yugo:GetModule("Frames")
local LCT = LibStub("LibCooldownTracker-1.0")



local CheckSpec = {}
function CheckSpec:Check()
    local playerSpec = select(2, GetSpecializationInfo(GetSpecialization()))

    if playerSpec ~= "Brewmaster" then
        YugoMonk:Disable()
    else
        YugoMonk:Enable()
        YugoMonk:GuardBarUpdate()
    end
end
LibStub('AceEvent-3.0'):Embed(CheckSpec)
CheckSpec:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED", 'Check')
CheckSpec:RegisterEvent("PLAYER_ENTERING_WORLD", 'Check')


local registerEvents = {
    "GLYPH_UPDATED",
    'ACTIVE_TALENT_GROUP_CHANGED',
    "PLAYER_LEVEL_UP",
    "PLAYER_TALENT_UPDATE",
    "PLAYER_REGEN_ENABLED",
    "PLAYER_REGEN_DISABLED",
    "PLAYER_ENTERING_WORLD",
    "UNIT_POWER_FREQUENT",
    "UNIT_POWER",
    "UNIT_AURA",
    "UNIT_MAXHEALTH",
    "UNIT_ATTACK_POWER",
    "UNIT_SPELLCAST_SUCCEEDED",
    "UNIT_ABSORB_AMOUNT_CHANGED",
    --"UNIT_THREAT_LIST_UPDATE", "UpdateAggro",
    --"UNIT_THREAT_SITUATION_UPDATE", "UpdateAggro",
    --"UNIT_TARGET", "UpdateAggro",
    "COMBAT_LOG_EVENT_UNFILTERED",
    "ZONE_CHANGED_NEW_AREA",
}

-- Frames
YugoMonk.EB = {}
YugoMonk.CHIS = {}
YugoMonk.configMode = false

local EB = YugoMonk.EB
local CHIS = YugoMonk.CHIS

YugoMonk.F = {}
YugoMonk.S = {}

local F = YugoMonk.F
local S = YugoMonk.S

-- tracking cd's and shit
local player = {
    GUID = 0,
    MaxHealth = 0,
    combat = false
}
local auras = {}
local cooldowns = {}

-- used vars for widgets
--local ebEnabled = false
--local ebHasStacks = false
local ebStarted = false
local ebMaxStacks = 15
local shuffleEnabled = false
local maxShuffleTime = 0


-- stagger
local LIGHT_STAGGER_ICON =  "INTERFACE\\ICONS\\priest_icon_chakra_green"
local MODERATE_STAGGER_ICON =  "INTERFACE\\ICONS\\priest_icon_chakra"
local HEAVY_STAGGER_ICON =  "INTERFACE\\ICONS\\priest_icon_chakra_red"

-- adjust
local adjust = {
    guardAbsorb = 0,
    guardCooldown = 0
}



-- transcendence
local Trans = {
    active = false,
    init = false,
    maxRange = 40,
    teleport = {
        facing		= 0,
        range		= 0,
        inside		= false,
        ping = {
            x		= 0,
            y		= 0
        },
        offset = {
            x		= 0,
            y		= 0
        }
    },
    MinimapSize = {
        indoor = {
            [0] = 300,
            [1] = 240,
            [2] = 180,
            [3] = 120,
            [4] = 80,
            [5] = 50,
        },
        outdoor = {
            [0] = 466 + 2/3,
            [1] = 400,
            [2] = 333 + 1/3,
            [3] = 266 + 2/6,
            [4] = 200,
            [5] = 133 + 1/3,
        },
    }
}
local _, _, transIcon = GetSpellInfo(119996)
Trans.spell = {
    icon = transIcon,
    teleport = GetSpellInfo(119996),
    summon = GetSpellInfo(101643)
}

-- vengeance
local Veng = {
    stamina = 0,
    baseHealth = 0,
    max = 0,
    value = 0,
    enabled = true
}

--------------------------------------------------------- Ace Addon Shit
function YugoMonk:OnInitialize()

    F['YM_GuardFrame'] = Frame('YM_GuardFrame')
    F['YM_GuardFrame'].register_as_anchor('Guard')
    F['YM_GuardFrame'].set({
        width = 250,
        height = 40,
        anchors = {
            {
                this = "TOPLEFT",
                that = "TOPRIGHT",
                to = "YM_Abilities",
                x = 0,
                y = 0
            }
        }
    })

    F['YM_ElusiveBrewFrame'] = Frame('YM_ElusiveBrewFrame')
    F['YM_ElusiveBrewFrame'].register_as_anchor('Elusive brew container')
    F['YM_ElusiveBrewFrame'].set({
        width = 250,
        height = 40,
        anchors = {
            {
                this = "TOPLEFT",
                that = "BOTTOMLEFT",
                to = "YM_GuardFrame",
                x = 0,
                y = 0
            }
        }
    })

    F['YM_ShuffleFrame'] = Frame('YM_ShuffleFrame')
    F['YM_ShuffleFrame'].register_as_anchor('Shuffle')
    F['YM_ShuffleFrame'].set({
        width = 40,
        height = 123,
        anchors = {
            {
                this = "TOPRIGHT",
                that = "TOPLEFT",
                to = "YM_Abilities",
                x = 0,
                y = 0
            }
        }
    })


    F['YM_Chis'] = Frame('YM_Chis')
    F['YM_Chis'].register_as_anchor('Chi container')
    F['YM_Chis'].set({
        width = 250,
        height = 22,
        border = {
            texture = 'None',
            size = 0
        },
        background = {
            texture = 'None',
            color = { a = 0 }
        },
        anchors = {
            {
                this = "BOTTOMLEFT",
                that = "TOPLEFT",
                to = "YM_Abilities",
                x = 0,
                y = 0
            }
        }
    })

    F['YM_TransFrame'] = Frame('YM_TransFrame')
    F['YM_TransFrame'].register_as_anchor('Transcendence')
    F['YM_TransFrame'].set({
        width = 40,
        height = 123,
        anchors = {
            {
                this = "TOPRIGHT",
                that = "TOPLEFT",
                to = "YM_ShuffleFrame",
                x = 0,
                y = 0
            }
        }
    })

    F['YM_VengeanceFrame'] = Frame('YM_VengeanceFrame')
    F['YM_VengeanceFrame'].register_as_anchor('Vengeance')
    F['YM_VengeanceFrame'].set({
        width = 250,
        height = 30,
        anchors = {
            {
                this = "TOPLEFT",
                that = "BOTTOMLEFT",
                to = "YM_ElusiveBrewFrame",
                x = 0,
                y = 0
            }
        }
    })


    F['YM_EnergyFrame'] = Frame('YM_EnergyFrame')
    F['YM_EnergyFrame'].register_as_anchor('Energy')
    F['YM_EnergyFrame'].set({
        width = 250,
        height = 35,
        anchors = {
            {
                this = "TOPLEFT",
                that = "BOTTOMLEFT",
                to = "YM_Abilities",
                x = 0,
                y = 0
            }
        }
    })


    F['YM_StaggerFrame'] = Frame('YM_StaggerFrame')
    F['YM_StaggerFrame'].register_as_anchor('Stagger')
    F['YM_StaggerFrame'].set({
        width = 250,
        height = 35,
        anchors = {
            {
                this = "TOPLEFT",
                that = "BOTTOMLEFT",
                to = "YM_EnergyFrame",
                x = 0,
                y = 0
            }
        }
    })

    S['YM_GuardBar'] = StatusBar("YM_GuardBar", 'YM_GuardFrame')
    S['YM_GuardBar'].set({
        bar = {
            text = {
                size = 30,
                font = "YugoWolf"
            }
        }
    })


    S['YM_ShuffleBar'] = StatusBar("YM_ShuffleBar", 'YM_ShuffleFrame')
    S['YM_ShuffleBar'].set({
        bar = {
            orientation = "VERTICAL",
            reverseFill = true,
            texture = "YugoPlastic",
            color = { r = 0.57, g = 0.21, b = 0.54, a = 1 },
            text = {
                verticalPosition = "TOP",
                horizontalPosition = "CENTER"
            }
        }
    })

    S['YM_StaggerBar'] = StatusBar("YM_StaggerBar", 'YM_StaggerFrame')
    S['YM_StaggerBar'].set({
        bar = {
            text = {
                size = 17,
                font = "YugoBara",
            }
        }
    })
    S['YM_StaggerBar']:SetMinMaxValues(0, 50)


    S['YM_EnergyBar'] = StatusBar("YM_EnergyBar", 'YM_EnergyFrame')
    S['YM_EnergyBar'].set({
        bar = {
            color = { r = 0.12, g = 0.48, b = 0.39, a = 1 },
            text = {
                size = 25,
                font = "YugoWolf"
            }
        }
    })
    S['YM_EnergyBar']:SetValue(100)
    S['YM_EnergyBar'].text:SetText("100")



    S['YM_TransBar'] = StatusBar("YM_TransBar", 'YM_TransFrame')
    S['YM_TransBar'].set({
        bar = {
            orientation = "VERTICAL",
            reverseFill = true,
            texture = "YugoPlastic",
            color = { r = 1, g = 1, b = 1, a = 1 },
            text = {
                verticalPosition = "TOP",
                horizontalPosition = "CENTER"
            }
        }
    })
    S['YM_TransBar']:SetMinMaxValues(0, 40)


    S['YM_VengeanceBar'] = StatusBar("YM_VengeanceBar", 'YM_VengeanceFrame')
    S['YM_VengeanceBar'].set({
        bar = {
            color = { r = 0.3, g = 0.31, b = 1, a = 1 }
        }
    })


    CHIS[1] = Frame("YM_Chi_1")
    CHIS[2] = Frame("YM_Chi_2")
    CHIS[3] = Frame("YM_Chi_3")
    CHIS[4] = Frame("YM_Chi_4")
    CHIS[5] = Frame("YM_Chi_5")

    for count = 1, 5 do
        CHIS[count].set({
            parent = 'YM_Chis',
            width = 8,
            height = 22,
            border = {
                color = {
                    ["b"] = 0.7450980392156863,
                    ["g"] = 0.7450980392156863,
                    ["r"] = 0.7450980392156863,
                },
                size = 14,
                texture = 'YugoChi'
            },
            background = {
                style = 'GRADIENT',
                orientation = 'VERTICAL',
                gradient = { a = 1, r = 0, b = 0.58, g = 1},
                insets = { b = 2, t = -2, l = 2, r = -2 },
                color = { a = 1, r = 0, g = 0.18, b = 0.10 },
                texture = 'Solid'
            }
        })
        CHIS[count].clear_anchors()
        CHIS[count].add_anchor({
            this = 'TOPLEFT',
            that = 'TOPLEFT',
            to = 'YM_Chis',
            x = 0,
            y = 0
        })
    end

    for count = 1, 15 do

        EB[count] = Frame("YM_ElusiveBrewStack_" .. count)
        local es = EB[count]
        es.set({
            parent = 'YM_ElusiveBrewFrame',
            level = 3,
            background = {
                style = 'GRADIENT',
                color = {
                    ["a"] = 1,
                    ["b"] = 0.1,
                    ["g"] = 0.18,
                    ["r"] = 0,
                },
                insets = {
                    ["r"] = 0,
                    ["t"] = 0,
                    ["l"] = 0,
                    ["b"] = 0,
                },
                texture = 'Solid',
                orientation = 'VERTICAL',
                gradient = {
                    ["a"] = 1,
                    ["b"] = 0.58,
                    ["g"] = 1,
                    ["r"] = 0,
                }
            },
            border = {
                texture = 'None',
                size = 0
            }
        })
        es.clear_anchors()
        es.add_anchor({
            this = 'TOPLEFT',
            that = 'TOPLEFT',
            to = 'YM_ElusiveBrewFrame',
            x = 0,
            y = 0
        })

        es.text = EB[count]:CreateFontString("YM_ElusiveBrewStackText_" .. count)
        es.text:SetParent("YM_ElusiveBrewStack_" .. count)
        es.text.set({
            font = 'Yugo',
            size = 12,
            color = { r = 0, b = 1, g = 0.12, a = 1},
            anchors = {
                {
                    this = "CENTER",
                    that = "CENTER",
                    to = "YM_ElusiveBrewStack_" .. count,
                    x = 0,
                    y = 0
                },
                {
                    this = "TOP",
                    that = "TOP",
                    to = "YM_ElusiveBrewStack_" .. count,
                    x = 0,
                    y = -2
                },
            }
        })
        if count > 9 then
            es.text:SetText( (count - 10) )
        else
            es.text:SetText(count)
        end

        -- Lets set the 2nd one to be an 'active', for default options, this iwll get overwritten anyways..
        if count == 2 then
            es.set('background', 'gradient', {
                    ["a"] = 1,
                    ["b"] = 1,
                    ["g"] = 0.1529411764705883,
                    ["r"] = 0.2745098039215687,
                })
            es.text.set('color', {
                ["b"] = 0,
                ["g"] = 1,
                ["r"] = 0.04705882352941176,
            })
        end

    end



    YugoMonk:InitOptions()

    self:SendMessage("CoreLoaded")
    self:Print("Loaded")
end
function YugoMonk:OnEnable()

    for k, v in pairs(S) do
        v.set_apply('enabled', true)
    end

    for k, v in pairs(F) do
        v.set_apply('enabled', true)
    end

    -- Chis
    for count = 1, 5 do
        CHIS[count].set_apply('enabled', false)
    end

    for count = 1, ebMaxStacks do
        EB[count].set_apply('enabled', false)
    end

    YugoMonk:CheckTalentsGlyphsItems()
    YugoMonk:SetDisplayOptions()

    LCT.RegisterCallback(self, "LCT_CooldownUsed")
    LCT.RegisterCallback(self, "LCT_CooldownsReset")
    LCT:RegisterUnit("player")

    for k, v in pairs(registerEvents) do
        self:RegisterEvent(v)
    end

    self.MaxHealth = UnitHealthMax("player")
    self:Print("Enabled")

    for name, module in YugoMonk:IterateModules() do
        local db = YugoMonk.db:GetNamespace('YugoMonk_' .. name)
        if db.profile.enabled == true then
            module:Enable()
        end

    end
end
function YugoMonk:OnDisable()
    for k, v in pairs(S) do
        v.set_apply('enabled', false)
    end

    for k, v in pairs(F) do
        v.set_apply('enabled', false)
    end

    self:Print('disabled')
    for k, v in pairs(registerEvents) do
        self:UnregisterEvent(v)
    end
end


--------------------------------------------------------- LOCALS
local function HasAura(spellName)

    local spellId = Spells:ID(spellName)
    if auras[spellId] ~= nil then
        return true
    end
    return nil
end
local function HasCooldown(spellId)
    if cooldowns[spellId] ~= nil then
        return true
    end
    return nil
end
local function GuardFormat(value)
    if value == nil then
        return 0
    elseif(value > 999999) then
        value = math.floor(value/1000000) .. "m"
    elseif value > 999 then
        value = math.floor(value/1000) .. "k"
    end
    return value
end
local function GuardAbsorbRemaining(format)
    local name,_,icon,_,_,_,_,_,_,_,_,_,_,_, remaining, v1, v2 ,v3 = UnitBuff("player", Spells:Name('Guard'))

    if format == true then
        return GuardFormat(remaining)
    end
    return remaining
end
local function GuardAbsorbExpected(format)
    local base, posBuff, negBuff = UnitAttackPower("player")
    local effective = base + posBuff + negBuff
    local expected = (effective * 1.971) + 14232

    if HasAura('Power Guard') then
        expected = (expected / 100 * 15) + expected
    end

    expected = (expected  / 100 * adjust.guardAbsorb) + expected


    if format == true then
        return GuardFormat(expected)
    end
    return expected
end


--------------------------------------------------------- DISPLAY
function YugoMonk:SetDisplayOptions()

    F['YM_GuardFrame'].SetDisplayOptions()
    F['YM_ShuffleFrame'].SetDisplayOptions()
    F['YM_ElusiveBrewFrame'].SetDisplayOptions()
    F['YM_StaggerFrame'].SetDisplayOptions()
    F['YM_EnergyFrame'].SetDisplayOptions()
    F['YM_VengeanceFrame'].SetDisplayOptions()
    F['YM_TransFrame'].SetDisplayOptions()
    F['YM_Chis'].SetDisplayOptions()

    --show_table(YugoMonk.S['YM_GuardBar'].get(), 'setdisplay')
    S['YM_GuardBar'].SetDisplayOptions()
    S['YM_EnergyBar'].SetDisplayOptions()
    S['YM_ShuffleBar'].SetDisplayOptions()
    S['YM_StaggerBar'].SetDisplayOptions()
    S['YM_VengeanceBar'].SetDisplayOptions()
    S['YM_TransBar'].SetDisplayOptions()


    local chiFrameWidth = F['YM_Chis'].config.width
    local chiWidth = (chiFrameWidth - 8) / 5
    for count = 1, 5 do
        CHIS[count].SetDisplayOptions()
        CHIS[count].set({
            width = chiWidth,
        })
        CHIS[count].config.anchors[1].x = (chiWidth * count) - chiWidth
        CHIS[count].config.enabled = false
        CHIS[count].apply()
    end


    local ebSpacing = 1
    local borderSize = F['YM_ElusiveBrewFrame'].config.border.size / 10
    local EBData = {
        x = F['YM_ElusiveBrewFrame'].config.background.insets.l + borderSize,
        y = F['YM_ElusiveBrewFrame'].config.background.insets.t - borderSize,
        spacing = ebSpacing,
        width = ((F['YM_ElusiveBrewFrame'].config.width - (F['YM_ElusiveBrewFrame'].config.background.insets.l * 2) - borderSize) / 15) - ebSpacing,
        height = F['YM_ElusiveBrewFrame'].config.height - (F['YM_ElusiveBrewFrame'].config.background.insets.b * 2) - borderSize
    }

    for count = 1, ebMaxStacks do

        EB[count].SetDisplayOptions()
        EB[count].text.SetDisplayOptions()

        EB[count].text.clear_anchors()
        EB[count].text.set({
            level = 2,
            anchors = {
                {
                    this = "CENTER",
                    that = "CENTER",
                    to = "YM_ElusiveBrewStack_" .. count,
                    x = 0,
                    y = 0
                },
                {
                    this = "TOP",
                    that = "TOP",
                    to = "YM_ElusiveBrewStack_" .. count,
                    x = 0,
                    y = -2
                },
            }
        })
        EB[count].text.apply()
        EB[count].config.width = EBData.width
        EB[count].config.height = EBData.height
        EB[count].config.anchors[1].x = EBData.x
        EB[count].config.anchors[1].y = EBData.y
        EB[count].config.enabled = false
        EB[count].apply()

        EBData.x = EBData.x + EBData.spacing + EBData.width
    end



    if self.configMode == true then
        self:ConfigModeEnable()
    else
        F['YM_TransFrame']:Hide()
    end

    self:SendMessage("SetDisplayOptions")

end
function YugoMonk:ConfigModeEnable()
    if player.combat == true then
        self:Print("Cannot enable config mode in combat")
    else
        self:SendMessage('ConfigModeEnable')

        for count = 1, 15 do
            EB[count].set_apply('enabled', true)
        end

        for count = 1, 5 do
            CHIS[count].set_apply('enabled', true)
        end


        if not self.configStaggerTimerStarted == true then
            self.configStaggerHP = 1
            self.configStaggerIcon = LIGHT_STAGGER_ICON
            self.configStaggerTotal = 100000
            self.configStaggerTimer = self:ScheduleRepeatingTimer("ConfigStagger", 1)
            self.configStaggerTimerStarted = true
        end

        S['YM_ShuffleBar']:SetValue(73)
        S['YM_ShuffleBar'].text:SetText("53")


        S['YM_VengeanceBar']:SetValue(73)
        S['YM_VengeanceBar'].text:SetText("53" .. " - 140%");

        if not self.configMode == true then
            self.configMode = true
            self:Print("Config mode enabled")
        end

    end
end
function YugoMonk:ConfigModeDisable()
    self.configMode = false

    for count = 1, 5 do
        CHIS[count].set_apply('enabled', false)
    end

    for count = 1, 15 do
        EB[count].set_apply('enabled', false)
    end

    self.configStaggerTimerStarted = false
    self:CancelTimer(self.configStaggerTimer)
    self:ClearStagger()

    S['YM_ShuffleBar']:SetValue(0)
    S['YM_ShuffleBar'].text:SetText("")

    S['YM_VengeanceBar']:SetValue(0)
    S['YM_VengeanceBar'].text:SetText("")


    self:SendMessage('ConfigModeDisable')
    self:Print("Config mode disabled")
end
function YugoMonk:ConfigStagger()
    local hp = self.configStaggerHP
    local icon = self.configStaggerIcon
    local staggerTotal = self.configStaggerTotal

    if hp <= 50 then
        S['YM_StaggerBar']:SetValue(hp)
    else
        S['YM_StaggerBar']:SetValue(50)
    end

    S['YM_StaggerBar'].text:SetText("" .. convert.tokilo(staggerTotal) .. " (" .. hp .. "%)")

    local iconset = false
    if icon == LIGHT_STAGGER_ICON then
        S['YM_StaggerBar']:SetStatusBarColor(0,192,0, 1)
        if iconset == false then self.configStaggerIcon = MODERATE_STAGGER_ICON; iconset = true end
    elseif icon == MODERATE_STAGGER_ICON then
        S['YM_StaggerBar']:SetStatusBarColor(255,255,0, 1)
        if iconset == false then self.configStaggerIcon = HEAVY_STAGGER_ICON; iconset = true end
    elseif icon == HEAVY_STAGGER_ICON then
        S['YM_StaggerBar']:SetStatusBarColor(192,0,0, 1)
        if iconset == false then self.configStaggerIcon = LIGHT_STAGGER_ICON; iconset = true end
    else
        S['YM_StaggerBar']:SetStatusBarColor(1, 1, 1, 1)
    end

    self.configStaggerHP = self.configStaggerHP + 1
    self.configStaggerTotal = self.configStaggerTotal + 50000

    if self.configStaggerHP > 48 then
        self.configStaggerHP = 1
        self.configStaggerTotal = 100000
    end

end


--------------------------------------------------------- Cooldowns
function YugoMonk:LCT_CooldownsReset(event, unit)
    cooldowns = {}
end
function YugoMonk:LCT_CooldownUsed(event, unitid, spellid)
    local cd = LCT:GetUnitCooldownInfo(unitid, spellid)
    if cd then
        cd.data = LCT:GetCooldownData(spellid)
        cooldowns[spellid] = table.deepcopy(cd)

        -- Adjust according to gear (vials)
        local duration = cooldowns[spellid].data.cooldown
        if spellid == Spells:ID('Guard') then
            local adjustment = (duration / 100 * adjust.guardCooldown)
            cooldowns[spellid].data.cooldown = duration - adjustment
            cooldowns[spellid].cooldown_end = cooldowns[spellid].cooldown_end - adjustment
        end


        self:ScheduleTimer("CooldownExpired", cooldowns[spellid].data.cooldown, spellid)
    end
end
function YugoMonk:CooldownExpired(spellId)
    self:SendMessage("PLAYER_COOLDOWN_EXPIRED", spellId)
    cooldowns[spellId] = nil
end


--------------------------------------------------------- Vengeance
function Veng:UpdateMax()
    if self.enabled == false then return end
    local _, stamina = UnitStat("player", 3);
    self.stamina = stamina;
    local basehp = (UnitHealthMax("player") or 0) - stamina*(UnitHPPerStamina("player") or 10);

    if self.baseHealth > 0 then
        self.baseHealth = min(self.baseHealth, basehp);
    else
        self.baseHealth = basehp;
    end
    self.max = self.baseHealth * .1 + stamina;
    S['YM_VengeanceBar']:SetMinMaxValues(0, self.max)
    --self.Frame:SetMinMaxValues(0, self.VengeanceMax);
end
function Veng:Update()
    if self.enabled == false then return end
    local exists = select(15, UnitBuff("player", Spells:Name("Vengeance") ));
    local value = exists or 0;
    if value > 0 then
        self:UpdateMax()
        self.value = value
        S['YM_VengeanceBar']:SetValue(value)
        S['YM_VengeanceBar'].text:SetText(value .. " - " .. convert.topercent(value/self.max));
    else
        S['YM_VengeanceBar']:SetValue(0)
        S['YM_VengeanceBar'].text:SetText("");
    end
end





--------------------------------------------------------- GUARD
local maxGuard = 0
--[[

Guard Active = Oranje balk 255, 157, 0 | Loopt af narmate absorb minder word
Guard CD = Grijze balk 150, 150, 150 | Groeit narmate CD minder word | Minder Alpha (0.7?)
Guard Ready = Gele Balk 255, 255, 0 | Blijft staan op 100%

]]--
function YugoMonk:GuardActivate()
    maxGuard = GuardAbsorbRemaining()
    S['YM_GuardBar'].text:SetVertexColor(0,192,0,1)
    YugoMonk:GuardBarUpdate()
    self.guardCDTimer = self:ScheduleRepeatingTimer("GuardBarUpdate", 0.5)
end
function YugoMonk:GuardDeactivate()
    S['YM_GuardBar'].text:SetVertexColor(1,1,1,1)
    YugoMonk:GuardBarUpdate()
end
function YugoMonk:GuardBarUpdate()
    if HasAura('Guard') and GuardAbsorbRemaining() ~= nil then
        S['YM_GuardBar']:SetValue(GuardAbsorbRemaining() / maxGuard * 100)
        S['YM_GuardBar'].text:SetText(GuardAbsorbRemaining(true))
    else
        --print('has not gaurd aura')
        if HasCooldown(Spells:ID('Guard')) then
            local cd = cooldowns[ Spells:ID('Guard') ]
            local remaining = cd.cooldown_end - GetTime()
            S['YM_GuardBar']:SetValue( 100 - ( remaining / cd.data.cooldown * 100) )
            S['YM_GuardBar']:SetStatusBarColor(0.5, 0.5, 0.5, 0.7)
            S['YM_GuardBar'].text:SetText("(" .. math.round(remaining) .. ") " .. GuardAbsorbExpected(true))
        else
            self:CancelTimer(self.guardCDTimer)
            S['YM_GuardBar']:SetStatusBarColor(1, 1, 0, 1)
            S['YM_GuardBar']:SetValue(100)
            S['YM_GuardBar'].text:SetText(GuardAbsorbExpected(true))
        end
    end
end


--------------------------------------------------------- Transcendence
function Trans:GetDistance()
    local x, y

    if Trans.teleport.inside then
        x = (Trans.teleport.ping.x + Trans.teleport.offset.x) * Trans.MinimapSize.indoor[Minimap:GetZoom()]
        y = (Trans.teleport.ping.y + Trans.teleport.offset.y) * Trans.MinimapSize.indoor[Minimap:GetZoom()]
    else
        x = (Trans.teleport.ping.x + Trans.teleport.offset.x) * Trans.MinimapSize.outdoor[Minimap:GetZoom()]
        y = (Trans.teleport.ping.y + Trans.teleport.offset.y) * Trans.MinimapSize.outdoor[Minimap:GetZoom()]
    end
    Trans.teleport.range = sqrt(x * x + y * y);
end
function MINIMAP_PING()
    local newX, newY = Minimap:GetPingPosition();
    local offX = Trans.teleport.ping.x - newX;
    local offY = Trans.teleport.ping.y - newY;

    Trans.teleport.offset.x = Trans.teleport.offset.x + offX;
    Trans.teleport.offset.y = Trans.teleport.offset.y + offY;
    Trans.teleport.ping.x = newX;
    Trans.teleport.ping.y = newY;
end
function MINIMAP_UPDATE_ZOOM()
    local Minimap = Minimap;
    local curZoom = Minimap:GetZoom();

    if (GetCVar("minimapZoom") == GetCVar("minimapInsideZoom")) then
        if (curZoom < 2) then
            Minimap:SetZoom(curZoom + 1);
        else
            Minimap:SetZoom(curZoom - 1);
        end
    end

    if ((GetCVar("minimapZoom") + 0) == Minimap:GetZoom()) then
        Trans.teleport.inside = true;
    else
        Trans.teleport.inside = false;
    end
    Minimap:SetZoom(curZoom);
end
function Trans:Init()
    -- init frame, hide it

    -- init timer
    Trans.init = true
end
function Trans:Start()
    if Trans.init == false then
        Trans:Init()
    end

    Trans.active = true
    Trans.teleport.facing = GetPlayerFacing()
    Trans.teleport.ping.x = 0
    Trans.teleport.ping.y = 0
    Trans.teleport.offset.x = 0
    Trans.teleport.offset.y = 0
    Minimap:PingLocation(0, 0)

    S['YM_TransBar']:SetMinMaxValues(0, Trans.maxRange)

    Trans.timer = YugoMonk:ScheduleRepeatingTimer("TransUpdate", 0.2)
    if YugoMonk.db.profile.frames.YM_TransFrame.enabled == true then
        F['YM_TransFrame']:Show()
        S['YM_TransBar'].set_apply('enabled', true)
    end
end
function Trans:Stop()
    YugoMonk:CancelTimer(Trans.timer)
    Trans.active = false
    F['YM_TransFrame']:Hide()
    S['YM_TransBar'].set_apply('enabled', false)
end
function YugoMonk:TransUpdate()
    if Trans.active == true then
        local x, y = Minimap:GetPingPosition()
        Trans.teleport.ping.x = x;
        Trans.teleport.ping.y = y;
        local distance = Trans.teleport.range;
        Trans:GetDistance()

        local r, g, b = 0, 0, 0

        if distance >= 1 then
            if distance <= 20 then
                r = (distance * 12.75 )
                g = 255
            elseif distance > 20 and distance <= 40 then
                r = 255
                g = 255 - ( (distance - 20) * 8 )
            elseif distance > 40 then
                r = 255
                g = 0
            end
        end

        if r > 0 then r = r / 255 end
        if g > 0 then g = g / 255 end

        local barDistance = distance
        if distance > Trans.maxRange then
            barDistance = Trans.maxRange
        end



        if self.transoor == nil then self.transoor = false end
        if distance > Trans.maxRange and self.transoor ~= true then
            self:SendMessage("TransOutOfRange")
            self.transoor = true
        elseif self.transoor == true and distance < Trans.maxRange then
            self.transoor = false
        end


        S['YM_TransBar']:SetStatusBarColor(r, g, b, 1)
        S['YM_TransBar']:SetValue(barDistance)
        S['YM_TransBar'].text:SetText(math.floor(distance))

    end
end


--------------------------------------------------------- ELUSIVE BREW
function YugoMonk:EBStartTimer()

    if ebStarted == false then
        ebStarted = true
        self.ebTimer = self:ScheduleRepeatingTimer('EBUpdate', 0.5)
        local a = self.db.profile.childframes.YM_ElusiveBrewStackActive
        local at = self.db.profile.childframes.YM_ElusiveBrewStackActiveText
        for count = 1, ebMaxStacks do
            EB[count].set_apply({
                background = a.background,
                border = a.border
            })
            EB[count].text.set_apply({
                font = at.font,
                size = at.size,
                color = at.color
            })
        end
    end
end
function YugoMonk:EBStopTimer()
    if ebStarted == true then
        ebStarted = false
        self:CancelTimer(self.ebTimer)
        for count = 1, ebMaxStacks do
            local a = self.db.profile.childframes.YM_ElusiveBrewStack
            local at = self.db.profile.childframes.YM_ElusiveBrewStackText
            EB[count].set_apply({
                background = a.background,
                border = a.border
            })
            EB[count].text.set_apply({
                font = at.font,
                size = at.size,
                color = at.color
            })
        end
    end
end
function YugoMonk:EBUpdate()
    local stacks = 0
    if HasAura('Elusive Brew activated') then
        stacks = math.floor(Player:GetRemainingBuffTime( Spells:Name("Elusive Brew") ))
    elseif HasAura('Elusive Brew') then
        local name, _, icon, count, _, duration, _, _, _, _, _, _, _, _, _ = UnitAura("player", Spells:Name("Elusive Brew") )
        stacks = count
    end

    for count = 1, ebMaxStacks do
        if count <= stacks then
            EB[count].set_apply('enabled', true)
        else
            EB[count].set_apply('enabled', false)
        end
    end

    if self.ebfull == nil then self.ebfull = false end
    if stacks == ebMaxStacks and self.ebfull ~= true then
        self:SendMessage("ElusiveBrewFullStacks")
        self.ebfull = true
    elseif self.ebfull == true and stacks < ebMaxStacks then
        self.ebfull = false
    end
end

--------------------------------------------------------- SHUFFLE
function YugoMonk:ShuffleUpdate()
    if shuffleEnabled == true then
        local remaining = Player:GetRemainingBuffTime("Shuffle")
        if remaining ~= nil then
            if remaining > maxShuffleTime then
                maxShuffleTime = remaining
            end
            S['YM_ShuffleBar'].text:SetText( math.round(remaining) )
            S['YM_ShuffleBar']:SetValue( Yugo:CalculateBarPercentage( remaining, maxShuffleTime ) )
        else
            YugoMonk:ShuffleDeactivate()
        end
    else
        YugoMonk:ShuffleDeactivate()
    end
end
function YugoMonk:ShuffleActivate()
    if shuffleEnabled == true then
        return
    end

    shuffleEnabled = true
    maxShuffleTime = Player:GetRemainingBuffTime("Shuffle")
    self.shuffleTimer = self:ScheduleRepeatingTimer(function()
        self:ShuffleUpdate()
    end, 0.1)
    YugoMonk:ShuffleUpdate()

    S['YM_ShuffleBar']:Show()
end
function YugoMonk:ShuffleDeactivate()
    shuffleEnabled = false
    S['YM_ShuffleBar']:Hide()
    self:CancelTimer(self.shuffleTimer)
end


--------------------------------------------------------- STAGGER
function YugoMonk:UpdateStagger()
    local name, _, icon, _, _, duration, _, _, _, _, _, _, _, value2, staggerTick = UnitAura("player", "Light Stagger", "", "HARMFUL")
    if (not name) then name, _, icon, _, _, duration, _, _, _, _, _, _, _, value2, staggerTick = UnitAura("player", "Moderate Stagger", "", "HARMFUL") end
    if (not name) then name, _, icon, _, _, duration, _, _, _, _, _, _, _, value2, staggerTick = UnitAura("player", "Heavy Stagger", "", "HARMFUL") end

    if not name then
        YugoMonk:ClearStagger()
        return
    end

    if player.MaxHealth == nil or player.MaxHealth == 0 then
        player.MaxHealth = UnitHealthMax("player")
    end

    local staggerTotal = staggerTick * math.floor(duration)
    local hp = math.floor(staggerTotal/player.MaxHealth * 100)

    if hp <= 50 then
        S['YM_StaggerBar']:SetValue(hp)
    else
        S['YM_StaggerBar']:SetValue(50)
    end

    S['YM_StaggerBar'].text:SetText("" .. convert.tokilo(staggerTotal) .. " (" .. hp .. "%)")

    if icon == LIGHT_STAGGER_ICON then
        self:SendMessage("LightStagger")
        S['YM_StaggerBar']:SetStatusBarColor(0,192,0, 1)

    elseif icon == MODERATE_STAGGER_ICON then

        if self.modstagger == nil then self.modstagger = false end
        if self.modstagger ~= true then
            self:SendMessage("ModerateStagger")
            self.modstagger = true
        end
        S['YM_StaggerBar']:SetStatusBarColor(255,255,0, 1)

    elseif icon == HEAVY_STAGGER_ICON then

        if self.heavystagger == nil then self.heavystagger = false end
        if self.heavystagger ~= true then
            self:SendMessage("HeavyStagger")
            self.heavystagger = true
        end
        S['YM_StaggerBar']:SetStatusBarColor(192,0,0, 1)

    else
        S['YM_StaggerBar']:SetStatusBarColor(1, 1, 1, 1)
    end
end
function YugoMonk:TestStagger()
    S['YM_StaggerBar']:SetStatusBarColor(255,255,0, 1)
    S['YM_StaggerBar']:SetValue(35)
    S['YM_StaggerBar'].text:SetText("72k (13%)")
end
function YugoMonk:ClearStagger()
    self.modstagger = false
    self.heavystagger = false
    S['YM_StaggerBar'].text:SetText("")
    S['YM_StaggerBar']:SetValue(0)
    S['YM_StaggerBar']:SetStatusBarColor(0,192,0, 0)
end


--------------------------------------------------------- AGGRO
function YugoMonk:UpdateAggro(event, arg1)
    if player.combat == true and YugoMonk.db.profile.frames.aggro == true then
        local isTanking, status, scaledPercent, rawPercent, threatValue = UnitDetailedThreatSituation("player", "playertarget")

        --AggroFrame:Hide()

        if isTanking ~= 1 then
            local c = { a = 0.34, b = 0.02, g = 0.03, r = 1 }
            --AggroFrame.bg:SetVertexColor(c.r, c.g, c.b, c.a)
            --AggroFrame:Show()
        end

    else
        --AggroFrame:Hide()
    end

    --aggroFrameGreen = { a = 0.15, b = 0.03, g = 1, r = 0.05 }
    --aggroFrameRed = { a = 0.34, b = 0.02, g = 0.03, r = 1 }

end
function YugoMonk:CheckTalentsGlyphsItems()


    -- Check for Vial of Living Corruption
    local vials = {
        { id = 105070, adjust = 16 },
        { id = 104821, adjust = 17 },
        { id = 102306, adjust = 20 },
        { id = 105319, adjust = 21 },
        { id = 104572, adjust = 22 },
        { id = 105568, adjust = 23 },
    }

    adjust.guardCooldown = 0
    for k, v in pairs(vials) do
        if IsEquippedItem(v.id) then
            adjust.guardCooldown = v.adjust
        end
    end

    Trans.maxRange = 40
    adjust.guardAbsorb = 0
    for socket = 1, GetNumGlyphSockets() do
        local glyphId = select(3, Yugo:Hyperlink(GetGlyphLink(socket)))

        if glyphId then
            glyphId = tonumber(glyphId)

            if glyphId == 998 then
                adjust.guardAbsorb = 10
            end

            if glyphId == 1011 then
                Trans.maxRange = 45
            end
        end
    end

    for talent = 1, GetNumTalents() do
        local name, iconTexture, tier, column, using, maxRank, isExceptional, meetsPrereq, previewRank, meetsPreviewPrereq = GetTalentInfo(talent)
        -- print(name, using)
    end
end


--------------------------------------------------------- EVENTS
function YugoMonk:GLYPH_UPDATED()
    YugoMonk:CheckTalentsGlyphsItems()
    YugoMonk:GuardBarUpdate()
end
function YugoMonk:ACTIVE_TALENT_GROUP_CHANGED()
    player.MaxHealth = UnitHealthMax("player")
end
function YugoMonk:PLAYER_LEVEL_UP()
    player.MaxHealth = UnitHealthMax("player")
end
function YugoMonk:PLAYER_TALENT_UPDATE()
    YugoMonk:CheckTalentsGlyphsItems()
end
function YugoMonk:PLAYER_REGEN_ENABLED()
    player.combat = false
end
function YugoMonk:PLAYER_REGEN_DISABLED()
    player.combat = true
end
function YugoMonk:PLAYER_DEAD()
    --Frames:ClearStagger()
    YugoMonk:GuardBarUpdate()
end
function YugoMonk:PLAYER_ENTERING_WORLD()
    player.GUID = UnitGUID("player")
end
function YugoMonk:PLAYER_DEAD()
end
function YugoMonk:UNIT_AURA()
    Veng:Update()
end
function YugoMonk:UNIT_POWER()
    local chi = UnitPower("player", 12)
    for count = 1, 5 do
        if count <= chi then
            CHIS[count].set_apply('enabled', true)
        else
            CHIS[count].set_apply('enabled', false)
        end
    end
end
function YugoMonk:UNIT_POWER_FREQUENT()
    local energy = UnitPower("player", 3)
    S['YM_EnergyBar']:SetValue(energy)
    S['YM_EnergyBar'].text:SetText(energy)
end
function YugoMonk:UNIT_ATTACK_POWER(event, unit)
    if unit == "player" then
        YugoMonk:GuardBarUpdate()
    end
end
function YugoMonk:UNIT_SPELLCAST_SUCCEEDED(event, unit, spell)
    if unit == "player"  then
        if spell == Trans.spell.teleport or spell == Trans.spell.summon then
            Trans:Start()
        elseif spell == "Purifying Brew" then
            YugoMonk:ClearStagger()
        end
    end
end
function YugoMonk:UNIT_ABSORB_AMOUNT_CHANGED(event, unit)
    if unit == "player" then
        if HasAura("Guard") == true then
            YugoMonk:GuardBarUpdate()
        end
    end
end
function YugoMonk:UNIT_MAXHEALTH()
    self.MaxHealth = UnitHealthMax("player")
end
function YugoMonk:COMBAT_LOG_EVENT_UNFILTERED(_, timestamp, event, _, sourceGUID, _, _, _, destGUID, _, _, _, spell, spellName)

    if event == "UNIT_DIED" and destGUID == player.GUID then
        Trans:Stop()
        YugoMonk:ClearStagger()
        YugoMonk:GuardDeactivate()
        YugoMonk:EBStopTimer()
    end


    if sourceGUID == player.GUID and destGUID == player.GUID then

        if Spells:Matches(spell, 'Stagger') == true then
            YugoMonk:UpdateStagger()
        end

        -- SPELL AURA APPLIED
        if event == "SPELL_AURA_APPLIED" then

            auras[spell] = {
                name = spellName,
                id = spell,
                timestamp = timestamp,
                time = GetTime(),
                sourceGUID = sourceGUID
            };

            if spell == Spells:ID('Guard') then
                YugoMonk:GuardActivate()

            elseif spell == Spells:ID("Power Guard") then
                YugoMonk:GuardBarUpdate()

            elseif spell == Spells:ID("Shuffle") then
                YugoMonk:ShuffleActivate()

            elseif spell == Spells:ID("Elusive Brew") then
                YugoMonk:EBUpdate()

            elseif spell == Spells:ID("Elusive Brew activated") then
                YugoMonk:EBUpdate()
                YugoMonk:EBStartTimer()

            end

        elseif event == "SPELL_AURA_APPLIED_DOSE" then

            if spell == Spells:ID("Elusive Brew") then
                YugoMonk:EBUpdate()
            end

        elseif event == "SPELL_AURA_REFRESH" then

            auras[spell] = {
                name = spellName,
                id = spell,
                timestamp = timestamp,
                time = GetTime(),
                sourceGUID = sourceGUID
            };


        elseif event == "SPELL_AURA_REMOVED" then
            auras[spell] = nil

            if spell == Spells:ID('Guard') then
                YugoMonk:GuardDeactivate()

            elseif spell == Spells:ID("Power Guard") then
                YugoMonk:GuardBarUpdate()

            elseif spell == Spells:ID("Shuffle") then
                YugoMonk:ShuffleDeactivate()

            elseif spell == Spells:ID("Elusive Brew") then
                YugoMonk:EBUpdate()

            elseif spell == Spells:ID("Elusive Brew activated") then
                YugoMonk:EBUpdate()
                YugoMonk:EBStopTimer()
            end
        end


    end

end
function YugoMonk:ZONE_CHANGED_NEW_AREA()
    Trans:Stop()
end



end