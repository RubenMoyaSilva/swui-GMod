--[[
    ---------------------------------------------------------
    SWUI - Store Configuration
    Proyecto Kamino
    ---------------------------------------------------------
]] SWUI = SWUI or {}
SWUI.Store = {}

---------------------------------------------------------
-- Constructores
---------------------------------------------------------

local function Preview(model, camPos, lookAt, fov, image, angle, zoom, material)

    return {
        Model = model,
        CamPos = camPos,
        LookAt = lookAt,
        FOV = fov,
        Image = image,

        Angle = angle or Angle(0, 0, 0),
        Zoom = zoom or 1,

        Material = material
    }

end

local function Stats(damage, fireRate, accuracy, range, mobility)

    return {
        Damage = damage,
        FireRate = fireRate,
        Accuracy = accuracy,
        Range = range,
        Mobility = mobility
    }

end

local function ApplyCompatibility(item)

    if item.Preview then
        item.Model = item.Preview.Model
        item.Image = item.Image or item.Preview.Image

        item.Angle = item.Preview.Angle
        item.Zoom = item.Preview.Zoom
        item.Material = item.Preview.Material

        item.Skin = item.Preview.Skin
        item.Material = item.Preview.Material
    end

    if item.Stats then
        item.Damage = item.Stats.Damage
        item.FireRate = item.Stats.FireRate
        item.Accuracy = item.Stats.Accuracy
        item.Range = item.Stats.Range
        item.Mobility = item.Stats.Mobility
    end

    return item

end

local function StoreItem(item)

    item.Stats = item.Stats or Stats(0, 0, 0, 0, 0)

    return ApplyCompatibility(item)

end

local function WeaponItem(item)

    local class = item.Class

    item.Category = item.Category or "weapons"
    item.Delivery = {
        Type = "weapon",
        Class = class
    }

    item.CanBuy = item.CanBuy or function(ply)

        return not ply:HasWeapon(class)

    end

    item.OnBuy = item.OnBuy or function(ply)

        ply:Give(class)

    end

    return StoreItem(item)

end

local function AmmoItem(item, ammoType, amount)

    item.Category = item.Category or "ammo"
    item.Class = nil
    item.Delivery = {
        Type = "ammo",
        AmmoType = ammoType,
        Amount = amount
    }

    item.CanBuy = item.CanBuy or function()

        return true

    end

    item.OnBuy = item.OnBuy or function(ply)

        ply:GiveAmmo(amount, ammoType, true)

    end

    return StoreItem(item)

end

---------------------------------------------------------
-- Categorias
---------------------------------------------------------

SWUI.Store.Categories = {{
    ID = "ammo",
    Name = "Munición",
    SortOrder = 1
}, {
    ID = "weapons",
    Name = "Armamento",
    SortOrder = 2
}, {
    ID = "medical",
    Name = "Medicina",
    SortOrder = 3
}, {
    ID = "equipment",
    Name = "Equipamiento",
    SortOrder = 4
}}

---------------------------------------------------------
-- Objetos
---------------------------------------------------------

SWUI.Store.Items = {AmmoItem({
    ID = "dc15a_ammo",
    Name = "Munición DC-15A",
    Price = 150,
    Manufacturer = "BlasTech Industries",
    Type = "Munición",
    Preview = Preview("models/Items/BoxMRounds.mdl", Vector(45, 45, 30), Vector(0, 0, 6), 28,
        "entities/tfa_ammo_special - copy"),
    Stats = Stats(0, 0, 0, 0, 0),
    Description = [[
Caja de munición estándar para los fusiles bláster DC-15A.

Contiene 120 proyectiles.
]]
}, "AR2", 120), AmmoItem({
    ID = "dc15s_ammo",
    Name = "Munición DC-15S",
    Price = 100,
    Manufacturer = "BlasTech Industries",
    Type = "Munición",
    Preview = Preview("models/Items/BoxMRounds.mdl", Vector(45, 45, 30), Vector(0, 0, 6), 28,
        "entities/tfa_ammo_special - copy"),
    Stats = Stats(0, 0, 0, 0, 0),
    Description = [[
Caja de munición estándar para las carabinas DC-15S.

Contiene 90 proyectiles.
]]
}, "SMG1", 90), WeaponItem({
    ID = "dc17",
    Name = "DC-17",
    Price = 250,
    Class = "rw_sw_dc17",
    Manufacturer = "BlasTech Industries",
    Type = "Pistola Bláster",
    Preview = Preview("models/sw_battlefront/weapons/dc17_blaster.mdl", Vector(30, -8, 2), Vector(0, 2, 0), 35,
        "entities/rw_sw_dc17", Angle(2, 25, 2), 0.85),
    Stats = Stats(4, 9, 8, 6, 10),
    Description = [[
Pistola bláster ligera utilizada por oficiales, pilotos y tropas especializadas.

Excelente como arma secundaria gracias a su alta cadencia y movilidad.
]]
}), WeaponItem({
    ID = "dc15le",
    Name = "DC-15LE",
    Price = 1000,
    Class = "rw_sw_dc15le",
    Manufacturer = "BlasTech Industries",
    Type = "Fusil Bláster",
    Preview = Preview("models/sw_battlefront/weapons/dc15a_rifle.mdl", Vector(30, -8, 2), Vector(0, 2, 2), 35,
        "entities/rw_sw_dc15le", Angle(2, 25, 2), 0.85),
    Stats = Stats(7, 7, 9, 8, 7),
    Description = [[
Versión de precisión del fusil DC-15.

Muy estable a media y larga distancia.
]]
}), WeaponItem({
    ID = "dc19",
    Name = "DC-19",
    Price = 1250,
    Class = "rw_sw_dc19",
    Manufacturer = "BlasTech Industries",
    Type = "Carabina Bláster",
    Preview = Preview("models/player/applesauce/228th/dc15s_carbine.mdl", Vector(30, -8, 2), Vector(0, 2, 2), 35,
        "entities/rw_sw_dc19", Angle(2, 25, 2), 0.85),
    Stats = Stats(6, 8, 8, 7, 8),
    Description = [[
Carabina bláster compacta.

Excelente equilibrio entre movilidad y potencia de fuego.
]]
}), WeaponItem({
    ID = "dc19le",
    Name = "DC-19LE",
    Price = 1800,
    Class = "rw_sw_dc19le",
    Manufacturer = "BlasTech Industries",
    Type = "Carabina Bláster",
    Preview = Preview("models/player/applesauce/228th/dc15s_carbine.mdl", Vector(30, -8, 2), Vector(0, 2, 2), 35,
        "entities/rw_sw_dc19le", Angle(2, 25, 2), 0.85),
    Stats = Stats(8, 8, 8, 8, 7),
    Description = [[
Versión mejorada de la DC-19.

Mayor potencia y precisión.
]]
}), WeaponItem({
    ID = "westarm5",
    Name = "WESTAR M5",
    Price = 2200,
    Class = "rw_sw_westarm5",
    Manufacturer = "MandalMotors",
    Type = "Fusil Bláster",
    Preview = Preview("models/sw_battlefront/weapons/westar_m5_blaster_rifle.mdl", Vector(30, -8, 2), Vector(0, 2, 0),
        35, "entities/rw_sw_westarm5", Angle(2, 25, 2), 0.85),
    Stats = Stats(8, 7, 8, 8, 8),
    Description = [[
Fusil bláster de origen mandaloriano.

Muy apreciado por su fiabilidad.
]]
}), WeaponItem({
    ID = "dp23",
    Name = "DP-23",
    Price = 2500,
    Class = "rw_sw_dp23",
    Manufacturer = "BlasTech Industries",
    Type = "Escopeta Bláster",
    Preview = Preview("models/cs574/weapons/dp23.mdl", Vector(30, -8, 2), Vector(0, 2, 0), 35, "entities/rw_sw_dp23"),
    Angle(2, 25, 2),
    0.85,
    Stats = Stats(10, 4, 5, 3, 6),
    Description = [[
Escopeta bláster de combate.

Devastadora a corta distancia, aunque pierde eficacia rápidamente a medida que aumenta la distancia.
]]
}), WeaponItem({
    ID = "dp24",
    Name = "DP-24",
    Price = 3000,
    Class = "rw_sw_dp24",
    Manufacturer = "BlasTech Industries",
    Type = "Escopeta Bláster",
    Preview = Preview("models/cs574/weapons/dp24.mdl", Vector(30, -8, 2), Vector(0, 2, 0), 35, "entities/rw_sw_dp24"),
    Angle(2, 25, 2),
    0.85,
    Stats = Stats(10, 5, 6, 4, 6),
    Description = [[
Versión mejorada de la DP-23.

Mayor estabilidad y mejor alcance manteniendo una enorme potencia a corta distancia.
]]
}), WeaponItem({
    ID = "dc17m",
    Name = "DC-17M",
    Price = 4000,
    Class = "rw_sw_dc17m",
    Manufacturer = "BlasTech Industries",
    Type = "Sistema Modular",
    Preview = Preview("models/fisher/extendeddc17/extendeddc17.mdl", Vector(30, -8, 2), Vector(0, 2, 0), 35,
        "entities/rw_sw_dc17m", Angle(2, 25, 2), 0.85),
    Stats = Stats(9, 8, 8, 8, 7),
    Description = [[
Sistema de armas modular empleado por las unidades ARC.

Combina una gran potencia de fuego con una elevada precisión.
]]
}), WeaponItem({
    ID = "bino_white",
    Name = "Binoculares Blancos",
    Category = "equipment",
    Price = 600,
    Class = "rw_sw_bino_white",
    Manufacturer = "Arakyd Industries",
    Type = "Óptica Militar",

    Preview = Preview("models/nate159/swbf2015/pewpew/electrobinocular.mdl", Vector(30, -8, 2), Vector(0, 2, 0), 35,
        "entities/rw_sw_bino_white", Angle(2, 25, 2), 0.85,
        "anthonyfuller/macrobinoculars/t_electrobinocularstd23_c_white"),

    Stats = Stats(0, 0, 0, 10, 10),
    Description = [[
Binoculares tácticos utilizados para reconocimiento y observación a larga distancia.

Ideales para exploradores y oficiales.
]]
}), WeaponItem({
    ID = "bino_dark",
    Name = "Binoculares Negros",
    Category = "equipment",
    Price = 600,
    Class = "rw_sw_bino_dark",
    Manufacturer = "Arakyd Industries",
    Type = "Óptica Militar",
    Preview = Preview("models/nate159/swbf2015/pewpew/electrobinocular.mdl", Vector(30, -8, 2), Vector(0, 2, 0), 35,
        "entities/rw_sw_bino_dark", Angle(2, 25, 2), 0.85,
        "anthonyfuller/macrobinoculars/t_electrobinocularstd23_c_dark"),
    Material = "anthonyfuller/macrobinoculars/t_electrobinocularstd23_c_dark",
    Stats = Stats(0, 0, 0, 10, 10),
    Description = [[
Versión oscura de los binoculares militares de la República.

Ofrecen las mismas prestaciones con una estética diferente.
]]
}), WeaponItem({
    ID = "bino_desert",
    Name = "Binoculares Desierto",
    Category = "equipment",
    Price = 600,
    Class = "rw_sw_bino_desert",
    Manufacturer = "Arakyd Industries",
    Type = "Óptica Militar",
    Preview = Preview("models/nate159/swbf2015/pewpew/electrobinocular.mdl", Vector(30, -8, 2), Vector(0, 2, 0), 35,
        "entities/rw_sw_bino_desert", Angle(2, 25, 2), 0.85, 0, ""),
    Stats = Stats(0, 0, 0, 10, 10),
    Description = [[
Binoculares con acabado desértico.

Especialmente utilizados durante operaciones en planetas áridos.
]]
})}
