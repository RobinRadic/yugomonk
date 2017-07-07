local Yugo = Yugo
local YugoMedia = YugoMedia

function FontString(obj)
    local self = obj
    ----------------------------
    ----- PRIVATES
    local name = self:GetName()

    local config = {
        name = name,
        font = "Yugo",
        size = 16,
        color = { r = 1, g = 1, b = 1, a = 1 },
        anchors = {
            {
                this = "CENTER",
                that = "CENTER",
                to = "UIParent",
                x = 0,
                y = 0
            }
        },
        flags = 'None'
    }

    function self.apply()

        self:ClearAllPoints()

        if config.flags == 'None' then
            config.flags = nil
        end

        self:SetFont( YugoMedia:Get(config.font, 'font'), config.size, config.flags )

        for k, anchor in pairs(config.anchors) do
            self:SetPoint(anchor.this, anchor.to, anchor.that, anchor.x, anchor.y)
        end

        self:SetVertexColor(config.color.r, config.color.g, config.color.b, config.color.a)

    end

    function self.set(...)
        table.setter(config, ...)
    end

    function self.set_apply(...)
        self.set(...)
        self.apply()
    end

    function self.get()
        return table.deepcopy(config)
    end

    function self.add_anchor(anchor)
        table.insert(config.anchors, anchor)
    end

    function self.clear_anchors()
        config.anchors = {}
    end

    function self.print_config()
        print_r(config)
    end

    function self.link_db(db, key)
        self.has_db = true
        self.db = db
    end

    function self.SetDisplayOptions()
        self.set(self.db)
        self.apply()
    end

    function self.link_options(re, disabled)
        return Yugo:link_fontstring_options(self.db, re, disabled)
    end

    -- return the instance
    return self
end
