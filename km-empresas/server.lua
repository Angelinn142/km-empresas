local QBCore = exports['qb-core']:GetCoreObject()

-- Función para verificar si la propiedad ya está comprada
local function isPropertyOwned(propertyName, cb)
    MySQL.Async.fetchScalar('SELECT owner_cid FROM owned_properties WHERE property_name = @propertyName', {
        ['@propertyName'] = propertyName
    }, function(ownerCid)
        cb(ownerCid ~= nil) -- Si ownerCid no es nil, significa que la propiedad está comprada
    end)
end

-- Función para manejar la compra de propiedades
local function handlePurchase(src, propertyName, propertyPrice, jobName, jobGrade)
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        local cid = Player.PlayerData.citizenid
        local playerMoney = Player.PlayerData.money["bank"]

        -- Comprobar si ya está comprada
        isPropertyOwned(propertyName, function(isOwned)
            if not isOwned then
                -- Verificar si el jugador tiene suficiente dinero
                if playerMoney >= propertyPrice then
                    -- Quitar dinero
                    if Player.Functions.RemoveMoney("bank", propertyPrice) then
                        -- Asignar el trabajo
                        Player.Functions.SetJob(jobName, jobGrade)

                        -- Registrar la propiedad en la base de datos
                        MySQL.Async.execute('INSERT INTO owned_properties (property_name, owner_cid) VALUES (@propertyName, @cid)', {
                            ['@propertyName'] = propertyName,
                            ['@cid'] = cid
                        })

                        -- Notificación de éxito
                        TriggerClientEvent('QBCore:Notify', src, "Has comprado " .. propertyName .. " y ahora eres el dueño, ¡Felicidades!", "success")
                    else
                        TriggerClientEvent('QBCore:Notify', src, "No tienes suficiente dinero", "error")
                    end
                else
                    TriggerClientEvent('QBCore:Notify', src, "No tienes suficiente dinero", "error")
                end
            else
                TriggerClientEvent('QBCore:Notify', src, propertyName .. " ya ha sido comprada por otro jugador.", "error")
            end
        end)
    else
        TriggerClientEvent('QBCore:Notify', src, "Error al obtener los datos del jugador", "error")
    end
end

-- Evento para Los Santos Customs
RegisterNetEvent('zs-empresas:purchasePropertyLSC', function()
    local src = source
    handlePurchase(src, "Los Santos Customs", Config.PropertyPriceLSC, Config.LSCustomJob, Config.JobGradeLSCustom)
end)

-- Evento para Burger Shot
RegisterNetEvent('zs-empresas:purchasePropertyBS', function()
    local src = source
    handlePurchase(src, "Burger Shot", Config.PropertyPriceBS, Config.BurgerShotJob, Config.JobGradeBurgerShot)
end)

-- Evento para Badulaque
RegisterNetEvent('zs-empresas:purchasePropertyB', function()
    local src = source
    handlePurchase(src, "Badulaque", Config.PropertyPriceB, Config.BadulaqueJob, Config.JobGradeBadulaque)
end)

-- Evento para Taxis
RegisterNetEvent('zs-empresas:purchasePropertyTX', function()
    local src = source
    handlePurchase(src, "Taxi", Config.PropertyPriceTX, Config.TaxiJob, Config.JobGradeTaxi)
end)
