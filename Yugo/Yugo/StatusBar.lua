local Yugo = Yugo
local YugoMedia = YugoMedia

function StatusBar(name, parent)
    local self = Frame(name, 'StatusBar')

    self:SetParent(parent)

    self.parent = parent
    self.parentFrame = self:GetParent()
    self.set({
        background = {
            texture = 'None',
            insets = { b = 0, t = 0, l = 0, r = 0 },
            color = { a = 0, r = 1, g = 1, b = 1 }

        },
        border = {
            texture = "None",
            color = { a = 0, r = 0, g = 0, b = 0 },
            size = 0
        }
    })


    self.config.bar = {
        orientation = "HORIZONTAL",
        reverseFill = false,
        texture = "YugoGlossyOil",
        color = { r = 1, g = 1, b = 1, a = 1 },
        text = {
            size = 16,
            font = "Yugo",
            verticalPosition = "CENTER",
            horizontalPosition = "CENTER",
            color = { r = 1, g = 1, b = 1, a = 1 },
        },
        inset = 6,
        parentFill = true
    }

    self.text = self:CreateFontString(self, name .. "_Text")

    self:SetMinMaxValues(0, 100)
    self:SetValue(0)

    -- Inheriteds
    local base_set = self.set
    function self.set(...)
        table.setter(self.config, ...)

    end

    local base_apply = self.apply
    function self.apply()

        base_apply()

        local options = self.config.bar
        self:SetOrientation(options.orientation)


        self:SetReverseFill(options.reverseFill)
        self:SetStatusBarTexture( YugoMedia:Get(options.texture, "statusbar"), "Artwork")
        self:SetStatusBarColor(options.color.r, options.color.g, options.color.b, options.color.a)


        self.text:SetFont( YugoMedia:Get(options.text.font,"font"), options.text.size)
        self.text:ClearAllPoints()
        self.text:SetPoint(options.text.verticalPosition, self , options.text.verticalPosition,0,0)
        self.text:SetPoint(options.text.horizontalPosition, self , options.text.horizontalPosition, 0, 0)
        self.text:SetVertexColor(options.text.color.r, options.text.color.g, options.text.color.b, options.text.color.a)

        if options.parentFill == true then
            self:ClearAllPoints()
        self:SetPoint("TOPLEFT", self.parent, "TOPLEFT", options.inset, math.reverse(options.inset))
        self:SetPoint("BOTTOMRIGHT", self.parent, "BOTTOMRIGHT", math.reverse(options.inset), options.inset)
        end

        if self.parentFrame and self.parentFrame.config.show_ooc == false then
            self:Hide()
        end
    end


    function self.get_bar_options(re, disabled)
        return Yugo:get_bar_options(self.db, re, disabled)
    end

    local base_SetDisplayOptions = self.SetDisplayOptions
    function self.SetDisplayOptions()
        self.set(self.db)
        base_SetDisplayOptions()

        if self.parentFrame then
            self.set_apply('enabled', self.parentFrame.config.enabled)
        end
        self.apply()

    end
    -- return the instance



    -- Events
    function self:PLAYER_REGEN_ENABLED()
        -- leaving combat
        if self.parentFrame and self.parentFrame.config.show_ooc == false then
            self:Hide()
        end

    end

    function self:PLAYER_REGEN_DISABLED()
        -- entering combat
        if self.parentFrame and self.parentFrame.config.show_ooc == false and self.parentFrame.config.enabled == true then
            self:Show()
        end
    end


    self:RegisterEvent("PLAYER_REGEN_ENABLED")
    self:RegisterEvent("PLAYER_REGEN_DISABLED")


    return self
end