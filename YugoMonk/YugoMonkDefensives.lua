if select(2, UnitClass("player")) == 'MONK' then
local Yugo = LibStub("AceAddon-3.0"):GetAddon("Yugo")
local YugoMedia = YugoMedia
local YugoMonk = LibStub("AceAddon-3.0"):GetAddon("YugoMonk")
local Defensives = YugoMonk:NewModule('Defensives')


YugoMedia:Add('background', "Dampen Harm", [[Interface\Addons\YugoMonk\textures\dampenharm.blp]])
YugoMedia:Add('background', "Diffuse Magic", [[Interface\Addons\YugoMonk\textures\diffuse.blp]])

YugoMedia:Add('background', "Fortifying Brew", [[Interface\Addons\YugoMonk\textures\fortbrew.blp]])
YugoMedia:Add('background', "Zen Meditation", [[Interface\Addons\YugoMonk\textures\zenmedi.blp]])
YugoMedia:Add('background', "Avert Harm", [[Interface\Addons\YugoMonk\textures\avert.blp]])

local cooldowns = {
    ["Fortifying Brew"] = {
        name = GetSpellInfo(115203),
        type = 'spell',
        icon = 'Fortifying Brew',
        id = 115203,
        aura = 120954,
        duration = 20,
        color = { r = 1, g = 1, b = 0, a = 0.3 },
        globalCooldown = false,
    },
    ['Zen Meditation'] = {
        name = GetSpellInfo(115176),
        type = 'spell',
        icon = 'Zen Meditation',
        id = 115176,
        aura = 115176,
        duration = 8,
        color = { r = 0.31, g = 1, b = 0.76, a = 0.3 },
        globalCooldown = false,
    },
    ['Avert Harm'] = {
        name = GetSpellInfo(115213),
        type = 'spell',
        icon = 'Avert Harm',
        id = 115213,
        aura = 115213,
        duration = 6,
        color = { r = 1, g = 0.4, b = 0.14, a = 0.3 },
        globalCooldown = false,
    },
    ["Talents75"] = {
        name = "Dampen Harm / Diffuse Magic",
        type = 'talents',
        talents = {
            {
                name = GetSpellInfo(122278),
                tier = 5,
                column = 2,
                icon = 'Dampen Harm',
                id = 122278,
                aura = 122278,
                duration = 45,
                globalCooldown = false,
                color = { r = 1, g = 0.16, b = 0, a = 0.3 },
            },
            {
                name = GetSpellInfo(122783),
                tier = 5,
                column = 3,
                icon = 'Diffuse Magic',
                id = 122783,
                aura = 122783,
                duration = 6,
                globalCooldown = false,
                color = { r = 1, g = 0.16, b = 0, a = 0.3 },
            },
        },
    }
}


Defensives.optionsDB = {

}

-- Container frame
Defensives.CD = Frame('YM_DefensivesContainer')
local CD = Defensives.CD
CD.register_as_anchor('Defensive cooldowns')
CD.set_apply({
    background = {
        insets = { r = 0, l = 0, b = 0, t = 0 },
        color = { a = 0, b = 1 },
        texture = 'Solid',
    },
    border = {
        size = 0,
        texture = 0
    },
    width = 120,
    height = 100,
    moveable = false,
})
CD.clear_anchors()
CD.add_anchor({
    this = 'BOTTOM',
    that = 'TOP',
    to = 'YM_Chis',
    x = 0,
    y = 5
})
Defensives.optionsDB.frame = CD.get()

-- Cooldowns in container
Defensives.CDS = {}
local CDS = Defensives.CDS
local cdCount = 1
local cdWidth = CD.config.width / 4
for cdName, cdData in pairs(cooldowns) do
    CDS[cdName] = CooldownWidget('YM_CD_' .. cdName, cdData)
    CDS[cdName].clear_anchors()
    CDS[cdName].add_anchor({
        this = 'BOTTOMLEFT',
        that = 'BOTTOMLEFT',
        to = 'YM_DefensivesContainer',
        x = (cdWidth * cdCount) - cdWidth,
        y = 0
    })
    CDS[cdName].set({
        width = cdWidth,
        height = CD.config.height,
        parent = 'YM_DefensivesContainer'
    })
    CDS[cdName].apply()
    cdCount = cdCount + 1
    Defensives.optionsDB[cdName] = {
        statusbar = CDS[cdName].content.statusbar.get(),
        cooldown = CDS[cdName].content.icon.content.cooldown.get()
    }
end


local function re()
    Defensives:SetDisplayOptions()
end

Defensives.options = {
    name = "Defensive Cooldowns",
    type = 'group',
    args = {
        enabled = {
            order = 0,
            name = 'Enabled',
            disabled = true,
            hidden = true,
            type = 'toggle',
            width = 'full',
            get = function() return
                Defensives.db.profile.enabled
            end,
            set = function(self, key)
                Defensives.db.profile.enabled = key

                if key == true then
                    Defensives:Enable()
                else
                    Defensives:Disable()
                end
            end
        },
        frame = {
            order = 10,
            name = 'Frame',
            type = 'group',
            childGroups = 'tab',
            args = {}
        },
        cooldowns = {
            order = 20,
            name = 'Cooldowns',
            type = 'group',
            childGroups = 'select',
            args = {}
        }
    }
}



Defensives.registerMessages = {
    -- 'SetDisplayOptions'
}




function Defensives:OnModuleInitialize()


    CD.link_db(self.db.profile.frame)
    CD.enable_position_save()
    self.options.args.frame.args = CD.link_options(re, self.optionsDB.frame)

    CD.apply()
    for cdName, cdData in pairs(cooldowns) do

        CDS[cdName].content.statusbar.link_db(self.db.profile[cdName].statusbar)
        CDS[cdName].content.icon.content.cooldown.link_db(self.db.profile[cdName].cooldown)
        self.options.args.cooldowns.args[cdName] = {
            name = cdName,
            type = 'group',
            args = {
                statusbar = {
                    name = 'Progress bar',
                    type = 'group',
                    args = CDS[cdName].content.statusbar.get_bar_options(re)--, self.optionsDB[cdName].statusbar)
                },
                cooldown = {
                    name = 'Cooldown text',
                    type = 'group',
                    args = CDS[cdName].content.icon.content.cooldown.link_options(re, { 'position' })
                }
            }
        }
    end

    self:SetDisplayOptions()


    CD.set('enabled', false)
    for cdName, cdData in pairs(cooldowns) do
        CDS[cdName].set('enabled', false)
        CDS[cdName].set('statusbar', 'enabled', false)
        CDS[cdName].apply()
    end
    CD.apply()
end

function Defensives:OnModuleEnable()
    CD.set('enabled', true)
    CD.apply()
    for cdName, cdData in pairs(cooldowns) do
        CDS[cdName].set('enabled', true)
        CDS[cdName].set('statusbar', 'enabled', true)
        CDS[cdName].apply()
    end
end

function Defensives:OnModuleDisable()
    CD.set('enabled', false)
    CD.apply()
    for cdName, cdData in pairs(cooldowns) do
        CDS[cdName].set('enabled', false)
        CDS[cdName].set('statusbar', 'enabled', false)
        CDS[cdName].apply()
    end
end

function Defensives:SetDisplayOptions()
    CD.SetDisplayOptions()

    local cdCount = 1
    local cdWidth = CD.config.width / 4
    for cdName, cdData in pairs(cooldowns) do

        CDS[cdName].content.statusbar.SetDisplayOptions()
        CDS[cdName].content.icon.content.cooldown.SetDisplayOptions()
        CDS[cdName].clear_anchors()
        CDS[cdName].add_anchor({
            this = 'BOTTOMLEFT',
            that = 'BOTTOMLEFT',
            to = 'YM_DefensivesContainer',
            x = (cdWidth * cdCount) - cdWidth,
            y = 0
        })
        CDS[cdName].set({
            width = cdWidth,
            height = CD.config.height,
            parent = 'YM_DefensivesContainer',
            statusbar = CDS[cdName].content.statusbar.get(),
            icon = {
                cooldown = CDS[cdName].content.icon.content.cooldown.get()
            }
        })
        CDS[cdName].apply()
        cdCount = cdCount + 1
    end
end























end -- classcheck
