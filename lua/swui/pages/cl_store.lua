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

    function Icon:LayoutEntity(ent)

        local ang = Angle(0, RealTime() * 20 % 360, 0)

        if SelectedItem and SelectedItem.Angle then
            ang = ang + SelectedItem.Angle
        end

        ent:SetAngles(ang)

        if SelectedItem then

            local material = nil

            if SelectedItem.Preview then
                material = SelectedItem.Preview.Material
            end

            if (not material or material == "") and element.material and element.material ~= "" then
                material = element.material
            end

            local skin = SelectedItem.Skin or 0

            ent:SetSkin(skin)

            if material and material ~= "" then
                ent:SetMaterial(material)
            else
                ent:SetMaterial("")
            end

        end

    end

    function Icon:PostDrawModel(ent)

        if SelectedItem and SelectedItem.Preview then
            return
        end

        local mn, mx = ent:GetRenderBounds()

        local center = (mn + mx) * 0.5
        local size = (mx - mn):Length()

        local dist = math.Clamp(size * 0.7, 18, 90)

        self:SetLookAt(center)
        self:SetCamPos(center + Vector(dist, dist, dist * 0.3))

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

    local function SelectItem(item)

        SelectedItem = item

        Name:SetText(item.Name)

        Manufacturer:SetText(item.Manufacturer or "")
        Type:SetText(item.Type or "")

        local stats = item.Stats or {}

        Stats.Damage = stats.Damage or 0
        Stats.FireRate = stats.FireRate or 0
        Stats.Accuracy = stats.Accuracy or 0
        Stats.Range = stats.Range or 0
        Stats.Mobility = stats.Mobility or 0

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

        if item.Preview then

            local preview = item.Preview

            Icon:SetModel(preview.Model)

            local zoom = preview.Zoom or 1

            Icon:SetCamPos(preview.CamPos * zoom)
            Icon:SetLookAt(preview.LookAt)
            Icon:SetFOV(preview.FOV or 45)

        else

            Icon:SetModel("models/Items/BoxMRounds.mdl")
            Icon:SetCamPos(Vector(18, 18, 18))
            Icon:SetLookAt(Vector(0, 0, 0))
            Icon:SetFOV(45)

        end

        Buy:SetEnabled(true)

    end

    local function CreateItemCard(item)

        local Card = vgui.Create("SWCard", Grid)

        Card:SetSize(235, 140)
        Card:SetTitle("")
        Card:SetCursor("hand")

        Card.Paint = function(self, w, h)

            local bg = Color(48, 48, 48)

            if SelectedItem == item then
                bg = Color(80, 80, 80)
            elseif self:IsHovered() then
                bg = Color(65, 65, 65)
            end

            surface.SetDrawColor(bg)
            surface.DrawRect(0, 0, w, h)

            surface.SetDrawColor(80, 80, 80)
            surface.DrawOutlinedRect(0, 0, w, h)

            -- Esquina superior izquierda
            draw.NoTexture()

            surface.SetDrawColor(90, 90, 90)

            surface.DrawPoly({{
                x = 0,
                y = 0
            }, {
                x = 26,
                y = 0
            }, {
                x = 0,
                y = 26
            }})

        end

        local Model = vgui.Create("DModelPanel", Card)
        Model:SetPos(8, 8)
        Model:SetSize(220, 92)

        if item.Preview then

            Model:SetModel(item.Preview.Model)
            -----------------------------------------------------
            -- Datos del SWEP
            -----------------------------------------------------

            local zoom = item.Preview.Zoom or 1

            Model:SetCamPos(item.Preview.CamPos * zoom)
            Model:SetLookAt(item.Preview.LookAt)
            Model:SetFOV(item.Preview.FOV or 45)

        else

            Model:SetModel("models/Items/BoxMRounds.mdl")
            Model:SetCamPos(Vector(18, 18, 18))
            Model:SetLookAt(Vector(0, 0, 0))
            Model:SetFOV(45)

        end

        function Model:PostDrawModel(ent)

            if item.Preview then
                return
            end

            local mn, mx = ent:GetRenderBounds()

            local center = (mn + mx) * 0.5
            local size = (mx - mn):Length()

            local dist = math.Clamp(size * 0.7, 18, 90)

            self:SetLookAt(center)
            self:SetCamPos(center + Vector(dist, dist, dist * 0.3))

        end

        function Model:LayoutEntity(ent)

            if item.Angle then
                ent:SetAngles(item.Angle)
            else
                ent:SetAngles(angle_zero)
            end

            local material = item.Material

            if item.Preview and item.Preview.Material and item.Preview.Material ~= "" then
                material = item.Preview.Material
            end

            ent:SetSkin(item.Skin or 0)

            if material and material ~= "" then
                ent:SetMaterial(material)
            else
                ent:SetMaterial("")
            end

            -------------------------------------------------
            -- Bodygroups
            -------------------------------------------------

            if item.Bodygroups then

                for id, value in pairs(item.Bodygroups) do
                    ent:SetBodygroup(id, value)
                end

            end

            -------------------------------------------------
            -- SubMaterials
            -------------------------------------------------

            if item.SubMaterials then

                for id, mat in pairs(item.SubMaterials) do
                    ent:SetSubMaterial(id, mat)
                end

            end
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
        Price:Dock(NODOCK)
        Price:SetPos(10, 120)
        Price:SetSize(210, 14)

        Price:SetTall(18)
        Price:SetFont("SWUI.Small")
        Price:SetTextColor(SWUI.Theme.Accent)
        Price:SetContentAlignment(4)

        Price:SetText(string.Comma(item.Price) .. " créditos")

        -----------------------------------------------------
        -- Nombre
        -----------------------------------------------------

        local Name = vgui.Create("DLabel", Card)
        Name:Dock(NODOCK)
        Name:SetPos(10, 104)
        Name:SetSize(210, 18)

        Name:SetTall(22)
        Name:SetFont("SWUI.Small")
        Name:SetTextColor(color_white)
        Name:SetContentAlignment(4)

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
