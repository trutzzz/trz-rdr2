
Citizen.CreateThread(function()
    WarMenu.CreateMenu('medic', _U('medic_menu'))
    WarMenu.SetSubTitle('medic', _U('select_option'))
    WarMenu.CreateSubMenu('options', 'medic', _U('select_option'))
    --WarMenu.CreateSubMenu('horse_options', 'medic', _U('select_option'))
    WarMenu.CreateMenu('medic_house', _U('medic_menu'))
    WarMenu.CreateSubMenu('options_house', 'medic_house', _U('select_option'))
    --WarMenu.CreateSubMenu('clothes_options', 'medic_house', _U('select_option'))


    while true do
        local ped = PlayerPedId()
        local pos = GetEntityCoords(PlayerPedId(), true)
        for k,v in pairs(Config.MedicLocations) do
            local distance = GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, true)
            if distance <= 1.5 then
                DrawTxt(_U('press_to'), 0.3, 0.95, 0.6, 0.4, true, 255, 255, 255, 255, false)
                if IsControlJustReleased(0, 0xD9D0E1C0) then
                    TriggerServerEvent('rwt-medic:getjob', 'medic_house')
                end
            end
        end
        if WarMenu.IsMenuOpened('medic') then
            if WarMenu.MenuButton(_U('medic_options'), 'options') then
            elseif WarMenu.MenuButton(_U('horse_options'), 'horse_options') then
            end
            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('options') then
            if WarMenu.Button(_U('revive_player')) then
                local closestPlayer, closestDistance = GetClosestPlayer()
                if closestPlayer == -1 or closestDistance > 3.0 then
                    --TriggerEvent("vorp:TipBottom", _U('no_nearby_players'), 3000)
                    exports['tarp-notify']:SendAlert('inform', _U('no_nearby_players'))
                else
                    RevivePlayer(closestPlayer)
                end
            elseif WarMenu.Button(_U('heal_player')) then
                local closestPlayer, closestDistance = GetClosestPlayer()
                if closestPlayer == -1 or closestDistance > 3.0 then
                    --TriggerEvent("vorp:TipBottom", _U('no_nearby_players'), 3000)
                    exports['tarp-notify']:SendAlert('inform', _U('no_nearby_players'))
                else
                    HealPlayer(closestPlayer)
                end
            end
            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('medic_house') then
            if WarMenu.MenuButton(_U('medic_options'), 'options_house') then
            elseif WarMenu.MenuButton(_U('change_clothes'), 'clothes_options') then
            end
            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('horse_options') then
            if WarMenu.Button(_U('spawn_horse')) then
                SpawnHorse()
            end
            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('options_house') then
            if WarMenu.Button(_U('take_syringe')) then
                TriggerServerEvent('rwt-medic:takeSyringe')
            elseif WarMenu.Button(_U('take_bandage')) then
                TriggerServerEvent('rwt-medic:takeBandage')
            elseif WarMenu.Button(_U('take_oplas')) then
                TriggerServerEvent('rwt-medic:takeOplas')
            end
            WarMenu.Display()
        elseif IsControlJustReleased(0, 5) then -- SUPR
            --TriggerServerEvent('rwt-medic:getjob', 'medic')
        end
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('rwt-medic:auth')
AddEventHandler('rwt-medic:auth', function(type)
    WarMenu.OpenMenu(type)
end)

RegisterNetEvent('rwt-medic:open')
AddEventHandler('rwt-medic:open', function(cb)
	WarMenu.OpenMenu('medic')
	--print ("openmenu")
end)


RegisterNetEvent('rwt-medic:revive')
AddEventHandler('rwt-medic:revive', function(closestPlayer)
    DoScreenFadeOut(800)

    while not IsScreenFadedOut() do
		Citizen.Wait(50)
    end
    
    Citizen.Wait(1200)
    TriggerEvent('vorp:resurrectPlayer', closestPlayer)
    DoScreenFadeIn(800)
end)

RegisterNetEvent('rwt-medic:heal')
AddEventHandler('rwt-medic:heal', function(closestPlayer)
    local closestPlayerPed = PlayerPedId()
    local health = GetAttributeCoreValue(closestPlayerPed, 0)
    local newHealth = health + 50
    local stamina = GetAttributeCoreValue(closestPlayerPed, 1)
    local newStamina = stamina + 50
    local health2 = GetEntityHealth(closestPlayerPed)
    local newHealth2 = health2 + 50
    Citizen.InvokeNative(0xC6258F41D86676E0, closestPlayerPed, 0, newHealth) --core
    Citizen.InvokeNative(0xC6258F41D86676E0, closestPlayerPed, 1, newStamina) --core
    SetEntityHealth(closestPlayerPed, newHealth2)
end)



Citizen.CreateThread(function()
    for k,v in pairs(Config.MedicLocations) do
        local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.x, v.y, v.z)
        SetBlipSprite(blip, -695368421, 1)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, _U('map_blip'))
    end
end)
