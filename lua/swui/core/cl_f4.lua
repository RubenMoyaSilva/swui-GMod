--[[
    ---------------------------------------------------------
    SWUI - F4 Override
    Proyecto Kamino
    ---------------------------------------------------------
]]

if SERVER then return end

hook.Add("ShowSpare2", "SWUI.OpenF4", function()

    if SWUI and SWUI.Open then
        SWUI.Open()
    end

    return true

end)