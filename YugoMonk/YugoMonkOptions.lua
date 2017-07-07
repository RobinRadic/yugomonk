if select(2, UnitClass("player")) == 'MONK' then
local Yugo = Yugo
local YugoMonk = LibStub("AceAddon-3.0"):GetAddon("YugoMonk")

local SML = LibStub("LibSharedMedia-3.0")

local AC = LibStub("AceConfig-3.0")
local ACD = LibStub("AceConfigDialog-3.0")
local AceGUI = LibStub("AceGUI-3.0")

local re = function() YugoMonk:SetDisplayOptions() end


local frameOptions = {
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
        ['UIParent'] = 'Screen (UIParent)',
        ["YM_GuardFrame"] = 'Guard',
        ["YM_ElusiveBrewFrame"] = 'Elusive Brew',
        ["YM_Chis"] = 'Chi container',
        ["YM_TransFrame"] = 'Transcendence',
        ["YM_ShuffleFrame"] = 'Shuffle',
        ["YM_StaggerFrame"] = 'Stagger',
        ["YM_Abilitys"] = 'Abilitys',
        ["YM_EnergyFrame"] = 'Energy',
        ["YM_VengeanceFrame"] = 'Vengeance',
    }
}
YugoMonk.frameOptions = frameOptions

local defaults = {
    profile = {
        frames = {
        },
        childframes = {
        },
        statusbars = {},
    },
    global = {
        version = 0,
        layout = {
            saveAs = '',
            importAs = ''
        },
        layouts = {
            ['*'] = {
                name = '',
                data = ''
            }
        }
    }
}
YugoMonk.defaults = defaults

local options = {
    name = "YugoMonk",
    handler = YugoMonk,
    type = 'group',
    args = {
        config = {
            name = "Open options",
            type = "execute",
            guiHidden = true,
            func = function()
                LibStub("AceConfigDialog-3.0"):Open("YugoMonk")
                --InterfaceOptionsFrame_OpenToCategory("YugoMonk")
            end
        },
        configmode = {
            order = -1,
            name = 'Toggle config mode',
            type = 'toggle',
            width = 'full',
            set = function()
                if YugoMonk.configMode == true then
                    YugoMonk:ConfigModeDisable()
                else
                    YugoMonk:ConfigModeEnable()
                end
            end,
            get = function() return YugoMonk.configMode end
        },
        frames = {
            order = 0,
            name = 'Frames',
            type = 'group',
            cmdHidden = true,
            args = {
            }
        },
        modules = {
            order = 10,
            name = 'Modules',
            type = 'group',
            cmdHidden = true,
            args = {}
        },
        layouts = {
            order = 20,
            name = 'Layouts',
            type = 'group',
            cmdHidden = true,
            args = {}
        },
        changelog = {
            order = 30,
            name = 'Changelog',
            type = 'group',

            args = {
                v158 = {
                    order = 1000,
                    name = '1.5.8',
                    type = 'group',
                    inline = true,
                    args = {
                        about = {
                            type = 'description',
                            name = [[
NEW: Defensive cooldowns. It shows remaining uptime, remaining cooldown time and stuff like that.

NEW: This changelog :)

BUGFIX: The positions of frames would not save if using 'mouse move'. This has been fixed.]]
                        }
                    }
                }
            }
        }
    }
}
YugoMonk.options = options

local function serialize_layout()
    local version = YugoMonk.db.global.version
    local p = YugoMonk.db.profile
    local ab_db = YugoMonk.db:GetNamespace('YugoMonk_Abilities')
    local data = LibStub('AceSerializer-3.0'):Serialize(
        version,
        p.frames,
        p.childframes,
        p.statusbars,
        ab_db.profile.frame,
        ab_db.profile.display,
        ab_db.profile.overides,
        ab_db.profile.assignments
    )
    return data
end
local function deserialize_layout(data)
    --local version, frames, childframes, statusbars, ab_frame, ab_display, ab_overides, ab_assignments =
    return LibStub('AceSerializer-3.0'):Deserialize(data)
end

local function layoutstring(string)
    local f = AceGUI:Create("Frame")
    f:SetCallback("OnClose",function(widget)
        widget:ReleaseChildren()
        AceGUI:Release(widget) end)
    f:SetTitle("Layout string")
    if string then
        f:SetStatusText("Select all text and copy it somewhere else")
    else
        f:SetStatusText("Insert a name then paste the layout string in the textbox and press the button")
    end

    f:SetLayout("List")

    local name = AceGUI:Create('EditBox')

    if not string then
        name:SetText("")
        name:SetLabel('Layout name')
        f:AddChild(name)
    end

    local textbox = AceGUI:Create('MultiLineEditBox')
    textbox:SetLabel('Layout string:')
    textbox:SetFullWidth(true)
    textbox:SetNumLines(20)
    textbox:DisableButton(true)

    if string then
        textbox:SetText(string)
    end
    f:AddChild(textbox)

    if not string then
        local button = AceGUI:Create("Button")
        button:SetText("Import layout string")
        button:SetWidth(200)

        button:SetCallback("OnClick", function()
            --print(textbox:GetText())

            YugoMonk.db.global.layouts[name:GetText()] = {
                name = name:GetText(),
                data = textbox:GetText()
            }
            f:SetStatusText("Layout imported! you can close this window now")
        end)

        f:AddChild(button)
    end


end
local function layouts_options()
    local l = YugoMonk.db.global.layout
    local ls = YugoMonk.db.global.layouts
    local g = YugoMonk.db.global
    local p = YugoMonk.db.profile

    options.args.layouts.args = {
        desc = {
            order = 10,
            type = 'description',
            name = 'Desc here',
        },
        set = {
            order = 20,
            name = 'Insert layout into settings',
            type = 'select',
            width = 'full',
            values = function()
                local values = {}
                for k, v in pairs(ls) do
                    values[k] = v.name
                end
                return values
            end,
            get = function()
                return ''
            end,
            set = function(self, key)
                local response, version, frames, childframes, statusbars, ab_frame, ab_display, ab_overides, ab_assignments = deserialize_layout(ls[key].data)
                if response == false then
                    YugoMonk:Print('Could not set this layout, something went wrong')
                elseif version ~= g.version then
                    YugoMonk:Print('This layout does not meet the version requirement. Layout: v' .. version .. ' - YugoMonk: ' .. g.version)
                elseif response == true and version == g.version then
                    local ab_db = YugoMonk.db:GetNamespace('YugoMonk_Abilities')
                    p.frames = frames
                    p.childframes = childframes
                    p.statusbars = statusbars
                    ab_db.profile.frame = ab_frame
                    ab_db.profile.display = ab_display
                    ab_db.profile.overides = ab_overides
                    ab_db.profile.assignments = ab_assignments
                    ReloadUI();
                end
            end
        },
        desc = {
            order = 30,
            name = 'This will reload your UI and apply the layout into your settings. You can save your current settings below',
            type = 'description',
        },
        saveH = {
            order = 100,
            name = 'Save current layout',
            type = 'header',
        },
        saveName = {
            order = 110,
            name = 'Save current layout as:',
            type = 'input',
            get = function() return l.saveAs end,
            set = function(self, key) l.saveAs = key  end
        },
        save = {
            order = 120,
            name = 'Save',
            type = 'execute',
            func = function()
                ls[l.saveAs] = {
                    name = l.saveAs,
                    data = serialize_layout()
                }
                l.saveAs = ''
            end
        },
        importExportH = {
            order = 200,
            name = 'Import / Export',
            type = 'header',
        },
        import = {
            order = 210,
            name = 'Import a layout string',
            width = 'full',
            type = 'execute',
            func = function()
                layoutstring()
            end
        },
        export = {
            order = 211,
            name = 'Export current layout to string',
            width = 'full',
            type = 'execute',
            func = function()
                local lstring = serialize_layout()
                layoutstring(lstring)
            end
        },
    }

end


function YugoMonk:InitOptions()

    defaults.profile.frames.YM_GuardFrame = YugoMonk.F['YM_GuardFrame'].get()
    defaults.profile.frames.YM_ElusiveBrewFrame = YugoMonk.F['YM_ElusiveBrewFrame'].get()
    defaults.profile.frames.YM_ShuffleFrame = YugoMonk.F['YM_ShuffleFrame'].get()
    defaults.profile.frames.YM_StaggerFrame = YugoMonk.F['YM_StaggerFrame'].get()
    defaults.profile.frames.YM_EnergyFrame = YugoMonk.F['YM_EnergyFrame'].get()
    defaults.profile.frames.YM_VengeanceFrame = YugoMonk.F['YM_VengeanceFrame'].get()
    defaults.profile.frames.YM_TransFrame = YugoMonk.F['YM_TransFrame'].get()
    defaults.profile.frames.YM_Chis = YugoMonk.F['YM_Chis'].get()

    defaults.profile.childframes.YM_Chi = YugoMonk.CHIS[1].get()
    defaults.profile.childframes.YM_ElusiveBrewStack = YugoMonk.EB[1].get()
    defaults.profile.childframes.YM_ElusiveBrewStackText = YugoMonk.EB[1].text.get()

    defaults.profile.childframes.YM_ElusiveBrewStackActive = YugoMonk.EB[2].get()
    defaults.profile.childframes.YM_ElusiveBrewStackActiveText = YugoMonk.EB[2].text.get()

    defaults.profile.statusbars.YM_GuardBar = YugoMonk.S['YM_GuardBar'].get()
    defaults.profile.statusbars.YM_ShuffleBar = YugoMonk.S['YM_ShuffleBar'].get()
    defaults.profile.statusbars.YM_StaggerBar = YugoMonk.S['YM_StaggerBar'].get()
    defaults.profile.statusbars.YM_VengeanceBar = YugoMonk.S['YM_VengeanceBar'].get()
    defaults.profile.statusbars.YM_TransBar = YugoMonk.S['YM_TransBar'].get()
    defaults.profile.statusbars.YM_EnergyBar = YugoMonk.S['YM_EnergyBar'].get()

    --show_table(defaults.profile.statusbars.YM_GuardBar, 'defaults')


    -- after all frammes and stuff have defaults, we go do the layouts stuff


    self.db = LibStub("AceDB-3.0"):New("YugoDB", defaults, true)
    options.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
    layouts_options()

    if tonumber(YugoMonk.db.global.version) < 150 then

        YugoMonk.db:ResetDB()
        self.db.global.version = 150
        YugoMonk:Print("Previous configuration settings have been resetted to default. This was needed to remove any conflicting data from the previous version."
                .. "This was a 1 time only event. This will not happen with future updates.")
    end

    self.db.global.version = 159
    --[[
        self:AddFrameOptions(YugoMonk.db.profile.frames, options)
        self:AddBarToFrame("YM_TransBar", "YM_TransFrame")
        self:AddBarToFrame("YM_ShuffleBar", "YM_ShuffleFrame")
        self:AddBarToFrame("YM_StaggerBar", "YM_StaggerFrame")
        self:AddBarToFrame("YM_GuardBar", "YM_GuardFrame")
        self:AddBarToFrame("YM_EnergyBar", "YM_EnergyFrame")
        self:AddBarToFrame("YM_VengeanceBar", "YM_VengeanceFrame")

        self:DisableFrameOptions(YugoMonk.db.profile.frames)
 ]]--
    YugoMonk.F['YM_GuardFrame'].link_db(YugoMonk.db.profile.frames.YM_GuardFrame)
    options.args.frames.args.YM_GuardFrame = {
        name = 'Guard',
        type = 'group',
        childGroups = 'tab',
        args = YugoMonk.F['YM_GuardFrame'].link_options(re, defaults.profile.frames.YM_GuardFrame)
    }
    YugoMonk.F['YM_ShuffleFrame'].link_db(YugoMonk.db.profile.frames.YM_ShuffleFrame)
    options.args.frames.args.YM_ShuffleFrame = {
        name = 'Shuffle',
        type = 'group',
        childGroups = 'tab',
        args = YugoMonk.F['YM_ShuffleFrame'].link_options(re, defaults.profile.frames.YM_ShuffleFrame)
    }
    YugoMonk.F['YM_ElusiveBrewFrame'].link_db(YugoMonk.db.profile.frames.YM_ElusiveBrewFrame)
    options.args.frames.args.YM_ElusiveBrewFrame = {
        name = 'Elusive Brew container',
        type = 'group',
        childGroups = 'tab',
        args = YugoMonk.F['YM_ElusiveBrewFrame'].link_options(re, defaults.profile.frames.YM_ElusiveBrewFrame)
    }

    YugoMonk.F['YM_StaggerFrame'].link_db(YugoMonk.db.profile.frames.YM_StaggerFrame)
    options.args.frames.args.YM_StaggerFrame = {
        name = 'Stagger',
        type = 'group',
        childGroups = 'tab',
        args = YugoMonk.F['YM_StaggerFrame'].link_options(re, defaults.profile.frames.YM_StaggerFrame)
    }

    YugoMonk.F['YM_EnergyFrame'].link_db(YugoMonk.db.profile.frames.YM_EnergyFrame)
    options.args.frames.args.YM_EnergyFrame = {
        name = 'Energy',
        type = 'group',
        childGroups = 'tab',
        args = YugoMonk.F['YM_EnergyFrame'].link_options(re, defaults.profile.frames.YM_EnergyFrame)
    }

    YugoMonk.F['YM_VengeanceFrame'].link_db(YugoMonk.db.profile.frames.YM_VengeanceFrame)
    options.args.frames.args.YM_VengeanceFrame = {
        name = 'Vengeance',
        type = 'group',
        childGroups = 'tab',
        args = YugoMonk.F['YM_VengeanceFrame'].link_options(re, defaults.profile.frames.YM_VengeanceFrame)
    }

    YugoMonk.F['YM_TransFrame'].link_db(YugoMonk.db.profile.frames.YM_TransFrame)
    options.args.frames.args.YM_TransFrame = {
        name = 'Transcendence',
        type = 'group',
        childGroups = 'tab',
        args = YugoMonk.F['YM_TransFrame'].link_options(re, defaults.profile.frames.YM_TransFramme)
    }

    YugoMonk.F['YM_Chis'].link_db(YugoMonk.db.profile.frames.YM_Chis)
    options.args.frames.args.YM_Chis = {
        name = 'Chi container',
        type = 'group',
        childGroups = 'tab',
        args = YugoMonk.F['YM_Chis'].link_options(re, defaults.profile.frames.YM_Chis)
    }


    YugoMonk.S['YM_GuardBar'].link_db(YugoMonk.db.profile.statusbars.YM_GuardBar)
    options.args.frames.args.YM_GuardFrame.args.bar = {
        name = 'Progress bar',
        type = 'group',
        childGroups = 'tab',
        args = YugoMonk.S['YM_GuardBar'].get_bar_options(re)
    }

    YugoMonk.S['YM_ShuffleBar'].link_db(YugoMonk.db.profile.statusbars.YM_ShuffleBar)
    options.args.frames.args.YM_ShuffleFrame.args.bar = {
        name = 'Progress bar',
        type = 'group',
        childGroups = 'tab',
        args = YugoMonk.S['YM_ShuffleBar'].get_bar_options(re)
    }

    YugoMonk.S['YM_StaggerBar'].link_db(YugoMonk.db.profile.statusbars.YM_StaggerBar)
    options.args.frames.args.YM_StaggerFrame.args.bar = {
        name = 'Progress bar',
        type = 'group',
        childGroups = 'tab',
        args = YugoMonk.S['YM_StaggerBar'].get_bar_options(re)
    }

    YugoMonk.S['YM_VengeanceBar'].link_db(YugoMonk.db.profile.statusbars.YM_VengeanceBar)
    options.args.frames.args.YM_VengeanceFrame.args.bar = {
        name = 'Progress bar',
        type = 'group',
        childGroups = 'tab',
        args = YugoMonk.S['YM_VengeanceBar'].get_bar_options(re)
    }

    YugoMonk.S['YM_TransBar'].link_db(YugoMonk.db.profile.statusbars.YM_TransBar)
    options.args.frames.args.YM_TransFrame.args.bar = {
        name = 'Progress bar',
        type = 'group',
        childGroups = 'tab',
        args = YugoMonk.S['YM_TransBar'].get_bar_options(re)
    }

    YugoMonk.S['YM_EnergyBar'].link_db(YugoMonk.db.profile.statusbars.YM_EnergyBar)
    options.args.frames.args.YM_EnergyFrame.args.bar = {
        name = 'Progress bar',
        type = 'group',
        childGroups = 'tab',
        args = YugoMonk.S['YM_EnergyBar'].get_bar_options(re)
    }

    YugoMonk.CHIS[1].link_db(YugoMonk.db.profile.childframes.YM_Chi)
    YugoMonk.CHIS[2].link_db(YugoMonk.db.profile.childframes.YM_Chi)
    YugoMonk.CHIS[3].link_db(YugoMonk.db.profile.childframes.YM_Chi)
    YugoMonk.CHIS[4].link_db(YugoMonk.db.profile.childframes.YM_Chi)
    YugoMonk.CHIS[5].link_db(YugoMonk.db.profile.childframes.YM_Chi)
    options.args.frames.args.YM_Chis.args.Chi = {
        name = 'Chi bar',
        type = 'group',
        childGroups = 'tree',
        args = YugoMonk.CHIS[1].link_options(re, defaults.profile.childframes.YM_Chi, {
            'position', 'general'
        })
    }


    for count = 1, 15 do
        YugoMonk.EB[count].link_db(YugoMonk.db.profile.childframes.YM_ElusiveBrewStack)
        YugoMonk.EB[count].text.link_db(YugoMonk.db.profile.childframes.YM_ElusiveBrewStackText)
    end
    options.args.frames.args.YM_ElusiveBrewFrame.args.Stack = {
        name = 'EB Stack',
        type = 'group',
        childGroups = 'tree',
        args = YugoMonk.EB[1].link_options(re, defaults.profile.childframes.YM_ElusiveBrewStack, {
            'position', 'general'
        })
    }
    options.args.frames.args.YM_ElusiveBrewFrame.args.Stack.args.text = {
        name = 'Text',
        type = 'group',
        childGroups = 'tree',
        args = YugoMonk.EB[1].text.link_options(re,  {
            'position'
        })
    }

   options.args.frames.args.YM_ElusiveBrewFrame.args.StackActive = {
        name = 'EB Stack activated',
        type = 'group',
        childGroups = 'tree',
        args = Yugo:link_frame_options(YugoMonk.db.profile.childframes.YM_ElusiveBrewStackActive, re, defaults.profile.childframes.YM_ElusiveBrewStackActive, {
            'position', 'general'
        })
    }
    options.args.frames.args.YM_ElusiveBrewFrame.args.StackActive.args.text = {
        name = 'Text',
        type = 'group',
        childGroups = 'tree',
        args = Yugo:link_fontstring_options(YugoMonk.db.profile.childframes.YM_ElusiveBrewStackActiveText, re, {
            'position'
        })
    }



    AC:RegisterOptionsTable("YugoMonk", options, {"yugomonk", "ym"})
   AC:RegisterOptionsTable("YugoMonk_Talents", options, {"ygt"})
   self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("YugoMonk", "YugoMonk")
   LibStub("AceConfigDialog-3.0"):SetDefaultSize('YugoMonk', 900, 800)
end


-- MainFrame, ShuffleFrame, GuardBrewFrame
end