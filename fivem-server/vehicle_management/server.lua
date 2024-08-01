const mongoose = require('mongoose');
const { MongoClient } = require('mongodb');

// Configuração do MongoDB
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

// Eventos do FiveM
RegisterNetEvent('vehicle:getPlayerVehicles');
AddEventHandler('vehicle:getPlayerVehicles', async function (playerId) {
    try {
        const vehicles = await Vehicle.find({ owner_id: playerId }).exec();
        TriggerClientEvent('vehicle:showPlayerVehicles', playerId, vehicles);
    } catch (err) {
        console.error(err);
    }
});

RegisterCommand('car', async function (source, args, rawCommand) {
    const adminId = source;
    if (IsPlayerAdmin(adminId)) {
        const plate = args[1];
        try {
            const vehicle = await Vehicle.findOne({ plate: plate }).exec();
            if (vehicle) {
                TriggerClientEvent('vehicle:spawnVehicle', adminId, vehicle);
            } else {
                TriggerClientEvent('chat:addMessage', adminId, { args: ['System', 'Vehicle not found!'] });
            }
        } catch (err) {
            console.error(err);
        }
    } else {
        TriggerClientEvent('chat:addMessage', adminId, { args: ['System', 'You are not an admin!'] });
    }
}, false);

// Comando "/car <placa>"
RegisterCommand('car', async (source, args, rawCommand) => {
    const playerId = source;
    if (!isPlayerAdmin(playerId)) {
        TriggerClientEvent('chat:addMessage', playerId, { args: ['System', 'Você não é um administrador!'] });
        return;
    }

    if (args.length < 1) {
        TriggerClientEvent('chat:addMessage', playerId, { args: ['System', 'Uso: /car <placa>'] });
        return;
    }

    const plate = args[0].toUpperCase(); // Normalizar a placa para evitar problemas de caixa
    try {
        const vehicle = await Vehicle.findOne({ plate }).exec();
        if (vehicle) {
            // Envia os dados do veículo para o cliente
            TriggerClientEvent('vehicle:spawnVehicle', playerId, vehicle);
        } else {
            TriggerClientEvent('chat:addMessage', playerId, { args: ['System', 'Veículo não encontrado!'] });
        }
    } catch (err) {
        console.error(err);
        TriggerClientEvent('chat:addMessage', playerId, { args: ['System', 'Erro ao procurar o veículo.'] });
    }
}, false);