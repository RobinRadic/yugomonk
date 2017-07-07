YugoTypes = {}
local Types = YugoTypes

local types = {
	['anchorPoint'] = {
		["CENTER"] = "CENTER",
		["BOTTOM"] = "BOTTOM",
		["TOP"] = "TOP",
		["LEFT"] = "LEFT",
		["RIGHT"] = "RIGHT",
		["BOTTOMLEFT"] = "BOTTOMLEFT",
		["BOTTOMRIGHT"] = "BOTTOMRIGHT",
		["TOPLEFT"] = "TOPLEFT",
		["TOPRIGHT"] = "TOPRIGHT"
	},
	['frameStrata'] = {
		["BACKGROUND"] = "BACKGROUND",
		["DIALOG"] = "DIALOG",
		["FULLSCREEN"] = "FULLSCREEN",
		["FULLSCREEN_DIALOG"] = "FULLSCREEN_DIALOG",
		["HIGH"] = "HIGH",
		["LOW"] = "LOW",
		["MEDIUM"] = "MEDIUM",
		["PARENT"] = "PARENT",
		["TOOLTIP"] = "TOOLTIP "
	},

	-- not sure if these belong here...
	style = {
		['SOLID'] = 'SOLID',
		['GRADIENT'] = 'GRADIENT'
	},
	blend = {
		['ADD'] = 'ADD',
		['ALPHAKEY'] = 'ALPHAKEY',
		['BLEND'] = 'BLEND',
		['DISABLE'] = 'DISABLE',
		['MOD'] = 'MOD'
	},
	orientation = {
		['HORIZONTAL'] = 'HORIZONTAL',
		['VERTICAL'] = 'VERTICAL'
	},
}

function Types:Get(dataType)
	if types[dataType] then
		return types[dataType]
	else
		return false
	end
end

function Types:ParseGUID(guid)
	local first3 = tonumber("0x"..strsub(guid, 3,5))
	local unitType = bit.band(first3,0x00f)

	if (unitType == 0x000) then
		print("Player, ID #", strsub(guid,6))
	elseif (unitType == 0x003) then
		local creatureID = tonumber("0x"..strsub(guid,7,10))
		local spawnCounter = tonumber("0x"..strsub(guid,11))
		print("NPC, ID #",creatureID,"spawn #",spawnCounter)
	elseif (unitType == 0x004) then
		local petID = tonumber("0x"..strsub(guid,7,10))
		local spawnCounter = tonumber("0x"..strsub(guid,11))
		print("Pet, ID #",petID,"spawn #",spawnCounter)
	elseif (unitType == 0x005) then
		local creatureID = tonumber("0x"..strsub(guid,7,10))
		local spawnCounter = tonumber("0x"..strsub(guid,11))
		print("Vehicle, ID #",creatureID,"spawn #",spawnCounter)
	end

	return type, id, spawnCounter
end

function Types:InventoryID(slot)
	--[[
	INVSLOT_AMMO       = 0;
	INVSLOT_HEAD       = 1; INVSLOT_FIRST_EQUIPPED = INVSLOT_HEAD;
	INVSLOT_NECK       = 2;
	INVSLOT_SHOULDER   = 3;
	INVSLOT_BODY       = 4;
	INVSLOT_CHEST      = 5;
	INVSLOT_WAIST      = 6;
	INVSLOT_LEGS       = 7;
	INVSLOT_FEET       = 8;
	INVSLOT_WRIST      = 9;
	INVSLOT_HAND       = 10;
	INVSLOT_FINGER1        = 11;
	INVSLOT_FINGER2        = 12;
	INVSLOT_TRINKET1   = 13;
	INVSLOT_TRINKET2   = 14;
	INVSLOT_BACK       = 15;
	INVSLOT_MAINHAND   = 16;
	INVSLOT_OFFHAND        = 17;
	INVSLOT_RANGED     = 18;
	INVSLOT_TABARD     = 19;
	INVSLOT_LAST_EQUIPPED = INVSLOT_TABARD;
	]]--
	local inventoryIds = {
		['head'] = INVSLOT_HEAD,
		['neck'] = INVSLOT_NECK,
	-- etc
	}

	if inventoryIds[slot] then
		return inventoryIds[slot]
	end
	return false
end