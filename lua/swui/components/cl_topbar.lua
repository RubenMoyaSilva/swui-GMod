--[[
    ---------------------------------------------------------
    SWUI - Top Bar
    Proyecto Kamino
    ---------------------------------------------------------
]]

if SERVER then return end

SWUI = SWUI or {}
local LogoMaterial = Material("swui/logo")
local BUTTONS = {
    { Name = "Inicio",     Page = "home"      },
    { Name = "Jugar",      Page = "play"      },
    { Name = "Personaje",  Page = "character" },
    { Name = "Tienda",     Page = "store"     },
    { Name = "Addons",     Page = "addons"    },
    { Name = "Sitio Web",  Page = "website"   },
    { Name = "Reglas",     Page = "rules"     }
}

function SWUI.CreateTopBar(parent)

    local topBar = vgui.Create("EditablePanel", parent)
    topBar:Dock(TOP)
    topBar:SetTall(95)

    topBar.Paint = function(self, w, h)

        local t = SWUI.Theme

        surface.SetDrawColor(8,12,18,250)
        surface.DrawRect(0,0,w,h)

        surface.SetDrawColor(t.Border)
        surface.DrawRect(0,h-2,w,2)

        surface.SetDrawColor(70,170,255,20)
        surface.DrawRect(0,h-6,w,6)

    end

    ---------------------------------------------------------
    -- Cabecera
    ---------------------------------------------------------

    local Header = vgui.Create("EditablePanel", topBar)
    Header:Dock(TOP)
    Header:SetTall(30)
    Header.Paint = nil

    local Version = vgui.Create("DLabel", Header)
    Version:Dock(RIGHT)
    Version:DockMargin(0,4,20,0)

    Version:SetFont("SWUI.Small")
    Version:SetTextColor(SWUI.Theme.TextSecondary)
    Version:SetText("SWUI v"..SWUI.Version)
    Version:SizeToContents()

    ---------------------------------------------------------
    -- Navegación
    ---------------------------------------------------------

    local Nav = vgui.Create("EditablePanel", topBar)
    Nav:Dock(FILL)

    Nav.Paint = function(self,w,h)

        surface.SetDrawColor(18,28,42,255)
        surface.DrawRect(0,0,w,1)

    end

    for _, data in ipairs(BUTTONS) do

        local btn = vgui.Create("DButton", Nav)

        btn:Dock(LEFT)
        btn:DockMargin(0,8,0,0)
        btn:SetWide(130)
        btn:SetText("")

        btn.ActiveAnim = 0

        btn.Think = function(self)

            local active = SWUI.GetCurrentPage and SWUI.GetCurrentPage() == data.Page

            self.ActiveAnim = Lerp(
                FrameTime() * 10,
                self.ActiveAnim,
                (active or self:IsHovered()) and 1 or 0
            )

        end

        btn.Paint = function(self,w,h)

            local t = SWUI.Theme

            draw.SimpleText(
                data.Name,
                "SWUI.Button",
                w * .5,
                h * .5 - 2,
                color_white,
                TEXT_ALIGN_CENTER,
                TEXT_ALIGN_CENTER
            )

            if self.ActiveAnim > 0.01 then

                surface.SetDrawColor(
                    70,
                    170,
                    255,
                    255 * self.ActiveAnim
                )

                surface.DrawRect(
                    20,
                    h - 4,
                    w - 40,
                    3
                )

            end

        end

        btn.DoClick = function()

            SWUI.Navigate(data.Page)

        end

    end

    ---------------------------------------------------------
    -- Acciones
    ---------------------------------------------------------

    local Actions = vgui.Create("EditablePanel", Nav)
    Actions:Dock(RIGHT)
    Actions:SetWide(280)
    Actions.Paint = nil

    local Close = vgui.Create("SWButton", Actions)
    Close:Dock(RIGHT)
    Close:DockMargin(8,10,8,8)
    Close:SetWide(90)
    Close:SetButtonText("Cerrar")

    Close.DoClick = function()

        SWUI.Close()

    end

    local GMod = vgui.Create("SWButton", Actions)
    GMod:Dock(RIGHT)
    GMod:DockMargin(8,10,0,8)
    GMod:SetWide(150)
    GMod:SetButtonText("Menú GMod")

    GMod.DoClick = function()

        SWUI.Close()

        timer.Simple(0,function()

            SWUI.OpenGameMenu()

        end)

    end

    return topBar

end