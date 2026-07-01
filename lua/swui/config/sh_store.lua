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

local function Preview(model, camPos, lookAt, fov)
    return {
        Model = model,
        CamPos = camPos,
        LookAt = lookAt,
        FOV = fov
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

---------------------------------------------------------
-- Categorías
---------------------------------------------------------

SWUI.Store.Categories = {{
    ID = "ammo",
    Name = "Munición"
}, {
    ID = "weapons",
    Name = "Armamento"
}, {
    ID = "medical",
    Name = "Medicina"
}, {
    ID = "equipment",
    Name = "Equipamiento"
}}

---------------------------------------------------------
-- Objetos
---------------------------------------------------------

SWUI.Store.Items = { -----------------------------------------------------
-- Munición DC-15A
-----------------------------------------------------
{

    ID = "dc15a_ammo",

    Name = "Munición DC-15A",

    Category = "ammo",

    Price = 150,

    -----------------------------------------------------
    -- Información
    -----------------------------------------------------

    Class = nil,

    Manufacturer = "BlasTech Industries",

    Type = "Munición",

    Damage = 0,

    FireRate = 0,

    Accuracy = 0,

    Range = 0,

    Mobility = 0,

    Description = [[
    Caja de munición estándar para los
    fusiles bláster DC-15A.

    Contiene 120 proyectiles.
    ]],

    -----------------------------------------------------

    CanBuy = function(ply)

        return true

    end,

    OnBuy = function(ply)

        ply:GiveAmmo(120, "AR2", true)

    end

}, -----------------------------------------------------
-- Munición DC-15S
-----------------------------------------------------
{

    ID = "dc15s_ammo",

    Name = "Munición DC-15S",

    Category = "ammo",

    Price = 100,

    -----------------------------------------------------
    -- Información
    -----------------------------------------------------

    Class = nil,

    Manufacturer = "BlasTech Industries",

    Type = "Munición",

    Damage = 0,

    FireRate = 0,

    Accuracy = 0,

    Range = 0,

    Mobility = 0,

    Description = [[
    Caja de munición estándar para las
    carabinas DC-15S.

    Contiene 90 proyectiles.
    ]],

    -----------------------------------------------------

    CanBuy = function(ply)

        return true

    end,

    OnBuy = function(ply)

        ply:GiveAmmo(90, "SMG1", true)

    end

}, -----------------------------------------------------
-- DC-17
-----------------------------------------------------
{

    ID = "dc17",

    Name = "DC-17",

    Category = "weapons",

    Price = 250,

    -----------------------------------------------------
    -- Información
    -----------------------------------------------------

    Class = "rw_sw_dc17",

    Manufacturer = "BlasTech Industries",

    Type = "Pistola Bláster",

    Damage = 4,

    FireRate = 9,

    Accuracy = 8,

    Range = 6,

    Mobility = 10,

    Description = [[
    Pistola bláster ligera utilizada por
    oficiales, pilotos y tropas especializadas.

    Excelente como arma secundaria gracias
    a su alta cadencia y movilidad.
    ]],

    -----------------------------------------------------

    CanBuy = function(ply)

        return not ply:HasWeapon("rw_sw_dc17")

    end,

    OnBuy = function(ply)

        ply:Give("rw_sw_dc17")

    end

}, -----------------------------------------------------
-- DC-15LE
-----------------------------------------------------
{

    ID = "dc15le",

    Name = "DC-15LE",

    Category = "weapons",

    Price = 1000,

    Class = "rw_sw_dc15le",

    Manufacturer = "BlasTech Industries",

    Type = "Fusil Bláster",

    Damage = 7,

    FireRate = 7,

    Accuracy = 9,

    Range = 8,

    Mobility = 7,

    Description = [[
    Versión de precisión del fusil DC-15.

    Muy estable a media y larga distancia.
    ]],

    CanBuy = function(ply)

        return not ply:HasWeapon("rw_sw_dc15le")

    end,

    OnBuy = function(ply)

        ply:Give("rw_sw_dc15le")

    end

}, -----------------------------------------------------
-- DC-19
-----------------------------------------------------
{

    ID = "dc19",

    Name = "DC-19",

    Category = "weapons",

    Price = 1250,

    Class = "rw_sw_dc19",

    Manufacturer = "BlasTech Industries",

    Type = "Carabina Bláster",

    Damage = 6,

    FireRate = 8,

    Accuracy = 8,

    Range = 7,

    Mobility = 8,

    Description = [[
Carabina bláster compacta.

Excelente equilibrio entre movilidad
y potencia de fuego.
]],

    CanBuy = function(ply)

        return not ply:HasWeapon("rw_sw_dc19")

    end,

    OnBuy = function(ply)

        ply:Give("rw_sw_dc19")

    end

}, -----------------------------------------------------
-- DC-19LE
-----------------------------------------------------
{

    ID = "dc19le",

    Name = "DC-19LE",

    Category = "weapons",

    Price = 1800,

    Class = "rw_sw_dc19le",

    Manufacturer = "BlasTech Industries",

    Type = "Carabina Bláster",

    Damage = 8,

    FireRate = 8,

    Accuracy = 8,

    Range = 8,

    Mobility = 7,

    Description = [[
Versión mejorada de la DC-19.

Mayor potencia y precisión.
]],

    CanBuy = function(ply)

        return not ply:HasWeapon("rw_sw_dc19le")

    end,

    OnBuy = function(ply)

        ply:Give("rw_sw_dc19le")

    end

}, -----------------------------------------------------
-- WESTAR M5
-----------------------------------------------------
{

    ID = "westarm5",

    Name = "WESTAR M5",

    Category = "weapons",

    Price = 2200,

    Class = "rw_sw_westarm5",

    Manufacturer = "MandalMotors",

    Type = "Fusil Bláster",

    Damage = 8,

    FireRate = 7,

    Accuracy = 8,

    Range = 8,

    Mobility = 8,

    Description = [[
Fusil bláster de origen mandaloriano.

Muy apreciado por su fiabilidad.
]],

    CanBuy = function(ply)

        return not ply:HasWeapon("rw_sw_westarm5")

    end,

    OnBuy = function(ply)

        ply:Give("rw_sw_westarm5")

    end

}, -----------------------------------------------------
-- DP-23
-----------------------------------------------------
{

    ID = "dp23",

    Name = "DP-23",

    Category = "weapons",

    Price = 2500,

    Class = "rw_sw_dp23",

    Manufacturer = "BlasTech Industries",

    Type = "Escopeta Bláster",

    Damage = 10,

    FireRate = 4,

    Accuracy = 5,

    Range = 3,

    Mobility = 6,

    Description = [[
Escopeta bláster de combate.

Devastadora a corta distancia,
aunque pierde eficacia rápidamente
a medida que aumenta la distancia.
]],

    CanBuy = function(ply)

        return not ply:HasWeapon("rw_sw_dp23")

    end,

    OnBuy = function(ply)

        ply:Give("rw_sw_dp23")

    end

}, -----------------------------------------------------
-- DP-24
-----------------------------------------------------
{

    ID = "dp24",

    Name = "DP-24",

    Category = "weapons",

    Price = 3000,

    Class = "rw_sw_dp24",

    Manufacturer = "BlasTech Industries",

    Type = "Escopeta Bláster",

    Damage = 10,

    FireRate = 5,

    Accuracy = 6,

    Range = 4,

    Mobility = 6,

    Description = [[
Versión mejorada de la DP-23.

Mayor estabilidad y mejor alcance
manteniendo una enorme potencia
a corta distancia.
]],

    CanBuy = function(ply)

        return not ply:HasWeapon("rw_sw_dp24")

    end,

    OnBuy = function(ply)

        ply:Give("rw_sw_dp24")

    end

}, -----------------------------------------------------
-- DC-17M
-----------------------------------------------------
{

    ID = "dc17m",

    Name = "DC-17M",

    Category = "weapons",

    Price = 4000,

    Class = "rw_sw_dc17m",

    Manufacturer = "BlasTech Industries",

    Type = "Sistema Modular",

    Damage = 9,

    FireRate = 8,

    Accuracy = 8,

    Range = 8,

    Mobility = 7,

    Description = [[
Sistema de armas modular empleado
por las unidades ARC.

Combina una gran potencia de fuego
con una elevada precisión.
]],

    CanBuy = function(ply)

        return not ply:HasWeapon("rw_sw_dc17m")

    end,

    OnBuy = function(ply)

        ply:Give("rw_sw_dc17m")

    end

}, -----------------------------------------------------
-- Binoculares Blancos
-----------------------------------------------------
{

    ID = "bino_white",

    Name = "Binoculares Blancos",

    Category = "equipment",

    Price = 600,

    Class = "rw_sw_bino_white",

    Manufacturer = "Arakyd Industries",

    Type = "Óptica Militar",

    Damage = 0,

    FireRate = 0,

    Accuracy = 0,

    Range = 10,

    Mobility = 10,

    Description = [[
Binoculares tácticos utilizados para
reconocimiento y observación a larga
distancia.

Ideales para exploradores y oficiales.
]],

    CanBuy = function(ply)

        return not ply:HasWeapon("rw_sw_bino_white")

    end,

    OnBuy = function(ply)

        ply:Give("rw_sw_bino_white")

    end

}, -----------------------------------------------------
-- Binoculares Negros
-----------------------------------------------------
{

    ID = "bino_dark",

    Name = "Binoculares Negros",

    Category = "equipment",

    Price = 600,

    Class = "rw_sw_bino_dark",

    Manufacturer = "Arakyd Industries",

    Type = "Óptica Militar",

    Damage = 0,

    FireRate = 0,

    Accuracy = 0,

    Range = 10,

    Mobility = 10,

    Description = [[
Versión oscura de los binoculares
militares de la República.

Ofrecen las mismas prestaciones con
una estética diferente.
]],

    CanBuy = function(ply)

        return not ply:HasWeapon("rw_sw_bino_dark")

    end,

    OnBuy = function(ply)

        ply:Give("rw_sw_bino_dark")

    end

}, -----------------------------------------------------
-- Binoculares Desierto
-----------------------------------------------------
{

    ID = "bino_desert",

    Name = "Binoculares Desierto",

    Category = "equipment",

    Price = 600,

    Class = "rw_sw_bino_desert",

    Manufacturer = "Arakyd Industries",

    Type = "Óptica Militar",

    Damage = 0,

    FireRate = 0,

    Accuracy = 0,

    Range = 10,

    Mobility = 10,

    Description = [[
Binoculares con acabado desértico.

Especialmente utilizados durante
operaciones en planetas áridos.
]],

    CanBuy = function(ply)

        return not ply:HasWeapon("rw_sw_bino_desert")

    end,

    OnBuy = function(ply)

        ply:Give("rw_sw_bino_desert")

    end

}}
