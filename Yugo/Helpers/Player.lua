local Yugo = Yugo
Player = {}
local Player = Player

Player.registerEvents = {
}


function Player:GetRemainingBuffTime(aura)
    local name, _, _, _, _, _, expires, _, _, _, _, _, _, _, _, _ = UnitAura("player", aura)
    if name ~= nil then
        return expires - GetTime()
    end
    return
end

function Player:GetSpellCooldownTime(spell)
    local start, duration, _ = GetSpellCooldown(spell)
    if duration > 1 then
        local elapsed = GetTime() - start
        local remaining = duration - elapsed
        return elapsed, remaining
    end
    return
end


function Player:GetTalents()
    local talents = {}
    for i=1,18 do
        local name, iconPath, tier, column, active = GetTalentInfo(i)
        if not talents[tier] then talents[tier] = {} end
        talents[tier][column] = {
            name = name,
            icon = iconPath,
            active = active
        }
    end
    return talents
end
