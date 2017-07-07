if select(2, UnitClass("player")) == 'MONK' then
local YugoMonk = LibStub("AceAddon-3.0"):GetAddon("YugoMonk")
local prototype = {
    OnInitialize = function (self)
        self.optionsDB.enabled = true
        YugoMonk.db:RegisterNamespace(self.name, { profile = self.optionsDB })
        self.db = YugoMonk.db:GetNamespace(self.name)

        local YugoMonkOptions = LibStub("AceConfigRegistry-3.0"):GetOptionsTable('YugoMonk', 'dialog', 'YugoMonkTalents-1.0')
        YugoMonkOptions.args.modules.args[self.name] = self.options
        YugoMonkOptions.args.modules.args[self.name .. 'enabled'] = {
            type = 'group',
            name = self.name,
            inline = true,
            args = {
                enabled = {
                    order = 0,
                    name = 'Enabled',
                    type = 'toggle',
                    width = 'full',
                    get = function() return
                        self.db.profile.enabled
                    end,
                    set = function(info, key)
                        self.db.profile.enabled = key

                        YugoMonkOptions.args.modules.args[self.name].disabled = (key == false)
                        if key == true then
                            self:Enable()
                        else
                            self:Disable()
                        end
                    end
                },
            }
        }
        LibStub("AceConfig-3.0"):RegisterOptionsTable("YugoMonk", YugoMonkOptions, {"ym", "yugomonk"})

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
        self:Print('Enabled')
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
        self:Print('Disabled')
    end,
}
YugoMonk:SetDefaultModulePrototype(prototype)
end