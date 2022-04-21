-- Made by Blue & Dungeon for Syn County RP
-- credits to malik & the creator of kcrp_boats_vorp
local iscrafting = false
local playerjob 
local propinfo
local loctitle
keys = {
    -- Letter E
    ["G"] = 0x760A9C6F,
}

function whenKeyJustPressed(key)
    if Citizen.InvokeNative(0x580417101DDB492F, 0, key) then
        return true
    else
        return false
    end
end

local keyopen = false
local craftingx = Config.crafting
function contains(table, element)
    if table ~= 0 then 
        for k, v in pairs(table) do
              if v == element then
                return true
            end
        end
    end
return false
end
Citizen.CreateThread(function()
    WarMenu.CreateMenu('Craft', "Craft")
    WarMenu.SetSubTitle('Craft', 'Time to craft' )

    local _source = source
    while true do

        local ped = GetPlayerPed(-1)
        local coords = GetEntityCoords(PlayerPedId())

        if WarMenu.IsMenuOpened('Craft') then
            if WarMenu.MenuButton('lets craft', "Craft") then
                OpenCraftMenu()
			end
            WarMenu.Display()
        end
        Citizen.Wait(0)
    end
end)

function OpenCraftMenu()
	WarMenu.OpenMenu('craftmenu')
end

Citizen.CreateThread( function()
	WarMenu.CreateMenu('craftmenu', 'craft menu')
	repeat
		if WarMenu.IsMenuOpened('craftmenu') then
			for i = 1, #craftingx do
                if loctitle ~= 0  then 
                    if contains(craftingx[i]['Param']['location'], loctitle) then
                        if contains(craftingx[i]['Param']['Job'], playerjob) or craftingx[i]['Param']['Job'] == 0 then 
				            if WarMenu.Button(craftingx[i]['Text'], craftingx[i]['SubText'], craftingx[i]['Desc']) then
                                TriggerEvent("vorpinputs:getInput","Confirm","Amount", function(cb)
                                    local count = tonumber(cb)
                                    if count ~= nil and count ~= 'close' and count ~= '' and count ~= 0 then
                                        TriggerServerEvent('tarp-crafting:menu', craftingx[i]['Param'],count)
                                    else
                                        TriggerEvent("vorp:TipBottom", "Invalid Amount", 4000)
                                    end
                                end)
				            	WarMenu.CloseMenu()
				            end
                        end
                    end
                else
                    if craftingx[i]['Param']['location'] == 0 then 
                        if contains(craftingx[i]['Param']['prop'], propinfo) or craftingx[i]['Param']['prop'] == 0 then 
                            if contains(craftingx[i]['Param']['Job'], playerjob) or craftingx[i]['Param']['Job'] == 0 then 
				                if WarMenu.Button(craftingx[i]['Text'], craftingx[i]['SubText'], craftingx[i]['Desc']) then
                                    TriggerEvent("vorpinputs:getInput","Confirm","Amount", function(cb)
                                        local count = tonumber(cb)
                                        if count ~= nil and count ~= 'close' and count ~= '' and count ~= 0 then
                                            TriggerServerEvent('tarp-crafting:menu', craftingx[i]['Param'],count)
                                        else
                                            TriggerEvent("vorp:TipBottom", "Invalid Amount", 4000)
                                        end
                                    end)
				                	WarMenu.CloseMenu()
				                end
                            end
                        end
                    end
                end
  
			end
			WarMenu.Display()
		end
		Citizen.Wait(0)
	until false
end)

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    SetTextFontForCurrentCommand(15) 
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
    DisplayText(str, x, y)
end

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        local player = PlayerPedId()
        local Coords = GetEntityCoords(player)
            for k,v in pairs(Config.craftingprops) do 
                local campfire = DoesObjectOfTypeExistAtCoords(Coords.x, Coords.y, Coords.z, 1.5, GetHashKey(v), 0) -- prop required to interact
                if campfire ~= false and iscrafting == false then 
                    DrawTxt("Press [~e~G~q~] to Craft", 0.50, 0.95, 0.7, 0.5, true, 255, 255, 255, 255, true)
                    if whenKeyJustPressed(keys["G"]) then
                        TriggerServerEvent('tarp-crafting:carijob')
                        Wait(500)
                        if keyopen == false then
                        propinfo = v
                        loctitle = 0
                        WarMenu.OpenMenu('Craft')
                        else end
                    end
                end
            end
            for k,v in pairs(Config.locations) do 
                local dist = GetDistanceBetweenCoords(v.x,v.y,v.z, Coords.x,Coords.y,Coords.z, 0)
                if 2.5 > dist then
                    DrawTxt("Press [~e~G~q~] to Craft", 0.50, 0.95, 0.7, 0.5, true, 255, 255, 255, 255, true)
                    if whenKeyJustPressed(keys["G"]) then
                        TriggerServerEvent('tarp-crafting:carijob')
                        Wait(500)
                        if keyopen == false then
                        loctitle = k
                        WarMenu.OpenMenu('Craft')
                        else end
                    end
                end
            end
    end
end)


RegisterNetEvent("tarp-crafting:jobkamu")
AddEventHandler("tarp-crafting:jobkamu", function(job)
    playerjob = job
end)

RegisterNetEvent("tarp-crafting:crafting")
AddEventHandler("tarp-crafting:crafting", function()
    local playerPed = PlayerPedId()
    iscrafting = true
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 15000, true, false, false, false)
    exports['progressBars']:startUI(15000, "Crafting...")
    Citizen.Wait(15000)
    keyopen = false
    iscrafting = false
end)
