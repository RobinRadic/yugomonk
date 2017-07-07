local Yugo = LibStub("AceAddon-3.0"):GetAddon("Yugo")
local YugoMonk = YugoMonk

function AlertFrame(name)
    local self = Frame(name)

    local config = {}

    local stacked = 0

    local positions = {}

    for count = 1, 15 do
        positions[count] = {
            offset = (255 - (count * 16)),
            filled = false
        }
    end

    self.set({
        height = 400,
        width = 250,
        moveable = false,
        background = {
            texture = "None"
        },
        border = {
            texture = 'None'
        }

    })
    self.clear_anchors()
    self.add_anchor({
        this = "BOTTOMLEFT",
        that = "TOPLEFT",
        to = "YM_GuardFrame",
        x = 0,
        y = 0
    })
    self.apply()

    local base_apply = self.apply
    function self.apply()


        base_apply()
    end

    local base_set = self.set
    function self.set(...)
        base_set(...)
    end

    local base_print_config = self.print_config
    function self.print_config()
        print_r(config)
        base_print_config()
    end

    function self.alert(message)
        local alert = self:CreateFontString(name .. "_Alert", "OVERLAY", "GameFontHighlightSmall")
        alert.clear_anchors()
        alert.add_anchor({
            this = "CENTER",
            that = "CENTER",
            to = self,
            x = 0,
            y = 0
        })
        alert.add_anchor({
            this = "TOP",
            that = "TOP",
            to = self,
            x = 0,
            y = 0
        })
        alert.set('parent', self)
        alert.apply()
        alert:SetText(message)


        alert.ag = alert:CreateAnimationGroup()
        alert.ag:SetScript("OnFinished", function(self, requested)

            alert:Hide()
        end)

        alert.ag.path = alert.ag:CreateAnimation("Path")
        alert.ag.alpha = alert.ag:CreateAnimation("Alpha")
        alert.ag.path.a = alert.ag.path:CreateControlPoint()

        alert.ag.path:SetCurve("SMOOTH")
        alert.ag.path:SetDuration(1.0)
        alert.ag.path.a:SetOffset(0, -240)
        alert.ag.path.a:SetOrder(1)

        alert.ag.alpha:SetDuration(3.0)
        alert.ag.alpha:SetChange(-1.0)
        alert.ag.alpha:SetOrder(2)

        --alert.ag.rot:SetDuration(2.0)
        --alert.ag.rot:SetDegrees(360)
        --alert.ag.rot:SetOrder(3)
        alert.ag:Play()

    end

    -- return the instance
    return self
end
--[[
Alert = Alert()
Alert:set({
    mode = "text",
    type = "warning",
    text = "Warning, Transandeance out of range",
    till = "Trans_In_Range"
})
Alert:apply()
AlertFrame:alert(Alert)
AlertFrame:event("Trans_In_Range")
]]--