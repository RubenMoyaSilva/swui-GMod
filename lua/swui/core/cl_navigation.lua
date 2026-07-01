--[[
    ---------------------------------------------------------
    SWUI - Navigation
    Proyecto Kamino
    ---------------------------------------------------------
]]

if SERVER then return end

SWUI = SWUI or {}

SWUI.Pages = SWUI.Pages or {}

local CurrentPage

function SWUI.RegisterPage(id, callback)

    assert(isstring(id), "Page id must be a string.")
    assert(isfunction(callback), "Page callback must be a function.")

    SWUI.Pages[id] = callback

end

function SWUI.ClearContent()

    if not IsValid(SWUI.ContentPanel) then return end

    for _, child in ipairs(SWUI.ContentPanel:GetChildren()) do
        child:Remove()
    end

    CurrentPage = nil

end

function SWUI.Navigate(id)

    if not IsValid(SWUI.ContentPanel) then
        SWUI.Log.Error("ContentPanel does not exist.")
        return
    end

    local page = SWUI.Pages[id]

    if not page then
        SWUI.Log.Error("Page '" .. id .. "' is not registered.")
        return
    end

    SWUI.ClearContent()

    local panel = vgui.Create("EditablePanel", SWUI.ContentPanel)
    panel:Dock(FILL)

    panel.Paint = nil

    CurrentPage = panel

    page(panel)

    SWUI.State.CurrentPage = id

end

function SWUI.GetCurrentPage()

    return SWUI.State.CurrentPage

end