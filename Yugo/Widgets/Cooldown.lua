local Yugo = Yugo
local YugoMedia = YugoMedia
local Player = Player

function CooldownWidget(name, spellData)
    local self = Frame(name)

    -- Privates
    local Timer = LibStub("AceTimer-3.0")
    local GUID
    local aura = {}
    LibStub('AceEvent-3.0'):Embed(self)

    -- Publics
    self.spellData = spellData
    self.spell = {}
    self.playerEnteredWorld = false
    self.content = {
        icon = SpellIconWidget(name .. 'SpellIcon', spellData),
        statusbar = StatusBar(name..'StatusBar', name)
    }
    self.display = {
        icon = true,
        statusbar = true,
    }
    self.config.icon = self.content.icon.get()
    self.config.statusbar = self.content.statusbar.get()

    -- Inherited function overides
    local base_set = self.set
    function self.set(...)
        table.setter(self.config, ...)
        self.content.icon.set(self.config.icon)
        self.content.statusbar.set(self.config.statusbar)
    end

    local base_apply = self.apply
    function self.apply()
        base_apply()

        self.set({
            icon = {
                width = self.config.width,
                height = self.config.width,
            },
            statusbar = {
                width = self.config.width,
                height = self.config.height - self.config.width
            }
        })


        self.content.icon.apply()
        self.content.statusbar.apply()
    end


    -- Functions
    function self.setSpellData(spellData)

        self.content.icon.setSpellData(spellData)

        -- Wait with executing this function until we can use the talent functions
        if self.playerEnteredWorld == false then
            self.waitTimer = Timer:ScheduleTimer(function()
                self.setSpellData(spellData)
            end, 1)
            return
        end

        self.spellData = spellData

        local id, icon, aura, name, duration
        if spellData.type == 'talents' and type(spellData.talents) == 'table' then
            local talents = Player:GetTalents()
            for k, v in pairs(spellData.talents) do
                if talents[v.tier][v.column].active == true then
                    id = v.id
                    icon = v.icon
                    aura = v.aura
                    name = v.name
                    duration = v.duration
                end
            end
            self:RegisterEvent('PLAYER_TALENT_UPDATE')
            if not id then return end
        else
            id, icon, aura, name, duration = spellData.id, spellData.icon, spellData.aura, spellData.name, spellData.duration
        end


        if type(spellData.replacedByTalent) == 'table' then
            local talents = Player:GetTalents()
            local talent = talents[spellData.replacedByTalent.tier][spellData.replacedByTalent.column]
            if talent.active == true then
                id = spellData.replacedByTalent.id
                icon = spellData.replacedByTalent.icon
                aura = spellData.replacedByTalent.aura
            end
            self:RegisterEvent('PLAYER_TALENT_UPDATE')
        end

        local cooldown = GetSpellBaseCooldown(id)
        if not cooldown then cooldown = 0 end

        self.spell = {
            id = id,
            name = name,
            cooldown = cooldown,
            duration = duration
        }


        if type(aura) == 'number' then
            --self.display.aura = true
            local auraName, _, _, powerCost, _, _, _, _, _ = GetSpellInfo(aura)
            self.spell.aura = {
                id = aura,
                name = auraName
            }

        else
            --self.display.aura = false
        end

    end


    -- Events
    function self:PLAYER_ENTERING_WORLD()
        self.playerEnteredWorld = true
    end

    function self:PLAYER_TALENT_UPDATE()
        self.setSpellData(self.spellData)
    end

    function self:COMBAT_LOG_EVENT_UNFILTERED(_, timestamp, event, _, sourceGUID, _, _, _, destGUID, _, _, _, spellID, spellName)

        if not GUID then
            GUID = UnitGUID('player')
        end

        if event == "UNIT_DIED" and destGUID == GUID then

        end


        if sourceGUID == GUID and destGUID == GUID and self.spell.aura and spellID == self.spell.aura.id then

            -- SPELL AURA APPLIED
            if event == "SPELL_AURA_APPLIED" then

                aura = {
                    name = spellName,
                    id = spellID,
                    timestamp = timestamp,
                    time = GetTime(),
                };
                self.auraTime = self.spell.duration

                self.content.statusbar:SetMinMaxValues(0, self.spell.duration)
                self.content.statusbar:SetValue(self.spell.duration)
                self.auraTimer = Timer:ScheduleRepeatingTimer(function()
                    if self.auraTime < 0.1 then return end
                    self.auraTime = self.auraTime - 0.1
                    self.content.statusbar.text:SetText(math.round(self.auraTime))
                    self.content.statusbar:SetValue(self.auraTime)
                end, 0.1)

            elseif event == "SPELL_AURA_REMOVED" then

                aura = {}
                self.content.statusbar.text:SetText('')
                self.content.statusbar:SetValue(0)
                Timer:CancelTimer(self.auraTimer)
                self.auraTimer = nil
            end


        end

    end


    self:RegisterEvent('PLAYER_ENTERING_WORLD')
    self:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED')


    -- Defaults
    self.set({
        height = 200,
        width = 37.5,
        level = 1,
        moveable = false,
        background = {
            texture = 'None',
        },
        border = {
            texture = 'None',
            size = 0
        },
        icon = {
            parent = name,
            level = 3,
            height = self.config.width,
            width = self.config.width,
            anchors = {
                {
                    this = 'BOTTOMLEFT',
                    that = 'BOTTOMLEFT',
                    to = name,
                    x = 0,
                    y = 0
                }
            },
            display = {
                aura = false
            },
            cooldown = {
                color = { r = 1, g = 1, b = 0, a = 1 },
                flags = 'OUTLINE',
                anchors = {
                    {
                        this = 'CENTER',
                        that = 'CENTER',
                        x = 0,
                        y = 0
                    }
                }
            }
        },
        statusbar = {
            level = 2,
            height = 150,
            width = 37.5,
            bar = {
                orientation = "VERTICAL",
                reverseFill = false,
                texture = "YugoFlat",
                color = spellData.color or spellData.talents[1].color,
                text = {
                    size = 14,
                    font = "Yugo",
                    verticalPosition = "BOTTOM",
                    horizontalPosition = "CENTER",
                    color = { r = 1, g = 1, b = 1, a = 1 },
                },
                parentFill = false,
                inset = 0
            },
            anchors = {
                {
                    this = 'TOPLEFT',
                    that = 'TOPLEFT',
                    to = name,
                    x = 0,
                    y = 0
                }

            }
        }
    })


    self.setSpellData(spellData)
    self.content.statusbar:SetValue(0)

    self.apply()

    return self
end
