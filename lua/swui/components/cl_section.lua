--[[
    ---------------------------------------------------------
    SWUI - Section
    Proyecto Kamino
    ---------------------------------------------------------
]]

if SERVER then return end

local PANEL = {}

AccessorFunc(PANEL, "m_Title", "Title", FORCE_STRING)

function PANEL:Init()

    self:SetTall(SWUI.Scale(36))

    self:SetTitle("")

end

function PANEL:Paint(w, h)

    local t = SWUI.Theme

    draw.SimpleText(

        self:GetTitle(),

        "SWUI.Header",

        0,

        h * .5,

        t.White,

        TEXT_ALIGN_LEFT,

        TEXT_ALIGN_CENTER

    )

    surface.SetDrawColor(t.Border)

    surface.DrawRect(

        SWUI.Scale(180),

        h * .5,

        w - SWUI.Scale(190),

        1

    )

end

vgui.Register("SWSection", PANEL, "EditablePanel")