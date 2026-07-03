--[[
    ---------------------------------------------------------
    SWUI - Play Page
    Proyecto Kamino
    ---------------------------------------------------------
]]

if SERVER then return end

SWUI.RegisterPage("play", function(parent)

    ---------------------------------------------------------
    -- Página
    ---------------------------------------------------------

    local Page = vgui.Create("SWPage", parent)
    Page:Dock(FILL)
    Page:SetTitle("JUGAR")

    local Content = Page:GetContent()

    ---------------------------------------------------------
    -- Estado
    ---------------------------------------------------------

    local CurrentFaction = nil
    local CurrentBattalion = nil
    local PendingTeamID = nil

    ---------------------------------------------------------
    -- Panel izquierdo
    ---------------------------------------------------------

    local Left = vgui.Create("SWCard", Content)
    Left:Dock(LEFT)
    Left:SetTitle("DESPLIEGUE")

    local LeftContent = vgui.Create("EditablePanel", Left)
    LeftContent:Dock(FILL)
    LeftContent:DockMargin(15,55,15,15)
    LeftContent.Paint = nil

    ---------------------------------------------------------
    -- Ruta
    ---------------------------------------------------------

    local Breadcrumb = vgui.Create("DLabel", LeftContent)
    Breadcrumb:Dock(TOP)
    Breadcrumb:SetTall(28)

    Breadcrumb:SetFont("SWUI.Header")
    Breadcrumb:SetTextColor(color_white)
    Breadcrumb:SetText("Selecciona una facción")

    ---------------------------------------------------------
    -- Contenedor dinámico
    ---------------------------------------------------------

    local Browser = vgui.Create("EditablePanel", LeftContent)
    Browser:Dock(FILL)
    Browser:DockMargin(0,15,0,0)
    Browser.Paint = nil

    ---------------------------------------------------------
    -- Panel derecho
    ---------------------------------------------------------

    local Right = vgui.Create("SWCard", Content)
    Right:Dock(FILL)
    Right:DockMargin(20,0,0,0)
    Right:SetTitle("PREVISUALIZACIÓN")
    Content.PerformLayout = function(self, w, h)
            
        Left:SetWide(w * 0.70)

    end

    ---------------------------------------------------------

    local Preview = vgui.Create("EditablePanel", Right)
    Preview:Dock(FILL)
    Preview:DockMargin(15,55,15,15)
    Preview.Paint = nil

    ---------------------------------------------------------
    -- Modelo
    ---------------------------------------------------------

    local Model = vgui.Create("DModelPanel", Preview)
    Model:Dock(TOP)
    Model:SetTall(590)

    Model:SetModel(LocalPlayer():GetModel())

    Model:SetFOV(36)
    Model:SetCamPos(Vector(100,50,38))
    Model:SetLookAt(Vector(0,0,38))

    function Model:LayoutEntity(ent)

        ent:SetAngles(
            Angle(
                0,
                RealTime() * 15,
                0
            )
        )

    end

    ---------------------------------------------------------
    -- Nombre
    ---------------------------------------------------------

    local Name = vgui.Create("DLabel", Preview)
    Name:Dock(TOP)
    Name:DockMargin(0,60,0,0)
    Name:SetTall(20)

    Name:SetFont("SWUI.Title")
    Name:SetTextColor(color_white)
    Name:SetText("Sin selección")

    ---------------------------------------------------------
    -- Batallón
    ---------------------------------------------------------

    local Battalion = vgui.Create("DLabel", Preview)
    Battalion:Dock(TOP)

    Battalion:SetTall(20)

    Battalion:SetFont("SWUI.Header")
    Battalion:SetTextColor(SWUI.Theme.Accent)
    Battalion:SetText("")

    ---------------------------------------------------------
    -- Separador
    ---------------------------------------------------------

    local Divider = vgui.Create("DPanel", Preview)
    Divider:Dock(TOP)
    Divider:DockMargin(0,5,0,8)
    Divider:SetTall(1)

    Divider.Paint = function(self,w,h)

        surface.SetDrawColor(SWUI.Theme.Border)
        surface.DrawRect(0,0,w,h)

    end

    ---------------------------------------------------------
    -- Descripción
    ---------------------------------------------------------

    local Description = vgui.Create("DLabel", Preview)
    Description:Dock(TOP)

    Description:SetWrap(true)
    Description:SetAutoStretchVertical(true)
    Description:SetContentAlignment(7)

    Description:SetFont("SWUI.Text")
    Description:SetTextColor(SWUI.Theme.TextSecondary)

    Description:SetText([[
        - Selecciona una facción.
        - Después selecciona un batallón.
        - Finalmente selecciona un trabajo.
        ]])

    ---------------------------------------------------------
    -- Salario
    ---------------------------------------------------------

    local Salary = vgui.Create("DLabel", Preview)
    Salary:Dock(TOP)
    Salary:DockMargin(0,8,0,0)

    Salary:SetTall(24)

    Salary:SetFont("SWUI.Text")
    Salary:SetTextColor(color_white)
    Salary:SetText("")

    ---------------------------------------------------------
    -- Botón
    ---------------------------------------------------------

    local Deploy = vgui.Create("SWButton", Preview)
    Deploy:Dock(BOTTOM)
    Deploy:SetTall(40)

    Deploy:SetButtonText("DESPLEGAR")
    Deploy:SetEnabled(false)
    Deploy:SetVisible(false)

    ---------------------------------------------------------
    -- Utilidades
    ---------------------------------------------------------

    local function ClearBrowser()

        for _, pnl in ipairs(Browser:GetChildren()) do
            pnl:Remove()
        end

    end

    local function CreateGrid()

    local Scroll = vgui.Create("DScrollPanel", Browser)
    Scroll:Dock(FILL)

    local Grid = vgui.Create("DIconLayout", Scroll)

    Grid:Dock(TOP)
    Grid:DockMargin(0,0,0,10)

    function Grid:Think()
        self:SetWide(Scroll:GetWide())
    end
    Grid:SetSpaceX(10)
    Grid:SetSpaceY(20)
    Grid:DockMargin(0,0,0,10)

    function Grid:PerformLayout()

        local spacingX = self:GetSpaceX()
        local spacingY = self:GetSpaceY()
        local maxWidth = self:GetWide()

        local x = 0
        local y = 0

        local row = {}
        local rowWidth = 0
        local rowHeight = 0

        local function LayoutRow()

            if #row == 0 then return end

            local startX = math.max((maxWidth - rowWidth) * 0.5, 0)

            local offset = startX

            for _, pnl in ipairs(row) do

                pnl:SetPos(offset, y)

                offset = offset + pnl:GetWide() + spacingX

            end

            y = y + rowHeight + spacingY

            row = {}
            rowWidth = 0
            rowHeight = 0

        end

        for _, pnl in ipairs(self:GetChildren()) do

            if not IsValid(pnl) then continue end

            local w = pnl:GetWide()
            local h = pnl:GetTall()

            local needed = (#row == 0) and w or (rowWidth + spacingX + w)

            if needed > maxWidth and #row > 0 then
                LayoutRow()
            end

            if #row == 0 then
                rowWidth = w
            else
                rowWidth = rowWidth + spacingX + w
            end

            rowHeight = math.max(rowHeight, h)

            table.insert(row, pnl)

            end

            LayoutRow()

            self:SetTall(y)

        end

        return Grid

    end

    ---------------------------------------------------------
    -- Obtener batallón
    ---------------------------------------------------------

    local function GetBattalion(job)

        return job.batallon or "Otros"

    end

    ---------------------------------------------------------
    -- Declaración de funciones
    ---------------------------------------------------------

    local ShowFactions
    local ShowBattalions
    local ShowJobs
    local SelectJob
        ---------------------------------------------------------
    -- Crear tarjeta
    ---------------------------------------------------------

    local function CreateCard(parent, title, image, model, callback, fill)

        local Card = vgui.Create("SWCard", parent)
        print("CreateCard:", title)
        Card:SetTitle("")

            if fill then
                Card:Dock(FILL)
            else
                Card:SetSize(260, 250)
            end

        -----------------------------------------------------
        -- Imagen
        -----------------------------------------------------

        local Preview = vgui.Create("DPanel", Card)
        Preview:Dock(FILL)
        Preview:DockMargin(10,10,10,10)

        Preview.Paint = nil

        if model then

            local mdl = istable(model) and model[1] or model

            local Model = vgui.Create("DModelPanel", Preview)
            Model:Dock(FILL)
            Model:SetModel(mdl)

            Model:SetFOV(22)
            Model:SetCamPos(Vector(90, 0, 38))
            Model:SetLookAt(Vector(0, 0, 67))

            function Model:LayoutEntity(ent)
                -- Sin rotación
            end

        else

            local Mat = image and Material(image) or nil

            Preview.Paint = function(self,w,h)

                if Mat and not Mat:IsError() then

                    surface.SetDrawColor(color_white)
                    surface.SetMaterial(Mat)

                    local Size = math.min(w - 20, h - 40)

                    surface.DrawTexturedRect(
                        (w - Size) * .5,
                        10,
                        Size,
                        Size
                    )

                else

                    draw.SimpleText(
                        "SIN IMAGEN",
                        "SWUI.Small",
                        w * .5,
                        h * .5,
                        SWUI.Theme.TextSecondary,
                        TEXT_ALIGN_CENTER,
                        TEXT_ALIGN_CENTER
                    )

                end

            end

        end

        -----------------------------------------------------
        -- Botón
        -----------------------------------------------------

        local Button = vgui.Create("SWButton", Card)
        Button:Dock(BOTTOM)
        Button:DockMargin(10,0,10,10)
        Button:SetTall(38)

        Button:SetButtonText(title)

        Button.DoClick = callback

        return Card

    end

    ---------------------------------------------------------
    -- Mostrar facciones
    ---------------------------------------------------------

    ShowFactions = function()

        CurrentFaction = nil
        CurrentBattalion = nil
        SelectedJob = nil

        ClearBrowser()

        Breadcrumb:SetText("Selecciona una facción")

        local Container = vgui.Create("EditablePanel", Browser)
        Container:Dock(FILL)
        Container.Paint = nil

        local LeftCard = vgui.Create("EditablePanel", Container)
        LeftCard:Dock(LEFT)
        LeftCard:SetWide(0)
        LeftCard.Paint = nil

        local RightCard = vgui.Create("EditablePanel", Container)
        RightCard:Dock(FILL)
        RightCard:DockMargin(10, 0, 0, 0)
        RightCard.Paint = nil
        Container.PerformLayout = function(self, w, h)
            LeftCard:SetWide((w - 10) * 0.5)
        end

        -----------------------------------------------------
        -- República
        -----------------------------------------------------

        local Republic = CreateCard(

            LeftCard,

            "REPÚBLICA",

            "swui/batallones/republica",

            nil,

            function()

                ShowBattalions("REPUBLIC")

            end,

            true

        )
        -----------------------------------------------------
        -- CIS
        -----------------------------------------------------

        local CIS = CreateCard(
            
            RightCard,

            "CIS",

            "swui/batallones/cis",

            nil,

            function()

                ShowBattalions("CIS")

            end,

            true

        )

    end

    ---------------------------------------------------------
    -- Mostrar batallones
    ---------------------------------------------------------

    ShowBattalions = function(faction)
        CurrentFaction = faction
        CurrentBattalion = nil
        SelectedJob = nil

        ClearBrowser()

        Breadcrumb:SetText(faction)

        -----------------------------------------------------
        -- Volver
        -----------------------------------------------------

        local Back = vgui.Create("SWButton", Browser)
        Back:Dock(TOP)
        Back:SetTall(40)
        Back:SetButtonText("← Volver")

        Back.DoClick = ShowFactions

        -----------------------------------------------------
        -- Cuadrícula
        -----------------------------------------------------

        local Grid = CreateGrid()
        Grid:DockMargin(0,10,0,0)

        -----------------------------------------------------
        -- Detectar batallones
        -----------------------------------------------------

        local Battalions = {}

        for _, job in ipairs(RPExtraTeams) do

            if job.category ~= faction then
                continue
            end

            local Battalion = GetBattalion(job)

            Battalions[Battalion] = true

        end

        -----------------------------------------------------
        -- Orden
        -----------------------------------------------------

        local List = {}

        for Battalion in pairs(Battalions) do

            table.insert(List,Battalion)

        end

        table.sort(List)

        -----------------------------------------------------
        -- Crear tarjetas
        -----------------------------------------------------

        for _, Battalion in ipairs(List) do

            CreateCard(

                Grid,

                Battalion,

                "swui/batallones/" .. string.lower(Battalion),

                nil,

                function()

                    ShowJobs(Battalion)

                end

            )

        end

    end
    
    ---------------------------------------------------------
    -- Seleccionar trabajo
    ---------------------------------------------------------

    SelectJob = function(job)

        SelectedJob = job
        PendingTeamID = job.__TeamID

        Name:SetText(job.name or "Desconocido")

        Battalion:SetText(GetBattalion(job))

        Description:SetText(job.description or "Sin descripción.")

        Salary:SetText("Salario: " .. tostring(job.salary or 0))

        if istable(job.model) then
            Model:SetModel(job.model[1])
        else
            Model:SetModel(job.model or LocalPlayer():GetModel())
        end

        Deploy:SetVisible(false)
        Deploy:SetEnabled(false)

        net.Start("SWUI.CheckJobAccess")
            net.WriteUInt(job.__TeamID, 16)
        net.SendToServer()
    
    end

    ---------------------------------------------------------
    -- Mostrar trabajos
    ---------------------------------------------------------

    ShowJobs = function(battalion)

        CurrentBattalion = battalion
        SelectedJob = nil

        ClearBrowser()

        Breadcrumb:SetText(CurrentFaction .. " > " .. battalion)

        -----------------------------------------------------
        -- Botón volver
        -----------------------------------------------------

        local Back = vgui.Create("SWButton", Browser)
        Back:Dock(TOP)
        Back:SetTall(40)
        Back:SetButtonText("← Volver")

        Back.DoClick = function()

            ShowBattalions(CurrentFaction)

        end

        -----------------------------------------------------
        -- Cuadrícula
        -----------------------------------------------------

        local Grid = CreateGrid()
        Grid:DockMargin(0,50,0,0)

        -----------------------------------------------------
        -- Crear tarjetas
        -----------------------------------------------------

        for teamID, job in ipairs(RPExtraTeams) do

            if job.category ~= CurrentFaction then
                continue
            end

            if GetBattalion(job) ~= battalion then
                continue
            end

            CreateCard(

                Grid,

                job.name,

                nil,
                job.model,

                function()

                    job.__TeamID = teamID
                    SelectJob(job)

                end

            )

        end

    end

    ---------------------------------------------------------
    -- Botón desplegar
    ---------------------------------------------------------

    Deploy.DoClick = function()

        if not SelectedJob then return end

        if not SelectedJob.command then return end

        RunConsoleCommand(
            "say",
            "/" .. SelectedJob.command
        )

        timer.Simple(0.1, function()

            SWUI.Close()

        end)

    end

    ---------------------------------------------------------
    -- Inicio
    ---------------------------------------------------------
    net.Receive("SWUI.JobAccessResult", function()

        local teamID = net.ReadUInt(16)
        local canAccess = net.ReadBool()

        if PendingTeamID ~= teamID then return end

        Deploy:SetVisible(canAccess)
        Deploy:SetEnabled(canAccess)

    end)

    ShowFactions()

end)