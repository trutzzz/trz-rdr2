local robtime = 120 -- Time to rob (in seconds) now its 3.3mins
local timerCount = robtime
local isRobbing = false
local timers = false
local storetimer = nil
local storenumber = nil

RegisterNetEvent("tarp-robbery:information1")
AddEventHandler("tarp-robbery:information1", function(coords, alert)
	print('perampokan notif')
	TriggerEvent("vorp:TipBottom", 'news : perampokan terjadi di ' .. alert, 15000)
	local blip = Citizen.InvokeNative(0x45f13b7e0a15c880, -1282792512, coords.x, coords.y, coords.z, 50.0)
	Wait(90000)--Time till notify blips dispears, 1 min
	RemoveBlip(blip)
end)

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end

Citizen.CreateThread(function()
    while true do
    Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        for i = 1, #Config.Toko do
           currentshop =  i
           if GetDistanceBetweenCoords(coords, Config.Toko[currentshop].coords.x, Config.Toko[currentshop].coords.y, Config.Toko[currentshop].coords.z, true)  < 1.2 then
                DrawTxt("Tekan [~e~G~q~] Untuk membobol berangkas", 0.50, 0.95, 0.7, 0.7, true, 255, 255, 255, 255, true)
                if IsControlJustReleased(0, 0x760A9C6F) then
                    TriggerServerEvent("tarp-robbery:awalperampokan", function()
                end)
                Wait(5000)
                local alert = Config.Toko [i].name
                TriggerServerEvent("tarp-robbery:policeinfo", GetPlayers(), coords, alert, i) --Getting the item lockpick
                Wait(0)
                isRobbing = true   
				end    
           end
        end
    end
end)

function GetPlayers()
    local players = {}

    for i = 0, 31 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, GetPlayerServerId(i))
        end
    end

    return players
end

RegisterNetEvent("tarp-robbery:memulaiperampokan")
AddEventHandler("tarp-robbery:memulaiperampokan", function()
    local _source = source
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
    local testplayer = exports["tarp-skillbar"]:taskBar(4000,7)

    --jam = GetClockHours()
    if GetClockHours() > 20 or GetClockHours() < 5 then
        Wait(1000)
        if testplayer == 100 then
            TaskStartScenarioInPlace(playerPed, GetHashKey('world_human_shop_browse_counter'), 60000, true, false, false, false)
            exports['progressBars']:startUI(60000, "Getting The Loot...")
            Citizen.Wait(1000)
            Citizen.Wait(60000)
            ClearPedTasksImmediately(PlayerPedId())
            ClearPedSecondaryTask(PlayerPedId())
            Citizen.Wait(1000)
            TriggerServerEvent("tarp-robbery:pendapatan", function(playerPed, coords)
            end)   
        end
    else
        exports['tarp-notify']:SendAlert('inform', ' tidak dapat melakukan aksi')
    end
end)