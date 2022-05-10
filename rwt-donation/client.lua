local hour = GetClockHours()
local second = GetClockSeconds()
local minute = GetClockMinutes()
local cooldown = 0

Citizen.CreateThread(function()
    for k,v in pairs(Config.donloc) do
        local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.x, v.y, v.z)
        SetBlipSprite(blip, -695368421, 1)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, 'donation area')
    end
end)


Citizen.CreateThread(function()

    WarMenu.CreateMenu('donation_room', 'Gacha Menu')
    WarMenu.CreateSubMenu('menu_donation', 'donation_room', 'Gacha')
    WarMenu.CreateSubMenu('menu_donation2', 'donation_room', 'Gacha')

    while true do

        local ped = PlayerPedId()
        local pos = GetEntityCoords(PlayerPedId(), true)
        for k,v in pairs(Config.donloc) do
            
            local distance = GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, true)
            if distance <= 1.0 then
                DrawTxt('tekan (E) untuk membuka menu', 0.3, 0.95, 0.6, 0.4, true, 255, 255, 255, 255, false)
                if IsControlJustReleased(0, 0xCEFD9220) then
                    exports['tarp-notify']:SendAlert('inform', 'anda membuka menu')
                    TriggerServerEvent('rwt-donation:opendonation', 'donation_room')
                end
            else    
                WarMenu.CloseMenu()
            end
           
        end

        if WarMenu.IsMenuOpened('donation_room') then
            if WarMenu.MenuButton('Tier 1 - [ 1 tiket ] + cooldown 10 detik', 'menu_donation') then
            elseif WarMenu.MenuButton('Tier 2 - [ 2 tiket ] + cooldown 10 detik', 'menu_donation2')then
            end
            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('menu_donation') then
            if cooldown == 0 then
                if WarMenu.Button('Yes') then
                    TriggerServerEvent('rwt-donation:tier1')
                    exports['tarp-notify']:SendAlert('inform', ' cooldown aktif + please wait')

                    donationcooldown()
                    exports['tarp-notify']:SendAlert('inform', ' cooldown nonaktif ')
                    WarMenu.CloseMenu()

                elseif WarMenu.Button('No') then
                    exports['tarp-notify']:SendAlert('inform', ' you suck  ')
                    WarMenu.CloseMenu()
                end
            end
            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('menu_donation2') then
            if cooldown == 0 then
                if WarMenu.Button('Yes') then
                    TriggerServerEvent('rwt-donation:tier2')
                    exports['tarp-notify']:SendAlert('inform', ' cooldown aktif + please wait')

                    donationcooldown()
                    exports['tarp-notify']:SendAlert('inform', ' cooldown nonaktif ')
                    WarMenu.CloseMenu()

                elseif WarMenu.Button('No') then
                    exports['tarp-notify']:SendAlert('inform', ' you suck  ')
                    WarMenu.CloseMenu()
                end
            end
            WarMenu.Display()
        
        end
        Citizen.Wait(0)
    end

end)

RegisterNetEvent('rwt-donation:open')
AddEventHandler('rwt-donation:open', function(type)
    WarMenu.OpenMenu(type)
end)

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    --Citizen.InvokeNative(0x66E0276CC5F6B9DA, 2)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end

function donationcooldown()
    cooldown = math.random(500,700)        
    while cooldown > 0 do
        Wait(0)
        cooldown = cooldown - 1
    end
end


