Inventory = exports.vorp_inventory:vorp_inventoryApi()

Citizen.CreateThread(function()
	Citizen.Wait(2000)
	Inventory.RegisterUsableItem("tobaccoseed", function(data)
		Inventory.subItem(data.source, "tobaccoseed", 1)
		TriggerClientEvent('tarp-petani:maumenanam', data.source, "CRP_TOBACCOPLANT_AA_SIM", "CRP_TOBACCOPLANT_AB_SIM", "CRP_TOBACCOPLANT_AC_SIM")
	end)
	
	Inventory.RegisterUsableItem("sugarcaneseed", function(data)
		Inventory.subItem(data.source, "sugarcaneseed", 1)
		TriggerClientEvent('tarp-petani:maumenanam', data.source, "CRP_SUGARCANE_AA_SIM", "CRP_SUGARCANE_AB_SIM", "CRP_SUGARCANE_AC_SIM")
	end)
	
	Inventory.RegisterUsableItem("cornseed", function(data)
		Inventory.subItem(data.source, "cornseed", 1)
		TriggerClientEvent('tarp-petani:maumenanam', data.source, "CRP_CORNSTALKS_CB_SIM", "CRP_CORNSTALKS_CA_SIM", "CRP_CORNSTALKS_AB_SIM")
	end)
	
	Inventory.RegisterUsableItem("wateringcan", function(data)
		TriggerClientEvent('tarp-petani:maumenyiram', data.source)
	end)
end)

RegisterServerEvent('tarp-petani:hasilpanen')
AddEventHandler('tarp-petani:hasilpanen', function(tipo)
    local _source = source
	local count = math.random(3, 8)
	if tipo == "CRP_TOBACCOPLANT_AC_SIM" then
		TriggerClientEvent("vorp:TipRight", _source, 'Has recolectado [X'..count..'] de tabaco', 3000)
		Inventory.addItem(_source, "tobacco", count)
	elseif tipo == "CRP_SUGARCANE_AC_SIM" then
		TriggerClientEvent("vorp:TipRight", _source, 'Has recolectado [X'..count..'] de de azucar', 3000)
		Inventory.addItem(_source, "sugar", count)
	elseif tipo == "CRP_CORNSTALKS_AB_SIM" then
		TriggerClientEvent("vorp:TipRight", _source, 'Has recolectado [X'..count..'] de maiz', 3000)
		Inventory.addItem(_source, "corn", count)
	end
end)
