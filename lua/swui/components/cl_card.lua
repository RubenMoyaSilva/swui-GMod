--[[
    ---------------------------------------------------------
    SWUI - Card
    Proyecto Kamino
    ---------------------------------------------------------
]]

if SERVER then return end

local PANEL = {}

AccessorFunc(PANEL, "m_Title", "Title", FORCE_STRING)

function PANEL:Init()

    self:SetTitle("")
    self.HeaderHeight = SWUI.Scale(42)

end

function PANEL:Paint(w, h)

    local t = SWUI.Theme

    ------------------------------------------
    -- Fondo principal
    ------------------------------------------

    surface.SetDrawColor(15, 22, 34, 245)
    surface.DrawRect(0, 0, w, h)

    ------------------------------------------
    -- Cabecera
    ------------------------------------------

    surface.SetDrawColor(18, 35, 55, 255)
    surface.DrawRect(0, 0, w, self.HeaderHeight)

    ------------------------------------------
    -- Línea inferior cabecera
    ------------------------------------------

    surface.SetDrawColor(t.Border)
    surface.DrawRect(
        SWUI.Scale(12),
        self.HeaderHeight - 2,
        w - SWUI.Scale(24),
        2
    )

    ------------------------------------------
    -- Borde exterior
    ------------------------------------------

    surface.SetDrawColor(t.Border)
    surface.DrawOutlinedRect(0, 0, w, h, 1)

    ------------------------------------------
    -- Esquinas estilo Clone Wars
    ------------------------------------------

    local c = SWUI.Scale(10)

    -- Superior izquierda
    surface.DrawLine(0, c, c, 0)

    -- Superior derecha
    surface.DrawLine(w - c, 0, w, c)

    -- Inferior izquierda
    surface.DrawLine(0, h - c, c, h)

    -- Inferior derecha
    surface.DrawLine(w - c, h, w, h - c)

    ------------------------------------------
    -- Brillo superior
    ------------------------------------------

    surface.SetDrawColor(70,170,255,25)
    surface.DrawRect(1,1,w-2,2)

    ------------------------------------------
    -- Título
    ------------------------------------------

    draw.SimpleText(

        self:GetTitle(),

        "SWUI.Header",

        SWUI.Scale(14),

        self.HeaderHeight * 0.5,

        color_white,

        TEXT_ALIGN_LEFT,

        TEXT_ALIGN_CENTER

    )

end

vgui.Register("SWCard", PANEL, "EditablePanel")