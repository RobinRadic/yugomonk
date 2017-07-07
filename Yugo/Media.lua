YugoMedia = {}
local YugoMedia = YugoMedia
local LSM = LibStub("LibSharedMedia-3.0")

YugoMedia.art = {}
local art = YugoMedia.art

local FONT_LANG_MASK_ALL = 255


function YugoMedia:Register(type, name, path)
    if not LSM:IsValid(type) then return false end
    if type == 'font' then
        LSM:Register(type, name, path, FONT_LANG_MASK_ALL)
    else
        LSM:Register(type, name, path)
    end
end

function YugoMedia:Add(type, name, path)
    if not art[type] then art[type] = {} end
    art[type][name] = path
end

-- Fetch art from SharedMedia or local art
function YugoMedia:Get(name, type)
    if not name then return nil end
    if not type then return nil end
    if name == "None" then
        return nil
    end

    if art[type] and art[type][name] then
        return art[type][name]
    elseif LSM and LSM.Fetch and LSM:Fetch(type, name, true) then
        return LSM:Fetch(type, name ,true)
    else
        return nil
    end
end
