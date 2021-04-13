ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterNetEvent('test:amount')
AddEventHandler('test:amount', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local monney = math.random(50,500)




    xPlayer.addMoney(monney)

    TriggerClientEvent('esx:showNotification', source, "~r~Vous venez de voler | "..monney.."$ |")
end)


RegisterNetEvent('weapon')
AddEventHandler('weapon', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)




    xPlayer.addWeapon('WEAPON_KNIFE', 1)

    TriggerClientEvent('esx:showNotification', source, "~r~Vous venez de voler | un couteau |")
end)
