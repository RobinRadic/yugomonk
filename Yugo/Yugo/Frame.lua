local Yugo = Yugo
local YugoMedia = YugoMedia

function Frame(name, type)
    if not type then type = 'Frame' end
    local self = CreateFrame(type, name, UIParent)

    LibStub('AceEvent-3.0'):Embed(self)

    self.db = false

    self.name = name

    self.config = {
        moveable = false,
        save_moved_position = false,
        enabled = true,
        show_ooc = true,
        width = 50,
        height = 50,
        level = 0,
        sub_level = 0,
        position = {
            this = "CENTER",
            that = "CENTER",
            to = "UIParent",
            x = 5,
            y = 5
        },
        strata = "BACKGROUND",
        parent = "UIParent",
        anchors = {
            {
                this = "CENTER",
                that = "CENTER",
                to = "UIParent",
                x = 5,
                y = 5
            }
        },
        background = {
            alpha = 1,
            texture = "Blizzard Rock",
            insets = { b = 4, t = -4, l = 4, r = -4 },
            style = "SOLID",
            gradient = { a = 1, r = 1, g = 1, b = 1},
            blend = "BLEND",
            orientation = "HORIZONTAL",
            color = { a = 0.7, r = 1, g = 1, b = 1 }
        },
        border = {
            texture = "Yugo",
            color = { a = 1, r = 0, g = 0, b = 0 },
            size = 21
        }
    }

    local function defaults()
        self.default_backdrop = {bgFile = "",edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = false, tileSize = 0, edgeSize = 16, insets = {left = 0,right = 0,top = 0,bottom = 0}}

        self.background = self:CreateTexture(name .. "_BG", "PARENT")
        self:SetScript("OnEvent",nil)
        self:SetScript("OnEvent",nil)
        self:SetScript("OnUpdate",nil)
        self:SetScript("OnShow",nil)
        self:SetScript("OnHide",nil)
        self:SetScript("OnEnter",nil)
        self:SetScript("OnLeave",nil)
        self:SetScript("OnSizeChanged",nil)
        self:SetScript("OnReceiveDrag",nil)
        self:SetScript("OnMouseUp",nil)
        self:SetScript("OnMouseDown",nil)
        self.background:SetTexture(0.1,0.1,0.1,0.8)
        self:SetFrameStrata("BACKGROUND")
        self.background:ClearAllPoints()
        self.background:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0);
        self.background:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, 0);
        self:ClearAllPoints()
        self:SetBackdrop(self.default_backdrop)
        self:SetPoint("CENTER",UIParent,"CENTER",0,0)
        self.scripts_loaded = false
        self.missing_parent_at_load = false
        self.missing_anchor_at_load = false
    end

    function self.apply()
        if self.config.enabled == false then
            self:Hide()
            return
        else
            self:Show()
        end

        self:SetParent(self.config.parent)
        local parent = self.config.parent
        self:ClearAllPoints()

        -- Percentage size support
        if strmatch(self.config.width, "%d+%.?%d*%%") then
            local pWidth = parent:GetWidth()
            local fWidth = strmatch(self.config.width, "%d+%.?%d*")
            self:SetWidth(pWidth * (fWidth / (100.0)))
        elseif strmatch(self.config.width, "%d+") then
            local pWidth = strmatch(self.config.width,"%d+")
            self:SetWidth(pWidth)
        end
        if strmatch(self.config.height, "%d+%.?%d*%%") then
            local pHeight = parent:GetHeight()
            local fHeight = strmatch(self.config.height, "%d+%.?%d*")
            self:SetHeight(pHeight * (fHeight / (100.0)))
        elseif strmatch(self.config.height, "%d+") then
            local pHeight = strmatch(self.config.height,"%d+")
            self:SetHeight(pHeight)
        end
        if self.config.scale then
            self:SetScale(self.config.scale)
        end
        local scale = self:GetScale()


        for k, anchor in pairs(self.config.anchors) do
            self:SetPoint(anchor.this, anchor.to, anchor.that, anchor.x, anchor.y)
        end



        if self.config.level < 0 then
            self.config.level = 0
        end
        self:SetFrameLevel(self.config.level)
        self:SetFrameStrata(self.config.strata)

        ------- Background texture

        local texture = self.config.background.texture

        self.background:SetTexCoord(0,1,0,1)
        local ULx,ULy,LLx,LLy,URx,URy,LRx,LRy = self.background:GetTexCoord()
        self.background:SetBlendMode(self.config.background.blend)
        self.background:SetAlpha(self.config.background.alpha)

        local alpha_override = self.config.background.alpha
        if self.config.background.style == "SOLID" then
            self.background:SetGradientAlpha(self.config.background.orientation, self.config.background.color.r, self.config.background.color.g, self.config.background.color.b,min(self.config.background.color.a,alpha_override), self.config.background.color.r, self.config.background.color.g, self.config.background.color.b,min(self.config.background.color.a,alpha_override))
            self.background:SetTexture(self.config.background.color.r, self.config.background.color.g, self.config.background.color.b,min(self.config.background.color.a,alpha_override))
        elseif self.config.background.style == "GRADIENT" then
            self.background:SetGradientAlpha(self.config.background.orientation, self.config.background.color.r, self.config.background.color.g, self.config.background.color.b,min(self.config.background.color.a,alpha_override), self.config.background.gradient.r, self.config.background.gradient.g, self.config.background.gradient.b,min(self.config.background.gradient.a,alpha_override))
            self.background:SetTexture(1,1,1,1)
        end

        if texture and strlen(texture) > 0 then
            local path = YugoMedia:Get(texture,"background")
            self.background:SetTexture(path)
            if texture == "None" then
                self.background:SetTexture(nil)
            end
        end

        if self.config.border.texture and strlen(self.config.border.texture) > 0 and self.config.border.texture ~= "None" then
            local path = YugoMedia:Get(self.config.border.texture,"border")
        end
        if self.config.tiling then
            self.background:SetTexture(nil)
            self:SetBackdrop({	bgFile = YugoMedia:Get(self.config.background.texture,"background"),edgeFile = YugoMedia:Get(self.config.border_texture,"border"),edgeSize = self.config.border_edgeSize,tile = true,tileSize = self.config.tileSize,insets = {left = self.config.background.insets.l,right = self.config.background.insets.r,top = self.config.background.insets.t,bottom = self.config.background.insets.b}})

            -- check direction
            if self.config.vert_tile then
                self.background:SetHorizTile(false)
                self.background:SetVertTile(true)
            end
            if self.config.horz_tile then
                self.background:SetHorizTile(true)
                self.background:SetVertTile(false)
            end

        else
            self:SetBackdrop({	bgFile = "",edgeFile = YugoMedia:Get(self.config.border.texture,"border"),edgeSize = self.config.border.size,tile = false,tileSize = 0,insets = {left = 0,right = 0,	top = 0,bottom = 0}})
        end

        self:SetBackdropColor(self.config.background.color.r, self.config.background.color.g, self.config.background.color.b, self.config.background.color.a)
        self:SetBackdropBorderColor(self.config.border.color.r, self.config.border.color.g, self.config.border.color.b, self.config.border.color.a)
        self.background:ClearAllPoints()
        self.background:SetPoint("TOPLEFT", self, "TOPLEFT", self.config.background.insets.l, self.config.background.insets.t);
        self.background:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", self.config.background.insets.r, self.config.background.insets.b);

        self:SetFrameLevel(self.config.level)
        self:SetFrameStrata(self.config.strata)
        self.background:SetDrawLayer("BACKGROUND", self.config.sub_level)

        ------- MouseMove
        self:SetMovable(self.config.moveable)
        self:EnableMouse(self.config.moveable)
        if self.config.moveable == true then
            self:SetScript("OnMouseDown", function() self:StartMoving() end)
            self:SetScript("OnMouseUp", function()
                self:StopMovingOrSizing()
                if self.config.save_moved_position == true then
                    self.save_position()
                end

            end)
            self:SetScript("OnDragStop", function() self:StopMovingOrSizing() end)
        else
            self:SetScript("OnMouseDown", nil)
            self:SetScript("OnMouseUp", nil)
            self:SetScript("OnDragStop", nil)
        end

        -- set position
        if self.config.save_moved_position == 2323 and self.has_db == true and self.config.position then
            local f = self.config.position
            local to
            if f.to then
                if not f.to.name then
                    to = f.to
                else
                    to = f.to.name
                end
            self:ClearAllPoints()

            self:SetPoint(f.this, to, f.that, f.x, f.y)
            end
        end


        if self.config.show_ooc == false then
            self:Hide()
        end

    end

    function self.set(...)
        table.setter(self.config, ...)
    end

    function self.set_apply(...)
        self.set(...)
        self.apply()
    end

    function self.get()
        return table.deepcopy(self.config)
    end

    function self.add_anchor(anchor)
        table.insert(self.config.anchors, anchor)
    end

    function self.clear_anchors()
        self.config.anchors = {}
    end

    function self.print_config()
        print_r(self.config)
    end

    function self.link_db(db, key)
        self.has_db = true
        self.db = db
    end

    function self.link_options(re, defaults, disabled)
        return Yugo:link_frame_options(self.db, re, defaults, disabled)
    end

    function self.register_as_anchor(friendlyName)
        Yugo.frameOptions.frames[self.name] = friendlyName
    end

    function self.save_position()
        print('saving position')
        if self.has_db == true then
            local points = self:GetNumPoints()
            for p = 1, points do
                local point, relativeTo, relativePoint, xOffset, yOffset = self:GetPoint(p)
                if not relativeTo then
                    relativeTo = 'UIParent'
                end

                print(relativeTo)
                self.db.anchors[p] = {
                    this = point,
                    to = relativeTo,
                    that = relativePoint,
                    x = xOffset,
                    y = yOffset
                };
            end

        end
    end

    function self.enable_position_save()
        self.config.save_moved_position = true
    end

    function self.disable_position_save()
        self.config.save_moved_position = false
        self.config.position = nil
    end

    function self.SetDisplayOptions()
        self.set(self.db)
        self.apply()
    end

    local base_CreateFontString = self.CreateFontString
    function self.CreateFontString(name, layer, inherits)
        if not layer then
            layer = "OVERLAY"
        end
        if not inherits then
            inherits = "GameFontHighlightSmall"
        end

        local baseFontString = base_CreateFontString(name, layer, inherits)

        local fontString = FontString(baseFontString)
        fontString.apply()
        return fontString
    end


    -- Events
    function self:PLAYER_REGEN_ENABLED()
        -- leaving combat
        if self.config.show_ooc == false then
            self:Hide()
        end

    end

    function self:PLAYER_REGEN_DISABLED()
        -- entering combat
        if self.config.show_ooc == false and self.config.enabled == true then
            self:Show()
        end
    end


    self:RegisterEvent("PLAYER_REGEN_ENABLED")
    self:RegisterEvent("PLAYER_REGEN_DISABLED")

    -- Defaults
    defaults()

    -- return the instance
    return self
end

--[[
local Container = BaseContainer("MainWindow")
local Container2 = BaseContainer("MainWindow")

    Container:CreateFontString()

Container.add_anchor({
    this = "TOPLEFT",
    that = "TOPLEFT",
    to = "UIParent",
    x = 0,
    y = 0
})
Container.add_anchor({
    this = "BOTTOMRIGHT",
    that = "BOTTOMRIGHT",
    to = "UIParent",
    x = 0,
    y = 0
})
Container.print_config()

   WORKS
Container.print_config()
Container.set('bg', 'gradient', 'r', 0.14)
Container.print_config()
Container.set('bg', 'gradient', { r = 0.5, g = 0.5 })
Container.print_config()
]]--


--[[
local function WidgetContainer(init, init2)
    local self = BaseContainer(init)

    self.public_field = init2

    -- this is independent from the base class's private field that has the same name
    local private_field = init2

    -- save the base version of foo for use in the derived version
    local base_foo = self.foo
    function self.foo()
        return private_field + self.public_field + base_foo()
    end

    -- return the instance
    return self
end

local Container = BaseContainer("CooldownContainer")
Container:set('height', 100)
Container:set('width', 50)
Container:clear_anchors()
Container:set('background', 'texture', 'Solid')
Container:apply()

local settings = Container:export()
Container:import(settings)
Container:apply()

local AvertHarm = CooldownWidget("Avert Harm")
Container:add_child(AvertHarm)
Container:apply_children()
Container:set_layout('LEFTRIGHT')
]]--