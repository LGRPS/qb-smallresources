-- QBCore.Commands.Add('sethunger', "Set hunger (Admin Only)", {{name="amount", help="Hunger amount"}}, false, function(args)
--     if args[1] then
--         TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", args[1])
--     end
-- end, "god")
local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Commands.Add("sethunger", "Set hunger (Admin Only)", {{name="amount", help="Hunger amount"}}, false, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if args[1] then
        Player.Functions.SetMetaData("hunger", tonumber(args[1]))
        --TriggerServerEvent("QBCore:Server:SetMetaData", "hunger",tonumber(args[1]))
    end
end, "admin")

QBCore.Commands.Add("setthirst", "Set thirst (Admin Only)", {{name="amount", help="Thirst amount"}}, false, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if args[1] then
        Player.Functions.SetMetaData("thirst", tonumber(args[1]))
        --TriggerServerEvent("QBCore:Server:SetMetaData", "hunger",tonumber(args[1]))
    end
end, "admin")
