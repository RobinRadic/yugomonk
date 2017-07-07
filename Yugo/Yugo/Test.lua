local config = {
    val = 1,
    background = {
        foo = 5,
        textures = {
            bar = 'okay',
            layers = {
                medium = {
                    alpha = 1,
                    color = {
                        red = 255,
                        blue = 5,
                        green = 100
                    }
                }
            }
        }
    },
    sub = {
        val = 5,
        foo = {
            val = true,
            bar = {
            }
        }
    }
}
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
local function set_config(...)
    local a={...}
    local n=#a
    local t=config
    if #a == 1 and type(a[1]) == 'table' then
        table.extend(config, a[1])
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
-- And this should go as deep into the table as I want to

set_config('background', 'textures', 'layers', 'medium', 'color', {
    red = 23
})
--print_r(config)

set_config({
    height = 400,
    background = {
        textures = {
            bar = 'nokai',
            fast = 400
        }
    }
})
print_r(config)