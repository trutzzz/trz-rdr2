local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

Inventory = exports.vorp_inventory:vorp_inventoryApi()



RegisterCommand('med', function(source, args, rawCommand)
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local job = Character.job
    if job == 'doctor' then
        TriggerClientEvent('rwt-medic:open', _source)
    else
        --TriggerClientEvent("vorp:TipBottom", _source, _U('no_autorizado'), 4000) -- from server side
        TriggerClientEvent('tarp-notify:client:SendAlert', _source, { type = 'inform', text = _U('no_autorizado') })
    end
end)


--[[ RegisterCommand('med2', function(source, args, rawCommand)
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local job = Character.job
    if job == 'police' or job == "marshal" then
        TriggerClientEvent('rwt-medic:open', _source)
    else
        TriggerClientEvent("vorp:TipBottom", _source, _U('no_autorizado'), 4000) -- from server side
    end
end) ]]


RegisterServerEvent('rwt-medic:getjob')
AddEventHandler('rwt-medic:getjob', function(type)
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local job = Character.job
    if job == 'doctor' then
        TriggerClientEvent('rwt-medic:auth', _source, type)
    else
        --TriggerClientEvent("vorp:TipBottom", source, 'You need a Medical Certificate', 6000)
        TriggerClientEvent('tarp-notify:client:SendAlert', _source, { type = 'inform', text = "You need a Medical Certificate" })
    end
end)

RegisterServerEvent('rwt-medic:reviveplayer')
AddEventHandler('rwt-medic:reviveplayer', function(closestPlayer)
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local count = Inventory.getItemCount(_source, "syringe")
    local job = Character.job
    --[[if job == "police" or job == "marshal" then 
        TriggerClientEvent('rwt-medic:revive', closestPlayer)
    end]]--
    if job == 'doctor' and count > 0 then
        Inventory.subItem(_source, "syringe", 1)
        TriggerClientEvent('rwt-medic:revive', closestPlayer)
    else
        --TriggerClientEvent("vorp:TipBottom", _source, _U('do_not_have', _U('syringe')), 3000)
        TriggerClientEvent('tarp-notify:client:SendAlert', _source, { type = 'inform', text = _U('do_not_have', _U('syringe')) })
    end
end)

RegisterServerEvent('rwt-medic:healplayer')
AddEventHandler('rwt-medic:healplayer', function(closestPlayer)
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local count = Inventory.getItemCount(_source, "bandage")
    local job = Character.job
    if job == 'doctor' and count > 0 then
        Inventory.subItem(_source, "bandage", 1)
        TriggerClientEvent('rwt-medic:heal', closestPlayer)
    else
        --TriggerClientEvent("vorp:TipBottom", _source, _U('do_not_have', _U('bandage')), 3000)
        TriggerClientEvent('tarp-notify:client:SendAlert', _source, { type = 'inform', text = _U('do_not_have', _U('bandage')) })
    end
end)

RegisterServerEvent('rwt-medic:takeSyringe')
AddEventHandler('rwt-medic:takeSyringe', function()
    local _source = source
    Inventory.addItem(_source, "syringe", Config.item1)
    local count = Inventory.getItemCount(_source, "syringe")
    TriggerEvent("vorp:removeMoney", _source, 0, 5.00)
    if count > 0 then 
        --TriggerClientEvent("vorp:TipBottom", source, 'You took 10 Syringes from Cabinet', 3000)
        TriggerClientEvent('tarp-notify:client:SendAlert', source, { type = 'inform', text = "anda mengambil 20 syringe dari lemari" })
    end
end)

RegisterServerEvent('rwt-medic:takeBandage')
AddEventHandler('rwt-medic:takeBandage', function()
    local _source = source
    Inventory.addItem(_source, "bandage", Config.item2)
    local count = Inventory.getItemCount(_source, "bandage")
    if count > 0 then 
        --TriggerClientEvent("vorp:TipBottom", source, 'You took 10 Syringes from Cabinet', 3000)
        TriggerClientEvent('tarp-notify:client:SendAlert', source, { type = 'inform', text = "anda mengambil 5 bandage dari lemari" })
    end
end)