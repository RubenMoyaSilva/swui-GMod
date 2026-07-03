if CLIENT then return end

util.AddNetworkString("SWUI.CheckJobAccess")
util.AddNetworkString("SWUI.JobAccessResult")

net.Receive("SWUI.CheckJobAccess", function(_, ply)

    local teamID = net.ReadUInt(16)

    local canAccess = false

    if GAS and GAS.JobWhitelist and GAS.JobWhitelist.CanAccessJob then

        local ok = GAS.JobWhitelist:CanAccessJob(ply, teamID)

        canAccess = ok == true

    end

    net.Start("SWUI.JobAccessResult")
        net.WriteUInt(teamID, 16)
        net.WriteBool(canAccess)
    net.Send(ply)

end)