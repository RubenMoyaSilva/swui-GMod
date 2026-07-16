--[[
    ---------------------------------------------------------
    SWUI - F4 Override
    Proyecto Kamino
    ---------------------------------------------------------
]]

if SERVER then return end

local waitingRelease = false

-- Bloquea el F4 del DarkRP
hook.Add("ShowSpare2", "SWUI_BlockDarkRPF4", function()
    return true
end)

-- Detecta F4 para abrir/cerrar el menú
hook.Add("Think", "SWUI.F4Toggle", function()

    if waitingRelease then
        if not input.IsKeyDown(KEY_F4) then
            waitingRelease = false
        end
        return
    end

    if input.IsKeyDown(KEY_F4) then
        waitingRelease = true

        if SWUI and SWUI.Toggle then
            SWUI.Toggle()
        end
    end

end)