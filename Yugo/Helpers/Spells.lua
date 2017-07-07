local Yugo = LibStub('AceAddon-3.0'):GetAddon('Yugo')
Spells = Yugo:NewModule("Spells");
local Spells = Spells


Spells.registerEvents = {
    'GLYPH_UPDATED',
    'PLAYER_TALENT_UPDATE'
}
Spells.spells = {
    ['Guard'] = 115295,
    ['Power Guard'] = 118636,
    ['Purifying Brew'] = 115295,
    ["Stagger"] = { 124255, 124275, 124274, 124273 },
    ["Shuffle"] = 115307,
    ["Elusive Brew"] = 128939,
    ["Elusive Brew activated"] = 115308,
}

local spells = {
    ['Guard'] = {
        id = 115295,
        name = GetSpellInfo(115295),
        type = 'spell',
        icon = 'Guard', -- Got our own icon for this
        --icon = select(3, GetSpellInfo(115295)),
        modifiedByTalent = false,
        replacedByGlyph = {
            id = 123402,
            glyph = 998,
            icon = 'Guard'
        }
    },
    ['Purifying Brew'] = {
        name = GetSpellInfo(115295),
        type = 'spell',
        icon = select(3, GetSpellInfo(115295)),
        id = 115295,
        replacedByTalent = false,
        modifiedByTalent = false,
        replacedByGlyph = false,
        modifiedByAura = false
    },
    ['Transcendence'] = {
        name = GetSpellInfo(101643),
        type = 'spell',
        icon = select(3, GetSpellInfo(101643)),
        id = 101643,
        replacedByTalent = false,
        modifiedByTalent = false,
        replacedByGlyph = false,
        modifiedByAura = false
    },
    ['Transcendence: Transfer'] = {
        name = GetSpellInfo(119996),
        type = 'spell',
        icon = select(3, GetSpellInfo(119996)),
        id = 119996,
        replacedByTalent = false,
        modifiedByTalent = false,
        replacedByGlyph = false,
        modifiedByAura = false

    },
    ['Power Guard'] = {
        name = GetSpellInfo(118636),
        type = 'spell',
        icon = select(3, GetSpellInfo(118636)),
        id = 118636,
        replacedByTalent = false,
        modifiedByTalent = false,
        replacedByGlyph = false,
        modifiedByAura = false
    },
    ['Vengeance'] = {
        name = GetSpellInfo(132365),
        type = 'spell',
        icon = select(3, GetSpellInfo(132365)),
        id = 132365,
        replacedByTalent = false,
        modifiedByTalent = false,
        replacedByGlyph = false,
        modifiedByAura = false
    },
    ['Elusive Brew'] = {
        name = GetSpellInfo(128939),
        type = 'spell',
        icon = select(3, GetSpellInfo(128939)),
        id = 128939,
        replacedByTalent = false,
        modifiedByTalent = false,
        replacedByGlyph = false,
        modifiedByAura = false
    },

}

function Spells:Get(name)
    return spells[name]
end

-- Returns spell ID based on my name
function Spells:ID(name)
    return Spells.spells[name]
end

function Spells:ID_Name(id)
    for k, v in pairs(Spells.spells) do
        if v == id then
            return k
        end
    end
    return nil
end

-- Returns localized name based on my name
function Spells:Name(name)
    return spells[name].name
end

function Spells:Matches(spell, name)
    for k, v in pairs(Spells.spells[name]) do
        if v == spell then
            return true
        end
    end
    return false
end

function Spells:OnModuleInitialization()
end

function Spells:OnModuleEnable()
    Spells:CheckTalentsGlyphsItems()
end

function Spells:OnModuleDisable()

end
function Spells:CheckTalentsGlyphsItems()
    for socket = 1, GetNumGlyphSockets() do

        local glyphId = select(3, Yugo:Hyperlink(GetGlyphLink(socket)))

        if glyphId then
            glyphId = tonumber(glyphId)

            for name, spell in pairs(spells) do
                if type(spell.replacedByGlyph) == 'table' then
                    if spell.replacedByGlyph.glyph == tonumber(glyphId) then
                        Spells.spells[name] = spell.replacedByGlyph.id
                    else
                        Spells.spells[name] = spell.id
                    end
                end
            end

        end

    end

    for talent = 1, GetNumTalents() do
        --local name, iconTexture, tier, column, using, maxRank, isExceptional, meetsPrereq, previewRank, meetsPreviewPrereq = GetTalentInfo(talent)
        -- print(name, using)
    end
end
function Spells:GLYPH_UPDATED()
    Spells:CheckTalentsGlyphsItems()
end

function Spells:PLAYER_TALENT_UPDATE()
    Spells:CheckTalentsGlyphsItems()
end