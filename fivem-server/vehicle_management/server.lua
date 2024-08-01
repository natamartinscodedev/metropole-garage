const mongoose = require('mongoose');
const { MongoClient } = require('mongodb');

// Configuração do MongoDB
--  criiar url do mongodb no arquivo .env para segurança dos dados
const mongoURI = 'mongodb+srv://<username>:<password>@cluster.mongodb.net/vehicle_management?retryWrites=true&w=majority';
mongoose.connect(mongoURI, { useNewUrlParser: true, useUnifiedTopology: true });

const db = mongoose.connection;
db.on('error', console.error.bind(console, 'connection error:'));
db.once('open', () => {
    console.log('Connected to MongoDB');
});

// Definição do Schema e Modelo do Veículo
const vehicleSchema = new mongoose.Schema({
    plate: { type: String, required: true, unique: true },
    model: String,
    color: String,
    customizations: String,
    owner_id: mongoose.Schema.Types.ObjectId
});

const Vehicle = mongoose.model('Vehicle', vehicleSchema);

// Função para definir o estado de um veículo usando StateBags
const setVehicleState = (vehicleId, key, value) => {
    Entity(vehicleId).state[key] = value;
};

// Eventos do FiveM
RegisterNetEvent('vehicle:getPlayerVehicles');
AddEventHandler('vehicle:getPlayerVehicles', async (playerId) => {
    try {
        const vehicles = await Vehicle.find({ owner_id: playerId }).exec();
        TriggerClientEvent('vehicle:showPlayerVehicles', playerId, vehicles);
    } catch (err) {
        console.error(err);
    }
});

// Comando para spawnar veículo por placa (somente administradores)
RegisterCommand('car', async (source, args) => {
    const playerId = source;
    if (!isPlayerAdmin(playerId)) {
        TriggerClientEvent('chat:addMessage', playerId, { args: ['System', 'Você não é um administrador!'] });
        return;
    }

    if (args.length < 1) {
        TriggerClientEvent('chat:addMessage', playerId, { args: ['System', 'Uso: /car <placa>'] });
        return;
    }

    const plate = args[0].toUpperCase();
    try {
        const vehicle = await Vehicle.findOne({ plate }).exec();
        if (vehicle) {
            // Definir estado do veículo usando StateBags
            setVehicleState(vehicle._id, 'plate', vehicle.plate);
            setVehicleState(vehicle._id, 'spawned', true);
            TriggerClientEvent('vehicle:spawnVehicle', playerId, vehicle);
        } else {
            TriggerClientEvent('chat:addMessage', playerId, { args: ['System', 'Veículo não encontrado!'] });
        }
    } catch (err) {
        console.error(err);
        TriggerClientEvent('chat:addMessage', playerId, { args: ['System', 'Erro ao procurar o veículo.'] });
    }
}, false);

// Função fictícia para verificar se um jogador é administrador
const isPlayerAdmin = (playerId) => {
    // Implementação fictícia
    return true; // Substituir pela lógica de verificação real
};
