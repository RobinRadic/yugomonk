convert = {}

function toboolean(v)
	return (type(v) == "string" and v == "true") or (type(v) == "number" and v ~= 0) or (type(v) == "boolean" and v)
end


-------------------------------------------------------------------------------------------------------- Yugo:rprint
function print_r(s, l, i) -- recursive Print (structure, limit, indent)
	l = (l) or 100; i = i or "";	-- default item limit, indent string
	if (l<1) then print "ERROR: Item limit reached."; return l-1 end;
	local ts = type(s);
	if (ts ~= "table") then print (i,ts,s); return l-1 end
	print (i,ts);           -- print "table"
	for k,v in pairs(s) do  -- print "[KEY] VALUE"
		l = print_r(v, l, i.."\t["..tostring(k).."]");
		if (l < 0) then break end
	end
	return l
end

function show_table(tbl, title)

	local string = ''
	local function print(...)
		local args = {... }
		for k, v in pairs(args) do
			string = string .. tostring(v)
		end
		string = string .. '\n'
	end
	local function print_r(s, l, i) -- recursive Print (structure, limit, indent)
		l = (l) or 1000; i = i or "";	-- default item limit, indent string
		if (l<1) then print "ERROR: Item limit reached."; return l-1 end;
		local ts = type(s);
		if (ts ~= "table") then print (i,ts,s); return l-1 end
		print (i,ts);           -- print "table"
		for k,v in pairs(s) do  -- print "[KEY] VALUE"
			l = print_r(v, l, i.."\t["..tostring(k).."]");
			if (l < 0) then break end
		end
		return l
	end

	print_r(tbl)
	local AceGUI = LibStub("AceGUI-3.0")
	local frame = AceGUI:Create("Frame")
	frame:SetTitle(title or 'Table output')
	frame:SetStatusText("AceGUI-3.0 Example Container Frame")
	frame:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end)
	frame:SetLayout("Fill")
	frame:SetHeight(1000)
	local editbox = AceGUI:Create("MultiLineEditBox")
	editbox:SetText(string)
	editbox:SetHeight(800)
	editbox:SetRelativeWidth(1)
	frame:AddChild(editbox)
end

-------------------------------------------------------------------------------------------------------- Yugo:round
function math.round(num, idp)
	local mult = 10^(idp or 0)
	return math.floor(num * mult + 0.5) / mult
end

-------------------------------------------------------------------------------------------------------- Yugo:reverse
function math.reverse(number)
	return number - number - number
end

-------------------------------------------------------------------------------------------------------- table.extend
function table.extend(t1, t2)
	for k, v in pairs(t2) do
		if (type(v) == "table") and (type(t1[k] or false) == "table") then
			table.extend(t1[k], t2[k])
		else
			t1[k] = v
		end
	end
	return t1
end

-------------------------------------------------------------------------------------------------------- Yugo:table_copy
function table.copy(t)
	if not t then return {} end
	local t2 = {}
	for k,v in pairs(t) do
		t2[k] = v
	end
	return t2
end

function table.deepcopy(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end

function table.length(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
end

function table.invert(tab) -- returns a table with inverted keys/values
	local new = {}
	for k, v in pairs(tab) do
		new[v] = k
	end
	return new
end

function table.toNumeric(tab) -- returns a table with numeric keys/indices
	local new = {}					-- allows a table to be unpacked
	local k = 0
	for _, v in pairs(tab) do
		k = k + 1
		new[k] = v
	end
	return new
end

function table.merge(...) -- returns the synthesis of the passed tables
	local new = {}
	for _, tab in pairs{...} do
		for k, v in pairs(tab) do
			new[k] = v
		end
	end
	return new
end

function table.setter(thetable, ...)
	local a={...}
	local n=#a
	local t=thetable
	if #a == 1 and type(a[1]) == 'table' then
		table.extend(thetable, a[1])
		return
	end
	for i=1,n-2 do
		local k=a[i]
		t[k]=t[k] or {}
		t=t[k]
	end
	if type(t[a[n-2]]) == 'table' then
		table.extend(t[a[n-1]], a[n])
	else
		t[a[n-1]] = a[n]
	end
end
-------------------------------------------------------------------------------------------------------- Yugo:ToKiloNumber
function convert.tokilo(number)
	return (floor(number/100+0.5)/10).."k"
end

-------------------------------------------------------------------------------------------------------- Yugo:ToMegaNumber
function convert.tomega(number)
	return (floor(number/100000+0.5)/10).."M"
end

-------------------------------------------------------------------------------------------------------- Yugo:ToPercentNumber
function convert.topercent(frac)
	return (floor(frac*1000+.5)/10).."%"
end