--[[
    ---------------------------------------------------------
    SWUI - Character Viewer
    Proyecto Kamino
    ---------------------------------------------------------
]]

if SERVER then return end

local PANEL = {}

function PANEL:Init()

    self.ModelPanel = vgui.Create("DModelPanel", self)
    self.ModelPanel:Dock(FILL)
    self.ModelPanel:SetFOV(32)

    self.ModelPanel:SetCamPos(Vector(55, -18, 60))
    self.ModelPanel:SetLookAt(Vector(0, 0, 55))

    self.Distance = 55
    self.Angle = 180

    self.Dragging = false

end

function PANEL:SetPlayer(ply)

    if not IsValid(ply) then return end

    self.ModelPanel:SetModel(ply:GetModel())

end

function PANEL:PerformLayout(w, h)

    self.ModelPanel:SetSize(w, h)

end

function PANEL:Paint(w, h)

    local t = SWUI.Theme

    draw.RoundedBox(
        0,
        0,
        0,
        w,
        h,
        t.SurfaceDark
    )

    surface.SetDrawColor(t.Border)
    surface.DrawOutlinedRect(0, 0, w, h, 1)

    surface.SetDrawColor(70,170,255,12)

    for i = 0, w, 24 do
        surface.DrawLine(i,0,i,h)
    end

    for i = 0, h, 24 do
        surface.DrawLine(0,i,w,i)
    end

end

function PANEL:Think()

    local ent = self.ModelPanel.Entity

    if not IsValid(ent) then return end

    if self.Dragging then

        self.Angle = self.Angle + gui.MouseX() * 0

    else

        self.Angle = self.Angle + FrameTime() * 15

    end

    ent:SetAngles(Angle(0,self.Angle,0))

end

function PANEL:OnMousePressed()

    self.Dragging = true

    self:MouseCapture(true)

end

function PANEL:OnMouseReleased()

    self.Dragging = false

    self:MouseCapture(false)

end

vgui.Register("SWCharacterViewer", PANEL, "EditablePanel")