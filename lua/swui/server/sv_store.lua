--[[
    ---------------------------------------------------------
    SWUI - Store
    Server
    Proyecto Kamino
    ---------------------------------------------------------
]]

if CLIENT then return end

util.AddNetworkString("SWUI.Store.Buy")
util.AddNetworkString("SWUI.Store.Result")

---------------------------------------------------------
-- Buscar objeto
---------------------------------------------------------

local function GetItem(id)

    for _, item in ipairs(SWUI.Store.Items or {}) do

        if item.ID == id then
            return item
        end

    end

end

---------------------------------------------------------
-- Comprar
---------------------------------------------------------

net.Receive("SWUI.Store.Buy", function(_, ply)

    local id = net.ReadString()

    local item = GetItem(id)

    if not item then return end

    -----------------------------------------------------
    -- Permisos
    -----------------------------------------------------

    if item.CanBuy and not item.CanBuy(ply) then

        net.Start("SWUI.Store.Result")
            net.WriteBool(false)
            net.WriteString("No puedes comprar este objeto.")
        net.Send(ply)

        return

    end

    -----------------------------------------------------
    -- Dinero
    -----------------------------------------------------

    local money = ply:getDarkRPVar("money") or 0

    if money < item.Price then

        net.Start("SWUI.Store.Result")
            net.WriteBool(false)
            net.WriteString("No tienes suficientes créditos.")
        net.Send(ply)

        return

    end

    -----------------------------------------------------
    -- Cobrar
    -----------------------------------------------------

    ply:addMoney(-item.Price)

    -----------------------------------------------------
    -- Dar objeto
    -----------------------------------------------------

    if item.OnBuy then

        item.OnBuy(ply)

    end

    -----------------------------------------------------
    -- Respuesta
    -----------------------------------------------------

    net.Start("SWUI.Store.Result")
        net.WriteBool(true)
        net.WriteString("Compra realizada correctamente.")
    net.Send(ply)

end)