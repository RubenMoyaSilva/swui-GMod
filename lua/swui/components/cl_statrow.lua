--[[
    ---------------------------------------------------------
    SWUI - Stat Row
    Proyecto Kamino
    ---------------------------------------------------------
]]

if SERVER then return end

local PANEL = {}

AccessorFunc(PANEL, "m_Title", "Title", FORCE_STRING)
AccessorFunc(PANEL, "m_Value", "Value", FORCE_STRING)

function PANEL:Init()

    self:SetTall(34)

    self:SetTitle("")
    self:SetValue("")

end

function PANEL:Paint(w, h)

    local theme = SWUI.Theme

    if self:IsHovered() then
        draw.RoundedBox(4, 0, 0, w, h, Color(22, 35, 55, 180))
    end

    draw.SimpleText(
        self:GetTitle(),
        "SWUI.Text",
        12,
        h * .5,
        theme.TextSecondary,
        TEXT_ALIGN_LEFT,
        TEXT_ALIGN_CENTER
    )

    draw.SimpleText(
        self:GetValue(),
        "SWUI.Text",
        w - 12,
        h * .5,
        theme.White,
        TEXT_ALIGN_RIGHT,
        TEXT_ALIGN_CENTER
    )

end

vgui.Register("SWStatRow", PANEL, "DPanel")