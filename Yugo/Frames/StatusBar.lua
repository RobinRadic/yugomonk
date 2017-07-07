local Yugo = LibStub('AceAddon-3.0'):GetAddon('Yugo')
local StatusBar = Yugo:NewModule("StatusBar")

StatusBar.defaultOptions = {
    orientation = "VERTICAL",
    reverseFill = true,
    texture = "YugoBar",
    color = { r = 1, g = 1, b = 1, a = 1 },
    text = {
        size = 16,
        font = "YugoMonk",
        verticalPosition = "TOP",
        horizontalPosition = "CENTER"
    },
    inset = 4
}

function StatusBar:Create(name, parent)
    local bar = CreateFrame("StatusBar", name, parent)
    bar:SetMinMaxValues(0, 100)
    bar:SetValue(0)

    bar.name = name
    bar.parent = parent
    bar.text = bar:CreateFontString("YM_" .. name .. "_Text", "OVERLAY", "GameFontHighlightSmall")
    bar.options = table.copy(StatusBar.defaultOptions)


    local mt = getmetatable(bar)

    mt.__index.ApplyOptions = function(self)
        local options = self.options
        self:ClearAllPoints()
        self:SetPoint("TOPLEFT", self.parent, "TOPLEFT", options.inset, math.reverse(options.inset))
        self:SetPoint("BOTTOMRIGHT", self.parent, "BOTTOMRIGHT", math.reverse(options.inset), options.inset)
        self:SetOrientation(options.orientation)
        self:SetReverseFill(options.reverseFill)
        self:SetStatusBarTexture( Yugo.SML:Fetch("statusbar", options.texture), "Artwork")
        self:SetStatusBarColor(options.color.r, options.color.g, options.color.b, options.color.a)


        self.text:SetFont( Yugo.SML:Fetch("font", options.text.font), options.text.size)
        self.text:ClearAllPoints()
        self.text:SetPoint(options.text.verticalPosition, self , options.text.verticalPosition,0,0)
        self.text:SetPoint(options.text.horizontalPosition, self , options.text.horizontalPosition, 0, 0)
    end


    return bar
end

