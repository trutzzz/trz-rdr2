VORP = exports.vorp_inventory:vorp_inventoryApi()

data = {}
TriggerEvent("vorp_inventory:getData",function(call)
    data = call
end)

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

RegisterNetEvent("tarp-robbery:awalperampokan")
AddEventHandler("tarp-robbery:awalperampokan", function(robtime)
    local _source = source
    local Character = VorpCore.getUser(source).getUsedCharacter
    local count = VORP.getItemCount(_source, "lockpick")

    local pol = 0
    if Character.job == "police" then 
        pol = pol + 1    
    end

    if pol >= 1 then --untuk mengatur anggota sherrif
        if count >= 1 then
            VORP.subItem(_source,"lockpick", 1)
            TriggerClientEvent('tarp-robbery:memulaiperampokan', _source)
            TriggerClientEvent('tarp-notify:client:SendAlert', _source, { type = 'inform', text = "seseorang memanggil sheriff" })
            TriggerClientEvent('tarp-notify:client:SendAlert', _source, { type = 'inform', text = "sheriff akan datang dalam waktu 1 menit" })
        else
            TriggerClientEvent('tarp-notify:client:SendAlert', _source, { type = 'inform', text = "kamu tidak mempunyai alat untuk merampok" })
        end
    else
        TriggerClientEvent('tarp-notify:client:SendAlert', _source, { type = 'inform', text = "jumlah police tidak mencukupi" })
    end
end)

RegisterNetEvent("tarp-robbery:policeinfo")
AddEventHandler("tarp-robbery:policeinfo", function(players, coords, alert)
    local Character = VorpCore.getUser(source).getUsedCharacter
    for each, player in ipairs(players) do
        if Character ~= nil then
			if Character.job == 'police' or Character.job == 'marshal' or Character.job == 'sheriff' then
				TriggerClientEvent("Witness:ToggleNotification2", player, coords, alert)
			end
            TriggerClientEvent('tarp-notify:client:SendAlert', -1, { type = 'inform', text = "perampokan di daerah "..alert })
        end
    end
end)

RegisterNetEvent("tarp-robbery:pendapatan")
AddEventHandler("tarp-robbery:pendapatan", function()
    TriggerEvent('vorp:getCharacter', source, function(user)
        local _source = source
        local _user = user
       -- randommoney = math.random(10,20)
        ritem = math.random(5,10)
        local randomitempull = math.random(1, #Config.Items)
        local itemName = Config.Items[randomitempull]
        VORP.addItem(_source, itemName, ritem)
        TriggerClientEvent('tarp-notify:client:SendAlert', _source, { type = 'inform', text = "kamu mendapatkan item ketika membobol"})
    end)    
end)

Locations = {
    vector3(-324.26, 804.1, 117.93),
    vector3(2825.2976074219, -1320.1049804688, 45.755676269531),
    vector3(-785.47, -1323.85, 43.9),
    vector3(-1789.34, -387.5, 160.37),
    vector3(-3687.2, -2622.31, -13.3), 
    vector3(-5486.33, -2937.6, -0.35),
    vector3(1328.03, -1293.70,  77.07),
}