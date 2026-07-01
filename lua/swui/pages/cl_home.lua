--[[
    ---------------------------------------------------------
    SWUI - Home
    Proyecto Kamino
    ---------------------------------------------------------
]]

if SERVER then return end

local LogoMaterial = Material("swui/logo")

SWUI.RegisterPage("home", function(parent)

    local Page = vgui.Create("SWPage", parent)
    Page:Dock(FILL)
    Page:SetTitle("INICIO")

    local Content = Page:GetContent()

    ---------------------------------------------------------
    -- Columna izquierda
    ---------------------------------------------------------

    local Left = vgui.Create("EditablePanel", Content)
    Left:Dock(LEFT)
    Left:SetWide(SWUI.Scale(520))
    Left.Paint = nil

    ---------------------------------------------------------
    -- Columna derecha
    ---------------------------------------------------------

    local Right = vgui.Create("EditablePanel", Content)
    Right:Dock(FILL)
    Right:DockMargin(SWUI.Scale(20),0,0,0)
    Right.Paint = nil

    ---------------------------------------------------------
    -- Bienvenida
    ---------------------------------------------------------

    local Welcome = vgui.Create("SWCard", Left)
    Welcome:Dock(TOP)
    Welcome:SetTall(SWUI.Scale(170))
    Welcome:SetTitle("Bienvenido")

    local WelcomeText = vgui.Create("DLabel", Welcome)

    WelcomeText:Dock(FILL)
    WelcomeText:DockMargin(20,60,20,20)

    WelcomeText:SetFont("SWUI.Text")
    WelcomeText:SetWrap(true)
    WelcomeText:SetTextColor(SWUI.Theme.Text)

    WelcomeText:SetText(string.format([[
Bienvenido %s.

Nos alegra tenerte en Proyecto Kamino.

Desde esta interfaz podrás acceder a todas las funciones principales del servidor.

¡Que tengas una buena estancia, soldado!
]], LocalPlayer():Nick()))

    ---------------------------------------------------------
    -- Estado del servidor
    ---------------------------------------------------------

    local Status = vgui.Create("SWCard", Left)
    Status:Dock(FILL)
    Status:DockMargin(0,20,0,0)
    Status:SetTitle("Estado del servidor")

    ---------------------------------------------------------
    -- Contenido
    ---------------------------------------------------------

    local Body = vgui.Create("DPanel", Status)
    Body:Dock(FILL)
    Body:DockMargin(15,55,15,15)
    Body.Paint = nil

    ---------------------------------------------------------
    -- Logo
    ---------------------------------------------------------

    local Logo = vgui.Create("DPanel", Body)
    Logo:Dock(TOP)
    Logo:SetTall(200)

    Logo.Paint = function(self,w,h)

        if LogoMaterial:IsError() then return end

        surface.SetMaterial(LogoMaterial)
        surface.SetDrawColor(color_white)

        local width = h * 2

        surface.DrawTexturedRect(
            (w-width)*0.5,
            0,
            width,
            h
        )

    end

    ---------------------------------------------------------
    -- Descripción
    ---------------------------------------------------------

    local Description = vgui.Create("DLabel", Body)
    Description:Dock(TOP)
    Description:SetTall(30)

    Description:SetFont("SWUI.Text")
    Description:SetText("Servidor Star Wars - Clone Wars")
    Description:SetContentAlignment(5)
    Description:SetTextColor(SWUI.Theme.TextSecondary)

    ---------------------------------------------------------
    -- Separador
    ---------------------------------------------------------

    local Separator = vgui.Create("DPanel", Body)
    Separator:Dock(TOP)
    Separator:DockMargin(20,20,20,20)
    Separator:SetTall(1)

    Separator.Paint = function(self,w,h)

        surface.SetDrawColor(
            SWUI.Theme.Border
        )

        surface.DrawRect(
            0,
            0,
            w,
            h
        )

    end

    ---------------------------------------------------------
    -- Lista estadísticas
    ---------------------------------------------------------

    local Stats = vgui.Create("DPanel", Body)
    Stats:Dock(FILL)
    Stats.Paint = nil

    local function AddStat(title,value)

        local Row = vgui.Create("SWStatRow", Stats)

        Row:Dock(TOP)
        Row:DockMargin(0,0,0,6)

        Row:SetTitle(title)
        Row:SetValue(value)

    end

    AddStat(
        "Jugadores",
        player.GetCount() .. "/" .. game.MaxPlayers()
    )

    AddStat(
        "Mapa",
        game.GetMap()
    )

    AddStat(
        "Ping",
        LocalPlayer():Ping() .. " ms"
    )
        ---------------------------------------------------------
    -- Noticias
    ---------------------------------------------------------

    local News = vgui.Create("SWCard", Right)
    News:Dock(FILL)
    News:SetTitle("Noticias")

    local NewsBody = vgui.Create("DPanel", News)
    NewsBody:Dock(FILL)
    NewsBody:DockMargin(20,60,20,20)
    NewsBody.Paint = nil

    local NewsTitle = vgui.Create("DLabel", NewsBody)
    NewsTitle:Dock(TOP)
    NewsTitle:SetTall(30)
    NewsTitle:SetFont("SWUI.Header")
    NewsTitle:SetText("Centro de comunicaciones")
    NewsTitle:SetTextColor(color_white)

    local NewsText = vgui.Create("DLabel", NewsBody)
    NewsText:Dock(FILL)
    NewsText:SetFont("SWUI.Text")
    NewsText:SetWrap(true)
    NewsText:SetAutoStretchVertical(true)
    NewsText:SetTextColor(SWUI.Theme.Text)

    NewsText:SetText([[
Bienvenido al sistema de comunicaciones de Proyecto Kamino.

Este panel será el centro de información del servidor y mostrará contenido actualizado en tiempo real.

Próximamente podrás consultar:

• Noticias del servidor.
• Eventos activos.
• Actualizaciones.
• Comunicados del Alto Mando.
• Mantenimiento programado.
• Información de batallones.
• Cambios de reglamento.
• Avisos administrativos.

Este contenido se sincronizará automáticamente con el servidor sin necesidad de reiniciar la interfaz.
]])

end)