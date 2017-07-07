local Yugo = LibStub('AceAddon-3.0'):GetAddon('Yugo')
local Player = Player

function SpellIconWidget(name, spellData)
    local self = Frame(name)

    LibStub('AceEvent-3.0'):Embed(self)

    local Timer = LibStub("AceTimer-3.0")
    local GUID

    -- Privates
    self.registerEvents = {
        "UNIT_SPELLCAST_SUCCEEDED",
        "UNIT_POWER_FREQUENT",
        "ACTIONBAR_UPDATE_USABLE",
        "SPELL_UPDATE_USABLE",
        "COMBAT_LOG_EVENT_UNFILTERED",
        'PLAYER_TALENT_UPDATE'
    }

    self.playerEnteredWorld = false

    self.spellData = spellData

    self.spell = {}

    -- This willl be set on SetSpellData. These are overriding the users display settings located at config.display
    self.display = {
        aura = false,
        range = false,
        globalCooldown = false,
        cooldown = false,
        energy = false
    }


    self.content = {
        globalCooldown = CreateFrame("Cooldown", name .. "GCD", self),
        aura = self:CreateFontString(self),
        energy = self:CreateFontString(self),
        cooldown = self:CreateFontString(self)
    }

    self.config.display = {
            aura = true,
            range = true,
            globalCooldown = true,
            cooldown = true,
            energy = true
    }
    self.config.aura = self.content.aura.get()
    self.config.energy = self.content.energy.get()
    self.config.cooldown = self.content.cooldown.get()

    self.content.globalCooldown:SetFrameStrata("MEDIUM")
    self.content.globalCooldown:ClearAllPoints()
    self.content.globalCooldown:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0);
    self.content.globalCooldown:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, 0);
    self.content.globalCooldown:Hide()


    -- Inheriteds
    local base_set = self.set
    function self.set(...)
        table.setter(self.config, ...)
        self.content.aura.set(self.config.aura)
        self.content.energy.set(self.config.energy)
        self.content.cooldown.set(self.config.cooldown)
    end

    local base_set = self.get
    function self.get()
        return table.copy(self.config)
    end

    local base_apply = self.apply
    function self.apply()

        if self.config.display.globalCooldown == true then
            self.content.globalCooldown:Show()
        else
            self.content.globalCooldown:Hide()
        end

        self.content.aura.apply()
        self.content.energy.apply()
        self.content.cooldown.apply()

        base_apply()
    end

    function self.hide()
        self.content.globalCooldown:Hide()
        self:Hide()
        print('shuld be hidden')
    end

    function self.show()
        print('gonna show')
        self.content.globalCooldown:Show()
        self:Show()
    end

    -- new functions
    function self.setSpellData(spellData)

        -- Wait with executing this function until we can use the talent functions
        if self.playerEnteredWorld == false then
            self.waitTimer = Timer:ScheduleTimer(function()
                self.setSpellData(spellData)
            end, 1)
            return
        end

        self.display = {}

        self.spellData = spellData

        for k, v in pairs(self.registerEvents) do
            self:UnregisterEvent(v)--, self.UNIT_POWER_FREQUENT)
        end

        local id, icon, aura

        if spellData.type == 'talents' and type(spellData.talents) == 'table' then
            local talents = Player:GetTalents()
            for k, v in pairs(spellData.talents) do
                if talents[v.tier][v.column].active == true then
                    id = v.id
                    icon = v.icon
                    aura = v.aura
                end
            end
            self:RegisterEvent('PLAYER_TALENT_UPDATE')
            if not id then return end
        else
            id, icon, aura = spellData.id, spellData.icon, spellData.aura
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


        local spellName, _, _, powerCost, _, _, _,  minRange, maxRange = GetSpellInfo(id)
        if id == 115072 then powerCost = 40 end -- fix expel harm
        if id == 100780 then powerCost = 40 end -- fix jab
        if id == 116847 then powerCost = 40 end -- fix rjw
        if id == 107270 then powerCost = 40 end -- fix sck

        local cooldown = GetSpellBaseCooldown(id)
        if not cooldown then cooldown = 0 end

        self.spell = {
            id = id,
            name = spellName,
            cost = powerCost,
            range = maxRange,
            cooldown = cooldown,
            hasrange = (SpellHasRange(spellName) == 1)
        }
        self.display.range = self.spell.hasrange
        self.display.energy = (self.spell.cost > 0)
        self.display.cooldown = (self.spell.cooldown > 0)
        self.display.globalCooldown = true

        if type(aura) == 'number' then
            self.display.aura = true
            local auraName, _, _, powerCost, _, _, _, _, _ = GetSpellInfo(aura)
            self.spell.aura = {
                id = spellData.aura,
                name = auraName
            }

        else
            self.display.aura = false
        end


        if self.display.range == true and self.config.display.range == true then
            self:RegisterEvent('ACTIONBAR_UPDATE_USABLE')
            self:RegisterEvent('SPELL_UPDATE_USABLE')
        end

        if self.display.energy == true and self.config.display.energy == true then
            self:RegisterEvent('UNIT_POWER_FREQUENT')
        end

        if (self.display.cooldown == true and self.config.display.cooldown == true) or (self.display.globalCooldown == true and self.config.display.globalCooldown == true) then
            self:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED')
        end

        if self.display.aura == true and self.config.display.aura == true then
            self:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED')
        end

        self.set('background', 'texture', icon)
        self.apply()


    end

    function self.rangeCheck()
        if self.display.range == true and self.config.display.range == true then
            local _, _, _, alpha = self.background:GetVertexColor()
            if IsSpellInRange(self.spell.name, "target") == 1 then
                self.background:SetVertexColor(255,255,255,alpha)
            else
                self.background:SetVertexColor(192,0,0,alpha)
            end
        end
    end

    function self:UNIT_SPELLCAST_SUCCEEDED(_, unit, _, _, _, spellId)
        if unit == 'player' then
            if self.display.globalCooldown == true and self.config.display.globalCooldown == true then
                local start, duration, enable = GetSpellCooldown("Jab")
                if duration ~= nil and duration > 0 and duration < 1.1 and not self.content.globalCooldown.started == true then
                    self.content.globalCooldown.started = true
                    local time = 0.9
                    if spellId == 107270 then time = 2 end -- Spinning crane kick fix
                    self.content.globalCooldown:SetCooldown(GetTime(), time)
                    self.content.globalCooldown.timer = Timer:ScheduleTimer(function()
                        self.content.globalCooldown.started = false
                    end, time)
                end
            end

            if self.display.cooldown == true and self.config.display.cooldown == true and spellId == self.spell.id then
                self.content.cooldown.timer = Timer:ScheduleRepeatingTimer(function()
                    local start, duration, _ = GetSpellCooldown(self.spell.id)
                    if duration > 1 then
                        local elapsed = GetTime() - start
                        local remaining = duration - elapsed
                        self.background:SetDesaturated(true)
                        if remaining < 3 then
                            self.content.cooldown:SetText(math.round(remaining, 1))
                        else
                            self.content.cooldown:SetText(math.floor(remaining))
                        end
                    else
                        Timer:CancelTimer(self.content.cooldown.timer)
                        self.background:SetDesaturated(false)
                        self.content.cooldown:SetText("")
                    end
                end, 0.1)
            end
        end
    end

    function self:COMBAT_LOG_EVENT_UNFILTERED(_, timestamp, event, _, sourceGUID, _, _, _, destGUID, _, _, _, spellId, spellName)

        if not GUID then
            GUID = UnitGUID('player')
        end

        if sourceGUID == GUID and destGUID == GUID and self.display.aura == true and spellId == self.spell.aura.id then
            if event == "SPELL_AURA_APPLIED" then

                local expires = select(7, UnitAura("player", self.spell.aura.name))
                if not expires then
                    for count = 1, 50 do
                        (function()
                            local sname, _, _, _, _, _, sexpires, _, _, _, _, _, _, _, _, _ = UnitAura("player", count)
                            if sname == self.spell.aura.name then
                                expires = sexpires
                                return
                            end
                        end)()
                    end
                end
                self.content.aura.expires = expires

                self.content.aura:SetText(math.round(expires - GetTime()))
                self.content.aura.timer = Timer:ScheduleRepeatingTimer(function()
                    local remaining = self.content.aura.expires - GetTime()
                    if remaining < 0.1 then
                        Timer:CancelTimer(self.content.aura.timer)
                        self.content.aura.timer = nil
                        self.content.aura:SetText("")
                    elseif remaining < 3 then
                        self.content.aura:SetText(math.round(remaining, 1))
                    else
                        self.content.aura:SetText(math.round(remaining))
                    end
                end, 0.1)

            elseif event == "SPELL_AURA_REFRESH" then

                local expires = select(7, UnitAura("player", self.spell.aura.name))
                if not expires then
                    for count = 1, 50 do
                        (function()
                            local sname, _, _, _, _, _, sexpires, _, _, _, _, _, _, _, _, _ = UnitAura("player", count)
                            if sname == self.spell.aura.name then
                                expires = sexpires
                                return
                            end
                        end)()
                    end
                end
                self.content.aura.expires = expires

            elseif event == "SPELL_AURA_REMOVED" then

                Timer:CancelTimer(self.content.aura.timer)
                self.content.aura.timer = nil
                self.content.aura.expires = nil
                self.content.aura:SetText("")

            end

        end
    end

    function self:UNIT_POWER_FREQUENT(_, unit)      --  print('frequent')
        if unit == 'player' then
            local energy = UnitPower("player", 3)
            local r, g, b, a = self.background:GetVertexColor()
            if energy < tonumber(self.spell.cost) then
                self.content.energy:SetText(energy)
                self.background:SetVertexColor(r,g,b,0.5)
            else
                self.content.energy:SetText("")
                self.background:SetVertexColor(r,g,b,1)
            end
        end
    end

    function self:ACTIONBAR_UPDATE_USABLE()
        self.rangeCheck()
    end

    function self:SPELL_UPDATE_USABLE()
        self.rangeCheck()
    end

    function self:PLAYER_TALENT_UPDATE()
        self.setSpellData(self.spellData)
    end

    function self:PLAYER_ENTERING_WORLD()
        self.playerEnteredWorld = true
    end
    self:RegisterEvent('PLAYER_ENTERING_WORLD')


    -- Defaults
    --self.setSpellData(self.spellData)

    self.set('background', 'color', {
        r = 1,
        a = 1,
        g = 1,
        b = 1
    })

    self.set('background', 'insets', { l = 0, b = 0, r = 0, t = 0})
    self.set('border', 'texture', 'None')
    self.set({
        aura = {
            anchors = {
            {
                this = "CENTER",
                that = "CENTER",
                to = name,
                x = 0,
                y = 0
            }
            }
        },
        energy = {
            anchors = {
                {
                    this = "TOP",
                    that = "TOP",
                    to = name,
                    x = 0,
                    y = 0
                }
            },
            color = { r = 1, g = 0, b = 0, a = 1 },
            flags = 'OUTLINE'

        },
        cooldown = {
            anchors = {
                {
                    this = "BOTTOM",
                    that = "BOTTOM",
                    to = name,
                    x = 0,
                    y = 0
                }
            }
        }
    })


    self.apply()

    return self
end
