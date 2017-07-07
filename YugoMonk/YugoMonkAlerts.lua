if select(2, UnitClass("player")) == 'MONK' then
local Yugo = LibStub("AceAddon-3.0"):GetAddon("Yugo")
local YugoMonk = LibStub("AceAddon-3.0"):GetAddon("YugoMonk")
local Alerts = YugoMonk:NewModule('Alerts')

Alerts.options = {
    name = "Alerts",
    type = 'group',
    childGroups = 'select',
    args = {
        enabled = {
            order = -1,
            disabled = true,
            hidden = true,
            name = 'Enabled',
            type = 'toggle',
            width = 'full',
            get = function() return
                Alerts.db.profile.enabled
            end,
            set = function(self, key)
                Alerts.db.profile.enabled = key

                for k, v in pairs(Alerts.db.profile) do
                    if type(v) == 'table' then
                        Alerts.options.args[k].disabled = (key == false)
                    end
                end

                if key == true then
                    Alerts:Enable()
                else
                    Alerts:Disable()
                end
            end
        },
    }
}

Alerts.optionsDB = {

}
Alerts.registerMessages = {}
local warnings = {}

local function AddAlertOption(keyname, name, sound)
    Alerts.registerMessages[keyname] = 'AlertHandler'
    warnings[keyname] = name

    Alerts.optionsDB[keyname] = {
        enabled = true,
        playSound = true,
        showText = true,
        sound = sound
    }

    Alerts.options.args[keyname] = {
        name = name,
        type = 'group',
        args = {
            enabled = {
                order = 1,
                type = 'toggle',
                name = 'Enabled',
                width = 'full',
                get = function() return Alerts.db.profile[keyname].enabled end,
                set = function(self, key) Alerts.db.profile[keyname].enabled = key end
            },
            playSound = {
                order = 2,
                type = 'toggle',
                name = 'Enable sound',
                get = function() return Alerts.db.profile[keyname].playSound end,
                set = function(self, key) Alerts.db.profile[keyname].playSound = key end
            },
            sound = {
                order = 3,
                type = 'select',
                dialogControl = 'LSM30_Sound', --Select your widget here
                name = 'Sound',
                values = AceGUIWidgetLSMlists.sound, -- this table needs to be a list of keys found in the sharedmedia type you want
                get = function() return Alerts.db.profile[keyname].sound end,
                set = function(self,key) Alerts.db.profile[keyname].sound = key end,
            },
            showText = {
                order = 4,
                type = 'toggle',
                name = 'Show text warning',
                width = 'full',
                get = function() return Alerts.db.profile[keyname].showText end,
                set = function(self, key) Alerts.db.profile[keyname].showText = key end
            },
        }
    }
end

AddAlertOption("TransOutOfRange", "Transcendence out of range", "Blizzard: Bell - Alliance")
AddAlertOption("ModerateStagger", "Moderate Stagger", "Blizzard: Mellow Bells")
AddAlertOption("HeavyStagger", "Heavy Stagger", "Blizzard: Gong - Troll")
AddAlertOption("ElusiveBrewFullStacks", "Full Elusive Brew stacks", "Blizzard: Alarm Clock 2")



local alertFrame

function Alerts:OnModuleInitialize()
    alertFrame = AlertFrame("YM_Alerts")
    alertFrame:Hide()
    self.alerts = self.db.profile
end

function Alerts:OnModuleEnable()
    alertFrame:Show()
end

function Alerts:OnModuleDisable()
    alertFrame:Hide()
end

function Alerts:AlertHandler(event)
    if self.alerts[event] then
        if self.alerts[event].enabled == true then
            if self.alerts[event].showText == true then
                alertFrame.alert(warnings[event])
            end
            if self.alerts[event].playSound == true then
                PlaySoundFile(Yugo.SML:Fetch("sound", self.alerts[event].sound), "Master")
            end

        end
    end

end

function Alerts:YugoMonk_ElusiveBrewFullStacks()
    if self.alerts.ebfull.enabled == true then
        if self.alerts.ebfull.showText == true then
            alertFrame.alert("Elusive Brew Stacks Full")
        end
        if self.alerts.ebfull.playSound == true then
            PlaySoundFile(Yugo.SML:Fetch("sound", self.alerts.ebfull.sound), "Master")
        end
    end
end

function Alerts:YugoMonk_TransOutOfRange()
    if self.alerts.trans.enabled == true then
        if self.alerts.trans.showText == true then
            alertFrame.alert("Transcendence out of range")
        end
        if self.alerts.trans.playSound == true then
            PlaySoundFile(Yugo.SML:Fetch("sound", self.alerts.trans.sound), "Master")
        end
    end
end

function Alerts:YugoMonk_LightStagger()
end

function Alerts:YugoMonk_ModerateStagger()
    if self.alerts.moderatestagger.enabled == true then
        if self.alerts.moderatestagger.showText == true then
            alertFrame.alert("Transcendence out of range")
        end
        if self.alerts.moderatestagger.playSound == true then
            PlaySoundFile(Yugo.SML:Fetch("sound", self.alerts.moderatestagger.sound), "Master")
        end

    end
end

function Alerts:YugoMonk_HeavyStagger()
    if self.alerts.heavystagger.enabled == true then
        if self.alerts.heavystagger.showText == true then
            alertFrame.alert("Transcendence out of range")
        end
        if self.alerts.heavystagger.playSound == true then
            PlaySoundFile(Yugo.SML:Fetch("sound", self.alerts.heavystagger.sound), "Master")
        end

    end
end



YugoMonkAlerts = Alerts
end
