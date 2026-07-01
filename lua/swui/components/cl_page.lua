--[[
    ---------------------------------------------------------
    SWUI - Base Page
    Proyecto Kamino
    ---------------------------------------------------------
]]

if SERVER then return end

local PANEL = {}

AccessorFunc(PANEL, "m_Title", "Title", FORCE_STRING)

function PANEL:Init()

    self:SetTitle("")

    self:DockPadding(
        SWUI.Scale(25),
        SWUI.Scale(25),
        SWUI.Scale(25),
        SWUI.Scale(25)
    )

    -------------------------------------------------
    -- Cabecera
    -------------------------------------------------

    self.Header = vgui.Create("SWSection", self)
    self.Header:Dock(TOP)

    -------------------------------------------------
    -- Contenido
    -------------------------------------------------

    self.Content = vgui.Create("EditablePanel", self)
    self.Content:Dock(FILL)
    self.Content:DockMargin(0, SWUI.Scale(20), 0, 0)
    self.Content.Paint = nil

end

function PANEL:SetTitle(title)

    self.m_Title = title

    if IsValid(self.Header) then
        self.Header:SetTitle(title)
    end

end

function PANEL:GetContent()

    return self.Content

end

function PANEL:Paint(w, h)

end

vgui.Register("SWPage", PANEL, "EditablePanel")