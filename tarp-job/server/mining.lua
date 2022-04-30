VorpInv = exports.vorp_inventory:vorp_inventoryApi()

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

RegisterServerEvent("vorp_mining:pickaxecheck")
AddEventHandler("vorp_mining:pickaxecheck", function(rock)
	local _source = source
	local miningrock = rock
	local pickaxe = VorpInv.getItemCount(_source, Config.Pickaxe)

	if pickaxe > 0 then
		TriggerClientEvent("vorp_mining:pickaxechecked", _source, miningrock)
	else
		TriggerClientEvent("vorp_mining:nopickaxe", _source)
		TriggerClientEvent("vorp:TipRight", _source, "Anda tidak memiliki pickaxe", 2000)
	end
end)

RegisterServerEvent('vorp_mining:addItem')
AddEventHandler('vorp_mining:addItem', function()
	local _source = source
	local User = VorpCore.getUser(_source).getUsedCharacter
	local playername = User.firstname.. ' ' ..User.lastname
	local inventory = VorpInv.getUserInventory(_source)
	local FinalLoot = LootToGive(_source)
	local goldChance = math.random(Config.MinGoldChance,Config.MaxGoldChance)
	TriggerEvent("vorpCore:canCarryItems", tonumber(_source), 1, function(canCarry)
		if canCarry then
			if goldChance <= Config.GoldChance then
				if contains(inventory, "stonenugget") then
					for i,item in pairs(inventory) do
						if item.name == "stonenugget" then
							local carrying = 1 + item.count
							if item.limit >= carrying then
								VorpInv.addItem(_source, "stonenugget", 1)
								TriggerClientEvent("vorp:TipRight", _source, "Anda menemukan "..item.label, 3000)
							else
								TriggerClientEvent("vorp:TipRight", _source, "Anda tidak bisa membawa lagi "..item.label.."'s", 3000)
							end
						end
					end
				else
					local item = "stonenugget"
					exports.ghmattimysql:execute('SELECT * FROM items WHERE item = @item', {['item'] = item}, function(result)
						if result[1] ~= nil then
							local itemlimit = result[1].limit
							local itemlabel = result[1].label
							if itemlimit >= 1 then 
								VorpInv.addItem(_source, item, 1)
								TriggerClientEvent("vorp:TipRight", _source, "Anda menemukan "..itemlabel, 3000)
							else
								TriggerClientEvent("vorp:TipRight", _source, "Anda tidak bisa membawa lagi "..itemlabel.."'s", 3000)
							end
						end
					end)
				end
			else
				for k,v in pairs(Config.Items) do
					if v == FinalLoot then
						if contains(inventory, FinalLoot) then
							for i,item in pairs(inventory) do
								if item.name == FinalLoot then
									local carrying = 1 + item.count
									if item.limit >= carrying then
										VorpInv.addItem(_source, FinalLoot, 1)
										TriggerClientEvent("vorp:TipRight", _source, "Anda menambang beberapa "..item.label, 3000)
									else
										TriggerClientEvent("vorp:TipRight", _source, "Anda tidak bisa membawa lagi "..item.label, 3000)
									end
								end
							end
						else
							local item = FinalLoot
							exports.ghmattimysql:execute('SELECT * FROM items WHERE item = @item', {['item'] = item}, function(result)
								if result[1] ~= nil then
									local itemlimit = result[1].limit
									local itemlabel = result[1].label
									if itemlimit >= 1 then 
										VorpInv.addItem(_source, item, 1)
										TriggerClientEvent("vorp:TipRight", _source, "Anda menambang beberapa "..itemlabel, 3000)
									else
										TriggerClientEvent("vorp:TipRight", _source, "Anda tidak bisa membawa lagi "..itemlabel, 3000)
									end
								end
							end)
						end
					end
				end
			end
		else
		  	TriggerClientEvent("vorp:TipRight", _source, "Anda tidak bisa membawa item lagi", 3000)
		end
	end)
end)

function contains(table, element)
	for k,v in pairs(table) do
		for x,y in pairs(v) do
			  if y == element then
				return true
			end
		end
	end
	return false
end

function LootToGive(source)
	local LootsToGive = {}
	for k,v in pairs(Config.Items) do
		table.insert(LootsToGive,v)
	end

	if LootsToGive[1] ~= nil then
		local value = math.random(1,#LootsToGive)
		local mined = LootsToGive[value]
		return mined
	end
end