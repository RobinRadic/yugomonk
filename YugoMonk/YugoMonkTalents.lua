if select(2, UnitClass("player")) == 'MONK' then
local Yugo = LibStub("AceAddon-3.0"):GetAddon("Yugo")
local YugoMonk = LibStub("AceAddon-3.0"):GetAddon("YugoMonk")
local Talents = YugoMonk:NewModule('Talents', 'LibBossEncountersYugoEdit-1.1')

Talents.options = {
    name = "Talents",
    type = 'group',
    args = {
        enabled = {
            order = 10,
            disabled = true,
            hidden = true,
            name = 'Enabled',
            type = 'toggle',
            width = 'full',
            get = function() return Talents.db.profile.enabled end,
            set = function(self, key)
                Talents.db.profile.enabled = key
                if key == true then
                    Talents:Enable()
                else
                    Talents:Disable()
                end
            end
        },
        dialogs = {
            order = 20,
            name = 'Show dialog warnings for bosses',
            type = 'toggle',
            width = 'full',
            get = function() return Talents.db.profile.dialogWindows end,
            set = function(self, key)
                Talents.db.profile.dialogWindows = key
            end
        },
        config = {
            order = 30,
            name = 'Configuration',
            type = 'execute',
            func = function()
                Talents:Show()
            end,
            width = 'double'
        },
    }
}

Talents.optionsDB = {
    ['**'] = { --Instance
        ['**'] = { --Boss
            talent = {0,0,0,0,0,0},
            majGlyph = {0,0,0},
            minGlyph = {0,0,0},
            checked = false,
        },
    },

    dialogWindows = true,
    checkUnset = true,
    first = true,
    debugging = false,
    checkLFR = true,
}

Talents.registerEvents = {
    'PLAYER_TARGET_CHANGED',
    'ZONE_CHANGED_NEW_AREA'
}

local aGUI = LibStub("AceGUI-3.0")

local instanceList = {}
local GlyphInfo = {
    major = {},
    minor = {}
}

local mapName
local instanceTreeData = {}
local bossTabData = {}
local selectedInstance, selectedBoss

local zoneTree, bossTab





local function DrawBossGroup(container, event, group)
    local instanceName = selectedInstance
    container:ReleaseChildren()
    local heading = aGUI:Create("Heading")
    heading:SetRelativeWidth(1)
    heading:SetText('Talents')
    container:AddChild(heading)
    container:SetLayout('Flow')
    for i=1,6 do
        for j=1,3 do
            local group = aGUI:Create("SimpleGroup")
            group:SetLayout("Flow")
            group:SetRelativeWidth(0.25)
            local icon = aGUI:Create("Icon")
            icon:SetImageSize(50,50)
            local name, iconPath, tier, column, currentRank = GetTalentInfo(i*3-3+j)
            icon:SetImage(iconPath)
            icon:SetUserData("name",name)
            icon:SetUserData("row",i)
            icon:SetUserData("column",j)
            icon:SetUserData("parent",container)
            icon:SetCallback("OnClick",function(widget)
                Talents:ChangeTalent(widget:GetUserData("row"),widget:GetUserData("column"), widget)
            end)
            local label = aGUI:Create("Label")
            label:SetRelativeWidth(0.75)
            label:SetText(name)
            if Talents.db.profile[instanceName][selectedBoss].talent[i] == j then
                icon:SetDisabled(true)
                label:SetColor(253,247,15)
            else
                icon:SetDisabled(false)
                label:SetColor(140,140,140)
            end
            group:AddChild(icon)
            group:AddChild(label)
            container:AddChild(group)
        end
        local group = aGUI:Create("SimpleGroup")
        group:SetLayout("Flow")
        group:SetRelativeWidth(0.25)
        local icon = aGUI:Create("Icon")
        icon:SetImageSize(50,50)
        icon:SetImage("Interface\\Buttons\\UI-GroupLoot-Pass-Down")
        icon:SetUserData("name","Ignore")
        icon:SetUserData("row",i)
        icon:SetUserData("column",0)
        icon:SetCallback("OnClick",function(widget) Talents:ChangeTalent(widget:GetUserData("row"),widget:GetUserData("column"), widget) end)
        local label = aGUI:Create("Label")
        label:SetRelativeWidth(0.75)
        label:SetText('Ignore')
        --[[
        if TalentCheck.db.char[slctInstance][slctBoss][difficulty][activeSpec].talent[i] == 0 then
            icon:SetDisabled(true)
        else
            icon:SetDisabled(false)
        end]]--
        group:AddChild(icon)
        group:AddChild(label)
        container:AddChild(group)


    end



    --Major Glyph section

    local heading = aGUI:Create("Heading")
    heading:SetRelativeWidth(1)
    heading:SetText("Majour Glyphs")
    container:AddChild(heading)
    for i=1,3 do
        local group = aGUI:Create("SimpleGroup")
        group:SetRelativeWidth(0.33)
        group:SetLayout("Flow")
        local icon  = aGUI:Create("Icon")
        icon:SetImageSize(50,50)
        if (Talents.db.profile[instanceName][selectedBoss].majGlyph[i] ~= 0) and (Talents.db.profile[instanceName][selectedBoss].majGlyph[i]) then
            icon:SetImage(Talents:GetGlyphImage(Talents.db.profile[instanceName][selectedBoss].majGlyph[i], true))
        else
            icon:SetImage("Interface\\Buttons\\UI-GroupLoot-Pass-Down")
        end
        icon:SetDisabled(true)
        local dropdown = aGUI:Create("Dropdown")
        dropdown:SetRelativeWidth(0.50)
        dropdown:SetLabel("Majour glyph " .. i)
        dropdown:SetList({})
        dropdown:AddItem(0,"Ignore")
        dropdown:SetUserData("ID", i)
        for j=1,#GlyphInfo.major do
            if Talents:GlyphCheck(j,i, true) then
                dropdown:AddItem(GlyphInfo.major[j].glyphID, GlyphInfo.major[j].name)
            end
        end
        if (Talents.db.profile[instanceName][selectedBoss].majGlyph[i] ~= 0) and (Talents.db.profile[instanceName][selectedBoss].majGlyph[i]) then
            dropdown:SetValue(Talents.db.profile[instanceName][selectedBoss].majGlyph[i])
        else
            dropdown:SetValue(0)
        end
        dropdown:SetCallback("OnValueChanged", function(widget, _, glyph, test4) Talents:ChangeGlyph(glyph,true, widget) end)
        group:AddChild(icon)
        group:AddChild(dropdown)
        container:AddChild(group)
    end



    --Minor Glyph section

    local heading = aGUI:Create("Heading")
    heading:SetRelativeWidth(1)
    heading:SetText("Minor Glyphs")
    container:AddChild(heading)
    for i=1,3 do
        local group = aGUI:Create("SimpleGroup")
        group:SetRelativeWidth(0.33)
        group:SetLayout("Flow")
        local icon  = aGUI:Create("Icon")
        icon:SetImageSize(50,50)
        if (Talents.db.profile[instanceName][selectedBoss].minGlyph[i] ~= 0) and (Talents.db.profile[instanceName][selectedBoss].minGlyph[i]) then
            icon:SetImage(Talents:GetGlyphImage(Talents.db.profile[instanceName][selectedBoss].minGlyph[i], false))
        else
            icon:SetImage("Interface\\Buttons\\UI-GroupLoot-Pass-Down")
        end
        icon:SetDisabled(true)
        local dropdown = aGUI:Create("Dropdown")
        dropdown:SetRelativeWidth(0.50)
        dropdown:SetLabel("Minor Glyph " .. i)
        dropdown:SetList({})
        dropdown:AddItem(0,"Ignore")
        dropdown:SetUserData("ID", i)
        for j=1,#GlyphInfo.minor do
            if Talents:GlyphCheck(j,i, false) then
                dropdown:AddItem(GlyphInfo.minor[j].glyphID, GlyphInfo.minor[j].name)
            end
        end
        if (Talents.db.profile[instanceName][selectedBoss].minGlyph[i] ~= 0) and (Talents.db.profile[instanceName][selectedBoss].minGlyph[i]) then
            dropdown:SetValue(Talents.db.profile[instanceName][selectedBoss].minGlyph[i])
        else
            dropdown:SetValue(0)
        end
        dropdown:SetCallback("OnValueChanged", function(widget, _, glyph, test4) Talents:ChangeGlyph(glyph, false, widget) end)
        group:AddChild(icon)
        group:AddChild(dropdown)
        container:AddChild(group)
    end

    --Buttons at the bottom

    local button = aGUI:Create("Button")
    button:SetText("Import current talents")
    button:SetCallback("OnClick", function() Talents:Import(true, false) end)
    button:SetRelativeWidth(0.20)
    container:AddChild(button)

    local button = aGUI:Create("Button")
    button:SetText("Import current glyphs")
    button:SetCallback("OnClick", function() Talents:Import(false, true) end)
    button:SetRelativeWidth(0.20)
    container:AddChild(button)

    local button = aGUI:Create("Button")
    button:SetText("Import talents and glyphs")
    button:SetCallback("OnClick", function() Talents:Import(true, true) end)
    button:SetRelativeWidth(0.25)
    container:AddChild(button)

end

local function SelectBossGroup(container, event, group)
    container:ReleaseChildren()
    selectedBoss = group
    DrawBossGroup(container, group)
end

local function DrawInstanceGroup(container, group)
    bossTab = aGUI:Create("TabGroup")
    bossTab:SetTabs(bossTabData[group])
    bossTab:SetCallback("OnGroupSelected", SelectBossGroup)
    container:AddChild(bossTab)
end

local function SelectInstanceGroup(container, event, group)
    container:ReleaseChildren()
    selectedInstance = group
    container:SetLayout("Fill")
    DrawInstanceGroup(container, group)
end




function Talents:OnModuleInitialize()

    -- Setup instances and bosses
    local instances = Talents:GetInstances()
    local instanceCount = 1
    for k, v in pairs(instances) do
        if k == 'THRONE_OF_THUNDER' or k == 'SIEGE_OF_ORGRIMMAR' or k == 'SERPENTSHRINE_CAVERN' then
            instanceList[instanceCount] = {
                name = v,
                key = k,
                bosses_by_id = {},
                bosses_by_count = {},
                bosses_by_name = {}
            }
            local encounters = BossEncounters_Data['BossEncounters_Criteria'][v]
            local count = 1
            for bossName, bossIDS in pairs(encounters) do
                for bossId, isTrue in pairs(bossIDS) do
                    instanceList[instanceCount].bosses_by_id[bossId] = {
                        name = bossName,
                        count = count
                    }
                end
                instanceList[instanceCount].bosses_by_count[count] = {
                    name = bossName,
                    ids = bossIDS
                }
                instanceList[instanceCount].bosses_by_name[bossName] = {
                    count = count,
                    ids = bossIDS
                }
                count = count + 1
            end
            instanceCount = instanceCount + 1
        end
    end

    -- Setup glyphs
    GlyphInfo.major = {} --Resets the tables in case the fuction runs again.
    GlyphInfo.minor = {}
    local index = 1
    local name, glyphType, isKnown, icon, glyphID,_, spec = GetGlyphInfo(index)
    while name do
        if spec ~= 'Windwalker' or spec ~= 'Mistweaver' then
            if (glyphType == 1) and (name ~= "header") then
                table.insert(GlyphInfo.major, {name = name, isKnown = isKnown, icon = icon, glyphID = glyphID, spec = spec})
            elseif (glyphType == 2) and (name ~= "header") then
                table.insert(GlyphInfo.minor, {name = name, isKnown = isKnown, icon = icon, glyphID = glyphID, spec = spec})
            end
        end
        index = index + 1
        name, glyphType, isKnown, icon, glyphID,_, spec = GetGlyphInfo(index)
    end


    -- setup tree(instances) and tab(bosses) data
    for instanceCount, instanceData in pairs(instanceList) do
        instanceTreeData[instanceCount] = {
            value = instanceData.key,
            text = instanceData.name
        }
        bossTabData[instanceData.key] = {}
        local count = 0
        for bossName, bossData in pairs(instanceData.bosses_by_name) do
            bossTabData[instanceData.key][count] = {
                value = bossName,
                text = bossName
            }
            count = count + 1
        end
    end

    Talents:SetupDialogs()

    if self.db.profile.enabled == false then
        Talents:Disable()
    end

end

function Talents:OnModuleEnable()
    mapName = Talents:GetMapName()
end

function Talents:OnModuleDisable()
end

function Talents:Show()
    local frame = aGUI:Create("Frame")

    frame:SetTitle("YugoMonk Talents")
    frame:SetStatusText("Developed by Yugö @ Hellfire(EU)")
    frame:SetCallback("OnClose", function(widget) aGUI:Release(widget) end)
    frame:SetLayout("Fill")
    frame:SetWidth(1000)
    frame:SetHeight(880)

    zoneTree = aGUI:Create("TreeGroup")

    zoneTree:SetTree(instanceTreeData)
    zoneTree:SetCallback("OnGroupSelected", SelectInstanceGroup)
    --if currentZone then
    --    tab:SelectTab(currentZone)
    -- else
    --     tab:SelectTab("conf")
    -- end
    frame:AddChild(zoneTree)

end



function Talents:ChangeTalent(row, column, container)
    Talents.db.profile[selectedInstance][selectedBoss].talent[row] = column
    Talents.db.profile[selectedInstance][selectedBoss].checked = true
    --bossChecked[slctInstance][slctBoss][activeSpec] = false
    SelectBossGroup(bossTab,nil,selectedBoss, true)
end

function Talents:CheckTalents(instance, boss)

    --Check talents

    selectedInstance = instanceList[instance].key
    local instanceName = instanceList[instance].key
    selectedBoss = instanceList[instance].bosses_by_id[boss].name

    local TCCheckCounter = 0 --Counter for checking the amount of talents set to ignore.
    local wrongTalents = false
    for i=1,18 do
        local name, iconPath, tier, column, currentRank = GetTalentInfo(i)
        if currentRank then
            if Talents.db.profile[instanceName][selectedBoss].talent[tier] == 0 then
                TCCheckCounter = TCCheckCounter + 1
            elseif Talents.db.profile[instanceName][selectedBoss].talent[tier] ~= column then
                wrongTalents = true
                break
            end
        end
    end
    if (TCCheckCounter == 6) and (not Talents.db.profile[instanceName][selectedBoss].checked) then
       StaticPopup_Show("TC_MISSING", selectedBoss)
       Talents.db.profile[instanceName][selectedBoss].checked = true
    end
    if GetNumUnspentTalents() ~= 0 then
        StaticPopup_Show("TC_NO_TALENTS")
    end

    --Check Glyphs
    local wrongMinorGlyph = false
    local wrongMajorGlyph = false
    for i=1,3 do
        if Talents.db.profile[instanceName][selectedBoss].majGlyph[i] ~= 0 then
            for j=1,6 do
                local enabled, glyphType, glyphTooltipIndex, glyphSpellID, icon, glyphID = GetGlyphSocketInfo(j)
                if glyphID == Talents.db.profile[instanceName][selectedBoss].majGlyph[i] then
                    break
                end
                if j == 6 then
                    wrongMajorGlyph = true
                end
            end
        end
        if Talents.db.profile[instanceName][selectedBoss].minGlyph[i] ~= 0 then
            for j=1,6 do
                local enabled, glyphType, glyphTooltipIndex, glyphSpellID, icon, glyphID = GetGlyphSocketInfo(j)
                if glyphID == Talents.db.profile[instanceName][selectedBoss].minGlyph[i] then
                    break
                end
                if j == 6 then
                    wrongMinorGlyph = true
                end
            end
        end
    end
   -- lastSeenBoss = boss
    local function checkCombat()
        local affectingCombat = UnitAffectingCombat("player")
        if affectingCombat == 1 then
            return true
        else
            --bossChecked[instance][boss][spec] = true
            return false
        end
    end
    if Talents.db.profile.dialogWindows and not checkCombat() then
        if wrongTalents and (wrongMinorGlyph or wrongMajorGlyph) then
            StaticPopup_Show("TC_WRONG_TALENTS_AND_GLYPHS",selectedBoss)
        elseif wrongTalents then
            StaticPopup_Show("TC_WRONG_TALENTS",selectedBoss)
        elseif (wrongMinorGlyph or wrongMajorGlyph) then
            StaticPopup_Show("TC_WRONG_GLYPHS", selectedBoss)
        end
    end
end




function Talents:ChangeGlyph(glyph, major, container)
    if major then
        Talents.db.profile[selectedInstance][selectedBoss].majGlyph[container:GetUserData("ID")] = glyph
    else
        Talents.db.profile[selectedInstance][selectedBoss].minGlyph[container:GetUserData("ID")] = glyph
    end
    Talents.db.profile[selectedInstance][selectedBoss].checked = true
    --bossChecked[slctInstance][slctBoss][activeSpec] = false
    bossTab:ReleaseChildren()
    SelectBossGroup(bossTab,nil,selectedBoss, true)
end

function Talents:GetGlyphImage(id, major)
    if major then
        for i=1,#GlyphInfo.major do
            if GlyphInfo.major[i].glyphID == id then
                return GlyphInfo.major[i].icon
            end
        end
    else
        for i=1,#GlyphInfo.minor do
            if GlyphInfo.minor[i].glyphID == id then
                return GlyphInfo.minor[i].icon
            end
        end
    end
end

function Talents:GlyphCheck(glyphID, databaseID, major)
    if major then
        if(GlyphInfo.major[glyphID].isKnown) then
            for i=1,3 do
                if i ~= databaseID then
                    if GlyphInfo.major[glyphID].glyphID == Talents.db.profile[selectedInstance][selectedBoss].majGlyph[i] then
                        return false
                    end
                end
            end
            return true
        end
    else
        if (GlyphInfo.minor[glyphID].isKnown) then
            for i=1,3 do
                if i ~= databaseID then
                    if (GlyphInfo.minor[glyphID].glyphID == Talents.db.profile[selectedInstance][selectedBoss].minGlyph[i]) then
                        return false
                    end
                end
            end
            return true
        end
    end
end




function Talents:GetInstanceByMapName(name)
    for k, v in pairs(instanceList) do
        if v.name == name then
            return k, v
        end
    end
    return
end

function Talents:GetMapName()
    local id = GetCurrentMapAreaID()
    return GetMapNameByID(id)
end




function Talents:Import(talents, glyphs)
    if talents then
        for i=1,6 do
            local notChosen, chosenTalent = GetTalentRowSelectionInfo(i)
            if not notChosen then
                Talents.db.profile[selectedInstance][selectedBoss].talent[i] = (chosenTalent - (i*3-3))
            else
                Talents.db.profile[selectedInstance][selectedBoss].talent[i] = 0
            end
        end
    end
    if glyphs then
        for i=1,6 do
            local enabled, glyphType, glyphTooltipIndex, glyphSpellID, icon, glyphID = GetGlyphSocketInfo(i)
            if glyphType == 1 then
                local id = i/2
                if glyphID then
                    Talents.db.profile[selectedInstance][selectedBoss].majGlyph[id] = glyphID
                else
                    Talents.db.profile[selectedInstance][selectedBoss].majGlyph[id] = 0
                end
            else
                local id = ((i+1)/2)
                if glyphID then
                    Talents.db.profile[selectedInstance][selectedBoss].minGlyph[id] = glyphID
                else
                    Talents.db.profile[selectedInstance][selectedBoss].minGlyph[id] = 0
                end
            end
        end
    end
    if (not talents) and (not glyphs) then
        for i=1,6 do
            Talents.db.profile[selectedInstance][selectedBoss].talent[i] = 0
            if i <= 3 then
                Talents.db.profile[selectedInstance][selectedBoss].minGlyph[i] = 0
                Talents.db.profile[selectedInstance][selectedBoss].majGlyph[i] = 0
            end
        end
    end
    bossTab:ReleaseChildren()
    SelectBossGroup(bossTab,nil,selectedBoss, true)
    --bossChecked[slctInstance][slctBoss][slctDiffic][activeSpec] = false
end


function Talents:SetupDialogs()
    StaticPopupDialogs["TC_WRONG_TALENTS"] = {
        text = "YugoMonk detected that your talents for %s aren't right. ",
        button1 = "I want to disable this message",
        button2 = "Thank you for the notification",
        OnAccept = function()
            Talents:Show()
            SelectInstanceGroup(zoneTree, nil, selectedInstance)
            SelectBossGroup(bossTab, nil, selectedBoss)
            bossTab:SelectTab(selectedBoss)
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3,
    }
    StaticPopupDialogs["TC_WRONG_GLYPHS"] = {
        text = "YugoMonk detected that your glyphs for %s aren't right.",
        button1 = "I want to disable this message",
        button2 = "Thank you for the notification",
        OnAccept = function()
            Talents:Show()
            SelectInstanceGroup(zoneTree, nil, selectedInstance)
            SelectBossGroup(bossTab, nil, selectedBoss)
            bossTab:SelectTab(selectedBoss)
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3,
    }
    StaticPopupDialogs["TC_WRONG_TALENTS_AND_GLYPHS"] = {
        text = "YugoMonk detected that your talents and glyphs for %s aren't right.",
        button1 = "I want to disable this message",
        button2 = "Thank you for the notification",
        OnAccept = function()
            Talents:Show()
            SelectInstanceGroup(zoneTree, nil, selectedInstance)
            SelectBossGroup(bossTab, nil, selectedBoss)
            bossTab:SelectTab(selectedBoss)
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3,
    }
    StaticPopupDialogs["TC_MISSING"] = {
        text = "YugoMonk detected that you haven't specified a build for %s.",
        button1 = "Yes, let me configure a build",
        button2 = "No thanks",
        OnAccept = function()
            Talents:Show()
            SelectInstanceGroup(zoneTree, nil, selectedInstance)
            SelectBossGroup(bossTab, nil, selectedBoss)
            bossTab:SelectTab(selectedBoss)
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3,
    }
    StaticPopupDialogs["TC_FIRST"] = {
        text = "This is the first time you're logging in with YugoMonkTalents enabled. Please use '/ymt config' to get to the configuration menu.",
        button1 = "Take me there",
        button2 = "Close",
        OnAccept = function()
            Talents:MakeGUI()
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = false,
        preferredIndex = 3,
    }
    StaticPopupDialogs["TC_NO_TALENTS"] = {
        text = "YugoMonk detected that you don't have 6 talents selected. Consider getting all the talents!",
        button1 = "Close",
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3,
    }
    StaticPopupDialogs["TC_DB_RESET"] = {
        text = string.format("YugoMonk: %s","Due to an update, the saved variables have been reset. Sorry for the inconvenience."),
        button1 = "Close",
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3,
    }

end




function Talents:PLAYER_TARGET_CHANGED()
    if not IsInInstance() then return end

    local targetId = "playertarget"
    local targetName = UnitName(targetId)
    if targetName == nil then
        return
    end

    local instanceCount, instance = Talents:GetInstanceByMapName(mapName)
    if instance ~= nil then
        local mobid = tonumber(UnitGUID(targetId):sub(-13, -9), 16)
        if LibStub("LibBossIDsYugoEdit-1.0").BossIDs[mobid] then
            if instance.bosses_by_id[mobid] ~= nil then
                Talents:CheckTalents(instanceCount, mobid)
            end

        end
    end

end


function Talents:ZONE_CHANGED_NEW_AREA()
    if not IsInInstance() then return end
    mapName = Talents:GetMapName()
end
end