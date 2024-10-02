fx_version 'cerulean'
game 'gta5'

author 'Kamuidll'

description 'Script que cambia el trabajo de los jugadores por dinero'

client_scripts {
    'config.lua',   
    'client.lua'
}

server_scripts {
    'config.lua',   
    '@oxmysql/lib/MySQL.lua', 
    'server.lua'
}

dependencies {
    'qb-core',   
    'qb-menu',   
    'qb-input',  
}
