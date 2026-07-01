--[[
    ---------------------------------------------------------
    SWUI - Utils
    Proyecto Kamino
    ---------------------------------------------------------
]]

if SERVER then return end

SWUI = SWUI or {}

local BASE_WIDTH = 1920
local BASE_HEIGHT = 1080

function SWUI.Scale(value)

    return math.Round(value * math.min(ScrW() / BASE_WIDTH, ScrH() / BASE_HEIGHT))

end

function SWUI.ScaleX(value)

    return math.Round(value * (ScrW() / BASE_WIDTH))

end

function SWUI.ScaleY(value)

    return math.Round(value * (ScrH() / BASE_HEIGHT))

end