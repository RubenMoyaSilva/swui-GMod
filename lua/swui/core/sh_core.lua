--[[
    ---------------------------------------------------------
    SWUI - Proyecto Kamino
    Core (Shared)
    ---------------------------------------------------------
]]

SWUI = SWUI or {}

SWUI.Name = "Proyecto Kamino UI"
SWUI.Version = "0.2.16"

SWUI.Config = SWUI.Config or {}
SWUI.Theme = SWUI.Theme or {}
SWUI.Fonts = SWUI.Fonts or {}
SWUI.Pages = SWUI.Pages or {}
SWUI.State = SWUI.State or {}

SWUI.State.Initialized = false

local function PrintMessage(prefixColor, prefix, message)
    MsgC(prefixColor, prefix, color_white, " ", message, "\n")
end

SWUI.Log = {}

function SWUI.Log.Info(message)
    PrintMessage(Color(70, 170, 255), "[SWUI]", message)
end

function SWUI.Log.Warning(message)
    PrintMessage(Color(255, 180, 0), "[SWUI WARNING]", message)
end

function SWUI.Log.Error(message)
    PrintMessage(Color(255, 70, 70), "[SWUI ERROR]", message)
end

function SWUI.Initialize()

    if SWUI.State.Initialized then
        return
    end

    SWUI.State.Initialized = true

    SWUI.Log.Info("Core initialized.")

end