Yugo = LibStub("AceAddon-3.0"):NewAddon("Yugo", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0" );
Yugo:SetDefaultModuleLibraries("AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0")
local prototype = {
    OnInitialize = function (self)
        if type(self.OnModuleInitialize) == "function" then
            self:OnModuleInitialize()
        end

        --self:Print('Loaded')
    end,

    OnEnable = function(self)
        if type(self.registerEvents) == 'table' then
            for k, v in pairs(self.registerEvents) do
                if type(k) == 'string' then
                    self:RegisterEvent(k, v)
                else
                    self:RegisterEvent(v)
                end
            end
        end

        if type(self.registerMessages) == 'table' then
            for k, v in pairs(self.registerMessages) do
                if type(k) == 'string' then
                    self:RegisterMessage(k, v)
                else
                    self:RegisterMessage(v)
                end
            end
        end

        if type(self.OnModuleEnable) == "function" then
            self:OnModuleEnable()
        end
        --self:Print('Enabled')
    end,

    OnDisable = function(self)
        if type(self.registerEvents) == 'table' then
            for k, v in pairs(self.registerEvents) do
                self:UnregisterEvent(v)
            end
        end

        if type(self.registerMessages) == 'table' then
            for k, v in pairs(self.registerMessages) do
                self:UnregisterMessage(v)
            end
        end
        if type(self.OnModuleDisable) == "function" then
            self:OnModuleDisable()
        end
        --self:Print('Disabled')
    end,
}
Yugo:SetDefaultModulePrototype(prototype)



local Yugo = Yugo
local YugoMedia = YugoMedia

local aGUI = LibStub("AceGUI-3.0")
local LSM = LibStub("LibSharedMedia-3.0")

Yugo.SML = LSM
Yugo.Art = {}

YugoMedia:Register("font", "Yugo", "Interface\\Addons\\Yugo\\fonts\\YugoFont.ttf")
YugoMedia:Register("font", "YugoBara", "Interface\\Addons\\Yugo\\fonts\\YugoBara.ttf")
YugoMedia:Register("font", "YugoDreams", "Interface\\Addons\\Yugo\\fonts\\YugoDreams.ttf")
YugoMedia:Register("font", "YugoLix", "Interface\\Addons\\Yugo\\fonts\\YugoLix.ttf")
YugoMedia:Register("font", "YugoNaga", "Interface\\Addons\\Yugo\\fonts\\YugoNaga.ttf")
YugoMedia:Register("font", "YugoWolf", "Interface\\Addons\\Yugo\\fonts\\YugoWolf.ttf")

YugoMedia:Register("border", "Yugo", [[Interface\Addons\Yugo\textures\YugoBorderGrained.blp]])
YugoMedia:Register("border", "YugoChi", [[Interface\Addons\Yugo\textures\YugoBorderGradient.tga]])

YugoMedia:Register("statusbar", "YugoGlossy", [[Interface\Addons\Yugo\textures\YugoGlossy.blp]])
YugoMedia:Register("statusbar", "YugoGlossyOil", [[Interface\Addons\Yugo\textures\YugoGlossyOil.blp]])
YugoMedia:Register("statusbar", "YugoGlossyTwo", [[Interface\Addons\Yugo\textures\YugoGlossyTwo.blp]])
YugoMedia:Register("statusbar", "YugoPlastic", [[Interface\Addons\Yugo\textures\YugoPlastic.blp]])
YugoMedia:Register("statusbar", "YugoFlat", [[Interface\Addons\Yugo\textures\YugoFlat.blp]])

YugoMedia:Register("sound", "Blizzard: Alarm Clock 1",    "Sound\\Interface\\AlarmClockWarning1.wav")
YugoMedia:Register("sound", "Blizzard: Alarm Clock 2",    "Sound\\Interface\\AlarmClockWarning2.wav")
YugoMedia:Register("sound", "Blizzard: Alarm Clock 3",    "Sound\\Interface\\AlarmClockWarning3.wav")
YugoMedia:Register("sound", "Blizzard: Bell - Alliance",  "Sound\\Doodad\\BellTollAlliance.wav")
YugoMedia:Register("sound", "Blizzard: Bell - Horde",     "Sound\\Doodad\\BellTollHorde.wav")
YugoMedia:Register("sound", "Blizzard: Bell - Night Elf", "Sound\\Doodad\\BellTollNightElf.wav")
YugoMedia:Register("sound", "Blizzard: Drum Hit",         "Sound\\Doodad\\BellTollTribal.wav")
YugoMedia:Register("sound", "Blizzard: Gong - Troll",     "Sound\\Doodad\\G_GongTroll01.wav")
YugoMedia:Register("sound", "Blizzard: Karazhan Bell",    "Sound\\Doodad\\KharazahnBellToll.wav")
YugoMedia:Register("sound", "Blizzard: Mellow Bells",     "Sound\\Spells\\ShaysBell.wav")

YugoMedia:Register("sound",	    "Blizzard: Big Bad Wolf", 		"Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav")
YugoMedia:Register("sound", 	"Blizzard: Murderous Rampage", 	"Sound\\Character\\Gnome\\GnomeVocalFemale\\GnomeFemalePissed01.wav")
YugoMedia:Register("sound", 	"Blizzard: Karazhan Bell", 		"Sound\\Doodad\\KharazahnBellToll.wav")
YugoMedia:Register("sound", 	"Blizzard: Fireworks", 			"Sound\\Doodad\\G_FireworkLauncher02Custom0.wav")
YugoMedia:Register("sound", 	"Blizzard: Springs", 				"Sound\\Doodad\\Goblin_Lottery_Open03.wav")
YugoMedia:Register("sound", 	"Blizzard: Troll Drums", 			"Sound\\Doodad\\TrollDrumLoop1.wav")
YugoMedia:Register("sound", 	"Blizzard: Ogre Drums", 			"Sound\\Event Sounds\\Event_wardrum_ogre.wav")

Yugo.frameOptions = {
    points = {
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
    strata = {
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
    frames = {
        ['UIParent'] = 'Screen (UIParent)'
    }
}

function Yugo:OnInitialize()
    --self:Print("Loaded")

end

function Yugo:OnEnable()
end

---------------------------------------------------
---------------------- HELPERS
-------------
-------------------------------------------------------------------------------------------------------- Yugo:FetchArt
function Yugo:FetchArt(art,artType)
	if not art then return nil end
	if art == "None" then
		return nil
    end

    if Yugo.Art[art] then
        return Yugo.Art[art]
    elseif LSM and LSM.Fetch and LSM:Fetch("border",art,true) and artType == "border" then
		return LSM:Fetch("border",art,true)
	elseif LSM and LSM.Fetch and LSM:Fetch("background",art,true) and artType == "background" then
		return LSM:Fetch("background",art,true)
    else
        return nil
    end
end

-------------------------------------------------------------------------------------------------------- Yugo:AddArt
function Yugo:AddArt(name, path)
	Yugo.Art[name] = path
end



-------------------------------------------------------------------------------------------------------- Yugo:CalculateBarPercentage
function Yugo:CalculateBarPercentage(currentValue, maxValue, maxBarValue)
	if maxBarValue == nil then
		return currentValue * 100 / maxValue
	else
		return (currentValue * 100 / maxValue) * (maxBarValue / 100)
	end
end

function Yugo:link_frame_options(f, re, defaults, disabled)
    local anchors = {}
    for k, v in pairs(f.anchors) do
        anchors['anchor' .. k] = {
            name = 'Anchor ' .. k,
            type = 'group',
            args = {
                this = {
                    order = 40,
                    name = 'Set my',
                    type = 'select',
                    width = 'full',
                    values = Yugo.frameOptions.points,
                    get = function() return f.anchors[k].this end,
                    set = function(self, key) f.anchors[k].this = key; re() end
                },
                that = {
                    order = 50,
                    name = 'To the other frame his',
                    type = 'select',
                    width = 'full',
                    values = Yugo.frameOptions.points,
                    get = function() return f.anchors[k].that end,
                    set = function(self, key) f.anchors[k].that = key; re() end
                },
                to = {
                    order = 60,
                    name = 'Other frame',
                    type = 'select',
                    width = 'full',
                    values = Yugo.frameOptions.frames,
                    get = function() return f.anchors[k].to end,
                    set = function(self, key) f.anchors[k].to = key; re() end
                },
                x = {
                    order = 70,
                    name = 'Adjust horizontal position',
                    type = 'range',
                    min = -500,
                    max = 500,
                    step = 1,
                    get = function() return f.anchors[k].x end,
                    set = function(self,key) f.anchors[k].x = key; re() end
                },
                y = {
                    order = 80,
                    name = 'Adjust vertical position',
                    type = 'range',
                    min = -500,
                    max = 500,
                    step = 1,
                    get = function() return f.anchors[k].y end,
                    set = function(self,key) f.anchors[k].y = key; re() end
                }
            }
        }
    end
    local options = {
        general = {
            order = 10,
            name = 'General',
            type = 'group',
            args = {
                enabled = {
                    order = 10,
                    name = 'Enabled',
                    width = 'full',
                    desc = 'Enable or disable this frame',
                    type = 'toggle',
                    get = function() return f.enabled end,
                    set = function(self, key) f.enabled = key; re() end
                },
                show_ooc = {
                    order = 25,
                    width = 'full',
                    name = "Show OOC",
                    descStyle = 'inline',
                    desc = "Show this frame when out of combat. Disable this to only show this frame in combat",
                    type = 'toggle',
                    get = function() return f.show_ooc end,
                    set = function(self, key) f.show_ooc = key; re() end
                },
                dimensionHeader = {
                    order = 29,
                    name = "Dimensions",
                    type = 'header'
                },
                width = {
                    order = 30,
                    name = 'Width',
                    type = 'range',
                    width = 'full',
                    min = 10,
                    max = 500,
                    step = 1,
                    get = function() return f.width end,
                    set = function(self,key) f.width = key; re() end
                },
                height = {
                    order = 40,
                    name = 'Height',
                    type = 'range',
                    width = 'full',
                    min = 10,
                    max = 500,
                    step = 1,
                    get = function() return f.height end,
                    set = function(self,key) f.height = key; re() end
                }
            }
        },
        background = {
            order = 20,
            name = 'Background',
            type = 'group',
            args = {
                -- style, blend, orientation, gradient, alpha, texture, insets, color
                style = {
                    order = 10,
                    name = 'Style',
                    desc = 'By selecting gradient here, you have the option to make the background flow into another color',
                    type = 'select',
                    values = Yugo.frameOptions.style,
                    get = function() return f.background.style end,
                    set = function(self, key) f.background.style = key; re() end
                },
                orientation = {
                    order = 20,
                    name = 'Orientation',
                    desc = 'If you have style on gradient, you can chose its direction here',
                    type = 'select',
                    values = Yugo.frameOptions.orientation,
                    get = function() return f.background.orientation end,
                    set = function(self, key) f.background.orientation = key; re() end
                },
                blend = {
                    order = 30,
                    name = 'Blend',
                    desc = 'Select the way the background blends with whats behind the frame',
                    type = 'select',
                    values = Yugo.frameOptions.blend,
                    get = function() return f.background.blend end,
                    set = function(self, key) f.background.blend = key; re() end
                },
                texture = {
                    order = 32,
                    name = 'Texture',
                    type = 'select',
                    width = 'full',
                    dialogControl = 'LSM30_Background',
                    values = AceGUIWidgetLSMlists.background,
                    get = function()
                        return f.background.texture
                    end,
                    set = function(self,key)
                        f.background.texture = key
                        re()
                    end

                },
                spacing223 = {
                    order = 33,
                    name = [[

                    ]],
                    type = 'description'
                },
                colorHeader = {
                    order = 35,
                    name = 'Colors',
                    type = 'header'
                }, -- r t l b
                color = {
                    order = 40,
                    name = 'Color',
                    type = 'color',
                    hasAlpha = true,
                    desc = 'The color of the bg',
                    get = function()
                        local c = f.background.color
                        return c.r, c.g, c.b, c.a
                    end,
                    set = function(self,r,g,b,a)
                        f.background.color = { r = r, g = g, b = b, a = a }
                        re()
                    end
                },
                gradient = {
                    order = 45,
                    name = 'Gradient color',
                    desc = 'If you have style on gradient, you can chose the color here',
                    type = 'color',
                    hasAlpha = true,
                    desc = 'The color that the other side will have',
                    get = function()
                        local c = f.background.gradient
                        return c.r, c.g, c.b, c.a
                    end,
                    set = function(self,r,g,b,a)
                        f.background.gradient = { r = r, g = g, b = b, a = a }
                        re()
                    end
                },
                spacing3212 = {
                    order = 50,
                    name = [[

                    ]],
                    type = 'description'
                },
                insetHeader = {
                    order = 100,
                    name = 'Background inset',
                    type = 'header'
                }, -- r t l b
                inset_r = {
                    order = 110,
                    name = 'Right',
                    type = 'input',
                    width = 'half',
                    get = function() return tostring(f.background.insets.r) end,
                    set = function(self, key) f.background.insets.r = tonumber(key); re() end,
                },
                inset_t = {
                    order = 120,
                    name = 'Top',
                    type = 'input',
                    width = 'half',
                    get = function() return tostring(f.background.insets.t) end,
                    set = function(self, key) f.background.insets.t = tonumber(key); re() end,
                },
                inset_l = {
                    order = 130,
                    name = 'Left',
                    type = 'input',
                    width = 'half',
                    get = function() return tostring(f.background.insets.l) end,
                    set = function(self, key) f.background.insets.l = tonumber(key); re() end,
                },
                inset_b = {
                    order = 140,
                    name = 'Bottom',
                    type = 'input',
                    width = 'half',
                    get = function() return tostring(f.background.insets.b) end,
                    set = function(self, key) f.background.insets.b = tonumber(key); re() end,
                },
                inset = {
                    order = 150,
                    name = 'All insets (overide above settings)',
                    width = 'full',
                    type = 'range',
                    min = 0,
                    max = 20,
                    step = 1,
                    get = function() return f.background.insets.l end,
                    set = function(self,key)
                        f.background.insets.l = key;
                        f.background.insets.r = math.reverse(key)
                        f.background.insets.b = key
                        f.background.insets.t = math.reverse(key)
                        re()
                    end
                },
            }
        },
        border = {
            order = 30,
            name = "Border",
            type = 'group',
            args = {
                color = {
                    order = 10,
                    name = 'Color',
                    type = 'color',
                    hasAlpha = true,
                    desc = 'The color the border will have',
                    get = function()
                        local c = f.border.color
                        return c.r, c.g, c.b, c.a
                    end,
                    set = function(self,r,g,b,a)
                        f.border.color = { r = r, g = g, b = b, a = a }
                        re()
                    end
                },
                size = {
                    order = 20,
                    name = 'Size',
                    desc = 'The size of the border',
                    type = 'range',
                    min = 8,
                    max = 30,
                    step = 1,
                    get = function()
                        return f.border.size
                    end,
                    set = function(self,key)
                        f.border.size = key
                        re()
                    end
                },
                texture = {
                    order = 30,
                    name = 'Texture',
                    type = 'select',
                    width = 'full',
                    dialogControl = 'LSM30_Border',
                    values = AceGUIWidgetLSMlists.border,
                    get = function()
                        return f.border.texture
                    end,
                    set = function(self,key)
                        f.border.texture = key
                        re()
                    end
                }
            }
        },
        position = {
            order = 15,
            name = "Position",
            type = "group",
            childGroups = 'tab',
            args = {
                moveable = {
                    order = 20,
                    name = 'Enable mouse move',
                    type = 'toggle',
                    get = function() return f.moveable end,
                    set = function(self, key)
                        --print(self, self.options, self.name, self[#self], self.arg, self.handler, self.type, self.option)
                        f.moveable = key;
                        f.anchors[1].to = 'UIParent'
                        if f.save_moved_position == false then
                            f.anchors[1].x = 0
                            f.anchors[1].y = 0
                            f.anchors[1].this = 'CENTER'
                            f.anchors[1].that = 'CENTER'
                        end

                        f.save_moved_position = true;
                        re()
                    end
                },
                resetmove = {
                    order = 30,
                    name = 'Reset position',
                    type = 'execute',
                    func = function()
                        f.moveable = false
                        f.anchors = table.deepcopy(defaults.anchors)
                        f.save_moved_position = false
                        re()
                    end
                },
                desc = {
                    type = 'description',
                    name = [[

When you enable mouse move, the anchor settings below will be overwritten according to where you put the frame on your screen. It will change the 'Other frame' to Screen (UIParent) so you can move it freely. The anchor system is quite easy to use and i would advise only to use the 'Enable mouse move' on the Abilities frame (Modules > Abilities > Frame). This frame already has the Screen (UIParent) anchor. You can place the other individual frames around this, so you are able to move the whole addon at once, as you get by default.

Lets say we want to have Vengeance frame below our Stagger frame. You would go to Frames > Vengeance > Position. Then you would Set my TOPLEFT (my = vengeance frame) to the other frame his BOTTOMLEFT, other frame = Stagger. And then you can tweak the position using the slider.
                    ]]
                },
                test = {
                    disabled = true,
                    hidden = true,
                    order = 31,
                    name = 'test',
                    type = 'execute',
                    func = function()
                        print_r(f)
                    end
                },
                anchors = {
                    name = 'Anchors',
                    type = 'group',
                    args = anchors

                }
            }
        }
    }
    if not disabled then disabled = {} end
    for dk, name in pairs(disabled) do
        local option = {}
        if type(name) == "table" then
            for tk, tv in pairs(name) do
                -- dk = bars, tv = color
                options[dk].args[tv].disabled = true
                options[dk].args[tv].hidden = true
            end
        elseif name == 'position' or name == 'border' or name == 'background' or name == 'general' then
            options[name].disabled = true
            options[name].hidden = true

        else
            options.general.args[name].disabled = true
            options.general.args[name].hidden = true
        end
    end
    return options
end

function Yugo:link_fontstring_options(db, re, disabled)
    local f = db
    local anchors = {}
    for k, v in pairs(db.anchors) do
        anchors['anchor' .. k] = {
            name = 'Anchor ' .. k,
            type = 'group',
            args = {
                this = {
                    order = 40,
                    name = 'Set my',
                    type = 'select',
                    width = 'full',
                    values = Yugo.frameOptions.points,
                    get = function() return f.anchors[k].this end,
                    set = function(self, key) f.anchors[k].this = key; re() end
                },
                that = {
                    order = 50,
                    name = 'To the other frame his',
                    type = 'select',
                    width = 'full',
                    values = Yugo.frameOptions.points,
                    get = function() return f.anchors[k].that end,
                    set = function(self, key) f.anchors[k].that = key; re() end
                },
                to = {
                    order = 60,
                    name = 'Other frame',
                    type = 'select',
                    width = 'full',
                    values = Yugo.frameOptions.frames,
                    get = function() return f.anchors[k].to end,
                    set = function(self, key) f.anchors[k].to = key; re() end
                },
                x = {
                    order = 70,
                    name = 'Adjust horizontal position',
                    type = 'range',
                    min = -500,
                    max = 500,
                    step = 1,
                    get = function() return f.anchors[k].x end,
                    set = function(self,key) f.anchors[k].x = key; re() end
                },
                y = {
                    order = 80,
                    name = 'Adjust vertical position',
                    type = 'range',
                    min = -500,
                    max = 500,
                    step = 1,
                    get = function() return f.anchors[k].y end,
                    set = function(self,key) f.anchors[k].y = key; re() end
                }
            }
        }
    end
    local options = {
        size = {
            order = 1,
            name = 'Size',
            type = 'range',
            min = 5,
            max = 30,
            step = 1,
            get = function() return f.size end,
            set = function(self,key) f.size = key; re() end
        },
        font = {
            order = 2,
            type = 'select',
            dialogControl = 'LSM30_Font',
            name = 'Font',
            values = AceGUIWidgetLSMlists.font,
            get = function() return f.font end,
            set = function(self,key) f.font = key; re() end
        },
        color = {
            order = 3,
            name = 'Color',
            type = 'color',
            hasAlpha = true,
            desc = 'The status bar color',
            get = function()
                local c = f.color
                return c.r, c.g, c.b, c.a
            end,
            set = function(self,r,g,b,a)
                f.color = { r = r, g = g, b = b, a = a }
                re()
            end
        },
        position = {
            order = 15,
            name = "Position",
            type = "group",
            childGroups = 'tab',
            args = {
                moveable = {
                    order = 20,
                    name = 'Enable mouse move',
                    type = 'toggle',
                    desc = 'Make this frame moveable with the mouse. Once you move the frame, you will override all the other position settings. You can reset this by pressing the Reset position button',
                    get = function() return f.moveable end,
                    set = function(self, key) f.moveable = key; re() end
                },
                test = {
                    disabled = true,
                    hidden = true,
                    order = 31,
                    name = 'test',
                    type = 'execute',
                    func = function()
                        print_r(f)
                    end
                },
                anchors = {
                    name = 'Anchors',
                    type = 'group',
                    args = anchors

                }
            }
        }
    }
    if not disabled then disabled = {} end
    for dk, name in pairs(disabled) do
        local option = {}
        if type(name) == "table" then
            for tk, tv in pairs(name) do
                -- dk = bars, tv = color
                options[dk].args[tv].disabled = true
                options[dk].args[tv].hidden = true
            end
        else
            options[name].disabled = true
            options[name].hidden = true
        end
    end
    return options
end

function Yugo:get_bar_options(db, re, disabled)
    local bar = db.bar
    local options = {
        orientation = {
            order = 10,
            name = "Orientation",
            type = 'select',
            width = 'double',
            values = Yugo.frameOptions.orientation,
            get = function() return bar.orientation end,
            set = function(self,key) bar.orientation = key; re() end
        },
        reverseFill = {
            order = 20,
            name = "Reverse",
            width = 'half',
            type = 'toggle',
            get = function() return bar.reverseFill end,
            set = function(self,key) bar.reverseFill = key; re() end
        },
        texture = {
            order = 30,
            name = "Texture",
            width = 'full',
            type = 'select',
            dialogControl = 'LSM30_Statusbar',
            values = AceGUIWidgetLSMlists.statusbar,
            get = function() return bar.texture end,
            set = function(self,key) bar.texture = key; re() end
        },
        color = {
            order = 40,
            name = 'Color',
            type = 'color',
            hasAlpha = true,
            desc = 'The status bar color',
            get = function()
                local c = bar.color
                return c.r, c.g, c.b, c.a
            end,
            set = function(self,r,g,b,a)
                bar.color = { r = r, g = g, b = b, a = a }
                re()
            end
        },
        inset = {
            order = 52,
            type = 'range',
            name = 'inset',
            min = -20,
            max = 20,
            step = 1,
            get = function() return bar.inset end,
            set = function(self,key) bar.inset = key; re() end
        },
        textHeading = {
            order = 80,
            type = 'header',
            name = 'Text and font display'
        },
        textSize = {
            order = 92,
            type = 'range',
            name = 'Font size',
            min = 8,
            max = 30,
            step = 1,
            get = function() return bar.text.size end,
            set = function(self,key) bar.text.size = key; re() end
        },
        font = {
            order = 111,
            type = 'select',
            dialogControl = 'LSM30_Font',
            name = 'Font',
            values = AceGUIWidgetLSMlists.font,
            get = function() return bar.text.font end,
            set = function(self,key) bar.text.font = key; re() end
        },
        textColor = {
            order = 112,
            name = 'Text color',
            type = 'color',
            hasAlpha = true,
            desc = 'The status bar color',
            get = function()
                local c = bar.text.color
                return c.r, c.g, c.b, c.a
            end,
            set = function(self,r,g,b,a)
                bar.text.color = { r = r, g = g, b = b, a = a }
                re()
            end
        },
        verticalPosition = {
            order = 211,
            name = 'Vertical position',
            type = 'select',
            width = 'full',
            values = Yugo.frameOptions.points,
            get = function() return bar.text.verticalPosition end,
            set = function(self,key) bar.text.verticalPosition = key; re() end
        },
        horizontalPosition = {
            order = 311,
            name = 'Horizontal position',
            width = 'full',
            type = 'select',
            values = Yugo.frameOptions.points,
            get = function() return bar.text.horizontalPosition end,
            set = function(self,key) bar.text.horizontalPosition = key; re() end
        }
    }
    if not disabled then disabled = {} end
    for dk, name in pairs(disabled) do
        local option = {}
        if type(name) == "table" then
            for tk, tv in pairs(name) do
                -- dk = bars, tv = color
                options[dk].args[tv].disabled = true
                options[dk].args[tv].hidden = true
            end
        else
            options[name].disabled = true
            options[name].hidden = true
        end
    end
    return options
end

function Yugo:array_events(method, register, object, array)
    if method == 'events' and register == true then
        for k, v in pairs(array) do
            if type(k) == 'string' then
                object:RegisterEvent(k, v)
            else
                object:RegisterEvent(v)
            end
        end
    elseif method == 'events' and register == false then
        for k, v in pairs(array) do
            if type(k) == 'string' then
                object:UnregisterEvent(k, v)
            else
                object:UnregisterEvent(v)
            end
        end
    elseif method == 'messages' and register == true then
        for k, v in pairs(array) do
            if type(k) == 'string' then
                object:RegisterMessage(k, v)
            else
                object:RegisterMessage(v)
            end
        end
    elseif method == 'messages' and register == false then
        for k, v in pairs(array) do
            if type(k) == 'string' then
                object:UnregisterMessage(k, v)
            else
                object:UnregisterMessage(v)
            end
        end
    end

end


function Yugo:Hyperlink(link)
    if not link then return nil end
    local _, _, Color, Ltype, Id, Enchant, Gem1, Gem2, Gem3, Gem4, Suffix, Unique, LinkLvl, Name = string.find(link, "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*):?(%d*):?(%-?%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?")
    return Color, Ltype, Id, Enchant, Gem1, Gem2, Gem3, Gem4, Suffix, Unique, LinkLvl, Name
end