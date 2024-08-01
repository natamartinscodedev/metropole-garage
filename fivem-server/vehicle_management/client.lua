-- Função para receber e mostrar a lista de veículos
RegisterNetEvent('vehicle:showPlayerVehicles')
AddEventHandler('vehicle:showPlayerVehicles', function(vehicles)
    SendNUIMessage({
        type = 'SHOW_VEHICLES',
        vehicles = vehicles
    })
end)

-- Função para spawnar o veículo
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

-- Escutar mudanças nos StateBags para atualizações de estado
AddStateBagChangeHandler('spawned', nil, function(bagName, key, value)
    local entity = GetEntityFromStateBagName(bagName)
    if DoesEntityExist(entity) then
        local stateBag = Entity(entity).state
        local plate = stateBag.plate
        local spawned = stateBag.spawned

        if spawned then
            print('Veículo com placa ' .. plate .. ' foi spawnado.')
            -- Realizar ações necessárias, como notificações ou logs
        end
    end
end)
