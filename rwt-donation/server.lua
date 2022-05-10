
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
    local count = rwt.getItemCount(_source, "tiket_donation")

    if count >= 1 then
        TriggerClientEvent('rwt-donation:open', _source, type)
    else
        TriggerClientEvent('tarp-notify:client:SendAlert', _source, { type = 'inform', text = "kamu tidak mempunyai item untuk membuka menu" })
    end
end)

RegisterServerEvent('rwt-donation:tier1')
AddEventHandler('rwt-donation:tier1', function()
    local _source = source
    local count = rwt.getItemCount(_source, "tiket_donation")
    if count >= 1 then
        --local ritem = 1
        local steamhex = GetPlayerIdentifier(_source)
        local name = GetPlayerName(_source)
        local randomrwt1 = math.random(1, #Config.tier1)
        local itemt1 = Config.tier1[randomrwt1]
        local description = "**System :** [ "..steamhex.." ] Mendapatkan sebuah tiket berupa **" ..itemt1.. "** berjumlah 1 di **TIER-1**"
        Discord('Tier-1',_source,description)

        rwt.subItem(_source,"tiket_donation", 1)
        rwt.addItem(_source, itemt1, 1)
        
        TriggerClientEvent('tarp-notify:client:SendAlert', _source, { type = 'inform', text = "kamu mendapatkan voucher "..itemt1..' - 1'})
        print("sukses")
    else
        TriggerClientEvent('tarp-notify:client:SendAlert', _source, { type = 'inform', text = "kamu tidak mempunyai item untuk membuka menu" })
        print("gagal melakukan")
    end
end)


RegisterServerEvent('rwt-donation:tier2')
AddEventHandler('rwt-donation:tier2', function()
    local _source = source
    local count = rwt.getItemCount(_source, "tiket_donation")
    if count >= 1 then
        --local ritem = 1
        local steamhex = GetPlayerIdentifier(_source)
        local name = GetPlayerName(_source)
        local randomrwt2 = math.random(1, #Config.tier2)
        local itemt2 = Config.tier2[randomrwt2]
        local description = "**System :** [ "..steamhex.." ] Mendapatkan sebuah tiket berupa **" ..itemt2.. "** berjumlah 1 di **TIER-2**"
        Discord('Tier-2',_source,description)

        rwt.subItem(_source,"tiket_donation", 1)
        rwt.addItem(_source, itemt2, 1)
        
        TriggerClientEvent('tarp-notify:client:SendAlert', _source, { type = 'inform', text = "kamu mendapatkan voucher "..itemt2..' - 1'})
        print("sukses")
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