--[[
    ---------------------------------------------------------
    SWUI - Escape Override
    Proyecto Kamino
    ---------------------------------------------------------
]]

if SERVER then return end

local openedFromEscape = false

hook.Add("OnPauseMenuShow", "SWUI.OverrideEscape", function()

    if SWUI.IsOpen() then return false end

    openedFromEscape = true

    SWUI.Open()

    return false

end)

function SWUI.OpenGameMenu()

    openedFromEscape = false

    gui.ActivateGameUI()

end