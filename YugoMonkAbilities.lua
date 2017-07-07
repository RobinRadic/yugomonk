if select(2, UnitClass("player")) == 'MONK' then
local Yugo = LibStub("AceAddon-3.0"):GetAddon("Yugo")
local YugoMedia = YugoMedia
local YugoMonk = LibStub("AceAddon-3.0"):GetAddon("YugoMonk")
local Abilities = YugoMonk:NewModule('Abilities')

YugoMedia:Add('background', "Keg Smash", [[Interface\Addons\YugoMonk\textures\brewery.blp]])
YugoMedia:Add('background', "Jab", [[Interface\Addons\YugoMonk\textures\jab.blp]])
YugoMedia:Add('background', "Chi Wave", [[Interface\Addons\YugoMonk\textures\chiwave.blp]])
YugoMedia:Add('background', "Expel Harm", [[Interface\Addons\YugoMonk\textures\expelharm.blp]])
YugoMedia:Add('background', "Tiger Palm", [[Interface\Addons\YugoMonk\textures\tigerpalm.blp]])
YugoMedia:Add('background', "Guard", [[Interface\Addons\YugoMonk\textures\guard.blp]])
YugoMedia:Add('background', "Elusive Brew", [[Interface\Addons\YugoMonk\textures\elusivebrew.blp]])
YugoMedia:Add('background', "Blackout Kick", [[Interface\Addons\YugoMonk\textures\blackoutkick.blp]])
YugoMedia:Add('background', "Chi Burst", [[Interface\Addons\YugoMonk\textures\chiburst.blp]])
YugoMedia:Add('background', "Zen Sphere", [[Interface\Addons\YugoMonk\textures\zensphere.blp]])
YugoMedia:Add('background', "Spinning Crane Kick", [[Interface\Addons\YugoMonk\textures\sck.blp]])
YugoMedia:Add('background', "Rushing Jade Wind", [[Interface\Addons\YugoMonk\textures\rjw.blp]])


local spells = {
    ["Keg Smash"] = {
        name = 'Keg Smash', -- Not needed for the SpellIconWidget, but for the options :)
        type = 'spell',
        icon = 'Keg Smash',
        id = 121253,
        aura = false,
        globalCooldown = true,
        replacedByTalent = false,
        modifiedByTalent = false,
        modifiedByGlyph = false

    },
    ['Jab'] = {
        name = 'Jab',
        type = 'spell',
        icon = 'Jab',
        id = 100780,
        aura = false,
        globalCooldown = true,
        replacedByTalent = false,
        modifiedByTalent = false,
        modifiedByGlyph = false
    },
    ['Blackout Kick'] = {
        name = 'Blackout Kick',
        type = 'spell',
        icon = 'Blackout Kick',
        id = 100784,
        aura = false,
        globalCooldown = true,
        replacedByTalent = false,
        modifiedByTalent = false,
        modifiedByGlyph = false
    },
    ['Expel Harm'] = {
        name = 'Expel Harm',
        type = 'spell',
        icon = 'Expel Harm',
        id = 115072,
        aura = false,
        globalCooldown = true,
        replacedByTalent = false,
        modifiedByTalent = false,
        modifiedByGlyph = false
    },
    ["Tiger Palm"] = {
        name = 'Tiger Palm',
        type = 'spell',
        icon = 'Tiger Palm',
        id = 100787,
        aura = 125359,
        replacedByTalent = false,
        modifiedByTalent = false,
        modifiedByGlyph = false,
        globalCooldown = true
    },
    ["Talents30"] = {
        name = "Chi Wave / Zen Sphere / Chi Burst",
        type = 'talents',
        talents = {
            {
                name = 'Chi Wave',
                tier = 2,
                column = 1,
                icon = 'Chi Wave',
                id = 115098,
                modifiedByTalent = false,
                replacedByTalent = false,
                modifiedByGlyph = false,
                globalCooldown = true,
                aura = false,
            },
            {
                name = 'Zen Sphere',
                tier = 2,
                column = 2,
                icon = 'Zen Sphere',
                id = 124081,
                modifiedByTalent = false,
                replacedByTalent = false,
                modifiedByGlyph = false,
                globalCooldown = true,
                aura = 124081,
            },
            {
                name = 'Chi Burst',
                tier = 2,
                column = 3,
                icon = 'Chi Burst',
                id = 123986,
                modifiedByTalent = false,
                replacedByTalent = false,
                modifiedByGlyph = false,
                globalCooldown = true,
                aura = false,
            }
        },
    },
    ["Spinning Crane Kick"] = {
        name = 'Spinning Crane Kick / Rushing Jade Wind',
        type = 'spell',
        icon = 'Spinning Crane Kick',
        id = 107270,-- chiwave: 115098, --115072, -- Expel harm --
        replacedByTalent = {
            tier = 6,
            column = 1,
            id = 116847,
            icon = 'Rushing Jade Wind',
            aura = false
        },
        modifiedByTalent = false,
        modifiedByGlyph = false,
        globalCooldown = true,
        aura = false
    },
    ["None"] = {
        name = 'None'
    }
}
local slots = { 'First', 'Second', 'Third', 'Fourth', 'Fifth', 'Sixth' }
local slotData = {
    ['First'] = 'Tiger Palm',
    ['Second'] = 'Jab',
    ['Third'] = 'Keg Smash',
    ['Fourth'] = 'Expel Harm',
    ['Fifth'] = 'Talents30',
    ['Sixth'] = 'Spinning Crane Kick'
}
local fontFlags = {
    ['Outline'] = 'OUTLINE',
    ['Thick outlined'] = 'THICKOUTLINE',
    ['None'] = 'None'
}
local slotValues = {}
for spellName, spellData in pairs(spells) do
    slotValues[spellName] = spellData.name
end


local ABC = Frame('YM_Abilities')
ABC.register_as_anchor('Abilities')
ABC.set({
    moveable = true,
    save_moved_position = true,
    width = 240,
    height = 41
})

local AB = {}


local function re()
    Abilities:SetDisplayOptions()
end

local function AddTextOption(optionName, orderNumber)

    Abilities.options.args.globalDisplay.args[optionName .. 'Header'] = {
        order = orderNumber + 1,
        type = 'header',
        name = optionName,
    }
    Abilities.options.args.globalDisplay.args[optionName .. 'OE'] = {
        order = orderNumber + 2,
        type = 'toggle',
        name = 'Enable overide',
        width = 'full',
        get = function()
            return toboolean(Abilities.db.profile.overides[optionName .. 'OE'])
        end,
        set = function(self,key)
            Abilities.db.profile.overides[optionName .. 'OE'] = key
            re()
        end
    }
    Abilities.options.args.globalDisplay.args[optionName .. 'Font'] = {
        order = orderNumber + 3,
        type = 'select',
        dialogControl = 'LSM30_Font',
        name = 'Font',
        values = AceGUIWidgetLSMlists.font,
        get = function()
            return Abilities.db.profile.overides[optionName .. 'O'].font
        end,
        set = function(self,key)
            Abilities.db.profile.overides[optionName .. 'O'].font = key
            re()
        end
    }
    Abilities.options.args.globalDisplay.args[optionName .. 'FontSize'] = {
        order = orderNumber + 4,
        type = 'range',
        name = 'Font size',
        min = 8,
        max = 30,
        step = 1,
        get = function()
            return Abilities.db.profile.overides[optionName .. 'O'].size
        end,
        set = function(self,key)
            Abilities.db.profile.overides[optionName .. 'O'].size = key
            re()
        end
    }
    Abilities.options.args.globalDisplay.args[optionName .. 'FontColor'] = {
        order = orderNumber + 5,
        name = 'Color',
        type = 'color',
        width = 'half',
        hasAlpha = true,
        desc = 'The color of text',
        get = function()
            local c = Abilities.db.profile.overides[optionName .. 'O'].color
            return c.r, c.g, c.b, c.a
        end,
        set = function(self,r,g,b,a)
            Abilities.db.profile.overides[optionName .. 'O'].color = { r = r, g = g, b = b, a = a }
            re()
        end
    }
    Abilities.options.args.globalDisplay.args[optionName .. 'FontFlag'] = {
        order = orderNumber + 6,
        name = 'Flags',
        type = 'select',
        desc = 'Outline this or what',
        values = fontFlags,
        get = function()
            return Abilities.db.profile.overides[optionName .. 'O'].flags
        end,
        set = function(self, key)
            Abilities.db.profile.overides[optionName .. 'O'].flags = key
            re()
        end
    }

end
Abilities.options = {
    name = "Abilities",
    type = 'group',
    args = {
        test = {
            type = 'execute',
            name = 'test',
            func = function()
                show_table(AB['First'])
            end
        },
        enabled = {
            order = 0,
            disabled = true,
            hidden = true,
            name = 'Enabled',
            type = 'toggle',
            width = 'full',
            get = function() return
                Abilities.db.profile.enabled
            end,
            set = function(self, key)
                Abilities.db.profile.enabled = key

                if key == true then
                    Abilities:Enable()
                else
                    Abilities:Disable()
                end
            end
        },
        globalDisplay = {
            type = 'group',
            inline = true,
            name = 'Global display override',
            args = {
                desc = {
                    order = 1,
                    name = [[Instead of defining all these options for every ability slot individually, you can also use these global overide options that control all of the display settings. Just click the 'Enable overide' checkbox and adjust the settings.
                    ]],
                    type = 'description'
                },
                range = {
                    order = 2,
                    name = 'Range check',
                    type = 'header'
                },
                rangeOE = {
                    order = 5,
                    name = 'Enable overide',
                    type = 'toggle',
                    set = function(self, key) Abilities.db.profile.overides.rangeOE = key; re() end,
                    get = function() return Abilities.db.profile.overides.rangeOE end
                },
                rangeO = {
                    order = 9,
                    name = 'Enable range check',
                    type = 'toggle',
                    set = function(self, key) Abilities.db.profile.overides.rangeO = key; re() end,
                    get = function() return Abilities.db.profile.overides.rangeO end
                },

                spacing1 = {
                    order = 10,
                    name = [[

                    ]],
                    type = 'description'
                },
                gcd = {
                    order = 11,
                    name = 'Global Cooldown',
                    type = 'header'
                },
                gcdOE = {
                    order = 15,
                    name = 'Enable overide',
                    type = 'toggle',
                    set = function(self, key) Abilities.db.profile.overides.gcdOE = key; re() end,
                    get = function() return Abilities.db.profile.overides.gcdOE end
                },
                gcdO = {
                    order = 18,
                    name = 'Enable global cooldown',
                    type = 'toggle',
                    width = 'double',
                    set = function(self, key) Abilities.db.profile.overides.gcdO = key; re() end,
                    get = function() return Abilities.db.profile.overides.gcdO end
                },

                spacing2 = {
                    order = 20,
                    name = [[

                    ]],
                    type = 'description'
                },

            }
        },
        assignments = {
            name = 'Assignments',
            type = 'group',
            args = {}
        },
        display = {
            type = 'group',
            name = 'Display',
            childGroups = 'select',
            args = {}
        }
    }
}
AddTextOption('aura', 400)
AddTextOption('energy', 500)
AddTextOption('cooldown', 600)

Abilities.optionsDB = {

    display = {},
    assignments = {},
    overides = {
        -- OE = Overide Enabled, O = Overides settings
        rangeOE = false,
        rangeO = true,
        gcdOE = false,
        gcdO = true,

        auraOE = false,
        auraO = {
            font = 'Yugo',
            size = 16,
            color = { r = 0, b = 0, g = 0, a = 1 },
            flags = 'None'
        },

        energyOE = false,
        energyO = {
            font = 'Yugo',
            size = 16,
            color = { r = 0, b = 0, g = 0, a = 1 },
            flags = 'None'
        },

        cooldownOE = false,
        cooldownO = {
            font = 'Yugo',
            size = 16,
            color = { r = 0, b = 0, g = 0, a = 1 },
            flags = 'None'
        },
    },
    frame = ABC.get()
}


Abilities.registerMessages = {
   -- 'SetDisplayOptions'
}

local function AddTextOptions(slotName, keyName, slotKey)
    Abilities.options.args.display.args[slotName].args[keyName] = {
    order = slotKey + 1,
    type = 'header',
    name = keyName
    }
    Abilities.options.args.display.args[slotName].args[keyName .. 'Toggle'] = {
        order = slotKey + 2,
        type = 'toggle',
        name = 'Enabled',
        width = 'full',
        desc = 'Enable this if this ability',
        --width = 'full',
        get = function()
            return toboolean(Abilities.db.profile.display[slotName][keyName].enabled)
        end,
        set = function(self,key)
            Abilities.db.profile.display[slotName][keyName].enabled = key
            re()
        end
    }
    Abilities.options.args.display.args[slotName].args[keyName .. 'Font'] = {
        order = slotKey + 3,
        type = 'select',
        dialogControl = 'LSM30_Font',
        name = 'Font',
        values = AceGUIWidgetLSMlists.font,
        get = function()
            return Abilities.db.profile.display[slotName][keyName].font
        end,
        set = function(self,key)
            Abilities.db.profile.display[slotName][keyName].font = key
            re()
        end
    }
    Abilities.options.args.display.args[slotName].args[keyName .. 'FontSize'] = {
        order = slotKey + 4,
        type = 'range',
        name = 'Font size',
        min = 8,
        max = 30,
        step = 1,
        get = function()
            return Abilities.db.profile.display[slotName][keyName].size
        end,
        set = function(self,key)
            Abilities.db.profile.display[slotName][keyName].size = key
            re()
        end
    }
    Abilities.options.args.display.args[slotName].args[keyName .. 'FontColor'] = {
        order = slotKey + 5,
        name = 'Color',
        type = 'color',
        width = 'half',
        hasAlpha = true,
        desc = 'The color of text',
        get = function()
            local c = Abilities.db.profile.display[slotName][keyName].color
            return c.r, c.g, c.b, c.a
        end,
        set = function(self,r,g,b,a)
            Abilities.db.profile.display[slotName][keyName].color = { r = r, g = g, b = b, a = a }
            re()
        end
    }
    Abilities.options.args.display.args[slotName].args[keyName .. 'FontFlag'] = {
        order = slotKey + 6,
        name = 'Flags',
        type = 'select',
        desc = 'Outline this or what',
        values = fontFlags,
        get = function()
            return Abilities.db.profile.display[slotName][keyName].flags
        end,
        set = function(self, key)
            Abilities.db.profile.display[slotName][keyName].flags = key
            re()
        end
    }
end

local function AddAbilities()
    for slotKey, slotName in pairs(slots) do
        Abilities.optionsDB.assignments[slotName] = slotData[slotName]
        Abilities.options.args.assignments.args[slotName] = {
            name = slotName,
            type = 'select',
            width = 'full',
            order = (slotKey * slotKey) + 11,
            values = slotValues,
            get = function() return Abilities.db.profile.assignments[slotName] end,
            set = function(self, key) Abilities.db.profile.assignments[slotName] = key; re() end
        }
        Abilities.optionsDB.display[slotName] = {
            Aura = {
                enabled = true,
                font = 'YugoWolf',
                size = 30,
                color = { r = 0.9, b = 0.3, g = 1, a = 1 },
                flags = 'OUTLINE'
            },
            range = true,
            globalCooldown = true,
            Cooldown = {
                enabled = true,
                font = 'Yugo',
                size = 22,
                color = { r = 1, b = 1, g = 1, a = 1 },
                flags = 'None'
            },
            Energy = {
                enabled = true,
                font = 'Yugo',
                size = 19,
                color = { r = 1, b = 0.2, g = 0.2, a = 1 },
                flags = 'OUTLINE'
            }
        }
        Abilities.options.args.display.args[slotName] = {
            name = slotName,
            type = 'group',
            order = slotKey,
            args = {
                header = {
                    order = 1,
                    name = slotName,
                    type = 'header'
                },
                range = {
                    order = 10,
                    type = 'toggle',
                    name = 'Range check',
                    width = 'full',
                    desc = 'Enable this if this ability is a melee ability',
                    --width = 'full',
                    get = function()
                        return toboolean(Abilities.db.profile.display[slotName].range)
                    end,
                    set = function(self,key)
                        Abilities.db.profile.display[slotName].range = key
                        re()
                    end

                },
                globalCooldown = {
                    order = 20,
                    type = 'toggle',
                    name = 'Global Cooldown',
                    width = 'full',
                    desc = 'Enable this if this ability is a melee ability',
                    --width = 'full',
                    get = function()
                        return toboolean(Abilities.db.profile.display[slotName].globalCooldown)
                    end,
                    set = function(self,key)
                        Abilities.db.profile.display[slotName].globalCooldown = key
                        re()
                    end
                }
            }
        }
        AddTextOptions(slotName, 'Aura', slotKey + 100)
        AddTextOptions(slotName, 'Energy', slotKey + 100 * 2)
        AddTextOptions(slotName, 'Cooldown', slotKey + 100 * 3)

    end

end
AddAbilities()


function Abilities:OnModuleInitialize()

    ABC.link_db(Abilities.db.profile.frame)
    ABC.enable_position_save()

    ABC.SetDisplayOptions()

    local activeAbilitys = 0
    for k, slotName in pairs(slots) do
        local ability = AB[slotName]
        local spellName = Abilities.db.profile.assignments[slotName]
        if spellName ~= 'None' then
            activeAbilitys = activeAbilitys + 1
        end
    end

    local childWidth = Abilities.db.profile.frame.width / activeAbilitys
    local childHeight = Abilities.db.profile.frame.height

    ABC.set({
        height = childHeight + (ABC.config.background.insets.b * 3),
        width = Abilities.db.profile.frame.width + ((ABC.config.background.insets.l + 2) * 2)
    })
    ABC.set('enabled', false)
    ABC.apply()

    Abilities.options.args.frame = {
        name = 'Frame',
        type = 'group',
        childGroups = 'tab',
        args = ABC.link_options(re, Abilities.optionsDB.frame)
    }

    for count, slotName in pairs(slots) do
        local spellName = slotData[slotName]
        local spellData = spells[spellName]
        AB[slotName] = SpellIconWidget('YM_Abilities' .. count, spellData)
        AB[slotName].set({
            parent = 'YM_Abilities',
            moveable = false,
            level = 2,
        })
        AB[slotName].apply()
    end

end

function Abilities:OnModuleEnable()



    ABC.set('enabled', true)
    ABC.apply()
    Abilities:SetDisplayOptions()
end

function Abilities:OnModuleDisable()
    ABC.set('enabled', false)
    for k, slotName in pairs(slots) do
        AB[slotName].set('enabled', false)
        AB[slotName].apply()
    end
    ABC.apply()
end

function Abilities:SetDisplayOptions()

    local texts = { 'Aura', 'Energy', 'Cooldown' }

    local activeAbilitys = 0
    for k, slotName in pairs(slots) do
        local ability = AB[slotName]
        local spellName = Abilities.db.profile.assignments[slotName]
        if spellName ~= 'None' then
            activeAbilitys = activeAbilitys + 1
        end
    end

    local childWidth = Abilities.db.profile.frame.width / activeAbilitys
    local childHeight = Abilities.db.profile.frame.height

    local count = 1
    for k, slotName in pairs(slots) do
        local ability = AB[slotName]
        local spellName = Abilities.db.profile.assignments[slotName]
        local display = Abilities.db.profile.display[slotName]

        if spellName == 'None' then
            ability.set('enabled', false)
        else
            ability.set('enabled', true)
            ability.clear_anchors()

            ability.add_anchor({
                this = 'TOPLEFT',
                that = 'TOPLEFT',
                to = 'YM_Abilities',
                x = ((childWidth * count) - childWidth) + (ABC.config.background.insets.l + 2),
                y = math.reverse(ABC.config.background.insets.b + 2)
            })
            ability.set({
                width = childWidth,
                height = childHeight,
                display = {
                    aura = display.Aura.enabled,
                    range = display.range,
                    globalCooldown = display.globalCooldown,
                    cooldown = display.Cooldown.enabled,
                    energy = display.Energy.enabled
                },
                cooldown = display.Cooldown,
                aura = display.Aura,
                energy = display.Energy,
            })
            ability.setSpellData(spells[spellName])

            -- Now for the global overides

            local o = Abilities.db.profile.overides
            local ov = {}
            ov.display = {
                aura = true,
                range = true,
                globalCooldown = true,
                cooldown = true,
                energy = true
            }
            if o.rangeOE == true then ov.display.range = o.rangeO end
            if o.gcdOE == true then ov.display.globalCooldown = o.gcdO end
            if o.auraOE == true then ov.aura = o.auraO end
            if o.energyOE == true then ov.energy = o.energyO end
            if o.cooldownOE == true then ov.cooldown = o.cooldownO end
            ability.set(ov)




            count = count + 1
        end
        ability.apply()
    end
    ABC.SetDisplayOptions()
    ABC.set({
        height = childHeight + (ABC.config.background.insets.b * 3),
        width = Abilities.db.profile.frame.width + ((ABC.config.background.insets.l + 2) * 2)
    })
    ABC.apply()
end

end
