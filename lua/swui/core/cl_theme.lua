--[[
    ---------------------------------------------------------
    SWUI - Theme
    Proyecto Kamino
    ---------------------------------------------------------
]]

if SERVER then return end

SWUI = SWUI or {}

SWUI.Theme = {

    Background = Color(6, 10, 18, 245),

    Surface = Color(14, 22, 34, 235),

    SurfaceDark = Color(10, 16, 26, 240),

    Border = Color(70, 170, 255, 180),

    BorderHover = Color(120, 210, 255, 255),

    Accent = Color(70, 170, 255),

    AccentDark = Color(45, 110, 180),

    White = Color(255, 255, 255),

    Text = Color(220, 230, 240),

    TextSecondary = Color(160, 175, 190),

    Success = Color(80, 200, 120),

    Warning = Color(255, 180, 0),

    Error = Color(220, 70, 70),

    Overlay = Color(0, 0, 0, 120)

}

function SWUI.GetThemeColor(name)
    return SWUI.Theme[name] or color_white
end