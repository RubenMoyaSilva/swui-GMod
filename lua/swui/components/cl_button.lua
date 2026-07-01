--[[
    ---------------------------------------------------------
    SWUI - Button
    Proyecto Kamino
    ---------------------------------------------------------
]]

if SERVER then return end

local PANEL = {}

AccessorFunc(PANEL, "m_Text", "ButtonText", FORCE_STRING)

function PANEL:Init()

    self:SetText("")
    self:SetButtonText("")

    self.Hover = 0

end

function PANEL:Think()

    self.Hover = Lerp(
        FrameTime() * 10,
        self.Hover,
        self:IsHovered() and 1 or 0
    )

end

function PANEL:Paint(w,h)

    local t = SWUI.Theme

    local bg = Color(
        Lerp(self.Hover, t.Surface.r, 35),
        Lerp(self.Hover, t.Surface.g, 60),
        Lerp(self.Hover, t.Surface.b, 90),
        240
    )

    draw.RoundedBox(
        0,
        0,
        0,
        w,
        h,
        bg
    )

    surface.SetDrawColor(t.Border)

    surface.DrawOutlinedRect(
        0,
        0,
        w,
        h,
        1
    )

    ------------------------------------------------
    -- Esquinas holográficas
    ------------------------------------------------

    local c = 8

    surface.DrawLine(0,0,c,0)
    surface.DrawLine(0,0,0,c)

    surface.DrawLine(w-c,0,w,0)
    surface.DrawLine(w-1,0,w-1,c)

    surface.DrawLine(0,h-c,0,h)
    surface.DrawLine(0,h-1,c,h-1)

    surface.DrawLine(w-c,h-1,w,h-1)
    surface.DrawLine(w-1,h-c,w-1,h)

    ------------------------------------------------

    draw.SimpleText(

        self:GetButtonText(),

        "SWUI.Button",

        w * .5,

        h * .5,

        Color(255,255,255),

        TEXT_ALIGN_CENTER,

        TEXT_ALIGN_CENTER

    )

end

vgui.Register("SWButton", PANEL, "DButton")