--[[
    ---------------------------------------------------------
    SWUI - Core
    Proyecto Kamino
    ---------------------------------------------------------
]]

if SERVER then return end

SWUI = SWUI or {}

SWUI.MainFrame = nil
SWUI.RootPanel = nil
SWUI.ContentPanel = nil

function SWUI.IsOpen()

    return IsValid(SWUI.MainFrame)

end

function SWUI.Close()

    if not SWUI.IsOpen() then return end

    SWUI.MainFrame:Remove()

    SWUI.MainFrame = nil
    SWUI.RootPanel = nil
    SWUI.ContentPanel = nil

end

function SWUI.Build()

    -------------------------------------------------
    -- Frame
    -------------------------------------------------

    local Frame = vgui.Create("EditablePanel")

    Frame:SetSize(ScrW(), ScrH())
    Frame:SetPos(0,0)

    Frame:MakePopup()

    Frame:SetKeyboardInputEnabled(true)
    Frame:SetMouseInputEnabled(true)

    Frame.Paint = function(self, w, h)

    local t = SWUI.Theme

    -------------------------------------
    -- Fondo principal
    -------------------------------------

    surface.SetDrawColor(t.Background)
    surface.DrawRect(0, 0, w, h)

    -------------------------------------
    -- Grid holográfico
    -------------------------------------

    surface.SetDrawColor(70,170,255,8)

    local spacing = SWUI.Scale(40)

    for x = 0, w, spacing do
        surface.DrawLine(x,0,x,h)
    end

    for y = 0, h, spacing do
        surface.DrawLine(0,y,w,y)
    end

    -------------------------------------
    -- Líneas de escaneo
    -------------------------------------

    surface.SetDrawColor(255,255,255,2)

    for y = 0,h,2 do
        surface.DrawLine(0,y,w,y)
    end

    -------------------------------------
    -- Glow superior
    -------------------------------------

    draw.RoundedBox(
        0,
        0,
        0,
        w,
        SWUI.Scale(180),
        Color(70,170,255,12)
    )

end

    SWUI.MainFrame = Frame

    -------------------------------------------------
    -- Root
    -------------------------------------------------

    local Root = vgui.Create("EditablePanel",Frame)

    Root:Dock(FILL)

    Root.Paint = function(self,w,h)

        draw.RoundedBox(
            0,
            0,
            0,
            w,
            h,
            SWUI.Theme.Background
        )

    end

    SWUI.RootPanel = Root

    -------------------------------------------------
    -- TopBar
    -------------------------------------------------

    SWUI.CreateTopBar(Root)

    -------------------------------------------------
    -- Content
    -------------------------------------------------

    SWUI.ContentPanel = vgui.Create("EditablePanel",Root)

    SWUI.ContentPanel:Dock(FILL)
    SWUI.ContentPanel.Paint = nil

    -------------------------------------------------
    -- Página inicial
    -------------------------------------------------

    SWUI.Navigate("home")

end

function SWUI.Open()

    if SWUI.IsOpen() then return end

    SWUI.Build()

end

function SWUI.Toggle()

    if SWUI.IsOpen() then
        SWUI.Close()
    else
        SWUI.Open()
    end

end

concommand.Add("swui_open",function()

    SWUI.Open()

end)

concommand.Add("swui_close",function()

    SWUI.Close()

end)

concommand.Add("swui_toggle",function()

    SWUI.Toggle()

end)