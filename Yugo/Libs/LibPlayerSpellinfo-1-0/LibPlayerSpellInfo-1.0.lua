--[[----------------------------------------------------------------------------------------------
-- LibPlayerSpellInfo-1.0
--
-- Author: Draake
--
------------------------------------------------------------------------------------------------]]

local MAJOR_VERSION = "LibPlayerSpellInfo-1.0"
local MINOR_VERSION = 10000 + ("$Rev: 7 $"):match("%d+")

-- Namespace delcaration
if not LibStub then error(MAJOR_VERSION .. " requires LibStub.") end
local lib = LibStub:NewLibrary(MAJOR_VERSION, MINOR_VERSION)

if not lib then return end

--~ lib.debug = true

--~ local print = function(...)
--~ 	printl(...)
--~ end

--------------------------------------------------------------------------------------------------
-- Local Variables
--------------------------------------------------------------------------------------------------

local _G = _G
local pairs, ipairs, type, select, tonumber, tostring = pairs, ipairs, type, select, tonumber, tostring
local bit, math, string, table = bit, math, string, table
local print = printl or print

local _32BIT_MASK = 0xFFFFFFFF

--------------------------------------------------------------------------------------------------
-- Core Library Structure
--------------------------------------------------------------------------------------------------

if ( not lib.tooltip ) then
	lib.tooltip = CreateFrame("GameTooltip", 
		"LibPlayerSpellInfo10Tooltip", UIParent, "GameTooltipTemplate")
end

lib.events, lib.timers = table.wipe( lib.events or {} ), table.wipe( lib.timers or {} )

--------------------------------------------------------------------------------------------------
-- Event, Timer, and Utility Functions
--------------------------------------------------------------------------------------------------

local SetTimer, SetEventHandle, SelectOne

function SetTimer(name, duration, func, ...)
	assert(type(name) == "string", "Usage: SetTimer(\"name\", \"duration\", \"func\", \"...\"): 'name' should be a string value.", 2)
	assert(type(duration) == "number", "Usage: SetTimer(\"name\", \"duration\", \"func\", \"...\"): 'duration' should be a number value.", 2)
	assert(type(func) == "function", "Usage: SetTimer(\"name\", \"duration\", \"func\", \"...\"): 'func' should be a function value.", 2)
	if ( not lib.timers[name] ) then
		lib.timers[name] = {}
	end
	lib.timers[name].start		= GetTime()
	lib.timers[name].duration	= duration
	lib.timers[name].method		= func
	lib.timers[name].args		= select("#", ...)
	for i = 1, lib.timers[name].args, 1 do
		lib.timers[name][i] = select(i, ...)
	end
	return lib.timers[name]
end

function SetEventHandle(event, func, delay)
	assert(type(event) == "table" or type(event) == "string", "Usage: SetEventHandle(\"event\", \"func\", \"delay\"): 'event' should be a string or table value.", 2)
	assert(type(func) == "function", "Usage: SetEventHandle(\"event\", \"func\", \"delay\"): 'func' should be a function value.", 2)
	assert(type(delay) == "number" or not delay, "Usage: SetEventHandle(\"event\", \"func\", \"delay\"): 'event' should be a string or table value.", 2)
	local method
	if delay and ( delay >= 0 ) then
		method = function(...)
			SetTimer(tostring(event), delay, func, ...)
		end
	else
		method = func
	end
	if type(event) == "table" then
		for _, i in pairs(event) do
			lib.events[i] = method
		end
	else
		lib.events[event] = method
	end
end

function SelectOne(n, ...)
	local v = select(n, ...); return v
end

--------------------------------------------------------------------------------------------------
-- Spell/Item Link Functions
--------------------------------------------------------------------------------------------------

local GetLinkObjectInfo, GetSpellLinkInfo, GetItemLinkInfo, SplitSpellSubName

local OBJECT_LINK_PATTERN = "^|c%x+|H(%a+):(%d+)|h%[(.*)%]"

function GetObjectLinkInfo(link)
	if type(link) == "string" then
		local kind, index, name = string.match(link, OBJECT_LINK_PATTERN)
		if kind then
			return kind, tonumber(index), name
		end
	end
end

function GetSpellLinkInfo(link)
	local kind, index, name = GetObjectLinkInfo(link)
	if kind == "spell" then
		return index, name
	end
end

function GetItemLinkInfo(link)
	local kind, index, name = GetObjectLinkInfo(link)
	if kind == "item" then
		return index, name
	end
end

function SplitSpellSubName(spell)
	if type(spell) == "string" then
		return string.match(spell, "^([^%(]+)[%(]?([^%)]*)[%)]?$")
	else
		return "", ""
	end
end

--------------------------------------------------------------------------------------------------
-- Item Cache State Functions
--------------------------------------------------------------------------------------------------

local HasItemInBags, UpdatePlayerWeaponCache, UpdateContainerCache

local ITEM_CACHE = {
	INVTYPE = {},
	INVMASK = _32BIT_MASK,
	BAGSLOTS = { 
		[-4] = {}, -- Token Container
		[KEYRING_CONTAINER] = {},
	},
}

do	-- Setup Weapon/Armor Type Tables
	
	local WEAPON_TABLE, ARMOR_TABLE = { GetAuctionItemSubClasses(1) }, { GetAuctionItemSubClasses(2) }
	
	local ONE_HANDED = INVTYPE_WEAPON
	local TWO_HANDED = INVTYPE_2HWEAPON
	local MELEE, RANGED = MELEE, INVTYPE_RANGED
	local FISTS, DAGGERS, THROWN, WANDS = WEAPON_TABLE[11], WEAPON_TABLE[13], WEAPON_TABLE[14], WEAPON_TABLE[16]
	local SHIELDS, FISHING_POLES = ARMOR_TABLE[6], WEAPON_TABLE[17]
	
	ITEM_CACHE.INVTYPE[MELEE]				= 0x0001
	ITEM_CACHE.INVTYPE[RANGED]				= 0x0002
	ITEM_CACHE.INVTYPE[ONE_HANDED]			= 0x0004
	ITEM_CACHE.INVTYPE[TWO_HANDED]			= 0x0008
	
	-- Fist Weapons
	ITEM_CACHE.INVTYPE[FISTS]				= 0x0010 + ITEM_CACHE.INVTYPE[MELEE]
	-- Daggers
	ITEM_CACHE.INVTYPE[DAGGERS]				= 0x0020 + ITEM_CACHE.INVTYPE[MELEE]
	-- Thrown
	ITEM_CACHE.INVTYPE[THROWN]				= 0x0040
	-- Wands
	ITEM_CACHE.INVTYPE[WANDS]				= 0x0080
	
	-- Shields
	ITEM_CACHE.INVTYPE[SHIELDS]				= 0x0100
	-- Fishing Poles
	ITEM_CACHE.INVTYPE[FISHING_POLES]		= 0x0200
	
	-- One-Handed Axes
	ITEM_CACHE.INVTYPE[WEAPON_TABLE[1]]		= ITEM_CACHE.INVTYPE[ONE_HANDED] + ITEM_CACHE.INVTYPE[MELEE]
	-- One-Handed Maces
	ITEM_CACHE.INVTYPE[WEAPON_TABLE[5]]		= ITEM_CACHE.INVTYPE[ONE_HANDED] + ITEM_CACHE.INVTYPE[MELEE]
	-- One-Handed Swords
	ITEM_CACHE.INVTYPE[WEAPON_TABLE[8]]		= ITEM_CACHE.INVTYPE[ONE_HANDED] + ITEM_CACHE.INVTYPE[MELEE]
	
	-- Two-Handed Axes
	ITEM_CACHE.INVTYPE[WEAPON_TABLE[2]]		= ITEM_CACHE.INVTYPE[TWO_HANDED] + ITEM_CACHE.INVTYPE[MELEE]
	-- Two-Handed Maces
	ITEM_CACHE.INVTYPE[WEAPON_TABLE[6]]		= ITEM_CACHE.INVTYPE[TWO_HANDED] + ITEM_CACHE.INVTYPE[MELEE]
	-- Two-Handed Swords
	ITEM_CACHE.INVTYPE[WEAPON_TABLE[9]]		= ITEM_CACHE.INVTYPE[TWO_HANDED] + ITEM_CACHE.INVTYPE[MELEE]
	-- Polearms
	ITEM_CACHE.INVTYPE[WEAPON_TABLE[7]]		= ITEM_CACHE.INVTYPE[TWO_HANDED] + ITEM_CACHE.INVTYPE[MELEE]
	-- Staves
	ITEM_CACHE.INVTYPE[WEAPON_TABLE[10]]	= ITEM_CACHE.INVTYPE[TWO_HANDED] + ITEM_CACHE.INVTYPE[MELEE]
	
	-- Bows
	ITEM_CACHE.INVTYPE[WEAPON_TABLE[3]]		= ITEM_CACHE.INVTYPE[RANGED]
	-- Guns
	ITEM_CACHE.INVTYPE[WEAPON_TABLE[4]]		= ITEM_CACHE.INVTYPE[RANGED]
	-- Crossbows
	ITEM_CACHE.INVTYPE[WEAPON_TABLE[15]]	= ITEM_CACHE.INVTYPE[RANGED]
	
	-- Create container slot tables
	for i = 0, NUM_BAG_SLOTS, 1 do ITEM_CACHE.BAGSLOTS[i] = {};	end
	
end

local EMPTY_SLOT_NUMBER = -1
local EMPTY_SLOT_STRING = ""

function HasItemInBags(search)
	for bag, v in pairs(ITEM_CACHE.BAGSLOTS) do
		for slot, j in ipairs(v) do
			if ( type(search) == "string" and ( j.name ~= EMPTY_SLOT_STRING and j.name == search ) 
											or ( j.link ~= EMPTY_SLOT_STRING and j.link == search ) )
			or ( type(search) == "number" and j.index ~= EMPTY_SLOT_NUMBER and j.index == search ) then
				return bag, slot, j.count
			end
		end
	end
end

function UpdatePlayerWeaponCache()
	ITEM_CACHE.INVMASK = 0
	for i = 16, 18, 1 do
		local itemLink = GetInventoryItemLink("player", i)
		if itemLink then
			local itemType = SelectOne(7, GetItemInfo(itemLink))
			if itemType and ITEM_CACHE.INVTYPE[itemType] then
				ITEM_CACHE.INVMASK = bit.bor(ITEM_CACHE.INVTYPE[itemType], ITEM_CACHE.INVMASK)
			end
		end
	end
end

function UpdateContainerCache(bag)
	if ( not bag ) or ( not ITEM_CACHE.BAGSLOTS[bag] ) then
		return
	end
	local newSlots, oldSlots = GetContainerNumSlots(bag), #ITEM_CACHE.BAGSLOTS[bag]
	for slot = 1, newSlots, 1 do
		if ( not ITEM_CACHE.BAGSLOTS[bag][slot] ) then
			ITEM_CACHE.BAGSLOTS[bag][slot] = {}
		end
		local slotCache = table.wipe(ITEM_CACHE.BAGSLOTS[bag][slot])
		local itemLink = GetContainerItemLink(bag, slot)
		if itemLink then
			local index, name = GetItemLinkInfo(itemLink)
			slotCache.link, slotCache.index, slotCache.name, slotCache.count = itemLink, index, name, SelectOne(2, GetContainerItemInfo(bag, slot))
		else
			slotCache.link, slotCache.index, slotCache.name, slotCache.count = EMPTY_SLOT_STRING, EMPTY_SLOT_NUMBER, EMPTY_SLOT_STRING, EMPTY_SLOT_NUMBER
		end
	end
	for slot = newSlots, oldSlots, 1 do
		ITEM_CACHE.BAGSLOTS[bag][slot] = nil
	end
end

SetEventHandle("UNIT_INVENTORY_CHANGED", function(unit)
	if ( unit == "player" ) then UpdatePlayerWeaponCache(); end
end)
SetEventHandle("BAG_UPDATE", UpdateContainerCache)

--------------------------------------------------------------------------------------------------
-- Player Form/Stance Functions
--------------------------------------------------------------------------------------------------

local UpdatePlayerCurrentForm, UpdatePlayerFormsCache

local PLAYER_FORMS = { CURRENT = 0, FLAGS = {} }

function UpdatePlayerCurrentForm()
	PLAYER_FORMS.CURRENT = 2 ^ GetShapeshiftForm(true)
end

function UpdatePlayerFormsCache()
	local info = table.wipe(PLAYER_FORMS.FLAGS)
	for i = 1, GetNumShapeshiftForms(), 1 do
		info[ SelectOne(2, GetShapeshiftFormInfo(i)) ] = 2 ^ i
	end
end

SetEventHandle("UPDATE_SHAPESHIFT_FORM", UpdatePlayerCurrentForm)
SetEventHandle("UPDATE_SHAPESHIFT_FORMS", UpdatePlayerFormsCache)

--------------------------------------------------------------------------------------------------
-- Spellcache Functions
--------------------------------------------------------------------------------------------------

local GetSpellGlobalID, GetSpellCacheInfo, UpdatePlayerSpellReqsCache, UpdatePlayerCompanionCache

local SPELL_CACHE = {
	[BOOKTYPE_SPELL] = {},
	[BOOKTYPE_PET] = {},
	[BOOKTYPE_MOUNT] = {},
	[BOOKTYPE_COMPANION] = {},
}

local MOUNT_LU = {}

function GetSpellGlobalID(spell, bookName)
	if ( not spell ) then
		return
	elseif bookName then
		return SelectOne(2, GetSpellBookItemInfo(spell, bookName)), GetSpellLink(spell, bookName)
	elseif ( not GetSpellLinkInfo(spell) ) then
		local link = GetSpellLink(spell)
		if link then
			return GetSpellLinkInfo(link), link
		elseif type(spell) == "string" then 
			-- Hackish way of getting around the fact that mounts/critters are not 
			-- considered player spells and thus do not return values with GetSpellInfo
			-- or GetSpellLink when just using their names.
			local spellID = MOUNT_LU[ string.lower(SplitSpellSubName(spell)) ]
			if spellID then
				return spellID, GetSpellLink(spellID)
			end
		end
	else
		return GetSpellLinkInfo(spell), spell
	end
end

function GetSpellCacheInfo(index)
	local spellID = GetSpellGlobalID(index)
	if spellID then
		for _, book in pairs(SPELL_CACHE) do
			if type(book[spellID]) == "table" then
				return spellID, unpack(book[spellID])
			elseif type(book[spellID]) == "boolean" then
				return spellID, 0, _32BIT_MASK, false
			end
		end
	end
	-- spellID, equipMask, stanceMask, reagentName
	return 0, 0, _32BIT_MASK, false
end

local IS_REQUIRE_CAPTURE = string.format("^"..SPELL_REQUIRED_FORM.."$", "(.-)")
local NO_REAGENT_CAPTURE = string.format("^%s[|]?[c]?%%x*([%%s%%w]+)[|]?[r]?$", SPELL_REAGENTS)

function UpdatePlayerSpellReqsCache()
	local spellCache, formCache = table.wipe(SPELL_CACHE[BOOKTYPE_SPELL]), PLAYER_FORMS.FLAGS
	local index = 1
	repeat
		local spellID, spellLink = GetSpellGlobalID(index, BOOKTYPE_SPELL)
		if spellID and ( not IsPassiveSpell(index, BOOKTYPE_SPELL) ) then
			-- Set default spell cache values.
			local equipMask, stanceMask, reagentName = nil, nil, false
			-- Set the custom tooltip to the current spellLink.
			lib.tooltip:SetOwner(UIParent, "ANCHOR_NONE")
			lib.tooltip:SetHyperlink(spellLink)
			-- Parse tooltip for equipment, form, and reagent requirements.
			for n = 2, lib.tooltip:NumLines() - 1, 1 do
				local lineText = _G[ lib.tooltip:GetName() .. "TextLeft" .. n ]:GetText()
				for kind in string.gmatch(lineText:match(IS_REQUIRE_CAPTURE) or "", "%s*([^,]+)[,]*") do
					if formCache[kind] then
						stanceMask = bit.bor(stanceMask or 0, formCache[kind])
					else
						-- Matching text is not a form so check if it's a weapon type.
						for j, k in pairs(ITEM_CACHE.INVTYPE) do
							if string.find(kind, j, nil, true) then
								equipMask = bit.bor(equipMask or 0, k)
							end
						end
					end
				end
				reagentName = lineText:match(NO_REAGENT_CAPTURE) or reagentName
			end
			lib.tooltip:Hide()
			-- Set spell cache values and insert them into cache table.
			spellCache[spellID] = { equipMask or 0, stanceMask or _32BIT_MASK, reagentName }
		end
		index = index + 1
	until ( not spellID )
	-- Warbringer fix
	if ( SelectOne(2, UnitClass("player")) == "WARRIOR" ) and ( SelectOne(5, GetTalentInfo(3, 11)) == 1 ) then
		spellCache[100][2], spellCache[3411][2], spellCache[20252][2] = 0x000E, 0x000E, 0x000E
	end
end

function UpdatePlayerCompanionCache()
	local lookup, mountCache, compCache = table.wipe(MOUNT_LU), 
		table.wipe(SPELL_CACHE[BOOKTYPE_MOUNT]), table.wipe(SPELL_CACHE[BOOKTYPE_COMPANION])
	for i = 1, GetNumCompanions("MOUNT"), 1 do
		local _, name, spellID = GetCompanionInfo("MOUNT", i)
		if not name then
--~ 			print(i, GetNumCompanions("MOUNT"), "MOUNT", name, spellID)
			return SetTimer("UpdatePlayerCompanionCache", 0.15, UpdatePlayerCompanionCache)
		else
			compCache[spellID], lookup[name:lower()] = true, spellID
		end
	end
	for i = 1, GetNumCompanions("CRITTER"), 1 do
		local _, name, spellID = GetCompanionInfo("CRITTER", i)
		if not name then
--~ 			print(i, GetNumCompanions("CRITTER"), "CRITTER", name, spellID)
			return SetTimer("UpdatePlayerCompanionCache", 0.15, UpdatePlayerCompanionCache)
		else
			compCache[spellID], lookup[name:lower()] = true, spellID
		end
	end
end

SetEventHandle({ "PLAYER_TALENT_UPDATE", "LEARNED_SPELL_IN_TAB", "GLYPH_UPDATED", "GLYPH_ADDED", "GLYPH_REMOVED" }, UpdatePlayerSpellReqsCache, 0.15)
SetEventHandle({ "COMPANION_LEARNED", "COMPANION_UNLEARNED" }, UpdatePlayerCompanionCache, 0.15)

--------------------------------------------------------------------------------------------------
-- Init Functions
--------------------------------------------------------------------------------------------------

SetEventHandle("PLAYER_LOGIN", function()

	-- Update keyring, main bag, and token bag.
	for i in pairs(ITEM_CACHE.BAGSLOTS) do
		if i <= 0 then
			UpdateContainerCache(i)
		end
	end
	
	-- Initiate equipped weapon cache.
	UpdatePlayerWeaponCache()
	
	-- Initiate player form caches.
	UpdatePlayerFormsCache()
	
	-- For whatever reason GetShapeshiftForm() can return incorrect values at initial login, but 
	-- GetShapeshiftFormInfo()'s "isActive" value does not...
	for i = 1, GetNumShapeshiftForms(), 1 do
		if SelectOne(3, GetShapeshiftFormInfo(i)) then
			PLAYER_FORMS.CURRENT = 2 ^ i
		end
	end
	
	-- Initiate player spell caches.
	UpdatePlayerSpellReqsCache()
	UpdatePlayerCompanionCache()
	
end)

--------------------------------------------------------------------------------------------------
-- Event Handling Functions
--------------------------------------------------------------------------------------------------

if lib.frame then
	lib.frame:UnregisterAllEvents()
else
	lib.frame = CreateFrame("Frame", "LibPlayerSpellInfo10Frame")
	lib.frame:SetScript("OnEvent", function(self, event, ...)
		if type(lib.events[event]) == "function" then
			lib.events[event](...)
		end
	end)
	lib.frame:SetScript("OnUpdate", function(self, elapsed)
		for i, v in pairs(lib.timers) do
			if GetTime() > v.start + v.duration then
				v.method(unpack(v, 1, v.args))
				lib.timers[i] = nil
			end
		end
	end)
end

-- Register frame events
for i, v in pairs(lib.events) do
	lib.frame:RegisterEvent(i)
end

--[[----------------------------------------------------------------------------------------------
-- Lib: Macro/Utility Functions
------------------------------------------------------------------------------------------------]]

local MACRO_SLASH_COMMANDS = {
	["#show"] = true,
	["#showtooltip"] = "show",
	[SLASH_CAST1] = true,
	[SLASH_CAST2] = true,
	[SLASH_CAST3] = true,
	[SLASH_CAST4] = true,
	[SLASH_CASTRANDOM1] = "random",
	[SLASH_CASTRANDOM2] = "random",
	[SLASH_CASTSEQUENCE1] = "sequence",
	[SLASH_CASTSEQUENCE2] = "sequence",
	[SLASH_EQUIP1] = true,
	[SLASH_EQUIP2] = true,
	[SLASH_EQUIP3] = true,
	[SLASH_EQUIP4] = true,
	[SLASH_EQUIP_TO_SLOT1] = true,
	[SLASH_EQUIP_TO_SLOT2] = true,
	[SLASH_USE1] = true,
	[SLASH_USE2] = true,
	[SLASH_USERANDOM1] = "random",
	[SLASH_USERANDOM2] = "random",
--~ 	[SLASH_CLICK1] = "click",
--~ 	[SLASH_CLICK2] = "click",
	["/cast"] = true,
	["/castrandom"] = "random",
	["/castsequence"] = "sequence",
	["/spell"] = true,
	["/equip"] = true,
	["/eq"] = true,
	["/equipslot"] = true,
	["/use"] = true,
	["/userandom"] = "random",
--~ 	["/click"] = "click",
}

--- Determines the spell/item and target of a macrotext object.
-- @param macrotext The specified macrotext.
-- @param objLink Boolean indicating whether an item should be returned as an item link (useful 
--  if you want enchant/gem info) or item id (the default).
-- @return itemID: The determined item id (or item link if 'objLink' is defined).
-- @return spellID: The determined spell id.
-- @return target: The determined target (or nil if not specified).
-- @return showTooltip: Whether '#showtooltip' was present in the macrotext otherwise '#show" 
--  or neither were used.

function lib:GetMacroTextObject(macrotext, objLink)
	local showTooltip
	for line in string.gmatch(macrotext, "([^\n]+)") do
		local slash, block = string.match(line, "^([#/]%a+)%s*(.*)$")
		local kind = slash and MACRO_SLASH_COMMANDS[slash]
		if kind then
			-- If '#showtooltip' is written at any point _before_ the chosen command we need to
			-- pass on that the tooltip should be shown.
			if kind == "show" then
				showTooltip = true
			end
			-- Make sure the option block actually has options before proceeding...
			if block ~= "" then
				-- Parse the option block and continue if there is a valid command chosen.
				local command, target = SecureCmdOptionParse(block)
				if command then
					-- If the slash command type is 'sequence' or 'random' we query the sequence 
					-- or just choose the first object available, respectively.
					if kind == "sequence" then
						local item, spell = select(2, QueryCastSequence(command))
						command = item or spell
					elseif kind == "random" then
						command = strsplit(",", command):trim()
					end
					-- Convert command to number value if possible or try to remove the 'notoggle' 
					-- prefix token from the command.
					command = tonumber(command) or command:gsub("^!", "")
					-- Check if the command refers to a container/inventory object. If a link isn't 
					-- found then assume the command is an item's name.
					local itemLink, _, found = SecureCmdItemParse(command)
					if ( not found ) then
						itemLink = SelectOne(2, GetItemInfo(command))
					end
					if itemLink then
						-- If an itemlink is found then return the link if asked, otherwise return the
						-- global item id...
						return objLink and itemLink or GetItemLinkInfo(itemLink), nil, target, showTooltip
					end
					-- In order to give 'accurate' results we exclude spell id's and spelllinks.
					if type(command) == "string" and ( not string.find(command, "spell:%d+") ) then
						-- Check if the given command is a valid player spell and if so return the
						-- global spell id...
						local spellID = GetSpellGlobalID(command)
						if spellID then
							return nil, spellID, target, showTooltip
						end
					end
				end
			end
		end
	end
end

--- Similar to the default API's GetActionInfo except this parses a macro's contents 
--   and returns the actual spell/item.
-- @param action The queried action slot id.
-- @return mainType: The object's type (ie. spell, item, etc...).
-- @return index: The objects id (ie. spellID, itemID, etc...).
-- @return subType: The object's sub type (if applicable).
-- @return target: If a macrobject the determined target, otherwise nil.

function lib:GetExtActionInfo(action)
	local mainType, index, subType = GetActionInfo(action)
	local target
	if mainType == "macro" then
		local item, spell, target = self:GetMacroTextObject( GetMacroBody(index) )
		if item then
			mainType, index = "item", item
		elseif spell then
			mainType, index, subType = "spell", spell, "spell"
		end
	end
	return mainType, index, subType, target
end

--- Determine whether or not the given spell is a player spell (or mount/pet).
-- @param spell The spell name/link/id.
-- @return The spellid if found, otherwise false.

function lib:IsPlayerSpell(spell)
	local index = GetSpellCacheInfo(spell)
	return ( index > 0 ) and index or false
end

--[[----------------------------------------------------------------------------------------------
-- Lib: Spell Requirement Functions
------------------------------------------------------------------------------------------------]]

--- Determine whether or not the given spell meets all equipment requirements.
-- @param spell The spell name/link/id.
-- @return 

function lib:HasSpellEquipment(spell)
	local index, equipMask = GetSpellCacheInfo(spell)
	return ( index == 0 ) or ( bit.band(equipMask, ITEM_CACHE.INVMASK) == equipMask )
end

--- Determine whether or not the given spell meets stance/form requirements.
-- @param spell The spell name/link/id.
-- @return Boolean indicating whether or not stance/form requirements are met.

function lib:InSpellForm(spell)
	local index, _, stanceMask = GetSpellCacheInfo(spell)
	return ( index == 0 ) or ( bit.band(PLAYER_FORMS.CURRENT, stanceMask) == PLAYER_FORMS.CURRENT )
end

--- Determine whether or not the given spell meets all reagent requirements.
-- @param spell The spell name/link/id.
-- @return Boolean indicating whether or not reagent requirements are met.

function lib:HasSpellReagent(spell)
	local index, _, _, reagentName = GetSpellCacheInfo(spell)
	return ( index == 0 ) or ( not reagentName ) or ( HasItemInBags(reagentName) ~= nil )
end

--- Determine whether or not the given spell meets all spell requirements.
-- @param spell The spell name/link/id.
-- @return hasReqs: Boolean indicating whether or not all spell requirements are met.
-- @return hasEquip: Boolean indicating whether or not equipment requirements are met.
-- @return inForm: Boolean indicating whether or not stance/form requirements are met.
-- @return hasReagent: Boolean indicating whether or not reagent requirements are met.

function lib:HasSpellRequirements(spell)
	local hasEquip, inForm, hasReagent = self:HasSpellEquipment(spell), self:InSpellForm(spell), self:HasSpellReagent(spell)
	return hasEquip and inForm and hasReagent, hasEquip, inForm, hasReagent
end

--- Determine whether or not the given spell meets all equipment requirements.
-- @param action The action id.
-- @return Boolean indicating whether or not equipment requirements are met.

function lib:HasActionEquipment(action)
	local kind, index = self:GetExtActionInfo(action)
	return ( kind ~= "spell" ) or self:HasSpellEquipment(index)
end

--- Determine whether or not the given action meets stance/form requirements.
-- @param action The action id.
-- @return Boolean indicating whether or not stance/form requirements are met.

function lib:InActionForm(action)
	local kind, index = self:GetExtActionInfo(action)
	return ( kind ~= "spell" ) or self:InSpellForm(index)
end

--- Determine whether or not the given action meets all reagent requirements.
-- @param action The action id.
-- @return Boolean indicating whether or not reagent requirements are met.

function lib:HasActionReagent(action)
	local kind, index = self:GetExtActionInfo(action)
	return ( kind ~= "spell" ) or self:HasSpellReagent(index)
end

--- Determine whether or not the given action meets all spell requirements (or returns true if 
--   the action isn't a player spell).
-- @param action The action id.
-- @return hasReqs: Boolean indicating whether or not all action requirements are met.
-- @return hasEquip: Boolean indicating whether or not equipment requirements are met.
-- @return inForm: Boolean indicating whether or not stance/form requirements are met.
-- @return hasReagent: Boolean indicating whether or not reagent requirements are met.

function lib:HasActionRequirements(action)
	local hasEquip, inForm, hasReagent = self:HasActionEquipment(action), self:InActionForm(action), self:HasActionReagent(action)
	return hasEquip and inForm and hasReagent, hasEquip, inForm, hasReagent
end

--[[----------------------------------------------------------------------------------------------
-- Lib: Spell Cast Functions
------------------------------------------------------------------------------------------------]]

--- Returns a series of boolean values which correspond to a spell's casting requirements.
-- @param spell The spell name/link/id.
-- @param target The unitID of the required target.
-- @return **isKnown**: True if the given is a valid player spell/companion/mount.
-- @return **hasReact**: True if player is not on a taxi, the spell is not currently 'enabled', and 
--  all reactive conditions have been met.
-- @return **isReady**: True if the spell is enabled and off cooldown.
-- @return **inRange**: True if no target is specified, if the spell has no range, if the spell is 
--  in range or if the spell cannot target the given unit.
-- @return **hasUnit**: True if the given target exists and is a valid target for the given spell.
-- @return **noMove**: True if the player is not taxiing/moving/falling or if the spell cast is instant.
-- @return **hasMana**: True if the player has enough resources to cast the spell.
-- @return **hasEquip**: See lib:HasSpellEquipment
-- @return **hasReagent**: See lib:HasSpellReagent
-- @return **inForm**: See lib:InSpellForm
-- @see lib:HasSpellEquipment
-- @see lib:HasSpellReagent
-- @see lib:InSpellForm
-- @usage local isKnown, hasReact, isReady, inRange, hasUnit, noMove, hasMana, hasEquip, hasReagent, 
--  inForm = lib:SpellCastInfo(spell, target)

function lib:SpellCastInfo(spell, target)
	
	-- Check the player spell cache to see if spell is valid.
	local spellID = self:IsPlayerSpell(spell)
	
	if ( not spellID ) then
		-- Spell is either passive or not a valid player spell, so return 'true'
		-- for all values except 'isKnown'.
		return false, true, true, true, true, true, true, true, true, true
	end
	
	local spellName, _, _, spellCost, _, powerType, castTime = GetSpellInfo(spellID)
	local taxiing, usable, nomana = ( UnitOnTaxi("player") == 1 ), IsUsableSpell(spellID)
	local start, duration, enabled = GetSpellCooldown(spellID)
	
	local hasReact, isReady, inRange, hasUnit, noMove, hasMana
	
	-- hasEquip, hasReagent, inForm: True if the player meets any equipment, reagent, or form
	-- requirements (respectively).
	local _, hasEquip, inForm, hasReagent = self:HasSpellRequirements(spellID)
	
	-- isReady: True if the spell is enabled and off cooldown. 
	isReady = ( enabled == 1 ) and ( start + duration - GetTime() <= 0 ) or false
	
	-- hasMana: True if the player has enough resources to cast the spell. If the power type
	-- is 5 (Rune) then hasMana is equal to isReady.
	if ( powerType == 5 ) then
		hasMana = isReady
	elseif ( usable == 1 ) or ( spellCost == 0 ) then
		hasMana = true
	elseif ( nomana ~= 1 ) then
		if ( powerType == -2 ) then
			hasMana = ( spellCost < UnitHealth("player") )
		else
			hasMana = ( spellCost <= UnitPower("player", powerType) )
		end
	else
		hasMana = false
	end
	
	-- hasUnit: True if the given target exists and is a valid target for the given spell.
	-- inRange: True if no target is specified, if the spell has no range, if the spell is in range
	-- or if the spell cannot target the given unit.
	if ( not SpellHasRange(spellName) ) then
		hasUnit, inRange = true, true
	elseif ( not target ) or ( not UnitExists(target) ) then
		hasUnit, inRange = false, true
	else
		local index = IsSpellInRange(spellName, target)
		if ( not index ) then
			hasUnit, inRange = false, true
		else
			hasUnit, inRange = true, ( index == 1 )
		end
	end
	
	-- hasReact: True if player is not on a taxi, the spell is not currently 'enabled', and all
	-- reactive conditions have been met (regardless of whether or not the player fails to meet 
	-- mana, reagent, or equipment requirements).
	hasReact = ( taxiing or enabled == 1 ) and ( usable == 1 or not hasMana or not hasEquip or not hasReagent )
	
	-- Charge fix
	if ( spellID == 100 ) and ( not hasUnit ) then
		hasReact = true
	end
	
	-- noMove: True if the player is not taxiing/moving/falling or if the spell cast is instant.
	noMove = ( not taxiing ) and ( castTime == 0 or ( not IsFalling() and GetUnitSpeed("player") == 0 ) )
	
	-- isKnown, hasReact, isReady, inRange, hasUnit, noMove, hasMana, hasEquip, hasReagent, inForm
	return true, hasReact, isReady, inRange, hasUnit, noMove, hasMana, hasEquip, hasReagent, inForm
	
end

--- Returns a series of boolean values which correspond to an item's usage requirements.
-- @param item The item name/link/id.
-- @param target The unitID of the required target.
-- @return **isKnown**: Always //true// (returned for consistency with lib:SpellCastInfo).
-- @return **hasReact**: True if player is not on a taxi, the spell is not currently 'enabled', and 
--  all reactive conditions have been met.
-- @return **isReady**: True if the spell is enabled and off cooldown.
-- @return **inRange**: True if no target is specified, if the spell has no range, if the spell is 
--  in range or if the spell cannot target the given unit.
-- @return **hasUnit**: True if the given target exists and is a valid target for the given spell.
-- @return **noMove**: Always //true// (returned for consistency with lib:SpellCastInfo).
-- @return **hasMana**: True if the player has enough resources to use the item.
-- @return **hasEquip**: True if the item is not eqquipable or the item is equipped.
-- @return **hasReagent**: Always //true// (returned for consistency with lib:SpellCastInfo).
-- @return **inForm**: Always //true// (returned for consistency with lib:SpellCastInfo).
-- @usage local isKnown, hasReact, isReady, inRange, hasUnit, noMove, hasMana, hasEquip, hasReagent, 
--  inForm = lib:ItemUseInfo(item, target)

function lib:ItemUseInfo(item, target)
	
	local hasReact, isReady, inRange, hasUnit, hasMana, hasEquip
	
	local usable, nomana = IsUsableItem(item)
	local start, duration, enabled = GetItemCooldown(item)
	
	hasReact, hasMana = ( usable == 1 ) and ( UnitOnTaxi("player") ~= 1 ), ( nomana ~= 1 )
	
	isReady = ( enabled == 1 ) and ( start + duration - GetTime() <= 0 ) or false
	
	if ( not ItemHasRange(item) ) then
		hasUnit, inRange = true, true
	elseif ( not target ) or ( not UnitExists(target) ) then
		hasUnit, inRange = false, true
	else
		local index = IsItemInRange(item, target)
		if ( not index ) then
			hasUnit, inRange = false, true
		else
			hasUnit, inRange = true, ( index == 1 )
		end
	end
	
	hasEquip = ( not IsEquippableItem(item) ) or IsEquippedItem(item)
	
	-- isKnown, hasReact, isReady, inRange, hasUnit, noMove, hasMana, hasEquip, hasReagent, inForm
	return true, hasReact, isReady, inRange, hasUnit, true, hasMana, hasEquip, true, true
	
end

--- Returns a series of boolean values which correspond to an action's usage requirements.
-- @param action The action id.
-- @param target The unitID of the required target.
-- @return **isKnown**: If item or spell see their respective lib:*Info functions, otherwise this 
--  is always //true// (returned for consistency with lib:SpellCastInfo).
-- @return **hasReact**: True if player is not on a taxi, the spell is not currently 'enabled', and 
--  all reactive conditions have been met.
-- @return **isReady**: True if the spell is enabled and off cooldown.
-- @return **inRange**: True if no target is specified, if the spell has no range, if the spell is 
--  in range or if the spell cannot target the given unit.
-- @return **hasUnit**: True if the given target exists and is a valid target for the given spell.
-- @return **noMove**: If item or spell see their respective lib:*Info functions, otherwise this 
--  is always //true// (returned for consistency with lib:SpellCastInfo).
-- @return **hasMana**: True if the player has enough resources to use the action.
-- @return **hasEquip**: If item or spell see their respective lib:*Info functions, otherwise this 
--  is always //true// (returned for consistency with lib:SpellCastInfo).
-- @return **hasReagent**: If item or spell see their respective lib:*Info functions, otherwise this 
--  is always //true// (returned for consistency with lib:SpellCastInfo).
-- @return **inForm**: If item or spell see their respective lib:*Info functions, otherwise this 
--  is always //true// (returned for consistency with lib:SpellCastInfo).
-- @see lib:SpellCastInfo
-- @usage local isKnown, hasReact, isReady, inRange, hasUnit, noMove, hasMana, hasEquip, hasReagent, 
--  inForm = lib:ActionUseInfo(action, target)

function lib:ActionUseInfo(action, target)
	
	local mainType, index, subType, macrotarget = self:GetExtActionInfo(action)
	
	-- Targets derived from macros override any innate button target attributes. If
	-- no target is specified then the default target is 'target'.
	target = macrotarget or target or "target"
	
	if ( mainType == "spell" ) and ( subType == "spell" ) then
		return self:SpellCastInfo(index, target)
	elseif ( mainType == "item" ) then
		return self:ItemUseInfo(index, target)
	else
		
		local hasReact, isReady, inRange, hasUnit, hasMana
		
		local usable, nomana = IsUsableAction(action)
		local start, duration, enabled = GetActionCooldown(action)
		
		if ( enabled == 1 ) then
			hasReact, isReady = ( usable == 1 ) and ( UnitOnTaxi("player") ~= 1 ), ( start + duration - GetTime() <= 0 )
		else
			hasReact, isReady = false, false
		end
		
		hasMana = ( nomana ~= 1 )
		
		if ( not ActionHasRange(action) ) then
			hasUnit, inRange = true, true
		elseif ( not UnitExists(target) ) then
			hasUnit, inRange = false, true
		else
			local index = IsActionInRange(action, target)
			if ( not index ) then
				hasUnit, inRange = false, true
			else
				hasUnit, inRange = true, ( index == 1 )
			end
		end
		
		-- isKnown, hasReact, isReady, inRange, hasUnit, noMove, hasMana, hasEquip, hasReagent, inForm
		return true, hasReact, isReady, inRange, hasUnit, true, hasMana, true, true, true
		
	end
	
end

