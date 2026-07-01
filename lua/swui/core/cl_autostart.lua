--[[
    ---------------------------------------------------------
    SWUI - Auto Start
    Proyecto Kamino
    ---------------------------------------------------------
]]

if SERVER then return end

local function OpenSWUI()

    timer.Simple(2, function()

        if not IsValid(LocalPlayer()) then return end
        if SWUI.IsOpen() then return end

        SWUI.Open()

    end)

end

hook.Add("InitPostEntity", "SWUI.AutoOpen", OpenSWUI)