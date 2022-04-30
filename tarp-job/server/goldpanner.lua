Vorp = exports.vorp_inventory:vorp_inventoryApi()

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

Citizen.CreateThread(function()
	Citizen.Wait(0)
	Vorp.RegisterUsableItem("goldpan", function(data)
		TriggerClientEvent('goldpanner:StartPaning', data.source)
	end)
end)


RegisterNetEvent("search")
AddEventHandler("search", function()
    local item = "goldnugget"
    local r = math.random(1,2)
    local _source = source 
    if r < 3 then
        Vorp.addItem(_source, item,math.random(1,2))
        TriggerClientEvent("vorp:TipBottom", _source, Config.berhasil, 6000)
    else
        TriggerClientEvent("vorp:TipBottom", _source, Config.tidakberhasil, 6000)
    end
end)

