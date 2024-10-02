local QBCore = exports['qb-core']:GetCoreObject()

-- Define las coordenadas donde quieres que aparezca el blip
local blipCoords = Config.blip -- Cambia estas coordenadas según tu necesidad

-- Crea el blip
Citizen.CreateThread(function()
    local blip = AddBlipForCoord(blipCoords)

    -- Configura las propiedades del blip
    SetBlipSprite(blip, 374) -- Puedes cambiar el número por el ícono que prefieras
    SetBlipScale(blip, 0.6)
    SetBlipColour(blip, 2) -- Puedes cambiar el número por el color que prefieras
    SetBlipAsShortRange(blip, true)

    -- Agrega un nombre al blip
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.BlipNombre) -- Cambia este texto por el nombre que desees
    EndTextCommandSetBlipName(blip)
end)


function LoadModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(500)
    end
end

CreateThread(function()
    LoadModel(Config.NpcModel)
    local npc = CreatePed(4, GetHashKey(Config.NpcModel), Config.Npccoords.x, Config.Npccoords.y, Config.Npccoords.z - 1.0, 201.4, false, true)
    SetEntityInvincible(npc, true)
    FreezeEntityPosition(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
end)

-- Evento para abrir el menú de interacción
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local dist = #(playerCoords - Config.Npccoords) -- Usamos la distancia de forma correcta

        -- Mostrar el mensaje si el jugador está cerca del NPC
        if dist < 3.0 then
            DrawText3D(Config.Npccoords.x, Config.Npccoords.y, Config.Npccoords.z, "[E] Interactuar")
            
            if IsControlJustReleased(0, 38) then -- Tecla E
                OpenPropertyMenu()
                --TriggerServerEvent('zs-empresas:purchaseProperty')
            end
        end
    end
end)

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local scale = 0.35

    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
        local factor = (string.len(text)) / 370
        DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 68)
    end
end

function OpenPropertyMenu()
    local menuOptions = {
        {
            header = "Comprar Los Santos Customs",
            txt = "Valor $500.000",
            params = {
                event = "zs-empresas:purchasePropertyLSC"
            }
        },
        {
            header = "Comprar Burger Shot",
            txt = "Valor $150.000",
            params = {
                event = "zs-empresas:purchasePropertyBS"
            }
        },
        {
            header = "Comprar Badulaque",
            txt = "Valor $150.000",
            params = {
                event = "zs-empresas:purchasePropertyB"
            }
        },
        {
            header = "Comprar Empresa de Taxis",
            txt = "Valor $250.000",
            params = {
                event = "zs-empresas:purchasePropertyTX"
            }
        },
        {
            header = "Vender Empresa",
            txt = "Proximamente.....",
            params = {
                event = "zs-empresas:openSellPropertyMenu" -- Evento de venta
            }
        },
        {
            header = "Cerrar",
            txt = "",
            params = {
                event = "qb-menu:client:closeMenu"
            }
        }
    }
    TriggerEvent('qb-menu:client:openMenu', menuOptions)
end

-- Evento al seleccionar la opción de comprar
RegisterNetEvent('zs-empresas:purchasePropertyLSC')
AddEventHandler('zs-empresas:purchasePropertyLSC', function()
    TriggerServerEvent('zs-empresas:purchasePropertyLSC')
end)

RegisterNetEvent('zs-empresas:purchasePropertyBS')
AddEventHandler('zs-empresas:purchasePropertyBS', function()
    TriggerServerEvent('zs-empresas:purchasePropertyBS')
end)

RegisterNetEvent('zs-empresas:purchasePropertyB')
AddEventHandler('zs-empresas:purchasePropertyB', function()
    TriggerServerEvent('zs-empresas:purchasePropertyB')
end)

RegisterNetEvent('zs-empresas:purchasePropertyTX')
AddEventHandler('zs-empresas:purchasePropertyTX', function()
    TriggerServerEvent('zs-empresas:purchasePropertyTX')
end)

RegisterNetEvent('zs-empresas:sellProperty')
AddEventHandler('zs-empresas:sellProperty', function()
    TriggerServerEvent('zs-empresas:sellProperty')
end)

RegisterNetEvent('zs-empresas:getOwnedProperties')
AddEventHandler('zs-empresas:getOwnedProperties', function()
    TriggerServerEvent('zs-empresas:getOwnedProperties')
end)
