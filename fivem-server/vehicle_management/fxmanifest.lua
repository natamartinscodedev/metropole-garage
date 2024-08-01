-- fxmanifest.lua

fx_version 'cerulean'
game 'gta5'

author 'Seu Nome'
description 'Sistema de gerenciamento de veículos com MongoDB Atlas'
version '1.0.0'

-- Script do lado do cliente
client_scripts {
    'client.lua',
    -- Adicione outros scripts de cliente aqui
}

-- Script do lado do servidor
server_scripts {
    'server.js',
    -- Adicione outros scripts de servidor aqui
}

-- Compartilhar arquivos ou variáveis comuns entre client e server
shared_scripts {
    'config.lua',
    -- Adicione outros arquivos de configuração ou scripts comuns aqui
}
