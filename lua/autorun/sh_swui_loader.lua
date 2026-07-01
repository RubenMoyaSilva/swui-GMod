--[[
    ---------------------------------------------------------
    SWUI - Proyecto Kamino
    Shared Loader

    Author: Proyecto Kamino
    Description:
        Automatic loader for the SWUI framework.
        Loads shared, client and server files in a predefined order.
    ---------------------------------------------------------
]]

SWUI = SWUI or {}

SWUI.Name = "Proyecto Kamino UI"
SWUI.Version = "0.1.12"

local ROOT = "swui/"

local LOAD_ORDER = {
    "config",
    "core",
    "components",
    "pages",
    "server"
}

local function IncludeFile(path)

    if SERVER then
        AddCSLuaFile(path)
    end

    include(path)

end

local function LoadFolder(folder)

    local files = file.Find(ROOT .. folder .. "/*.lua", "LUA")

    table.sort(files)

    for _, fileName in ipairs(files) do

        local path = ROOT .. folder .. "/" .. fileName

        if string.StartWith(fileName, "sv_") then

            if SERVER then
                include(path)
            end

        elseif string.StartWith(fileName, "cl_") then

            if SERVER then
                AddCSLuaFile(path)
            else
                include(path)
            end

        else

            IncludeFile(path)

        end

    end

end

for _, folder in ipairs(LOAD_ORDER) do
    LoadFolder(folder)
end

MsgC(
    Color(70, 170, 255),
    "[SWUI] ",
    color_white,
    "Framework loaded successfully.\n"
)