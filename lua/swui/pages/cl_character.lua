--[[
    ---------------------------------------------------------
    SWUI - Character Page V2
    Proyecto Kamino
    ---------------------------------------------------------
]]

if SERVER then return end

SWUI.RegisterPage("character", function(parent)

    parent:DockPadding(20,20,20,20)

    ---------------------------------------------------------
    -- Utilidades
    ---------------------------------------------------------

    local function FormatPlayTime(seconds)

        seconds = math.max(0, math.floor(seconds or 0))

        local h = math.floor(seconds / 3600)
        local m = math.floor((seconds % 3600) / 60)

        return string.format("%dh %02dm", h, m)

    end

    local function GetPlayTime()

        local ply = LocalPlayer()

        if ply.GetUTimeTotalTime then
            return ply:GetUTimeTotalTime()
        end

        if ply.GetUTime then
            return ply:GetUTime()
        end

        return 0

    end

    ---------------------------------------------------------
    -- Color del trabajo
    ---------------------------------------------------------

    local function GetJobColor()

        local teamData = RPExtraTeams and RPExtraTeams[LocalPlayer():Team()]

        if teamData and teamData.color then
            return teamData.color
        end

        return Color(70,170,255)

    end

    local JobColor = GetJobColor()

    ---------------------------------------------------------
    -- Cabecera
    ---------------------------------------------------------

    local Header = vgui.Create("EditablePanel", parent)
    Header:Dock(TOP)
    Header:SetTall(80)
    Header.Paint = nil

    local Title = vgui.Create("DLabel", Header)
    Title:Dock(LEFT)

    Title:SetFont("SWUI.Title")
    Title:SetText("PERSONAJE")
    Title:SetTextColor(color_white)
    Title:SizeToContents()

    ---------------------------------------------------------
    -- Panel principal
    ---------------------------------------------------------

    local Main = vgui.Create("DPanel", parent)
    Main:Dock(TOP)
    Main:SetTall(620)

    Main.Paint = function(self,w,h)

        draw.RoundedBox(
            6,
            0,
            0,
            w,
            h,
            Color(8,12,18,235)
        )

        surface.SetDrawColor(255,255,255,255)
        surface.DrawOutlinedRect(0,0,w,h,2)

    end
        ---------------------------------------------------------
    -- Contenedor
    ---------------------------------------------------------

    local Body = vgui.Create("EditablePanel", Main)
    Body:Dock(FILL)
    Body:DockMargin(25,25,25,25)
    Body.Paint = nil

    ---------------------------------------------------------
    -- Panel izquierdo (Modelo)
    ---------------------------------------------------------

    local Left = vgui.Create("DPanel", Body)
    Left:Dock(LEFT)
    Left:SetWide(460)

    Left.Paint = function(self,w,h)

        draw.RoundedBox(
            4,
            0,
            0,
            w,
            h,
            Color(10,18,28,220)
        )

        surface.SetDrawColor(255,255,255,255)
        surface.DrawOutlinedRect(
            0,
            0,
            w,
            h,
            2
        )

        -----------------------------------------------------
        -- Glow
        -----------------------------------------------------

        surface.SetDrawColor(
            JobColor.r,
            JobColor.g,
            JobColor.b,
            10
        )

        surface.DrawRect(
            0,
            0,
            w,
            h
        )

        -----------------------------------------------------
        -- Esquinas holográficas
        -----------------------------------------------------

        local c = JobColor

        surface.SetDrawColor(c)

        local s = 26

        -- Superior izquierda
        surface.DrawRect(0,0,s,2)
        surface.DrawRect(0,0,2,s)

        -- Superior derecha
        surface.DrawRect(w-s,0,s,2)
        surface.DrawRect(w-2,0,2,s)

        -- Inferior izquierda
        surface.DrawRect(0,h-2,s,2)
        surface.DrawRect(0,h-s,2,s)

        -- Inferior derecha
        surface.DrawRect(w-s,h-2,s,2)
        surface.DrawRect(w-2,h-s,2,s)

    end

    ---------------------------------------------------------
    -- Modelo
    ---------------------------------------------------------

    local Model = vgui.Create("DModelPanel", Left)
    Model:Dock(FILL)
    Model:DockMargin(20,20,20,20)

    Model:SetModel(LocalPlayer():GetModel())

    Model:SetFOV(22)

    Model:SetCamPos(
        Vector(90,-18,60)
    )

    Model:SetLookAt(
        Vector(0,0,58)
    )

    function Model:LayoutEntity(ent)

        ent:SetAngles(
            Angle(
                0,
                35,
                0
            )
        )

    end

    ---------------------------------------------------------
    -- Fondo holográfico
    ---------------------------------------------------------

    local Overlay = vgui.Create("DPanel", Left)
    Overlay:SetZPos(-1)
    Overlay:Dock(FILL)
    Overlay:SetMouseInputEnabled(false)

    Overlay.Paint = function(self,w,h)

        local c = JobColor

        ------------------------------------------
        -- Círculos
        ------------------------------------------

        surface.SetDrawColor(
            c.r,
            c.g,
            c.b,
            6
        )

        for i=1,5 do

            surface.DrawOutlinedRect(
                w*0.5-(i*45),
                h*0.5-(i*45),
                i*90,
                i*90
            )

        end

        ------------------------------------------
        -- Grid inferior
        ------------------------------------------

        surface.SetDrawColor(
            c.r,
            c.g,
            c.b,
            8
        )

        ------------------------------------------
        -- Líneas holográficas ascendentes
        ------------------------------------------

        local spacing = 18
        local speed = 18

        local offset = (RealTime() * speed) % spacing

        surface.SetDrawColor(
            c.r,
            c.g,
            c.b,
            8
        )

        for y = h + spacing, -spacing, -spacing do

            surface.DrawLine(
                0,
                y - offset,
                w,
                y - offset
            )

        end

    end

            ---------------------------------------------------------
            -- Panel derecho
            ---------------------------------------------------------

            local Right = vgui.Create("EditablePanel", Body)
            Right:Dock(FILL)
            Right:DockMargin(25,0,0,0)
            Right.Paint = nil
                ---------------------------------------------------------
            -- Nombre del clon
            ---------------------------------------------------------

            local Name = vgui.Create("DLabel", Right)
            Name:Dock(TOP)
            Name:SetTall(70)

            Name:SetFont("SWUI.Title")
            Name:SetText(LocalPlayer():Nick())
            Name:SetTextColor(color_white)

            ---------------------------------------------------------
            -- Separador central
            ---------------------------------------------------------

            local Divider = vgui.Create("DPanel", Right)
            Divider:Dock(TOP)
            Divider:SetTall(35)
            Divider:DockMargin(0,0,0,25)

            Divider.Paint = function(self,w,h)

                surface.SetDrawColor(
                    JobColor.r,
                    JobColor.g,
                    JobColor.b,
                    180
                )

                surface.DrawRect(
                    0,
                    h*0.5,
                    w*0.42,
                    2
                )

                surface.DrawRect(
                    w*0.58,
                    h*0.5,
                    w*0.42,
                    2
                )

                draw.RoundedBox(
                    4,
                    w*0.5-18,
                    h*0.5-18,
                    36,
                    36,
                    Color(
                        12,
                        18,
                        28
                    )
                )

                surface.SetDrawColor(255,255,255,255)

                surface.DrawOutlinedRect(
                    w*0.5-18,
                    h*0.5-18,
                    36,
                    36,
                    2
                )

                draw.SimpleText(
                    "✦",
                    "SWUI.Header",
                    w*0.5,
                    h*0.5,
                    JobColor,
                    TEXT_ALIGN_CENTER,
                    TEXT_ALIGN_CENTER
                )

            end

    ---------------------------------------------------------
    -- Panel información
    ---------------------------------------------------------

    local Info = vgui.Create("EditablePanel", Right)
    Info:Dock(FILL)
    Info.Paint = nil

    ---------------------------------------------------------
    -- Filas
    ---------------------------------------------------------

    local function CreateRow(icon,title,value)

        local Row = vgui.Create("DPanel", Info)
        Row:Dock(TOP)
        Row:SetTall(65)
        Row:DockMargin(0,0,0,6)

        Row.Paint = function(self,w,h)

            surface.SetDrawColor(
                JobColor.r,
                JobColor.g,
                JobColor.b,
                35
            )

            surface.DrawLine(
                0,
                h-1,
                w,
                h-1
            )

        end

        -----------------------------------------------------
        -- Icono
        -----------------------------------------------------

        local Icon = vgui.Create("DPanel", Row)
        Icon:Dock(LEFT)
        Icon:SetWide(42)

        Icon.Paint = function(self, w, h)

            print("ICON:", icon)

            surface.SetDrawColor(255,255,255,255)
            surface.SetMaterial(icon)

            local size = 28

            surface.DrawTexturedRect(
                (w - size) / 2,
                (h - size) / 2,
                size,
                size
            )

        end

        -----------------------------------------------------
        -- Nombre
        -----------------------------------------------------

        local L = vgui.Create("DLabel", Row)
        L:Dock(LEFT)
        L:SetWide(220)

        L:SetFont("SWUI.Header")
        L:SetText(title)
        L:SetTextColor(JobColor)

        -----------------------------------------------------
        -- Valor
        -----------------------------------------------------

        local V = vgui.Create("DLabel", Row)
        V:Dock(FILL)

        V:SetFont("SWUI.Header")
        V:SetContentAlignment(6)

        V:SetTextColor(color_white)
        V:SetText(value)

    end

    ---------------------------------------------------------
    -- Datos
    ---------------------------------------------------------

    local TeamName = "Desconocido"

    if LocalPlayer().getDarkRPVar then

        TeamName =
            LocalPlayer():getDarkRPVar("job")
            or
            "Desconocido"

    end

    CreateRow(
        SWUI.Icons.Job,
        "Batallón",
        TeamName
    )

    CreateRow(
        SWUI.Icons.Clock,
        "Tiempo jugado",
        FormatPlayTime(GetPlayTime())
    )

    CreateRow(
        SWUI.Icons.Credits,
        "Créditos",
        LocalPlayer().getDarkRPVar
            and
            DarkRP.formatMoney(
                LocalPlayer():getDarkRPVar("money") or 0
            )
            or
            "$0"
    )
        ---------------------------------------------------------
    -- Estadísticas
    ---------------------------------------------------------

    local StatsCard = vgui.Create("DPanel", parent)
    StatsCard:Dock(FILL)
    StatsCard:DockMargin(0,20,0,0)

    StatsCard.Paint = function(self,w,h)

        draw.RoundedBox(
            6,
            0,
            0,
            w,
            h,
            Color(8,12,18,235)
        )

        surface.SetDrawColor(255,255,255,255)
        surface.DrawOutlinedRect(
            0,
            0,
            w,
            h,
            2
        )

        draw.SimpleText(
            "ESTADÍSTICAS",
            "SWUI.Title",
            20,
            20,
            color_white
        )

    end

    ---------------------------------------------------------
    -- Contenedor
    ---------------------------------------------------------

    local StatsBody = vgui.Create("DIconLayout", StatsCard)
    StatsBody:Dock(FILL)
    StatsBody:DockMargin(20,70,20,20)

    StatsBody:SetSpaceX(15)
    StatsBody:SetSpaceY(15)

    ---------------------------------------------------------
    -- Tarjeta
    ---------------------------------------------------------

    local function CreateStat(icon,title,value)

        local Card = StatsBody:Add("DPanel")
        Card:SetSize(175,125)

        Card.Paint = function(self,w,h)

            local hovered = self:IsHovered()

            draw.RoundedBox(
                4,
                0,
                0,
                w,
                h,
                hovered
                    and Color(24,38,55,255)
                    or Color(16,24,36,220)
            )

            surface.SetDrawColor(255,255,255,255)
            surface.DrawOutlinedRect(
                0,
                0,
                w,
                h,
                1
            )

            if hovered then

                surface.SetDrawColor(
                    JobColor.r,
                    JobColor.g,
                    JobColor.b,
                    18
                )

                surface.DrawRect(
                    0,
                    0,
                    w,
                    h
                )

            end

        end

        local Img = vgui.Create("DPanel", Card)

        Img:SetSize(24,24)
        Img:SetPos(15,15)

        Img.Paint = function(self,w,h)

            surface.SetDrawColor(255,255,255,255)
            surface.SetMaterial(icon)

            surface.DrawTexturedRect(
                0,
                0,
                w,
                h
            )

        end

        local Title = vgui.Create("DLabel", Card)
        Title:SetPos(50,12)
        Title:SetSize(110,24)

        Title:SetFont("SWUI.Small")
        Title:SetText(string.upper(title))
        Title:SetTextColor(JobColor)

        local Value = vgui.Create("DLabel", Card)
        Value:Dock(BOTTOM)
        Value:SetTall(55)

        Value:SetFont("SWUI.Title")
        Value:SetContentAlignment(5)
        Value:SetTextColor(color_white)
        Value:SetText(tostring(value))

    end

    ---------------------------------------------------------
    -- Datos
    ---------------------------------------------------------

    local deaths = LocalPlayer():Deaths()
    local frags = LocalPlayer():Frags()

    local kd = deaths > 0
        and string.format("%.2f", frags / deaths)
        or tostring(frags)

    CreateStat(
        SWUI.Icons.Kills,
        "Kills",
        frags
    )

    CreateStat(
        SWUI.Icons.Deaths,
        "Muertes",
        deaths
    )

    CreateStat(
        SWUI.Icons.KD,
        "K/D",
        kd
    )
    ---------------------------------------------------------
    -- Actualización automática
    ---------------------------------------------------------

    Main.Think = function()

        local ply = LocalPlayer()

        -----------------------------------------------------
        -- Modelo
        -----------------------------------------------------

        if IsValid(Model) and Model:GetModel() ~= ply:GetModel() then

            Model:SetModel(
                ply:GetModel()
            )

        end

        -----------------------------------------------------
        -- Nombre
        -----------------------------------------------------

        if IsValid(Name) and Name:GetText() ~= ply:Nick() then

            Name:SetText(
                ply:Nick()
            )

        end

        -----------------------------------------------------
        -- Trabajo
        -----------------------------------------------------

        if ply.getDarkRPVar then

            local job =
                ply:getDarkRPVar("job")
                or
                "Desconocido"

            if TeamName ~= job then

                TeamName = job

            end

        end

    end

    ---------------------------------------------------------
    -- Overlay holográfico
    ---------------------------------------------------------

    local Overlay = vgui.Create("DPanel", Main)
    Overlay:Dock(FILL)
    Overlay:SetMouseInputEnabled(false)

    Overlay.Paint = function(self,w,h)

        local alpha = 8 + math.sin(RealTime()*2) * 4

        surface.SetDrawColor(
            JobColor.r,
            JobColor.g,
            JobColor.b,
            alpha
        )

        -----------------------------------------------------
        -- Glow superior
        -----------------------------------------------------

        surface.DrawRect(
            0,
            0,
            w,
            2
        )

        -----------------------------------------------------
        -- Glow inferior
        -----------------------------------------------------

        surface.DrawRect(
            0,
            h-2,
            w,
            2
        )

        -----------------------------------------------------
        -- Glow izquierdo
        -----------------------------------------------------

        surface.DrawRect(
            0,
            0,
            2,
            h
        )

        -----------------------------------------------------
        -- Glow derecho
        -----------------------------------------------------

        surface.DrawRect(
            w-2,
            0,
            2,
            h
        )

    end

    ---------------------------------------------------------
    -- Fondo animado
    ---------------------------------------------------------

    local Background = vgui.Create("DPanel", Main)
    Background:SetZPos(-100)
    Background:Dock(FILL)
    Background:SetMouseInputEnabled(false)

    Background.Paint = function(self,w,h)

        local c = JobColor

        surface.SetDrawColor(
            c.r,
            c.g,
            c.b,
            5
        )

        local spacing = 40
        local offset = (RealTime()*15)%spacing

        for x=-spacing,w+spacing,spacing do

            surface.DrawLine(
                x+offset,
                0,
                x-spacing+offset,
                h
            )

        end

    end

end)