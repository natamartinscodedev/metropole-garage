-- Função para receber e mostrar a lista de veículos
RegisterNetEvent('vehicle:showPlayerVehicles')
AddEventHandler('vehicle:showPlayerVehicles', function(vehicles)
    SendNUIMessage({
        type = 'SHOW_VEHICLES',
        vehicles = vehicles
    })
end)

-- Função para spawnar o veículo
RegisterNetEvent('vehicle:spawnVehicle')
AddEventHandler('vehicle:spawnVehicle', function(vehicle)
    local model = vehicle.model
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(500)
    end
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local veh = CreateVehicle(model, coords.x, coords.y, coords.z, GetEntityHeading(playerPed), true, false)
    SetVehicleNumberPlateText(veh, vehicle.plate)
    -- Adicione outras customizações se necessário
end)

-- Função para spawnar veículo no cliente AMD
function spawnVehicle(vehicleData)
    local model = GetHashKey(vehicleData.model)
    
    -- Carregar o modelo de veículo
    RequestModel(model)
    while not HasModelLoaded(model) do
        Citizen.Wait(100)
    end

    -- Obter posição do jogador para spawnar o veículo
    local playerPed = PlayerPedId()
    local playerPos = GetEntityCoords(playerPed)

    -- Criar veículo
    local vehicle = CreateVehicle(model, playerPos.x, playerPos.y, playerPos.z, GetEntityHeading(playerPed), true, false)

    -- Aplicar customizações (se houver)
    if vehicleData.customizations then
        -- Exemplo de como aplicar customizações (deve ser ajustado de acordo com a estrutura de customizações)
        SetVehicleColours(vehicle, vehicleData.color.primary, vehicleData.color.secondary)
        -- Outras customizações aqui...
    end

    -- Definir o veículo como propriedade do jogador
    SetPedIntoVehicle(playerPed, vehicle, -1)
end

-- Ouvir o evento do servidor para spawnar o veículo
RegisterNetEvent('vehicle:spawnVehicle')
AddEventHandler('vehicle:spawnVehicle', function(vehicleData)
    spawnVehicle(vehicleData)
end)
