local addonName, addon = ...
--local YugoMonk = LibStub("AceAddon-3.0"):GetAddon("YugoMonk")

local ldb = LibStub:GetLibrary("LibDataBroker-1.1", true)
if not ldb then return end

local plugin = ldb:NewDataObject(addonName, {
    type = "data source",
    text = "YugoMonk",
    icon = "Interface\\AddOns\\YugoMonk\\Textures\\brewery.bpl"
})


function plugin.OnClick(self, button)
    if button == "LeftButton" then
        LibStub("AceConfigDialog-3.0"):Open("YugoMonk")
    else
        if IsShiftKeyDown() then
            ReloadUI()
        elseif IsAltKeyDown() then
           -- addon:Reset()
        --elseif BugSackFrame and BugSackFrame:IsShown() then
          --  addon:CloseSack()
        else
          --  addon:OpenSack()
        end
    end
end

do
    function plugin.OnTooltipShow(tt)
        tt:AddLine('YugoMonk! Left click for configuration.')
    end
end

local f = CreateFrame("Frame")
f:SetScript("OnEvent", function()
    local icon = LibStub("LibDBIcon-1.0", true)
    if not icon then return end
   icon:Register(addonName, plugin, YugoDB)
end)
f:RegisterEvent("PLAYER_LOGIN")

