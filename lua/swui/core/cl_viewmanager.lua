--[[
    ---------------------------------------------------------
    SWUI - View Manager
    Proyecto Kamino
    ---------------------------------------------------------
]]

if SERVER then return end

SWUI = SWUI or {}

SWUI.Views = SWUI.Views or {}

function SWUI.RegisterView(page, name, callback)

    SWUI.Views[page] = SWUI.Views[page] or {}

    SWUI.Views[page][name] = callback

end

function SWUI.OpenView(page, name, parent)

    if not SWUI.Views[page] then return false end

    local callback = SWUI.Views[page][name]

    if not callback then return false end

    parent:Clear()

    callback(parent)

    return true

end