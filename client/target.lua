Citizen.CreateThread(function()
    exports['qb-target']:AddGlobalVehicle({
        options = {
            { 
                type = "client",
                event = 'LegacyFuel:client:petrolcanrefuel',
                label = 'Refuel Car', 
                icon = 'fas fa-gas-pump',
                item = 'weapon_petrolcan',
                canInteract = function(entity)
                    if GetVehicleEngineHealth(entity) <= 0 then return false end
                    if isFueling == false then
                        local curGasCanDurability = GetCurrentGasCanDurability()
                        if curGasCanDurability == nil then return false end
                        if curGasCanDurability > 0 then return true end
                        return false
                    end
                    return false
                end
            },
            {
                type="client",
                event="LegacyFuel:client:siphonfuel",
                label = "Siphon Fuel",
                icon = 'fas fa-gas-pump',
                item = 'fuelsiphon',
                canInteract = function(entity)
                    if GetVehicleEngineHealth(entity) <= 0 then return false end
                    if isFueling then return false end
                    local curGasCanDurability = GetCurrentGasCanDurability()
                    if curGasCanDurability == nil then return false end
                    if curGasCanDurability >= 100 then return false end
                    
                    return Config.AllowFuelSiphoning
                end
            },
            {
                type = "client",
                event = "police:client:PutPlayerInVehicle",
                icon = "fas fa-chevron-circle-left",
                label = "Seat In Vehicle",
            },
            {
                type = "client",
                event = "police:client:SetPlayerOutVehicle",
                icon = "fas fa-chevron-circle-right",
                label = "Remove From Vehicle",
            },
            {
                type = "client",
                event = "police:client:ImpoundVehicle",
                icon = "fas fa-car",
                label = "Impound Vehicle",
                job = 'police'
            },
            {
                type = "client",
                event = "qb-trunk:client:GetIn",
                icon = "fas fa-user-secret",
                label = "Get In Trunk",
            },
            {
                type = "client",
                event = "vehicle:flipit",
                icon = "fas fa-car",
                label = "Flip Vehicle",
                canInteract = function()
                    vehicle = QBCore.Functions.GetClosestVehicle()
                    return not IsVehicleOnAllWheels(vehicle)
                end,
            },
        },
        distance = 2.5,
    })
end)

RegisterNetEvent('vehicle:flipit')
AddEventHandler('vehicle:flipit', function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
    --if IsPedInAnyVehicle(ped, false) then vehicle = GetVehiclePedIsIn(ped, false) else vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71) end
        if DoesEntityExist(vehicle) then
            QBCore.Functions.Progressbar({
            name = "flipping_vehicle",
            duration = 5000,
            label = "Flipping Vehicle Over",
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "random@mugging4",
                anim = "struggle_loop_b_thief",
                flags = 49,
            }
        }, function(status)

            local playerped = PlayerPedId()
            local coordA = GetEntityCoords(playerped, 1)
            local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
            --local targetVehicle = getVehicleInDirection(coordA, coordB)
            SetVehicleOnGroundProperly(vehicle)
        end)
    else
        QBCore.Functions.Notify('Cant flip vehicle', 'error', 2500) 
    end
end)