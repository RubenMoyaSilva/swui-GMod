--[[
    ---------------------------------------------------------
    SWUI - Store Configuration
    Proyecto Kamino
    ---------------------------------------------------------
]]

SWUI = SWUI or {}

SWUI.Store = {}

---------------------------------------------------------
-- Categorías
---------------------------------------------------------

SWUI.Store.Categories = {

    {
        ID = "ammo",
        Name = "Munición",
        SortOrder = 1
    },

    {
        ID = "weapons",
        Name = "Armamento",
        SortOrder = 2
    },

    {
        ID = "medical",
        Name = "Medicina",
        SortOrder = 3
    },

    {
        ID = "equipment",
        Name = "Equipamiento",
        SortOrder = 4
    }

}

---------------------------------------------------------
-- Objetos
---------------------------------------------------------

SWUI.Store.Items = {
        ---------------------------------------------------------
    -- MUNICIÓN
    ---------------------------------------------------------

    {

        ID = "dc15a_ammo",

        Name = "Munición DC-15A",

        Category = "ammo",

        SortOrder = 1,

        Price = 150,

        Model = "models/Items/BoxMRounds.mdl",

        Preview = {

            FOV = 28,
            CamPos = Vector(45, 45, 30),
            LookAt = Vector(0, 0, 0)

        },

        Manufacturer = "Kamino Armory",

        Type = "Munición",

        Description = [[
Caja de munición estándar para rifles DC-15A.

Contiene suficiente munición para un reabastecimiento completo.
]],

        OnBuy = function(ply)

            ply:GiveAmmo(
                120,
                "AR2",
                true
            )

        end

    },

    {

        ID = "dc15s_ammo",

        Name = "Munición DC-15S",

        Category = "ammo",

        SortOrder = 2,

        Price = 100,

        Model = "models/Items/BoxMRounds.mdl",

        Preview = {

            FOV = 28,
            CamPos = Vector(45, 45, 30),
            LookAt = Vector(0, 0, 0)

        },

        Manufacturer = "Kamino Armory",

        Type = "Munición",

        Description = [[
Caja de munición para carabinas DC-15S.

Ideal para reabastecimiento rápido en combate.
]],

        OnBuy = function(ply)

            ply:GiveAmmo(
                90,
                "SMG1",
                true
            )

        end

    },
