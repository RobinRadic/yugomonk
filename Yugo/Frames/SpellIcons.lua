local Yugo = LibStub('AceAddon-3.0'):GetAddon('Yugo')
local SpellIcons = Yugo:NewModule("SpellIcons")

local Frames = Yugo:GetModule("Frames")
Frames:Enable()
local Player = Player

SpellIcons.defaultOptions = {
    inherits = false,
    y = 0,
    x = 0,
    height = 50,
    width = 50,
    scale = 1,
    level = 0,
    sub_level = 0,
    strata = "BACKGROUND",
    parent = "YM_Abilitys",
    anchor = {
        this = "TOPLEFT",
        that = "TOPLEFT",
        to = "YM_Abilitys"
    },
    bg = {
        alpha = 1,
        texture = "None",
        insets = { b = 0, t = 0, l = 0, r = 0 },
        style = "SOLID",
        gradient = { a = 1, r = 1, g = 1, b = 1},
        blend = "BLEND",
        orientation = "HORIZONTAL",
        color = { a = 1, r = 1, g = 1, b = 1 }
    },
    border = {
        texture = "None",
        color = { a = 1, r = 1, g = 1, b = 1 },
        size = 0
    },
}

local spellOptions = {
	globalCooldowns = {},
	auraTimes = {},
	rangeChecks = {},
	spellCooldowns = {},
	requiredEnergies = {}
}

local globalCooldowns = spellOptions.globalCooldowns
local auraTimes = spellOptions.auraTimes
local rangeChecks = spellOptions.rangeChecks
local spellCooldowns = spellOptions.spellCooldowns
local requiredEnergies = spellOptions.requiredEnergies

function SpellIcons:OnInitialize()
    self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
    self:RegisterEvent("UNIT_AURA")
    self:RegisterEvent("UNIT_POWER_FREQUENT")
    self:RegisterEvent("ACTIONBAR_UPDATE_USABLE", "RangeCheck")
    self:RegisterEvent("SPELL_UPDATE_USABLE", "RangeCheck")
end

function SpellIcons:OnEnable()
end
function SpellIcons:OnDisable()
end

function SpellIcons:Create(name, spellName)

	local frame = Frames:Create(name:gsub("%s+", ""))
	frame.name = name:gsub("%s+", "")
	frame.spellName = spellName
    frame.options = table.copy(SpellIcons.defaultOptions)
    frame.options.bg.texture = spellName


	frame.spellIconOptions = {
		globalCooldowns = false,
		auraTimes = false,
		rangeChecks = false,
		spellCooldowns = false,
		requiredEnergies = false
	}

	local SML = LibStub("LibSharedMedia-3.0")



	frame.auraTime = frame:CreateFontString("YM_AuraTime_" .. frame.name, "OVERLAY", "GameFontHighlightSmall")
	frame.auraTime:SetFont(SML:Fetch("font", "Yugo"), 25)
	frame.auraTime:SetPoint("CENTER", frame ,"CENTER",0,0)
	frame.auraTime:SetText("")
	frame.auraTime:Hide()
    frame.auraTimeUntilExpire = 0

	frame.CooldownText = frame:CreateFontString("YM_CooldownText_" .. frame.spellName, "OVERLAY", "GameFontHighlightSmall")
	frame.CooldownText:SetFont( SML:Fetch("font", "Yugo"), 16)
	frame.CooldownText:SetPoint("CENTER", frame ,"CENTER",0, -7)
	frame.CooldownText:SetText("")
	frame.CooldownText:Hide()

	frame.EnergyReqText = frame:CreateFontString("YM_EnergyReq_" .. frame.spellName, "OVERLAY", "GameFontHighlightSmall")
	frame.EnergyReqText:SetFont(SML:Fetch("font", "Yugo"), 16, "OUTLINE")
	frame.EnergyReqText:SetVertexColor(192,0,0,1)
	frame.EnergyReqText:SetPoint("TOP", frame ,"TOP", 0,-5)
	frame.EnergyReqText:SetText("")	
	frame.EnergyReqText:Hide()

	frame.GlobalCooldown = CreateFrame("Cooldown", "GCD_" .. frame.name, frame)
	frame.GlobalCooldown:SetFrameStrata("MEDIUM")
	frame.GlobalCooldown:ClearAllPoints()
	frame.GlobalCooldown:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0);
	frame.GlobalCooldown:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 0);
	frame.GlobalCooldown:Hide()



	local mt = getmetatable(frame)

	---------------------------
	------- AddSpellCooldown
	----
	mt.__index.AddSpellCooldown = function(self)
		self.cooldownTimer = LibStub("AceTimer-3.0")
		self.CooldownText:Show()
		local pos = #spellCooldowns + 1
		table.insert(spellCooldowns, pos, self)
		self.spellIconOptions.spellCooldowns = pos
	end

	---------------------------
	------- EnableRangeCheck
	----
	mt.__index.EnableRangeCheck = function(self)
		local pos = #rangeChecks + 1
		table.insert(rangeChecks, pos, self)
		self.spellIconOptions.rangeChecks = pos
	end

	---------------------------
	------- RequireEnergy
	----
	mt.__index.RequiredEnergy = function(self, requiredEnergy)
		self.requiredEnergy = tonumber(requiredEnergy)
		self.EnergyReqText:Show()
		local pos = #requiredEnergies + 1
		table.insert(requiredEnergies, pos, self)
		self.spellIconOptions.requiredEnergies = pos
	end

	---------------------------
	------- AddGlobalCooldown
	----
	mt.__index.AddGlobalCooldown = function(self)
		local gcdName = self.name .. "_GlobalCooldown"
        --print(gcdName)
		self.GlobalCooldown:Show()
		local pos = #globalCooldowns + 1
		table.insert(globalCooldowns, pos, self)
        self.spellIconOptions.globalCooldowns = pos
	end

	---------------------------
	------- AddAuraTime
	----
	mt.__index.AddAuraTime = function(self, aura)
		self.aura = aura
		self.auraTime:Show()
		local pos = #auraTimes + 1
		table.insert(auraTimes, pos, self)
		self.spellIconOptions.auraTimes = pos
	end
	
	---------------------------
	------- SetSpell
	----
	mt.__index.SetSpell = function(self, spellname)
        --print_r(self.options)
		self.spellName = spellname
        self.options.bg.texture = spellName
        self:ApplyOptions()

	end
	
	---------------------------
	------- ResetOptions
	----
	mt.__index.ResetSpellOptions = function(self)
		for k,v in pairs(self.spellIconOptions) do
			if v ~= false then -- k = auraTimes
				self.spellIconOptions[k] = false
                spellOptions[k][v] = nil
			end
		end
		self.CooldownText:Hide()
		self.auraTime:Hide()
		self.GlobalCooldown:Hide()
		self.EnergyReqText:Hide()
	end
	
	---------------------------
	------- SetDisplayOptions
	----
	mt.__index.SetDisplayOptions = function(self, o)
		if self.options.spellCooldowns ~= false then
			self.CooldownText:SetFont( SML:Fetch("font", o.cooldownFont), o.cooldownFontSize)
		end
		if self.options.requiredEnergies ~= false then
			self.EnergyReqText:SetFont(SML:Fetch("font", o.energyFont), o.energyFontSize, "OUTLINE")
		end
		if self.options.auraTimes ~= false then
			self.auraTime:SetFont(SML:Fetch("font", o.auraFont), o.auraFontSize)
		end

	end

    mt.__index.DoGCD = function(self)
        if not self.globalCooldownStarted == true then
            self.globalCooldownStarted = true
            self.GlobalCooldown:SetCooldown(GetTime(), 1)
            self.globalCooldownTimer = LibStub("AceTimer-3.0"):ScheduleTimer(function(fra)
                fra.globalCooldownStarted = false
            end, 1, self)
        end


    end


	---------------------------
	------- Update
	----
	mt.__index.Update = function(self, what, ...)
		if what == "RangeCheck" then
			local _, _, _, alpha = self.bg:GetVertexColor()
			if IsSpellInRange(self.spellName, "target") == 1 then
				self.bg:SetVertexColor(255,255,255,alpha)
			else
				self.bg:SetVertexColor(192,0,0,alpha)
			end
		elseif what == "RequiredEnergy" then
			local energy = UnitPower("player", 3)
			local r, g, b, a = self.bg:GetVertexColor()
			if energy < tonumber(self.requiredEnergy) then
				self.EnergyReqText:SetText(energy)
				self.bg:SetVertexColor(r,g,b,0.5)
			else
				self.EnergyReqText:SetText("")
				self.bg:SetVertexColor(r,g,b,1)
			end
		elseif what == "AuraTime" then

            local event, spellId, timestamp = ...

            if event == "applied" then
                --self.auraTimeStart = timestamp

                local expires = select(7, UnitAura("player", self.aura))
                if not expires then
                    for count = 1, 50 do
                        (function()
                            local sname, _, _, _, _, _, sexpires, _, _, _, _, _, _, _, _, _ = UnitAura("player", count)
                            if sname == self.aura then
                                expires = sexpires
                                return
                            end
                        end)()
                    end
                end
                self.auraTimeExpires = expires

                self.auraTime:SetText(math.round(expires - GetTime()))
                self.auraTimer = LibStub("AceTimer-3.0"):ScheduleRepeatingTimer(function(fra)
                    local remaining = fra.auraTimeExpires - GetTime()
                    if remaining < 0.1 then
                        LibStub("AceTimer-3.0"):CancelTimer(fra.auraTimer)
                        fra.auraTimer = nil
                        fra.auraTime:SetText("")
                    elseif remaining < 3 then
                        fra.auraTime:SetText(math.round(remaining, 1))
                    else
                        fra.auraTime:SetText(math.round(remaining))
                    end
                end, 0.1, self)

            elseif event == "refresh" then

                local expires = select(7, UnitAura("player", self.aura))
                if not expires then
                    for count = 1, 50 do
                        (function()
                            local sname, _, _, _, _, _, sexpires, _, _, _, _, _, _, _, _, _ = UnitAura("player", count)
                            if sname == self.aura then
                                expires = sexpires
                                return
                            end
                        end)()
                    end
                end
                self.auraTimeExpires = expires

            elseif event == "removed" then

                LibStub("AceTimer-3.0"):CancelTimer(self.auraTimer)
                self.auraTimer = nil
                self.auraTime:SetText("")

            end


		elseif what == "SpellCooldown" then
            local spell = self.spellName
            if self.spellName == "Rushing Jade Wind" then spell = 116847 end
			local start, duration, _ = GetSpellCooldown(spell)
			if duration > 1 then
				local elapsed = GetTime() - start
				local remaining = duration - elapsed
				self.bg:SetDesaturated(true)
				if remaining < 3 then
					self.CooldownText:SetText(math.round(remaining, 1))
				else
					self.CooldownText:SetText(math.floor(remaining))
				end
			else
				self.cooldownTimer:CancelTimer(self.timer)
				self.bg:SetDesaturated(false)
				self.CooldownText:SetText("")
			end
		end
    end

	return frame
end

function SpellIcons:AuraTimeTick()


end

---------------------------------------------------
---------------------- EVENTS
-------------
function SpellIcons:UNIT_POWER_FREQUENT()
    for k,v in pairs(requiredEnergies) do
        v:Update("RequiredEnergy")
    end
end


function SpellIcons:UNIT_SPELLCAST_SUCCEEDED(event, unit, spell)
    if unit == "player" then
        local start, duration, enable = GetSpellCooldown("Jab")
        if duration ~= nil and duration > 0 and duration < 1.5 then
            local showgcd = true
            if  spell == "Rushing Jade Wind" or spell == "Spinning Crane Kick" then
                --local rushAura = Player:GetAura(spell)
                --print_r(rushAura)
                --if GetTime() - rushAura.time > 0 then
                --    showgcd = false
                --end
            end
            if showgcd == true then
                for k,v in pairs(globalCooldowns) do
                    v:DoGCD()
                end
            end
        end
        for k, v in pairs(spellCooldowns) do
            if v.spellName == spell then
                v.timer = v.cooldownTimer:ScheduleRepeatingTimer(function()
                    v:Update("SpellCooldown")
                end, 0.1)

            end
        end
    end
end

function SpellIcons:UNIT_AURA(event, unit)
    if unit == "player" then
        for k,v in pairs(auraTimes) do
            v:Update("AuraTime")
        end
    end
end


function SpellIcons:RangeCheck()
    for k, v in pairs(rangeChecks) do
        v:Update("RangeCheck")
    end
end

function Player:COMBAT_LOG_EVENT_UNFILTERED(_, timestamp, event, _, sourceGUID, _, _, _, destGUID, _, _, _, spellId, spellName)
    if not Player.MaxHealth then
        Player.MaxHealth = UnitHealthMax("player")
    end

    if sourceGUID == Player.GUID and destGUID == Player.GUID then

        if event == "SPELL_AURA_APPLIED" then

            for k,v in pairs(auraTimes) do
                if v.aura == spellName then
                    v:Update("AuraTime", "applied", spellId, timestamp)
                end
            end

        elseif event == "SPELL_AURA_REMOVED" then

            for k,v in pairs(auraTimes) do
                if v.aura == spellName then
                    v:Update("AuraTime", "removed", spellId, timestamp)
                end
            end

        elseif event == "SPELL_AURA_REFRESH" then

            for k,v in pairs(auraTimes) do
                if v.aura == spellName then
                    v:Update("AuraTime", "refresh", spellId, timestamp)
                end
            end

        end

    end
end