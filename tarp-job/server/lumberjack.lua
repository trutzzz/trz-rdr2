VorpInv = exports.vorp_inventory:vorp_inventoryApi()

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

RegisterServerEvent("vorp_lumberjack:axecheck")
AddEventHandler("vorp_lumberjack:axecheck", function(tree)
	local _source = source
	local choppingtree = tree
	local axe = VorpInv.getItemCount(_source, Config.Axe)

	if axe > 0 then
		TriggerClientEvent("vorp_lumberjack:axechecked", _source, choppingtree)
	else
		TriggerClientEvent("vorp_lumberjack:noaxe", _source)
		TriggerClientEvent("vorp:TipRight", _source, "Anda tidak memiliki Hatchet", 2000)
	end
end)

RegisterServerEvent("vorp_lumberjack:addItem")
AddEventHandler("vorp_lumberjack:addItem", function()
	local _source = source
	local User = VorpCore.getUser(_source).getUsedCharacter
	local inventory = VorpInv.getUserInventory(_source)
	TriggerEvent("vorpCore:canCarryItems", tonumber(_source), 1, function(canCarry)
		if canCarry then
			if contains(inventory, "wood") then
				for i,item in pairs(inventory) do
					if item.name == "wood" then
						local carrying = 1 + item.count
						if item.limit >= carrying then
							VorpInv.addItem(_source, "wood", 1)
							TriggerClientEvent("vorp:TipRight", _source, "Anda memotong beberapa "..item.label, 3000)
						else
							TriggerClientEvent("vorp:TipRight", _source, "Anda tidak bisa membawa lebih banyak lagi "..item.label, 3000)
						end
					end
				end
			else
				local item = "wood"
				exports.ghmattimysql:execute('SELECT * FROM items WHERE item = @item', {['item'] = item}, function(result)
					if result[1] ~= nil then
						local itemlimit = result[1].limit
						local itemlabel = result[1].label
						if itemlimit >= 1 then 
							VorpInv.addItem(_source, item, 1)
							TriggerClientEvent("vorp:TipRight", _source, "Anda memotong beberapa "..itemlabel, 3000)
						else
							TriggerClientEvent("vorp:TipRight", _source, "Anda tidak bisa membawa lebih banyak lagi "..itemlabel, 3000)
						end 
					end
				end)
			end
		else
			TriggerClientEvent("vorp:TipRight", _source, "Anda tidak bisa membawa lebih banyak item lagi", 3000)
		end
	end)
end)

function contains(table, element)
	for k, v in pairs(table) do
		for x, y in  pairs(v) do
			  if y == element then
				return true
			end
		end
	end
	return false
end