
rwt = exports.vorp_inventory:vorp_inventoryApi()

data = {}
TriggerEvent("vorp_inventory:getData",function(call)
    data = call
end)

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

RegisterServerEvent('rwt-donation:opendonation')
AddEventHandler('rwt-donation:opendonation', function(type)
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    --local job = Character.job
    local count = rwt.getItemCount(_source, "cointa")

    if count >= 1 then
        TriggerClientEvent('rwt-donation:open', _source, type)
    else
        TriggerClientEvent('tarp-notify:client:SendAlert', _source, { type = 'inform', text = "kamu tidak mempunyai item untuk membuka menu" })
    end
end)


RegisterNetEvent('rwt-donation:tier1')
AddEventHandler('rwt-donation:tier1',function()

  local _source = source
  local count = rwt.getItemCount(_source, "cointa")
  if count >= 1 then
    local steamhex = GetPlayerIdentifier(_source)
    local name = GetPlayerName(_source)
    local dptgun = math.random(1, #Config.tier1)
    local weaponHash = Config.tier1[dptgun]
    local ammo = {["nothing"] = 0}
    local components =  {["nothing"] = 0}
    local id =  source
    local description = "**System :** [ "..steamhex.." ] Mendapatkan sebuah Item berupa  **" ..weaponHash.. "** berjumlah 1 di **TIER-1**"
    Discord('Tier-1',_source,description)

    rwt.subItem(_source,"cointa", 1)
    
    TriggerEvent("vorpCore:canCarryWeapons", tonumber(id), 1, function(canCarry)
      --VorpInv.createWeapon(id, weaponHash, ammo, components)
      if canCarry then 
        -- TriggerEvent("vorpCore:registerWeapon", tonumber(id), weaponHash, ammo, components)
         rwt.createWeapon(tonumber(id), weaponHash, ammo, components)
         --Discord("Player Used give weapon "..args[2], "Player ID: "..GetPlayerName(source).."\nCharacter: "..playername, 65280)
         TriggerClientEvent('tarp-notify:client:SendAlert', _source, { type = 'inform', text = "Kamu Mendapatkan Gacha | Silakan Cek Di Inventory" })
       end
    end)
  else
    TriggerClientEvent('tarp-notify:client:SendAlert', _source, { type = 'inform', text = "kamu tidak mempunyai item untuk membuka menu" })
    print("gagal melakukan")
  end 
end)

RegisterNetEvent('rwt-donation:tier2')
AddEventHandler('rwt-donation:tier2',function()

  local _source = source
  local count = rwt.getItemCount(_source, "cointa")
  if count >= 2 then
    local steamhex = GetPlayerIdentifier(_source)
    local name = GetPlayerName(_source)
    local dptgun = math.random(1, #Config.tier2)
    local weaponHash = Config.tier2[dptgun]
    local ammo = {["nothing"] = 0}
    local components =  {["nothing"] = 0}
    local id =  source
    local description = "**System :** [ "..steamhex.." ] Mendapatkan sebuah Item berupa  **" ..weaponHash.. "** berjumlah 1 di **TIER-2**"
    Discord('Tier-2',_source,description)

    rwt.subItem(_source,"cointa", 2)
    
    TriggerEvent("vorpCore:canCarryWeapons", tonumber(id), 1, function(canCarry)
      --VorpInv.createWeapon(id, weaponHash, ammo, components)
      if canCarry then 
        -- TriggerEvent("vorpCore:registerWeapon", tonumber(id), weaponHash, ammo, components)
         rwt.createWeapon(tonumber(id), weaponHash, ammo, components)
         --Discord("Player Used give weapon "..args[2], "Player ID: "..GetPlayerName(source).."\nCharacter: "..playername, 65280)
         TriggerClientEvent('tarp-notify:client:SendAlert', _source, { type = 'inform', text = "Kamu Mendapatkan Gacha | Silakan Cek Di Inventory" })
       end
    end)
  else
    TriggerClientEvent('tarp-notify:client:SendAlert', _source, { type = 'inform', text = "kamu tidak mempunyai item untuk membuka menu" })
    print("gagal melakukan")
  end 
end)

RegisterNetEvent('rwt-donation:rare')
AddEventHandler('rwt-donation:rare',function()

  local _source = source
  local count = rwt.getItemCount(_source, "cointa")
  if count >= 3 then
    local steamhex = GetPlayerIdentifier(_source)
    local name = GetPlayerName(_source)
    local dptgun = math.random(1, #Config.rareitem)
    local weaponHash = Config.rareitem[dptgun]
    local ammo = {["nothing"] = 0}
    local components =  {["nothing"] = 0}
    local id =  source
    local description = "**System :** [ "..steamhex.." ] Mendapatkan sebuah Item berupa  **" ..weaponHash.. "** berjumlah 1 di **RARE-TIER-3**"
    Discord('Rare',_source,description)

    rwt.subItem(_source,"cointa", 3)
    
    TriggerEvent("vorpCore:canCarryWeapons", tonumber(id), 1, function(canCarry)
      --VorpInv.createWeapon(id, weaponHash, ammo, components)
      if canCarry then 
        -- TriggerEvent("vorpCore:registerWeapon", tonumber(id), weaponHash, ammo, components)
        rwt.createWeapon(tonumber(id), weaponHash, ammo, components)
         --Discord("Player Used give weapon "..args[2], "Player ID: "..GetPlayerName(source).."\nCharacter: "..playername, 65280)
        TriggerClientEvent('tarp-notify:client:SendAlert', _source, { type = 'inform', text = "Kamu Mendapatkan Gacha | Silakan Cek Di Inventory" })
       end
    end)
  else
    TriggerClientEvent('tarp-notify:client:SendAlert', _source, { type = 'inform', text = "kamu tidak mempunyai item untuk membuka menu" })
    print("gagal melakukan")
  end 
end)

function Discord(title,_source,description)
    local logs = {}
    --local name = GetPlayerName(_source)
    local avatar = Config.webhookavatar
    local color = 3447003
    local discordid
    if Config.discordid then 
      discordid = getIdentity(_source, "discord")
    else
      discordid = nil 
    end
    if discordid ~= nil then 
      logs = {
        {
          ["color"] = color,
          ["title"] = 'donation',
          ["description"] = description.."\n".."**Discord:** <@"..discordid..">",
        }
      }
    else
      logs = {
        {
          ["color"] = color,
          ["title"] = 'donation',
          ["description"] = description,
        }
      }
    end
    PerformHttpRequest(Config.webhook, function(err, text, headers) end, 'POST', json.encode({["username"] = title ,["avatar_url"] = avatar ,embeds = logs}), { ['Content-Type'] = 'application/json' })
end

function getIdentity(source, identity)
	local num = 0
	local num2 = GetNumPlayerIdentifiers(source)
  
	if GetNumPlayerIdentifiers(source) > 0 then
	  local ident = nil
	  while num < num2 and not ident do
		local a = GetPlayerIdentifier(source, num)
		if string.find(a, identity) then ident = a end
		num = num+1
	  end
	  --return ident;
	  return string.sub(ident, 9)
	end
end