--[[
    ---------------------------------------------------------
    SWUI - Store
    Proyecto Kamino
    ---------------------------------------------------------
]] if SERVER then
    return
end

SWUI.RegisterPage("store", function(parent)

    ---------------------------------------------------------
    -- Página
    ---------------------------------------------------------

    local Page = vgui.Create("SWPage", parent)
    Page:Dock(FILL)
    Page:SetTitle("TIENDA")

    local Content = Page:GetContent()

    ---------------------------------------------------------
    -- Panel izquierdo
    ---------------------------------------------------------

    local Left = vgui.Create("SWCard", Content)
    Left:Dock(LEFT)
    Left:SetWide(ScrW() * 0.70)
    Left:SetTitle("CATÁLOGO")

    ---------------------------------------------------------

    local LeftContent = vgui.Create("EditablePanel", Left)
    LeftContent:Dock(FILL)
    LeftContent:DockMargin(15, 55, 15, 15)
    LeftContent.Paint = nil

    ---------------------------------------------------------
    -- Categorías
    ---------------------------------------------------------

    local Categories = vgui.Create("DIconLayout", LeftContent)
    Categories:Dock(TOP)
    Categories:SetTall(45)

    Categories:SetSpaceX(10)
    Categories:SetSpaceY(10)

    ---------------------------------------------------------
    -- Lista
    ---------------------------------------------------------

    local Scroll = vgui.Create("DScrollPanel", LeftContent)
    Scroll:Dock(FILL)
    Scroll:DockMargin(0, 15, 0, 0)

    local Grid = vgui.Create("DIconLayout", Scroll)
    Grid:Dock(TOP)

    Grid:SetSpaceX(15)
    Grid:SetSpaceY(15)

    ---------------------------------------------------------
    -- Panel derecho
    ---------------------------------------------------------

    local Right = vgui.Create("SWCard", Content)
    Right:Dock(FILL)
    Right:DockMargin(20, 0, 0, 0)
    Right:SetTitle("PREVISUALIZACIÓN")

    ---------------------------------------------------------

    local Preview = vgui.Create("EditablePanel", Right)
    Preview:Dock(FILL)
    Preview:DockMargin(15, 55, 15, 15)
    Preview.Paint = nil

    ---------------------------------------------------------
    -- Imagen
    ---------------------------------------------------------

    local Icon = vgui.Create("DModelPanel", Preview)
    Icon:Dock(TOP)
    Icon:SetTall(340)

    Icon:SetModel("models/Items/BoxMRounds.mdl")

    function Icon:LayoutEntity()

    end

    ---------------------------------------------------------
    -- Nombre
    ---------------------------------------------------------

    local Name = vgui.Create("DLabel", Preview)
    Name:Dock(TOP)
    Name:DockMargin(0, 15, 0, 0)

    Name:SetTall(35)

    Name:SetFont("SWUI.Title")
    Name:SetTextColor(color_white)
    Name:SetText("Selecciona un objeto")

    ---------------------------------------------------------
    -- Fabricante
    ---------------------------------------------------------

    local Manufacturer = vgui.Create("DLabel", Preview)
    Manufacturer:Dock(TOP)

    Manufacturer:SetTall(22)

    Manufacturer:SetFont("SWUI.Small")
    Manufacturer:SetTextColor(SWUI.Theme.TextSecondary)

    ---------------------------------------------------------
    -- Tipo
    ---------------------------------------------------------

    local Type = vgui.Create("DLabel", Preview)
    Type:Dock(TOP)
    Type:DockMargin(0, 0, 0, 12)

    Type:SetTall(22)

    Type:SetFont("SWUI.Text")
    Type:SetTextColor(color_white)

    ---------------------------------------------------------
    -- Estadísticas
    ---------------------------------------------------------

    local Stats = {}

    local StatNames = {{"Daño", "Damage"}, {"Cadencia", "FireRate"}, {"Precisión", "Accuracy"}, {"Alcance", "Range"},
                       {"Movilidad", "Mobility"}}
    local StatRows = {}

    for _, data in ipairs(StatNames) do

        local Row = vgui.Create("DPanel", Preview)
        table.insert(StatRows, Row)
        Row:Dock(TOP)
        Row:SetTall(22)
        Row:DockMargin(0, 0, 0, 4)

        Row.Paint = function(self, w, h)

            draw.SimpleText(data[1], "SWUI.Small", 0, h / 2, SWUI.Theme.TextSecondary, TEXT_ALIGN_LEFT,
                TEXT_ALIGN_CENTER)

            local value = Stats[data[2]] or 0

            local startX = 100
            local barW = 12
            local gap = 3

            for i = 1, 10 do

                local x = startX + (i - 1) * (barW + gap)

                surface.SetDrawColor(40, 50, 60, 255)
                surface.DrawRect(x, 4, barW, h - 8)

                if i <= value then

                    surface.SetDrawColor(70, 170, 255, 255)
                    surface.DrawRect(x, 4, barW, h - 8)

                end

            end

        end

    end

    ---------------------------------------------------------
    -- Precio
    ---------------------------------------------------------

    local Price = vgui.Create("DLabel", Preview)
    Price:Dock(TOP)
    Price:DockMargin(0, 15, 0, 0)

    Price:SetTall(26)

    Price:SetFont("SWUI.Header")
    Price:SetTextColor(SWUI.Theme.Accent)

    Price:SetText("")

    ---------------------------------------------------------
    -- Descripción
    ---------------------------------------------------------

    local Description = vgui.Create("DLabel", Preview)
    Description:Dock(TOP)
    Description:DockMargin(0, 15, 0, 0)

    Description:SetWrap(true)
    Description:SetAutoStretchVertical(true)

    Description:SetFont("SWUI.Text")
    Description:SetTextColor(SWUI.Theme.TextSecondary)

    Description:SetText("Selecciona un objeto para ver su información.")

    ---------------------------------------------------------
    -- Comprar
    ---------------------------------------------------------

    local Buy = vgui.Create("SWButton", Preview)
    Buy:Dock(BOTTOM)

    Buy:SetTall(48)
    Buy:SetButtonText("COMPRAR")
    Buy:SetEnabled(false)

    ---------------------------------------------------------
    -- Variables
    ---------------------------------------------------------

    local CurrentCategory = nil
    local SelectedItem = nil
    ---------------------------------------------------------
    -- Funciones
    ---------------------------------------------------------

    local function ClearGrid()

        for _, pnl in ipairs(Grid:GetChildren()) do
            pnl:Remove()
        end

    end

    local ModelOverrides = {

        rw_sw_dc17 = "models/sw_battlefront/weapons/dc17_blaster.mdl",
        rw_sw_dc17m = "models/fisher/extendeddc17/extendeddc17.mdl",
        rw_sw_dc15a = "models/sw_battlefront/weapons/dc15a_rifle.mdl",
        rw_sw_dc15s = "models/sw_battlefront/weapons/dc15s_carbine.mdl",
        rw_sw_westarm5 = "models/sw_battlefront/weapons/westar_m5_blaster_rifle.mdl"

    }

    local SearchFolders = {"models/cs574", "models/fisher", "models/player", "models/sw_battlefront", "models/swbf3",
                           "models/weapons"}

    local function SearchFolder(folder, search)

        local files, dirs = file.Find(folder .. "/*", "GAME")

        for _, fileName in ipairs(files) do

            if string.GetExtensionFromFilename(fileName) == "mdl" then

                local mdl = string.lower(string.StripExtension(fileName))

                if mdl == search or string.find(mdl, search, 1, true) or string.find(search, mdl, 1, true) then

                    return folder .. "/" .. fileName

                end

            end

        end

        for _, dir in ipairs(dirs) do

            local result = SearchFolder(folder .. "/" .. dir, search)

            if result then
                return result
            end

        end

    end

    local function GetModel(class)

        if not class then
            return "models/Items/BoxMRounds.mdl"
        end

        if ModelOverrides[class] then
            return ModelOverrides[class]
        end

        local name = string.lower(string.Replace(class, "rw_sw_", ""))
        local aliases = {

            dc19 = "e11",
            dc19le = "e11",
            dc15le = "dlt19",
            bino_white = "binocular",
            bino_dark = "binocular",
            bino_desert = "binocular"

        }

        if aliases[name] then
            name = aliases[name]
        end

        for _, folder in ipairs(SearchFolders) do

            local mdl = SearchFolder(folder, name)

            if mdl then
                return mdl
            end

        end

        return "models/Items/BoxMRounds.mdl"

    end

    local function SelectItem(item)

        SelectedItem = item

        Name:SetText(item.Name)

        Manufacturer:SetText(item.Manufacturer or "")
        Type:SetText(item.Type or "")

        Stats.Damage = item.Damage or 0
        Stats.FireRate = item.FireRate or 0
        Stats.Accuracy = item.Accuracy or 0
        Stats.Range = item.Range or 0
        Stats.Mobility = item.Mobility or 0

        Price:SetText(string.format("%s créditos", string.Comma(item.Price or 0)))

        Description:SetText(item.Description or "")
        local showStats = item.Category == "weapons"

        for _, row in ipairs(StatRows) do
            row:SetVisible(showStats)
        end

        Manufacturer:SizeToContentsY()
        Type:SizeToContentsY()

        Preview:InvalidateLayout(true)
        Preview:InvalidateParent(true)

        -----------------------------------------------------
        -- Modelo
        -----------------------------------------------------

        Icon:SetModel(GetModel(item.Class or item.Model))
        Icon:SetFOV(45)

        Buy:SetEnabled(true)

    end

    local function CreateItemCard(item)

        local Card = vgui.Create("SWCard", Grid)

        Card:SetSize(180, 220)
        Card:SetTitle("")
        Card:SetCursor("hand")

        Card.Paint = function(self, w, h)

            local bg = SWUI.Theme.Surface

            if SelectedItem == item then

                bg = SWUI.Theme.AccentDark

            elseif self:IsHovered() then

                bg = Color(35, 55, 85)

            end

            draw.RoundedBox(8, 0, 0, w, h, bg)

            surface.SetDrawColor(SWUI.Theme.Border)
            surface.DrawOutlinedRect(0, 0, w, h, 1)

        end

        local Model = vgui.Create("DModelPanel", Card)
        Model:Dock(FILL)
        Model:DockMargin(10, 10, 10, 0)

        -----------------------------------------------------
        -- Modelo automático
        -----------------------------------------------------

        Model:SetModel(GetModel(item.Class or item.Model))
        Model:SetFOV(45)

        function Model:PostDrawModel(ent)

            local mn, mx = ent:GetRenderBounds()
            local center = (mn + mx) * 0.5
            local radius = (mx - mn):Length()

            self:SetLookAt(center)
            self:SetCamPos(center + Vector(radius, radius, radius * 0.35))

        end

        function Model:LayoutEntity(ent)

            ent:SetAngles(Angle(0, 0, 0))

        end
        local Click = vgui.Create("DButton", Card)
        Click:SetPos(0, 0)
        Click:SetSize(Card:GetWide(), Card:GetTall())

        Click:SetText("")
        Click:SetDrawBackground(false)
        Click:SetTextColor(Color(0, 0, 0, 0))

        function Click:PerformLayout()

            self:SetSize(Card:GetWide(), Card:GetTall())

        end

        Click.DoClick = function()

            SelectItem(item)

        end

        -----------------------------------------------------
        -- Precio
        -----------------------------------------------------

        local Price = vgui.Create("DLabel", Card)
        Price:Dock(BOTTOM)
        Price:DockMargin(10, 0, 10, 5)

        Price:SetTall(18)
        Price:SetFont("SWUI.Small")
        Price:SetTextColor(SWUI.Theme.Accent)

        Price:SetText(string.Comma(item.Price) .. " créditos")

        -----------------------------------------------------
        -- Nombre
        -----------------------------------------------------

        local Name = vgui.Create("DLabel", Card)
        Name:Dock(BOTTOM)
        Name:DockMargin(10, 0, 10, 8)

        Name:SetTall(22)
        Name:SetFont("SWUI.Text")
        Name:SetTextColor(color_white)
        Name:SetContentAlignment(5)

        Name:SetText(item.Name)

    end

    local function LoadCategory(id)

        CurrentCategory = id

        ClearGrid()

        for _, item in ipairs(SWUI.Store.Items) do

            if item.Category == id then

                CreateItemCard(item)

            end

        end

        Grid:InvalidateLayout(true)
        Grid:SizeToChildren(false, true)

    end

    ---------------------------------------------------------
    -- Categorías
    ---------------------------------------------------------

    for _, category in ipairs(SWUI.Store.Categories) do

        local Button = vgui.Create("SWButton", Categories)

        Button:SetSize(150, 40)
        Button:SetButtonText(category.Name)

        Button.DoClick = function()

            LoadCategory(category.ID)

        end

    end
    ---------------------------------------------------------
    -- Comprar
    ---------------------------------------------------------

    Buy.DoClick = function()

        if not SelectedItem then
            return
        end

        net.Start("SWUI.Store.Buy")
        net.WriteString(SelectedItem.ID)
        net.SendToServer()

    end

    ---------------------------------------------------------
    -- Resultado compra
    ---------------------------------------------------------

    net.Receive("SWUI.Store.Result", function()

        local Success = net.ReadBool()
        local Message = net.ReadString()

        notification.AddLegacy(Message, Success and NOTIFY_GENERIC or NOTIFY_ERROR, 4)

        surface.PlaySound(Success and "buttons/button14.wav" or "buttons/button10.wav")

    end)

    ---------------------------------------------------------
    -- Inicio
    ---------------------------------------------------------

    if #SWUI.Store.Categories > 0 then

        LoadCategory(SWUI.Store.Categories[1].ID)

    end

end)
