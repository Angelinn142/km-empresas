Config = {}

Config.Npccoords = vector3(6.41, -708.66, 45.97) -- Modificar para cambiar al NPC
Config.NpcModel = 'csb_tomcasino' -- Modificar para cambiar el modelo de NPC

Config.PropertyPriceLSC= 500000 -- Los Santos Customs
Config.PropertyPriceBS= 150000 -- Burger Shot
Config.PropertyPriceB= 150000 -- Badulaque
Config.PropertyPriceTX= 250000 -- Taxis

Config.blip= Config.Npccoords
Config.BlipNombre= 'Vendedor de Empresas'

--[[

Este script lo unico que hace es cambiar el trabajo del jugador que compra la faccion/empresa/organizacion
Queda a criterio de ustedes ver como lo implementan, en mi caso lo implemente entregando el rango de jefe y tambien con el ps-multijob
para que mis jugadores puedan tener más de una empresa o trabajo a la vez.

]]
Config.LSCustomJob = 'mechanic' -- Nombre del trabajo
Config.JobGradeLSCustom = 4 -- Rango del trabajo

Config.BurgerShotJob = 'burgershot' -- Nombre del trabajo
Config.JobGradeBurgerShot = 4 -- Rango del trabajo

Config.BadulaqueJob = 'badulaque' -- Nombre del trabajo
Config.JobGradeBadulaque = 4 -- Rango del trabajo

Config.TaxiJob = 'taxi' -- Nombre del trabajo
Config.JobGradeTaxi = 4 -- Rango del trabajo
