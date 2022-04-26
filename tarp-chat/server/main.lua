VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

-- LOCAL OOC
AddEventHandler('chatMessage', function(source, name, message)
    if string.sub(message, 1, string.len("/")) == "/" and string.sub(message, 1, string.len("/ooc")) == "/ooc" then
        local name = GetPlayerName(source)
        local _message = message:gsub("/ooc", "")
        TriggerClientEvent('poke_rpchat:sendProximityMessage', -1, source, '[OOC] '..name, _message, {128, 128, 128})
    end
    CancelEvent()
end)

-- CHAT COMMANDS
--[[RegisterCommand('ayuda', function(source, args, rawCommand)
    local source = source
    local msg = rawCommand:sub(6)
    if player ~= false then
        if args[1] ~= nil then
            local user = GetPlayerName(source)
            TriggerClientEvent("chatMessage", -1, "[Ayuda] [ID:"..source.."] ["..user.."]", {135, 105, 105}, msg)
        end
    end
end, false)]]--

-- PROXIMITY CHAT
--[[RegisterCommand('me', function(source, args, rawCommand)
    local source = source
    args = table.concat(args, ' ')
    local User = VorpCore.getUser(source)
    local Character = User.getUsedCharacter
    local playerName = Character.firstname..' '..Character.lastname
    TriggerClientEvent('poke_rpchat:sendProximityMessage', -1, source,"[me]", args, {255, 0, 0})
end, false)

RegisterCommand('do', function(source, args, rawCommand)
    local source = source
    args = table.concat(args, ' ')
    local User = VorpCore.getUser(source)
    local Character = User.getUsedCharacter
    local playerName = Character.firstname..' '..Character.lastname
    TriggerClientEvent('poke_rpchat:sendProximityMessage', -1, source,"[do]", args, {0, 0, 255})
end, false)]]--

--rwtserver

--[[RegisterCommand('rwt', function(source, args, rawCommand)
    local source = source
    local playerName
    args = table.concat(args, ' ')
    local User = VorpCore.getUser(source)
    local Character = User.getUsedCharacter
    local playerName = Character.firstname..' '..Character.lastname
    TriggerClientEvent("chatMessage", -1, "[gossip]", {0, 147, 255}, args) --- 9, 81, 3
end, false)]]--

RegisterCommand('myjob', function(source, args, rawCommand)
    local src = source
    local playerName
    args = table.concat(args, ' ')
    local name = GetPlayerName(source)
    local User = VorpCore.getUser(source)
    local Character = User.getUsedCharacter
    local kerja = Character.job
    --TriggerClientEvent("chatMessage", -1, "[OOC] ["..name.."]", {240, 255, 255}, args) --- 9, 81, 3
    TriggerClientEvent('tarp-notify:client:SendAlert', src, { type = 'inform', text = "you work as "..kerja })
end, false)

RegisterCommand('myname', function(source, args, rawCommand)
    local src = source
    local playerName
    args = table.concat(args, ' ')
    local name = GetPlayerName(source)
    local User = VorpCore.getUser(source)
    local Character = User.getUsedCharacter
    local namaic = Character.firstname..' '..Character.lastname
    --TriggerClientEvent("chatMessage", -1, "[OOC] ["..name.."]", {240, 255, 255}, args) --- 9, 81, 3
    TriggerClientEvent('tarp-notify:client:SendAlert', src, { type = 'inform', text = "your name "..namaic })
end, false)

RegisterCommand('myid', function(source, args, rawCommand)
    local src = source
    local playerName
    args = table.concat(args, ' ')
    local name = GetPlayerName(source)
    local User = VorpCore.getUser(source)
    local Character = User.getUsedCharacter
    local namaic = Character.firstname..' '..Character.lastname
    --TriggerClientEvent("chatMessage", -1, "[OOC] ["..name.."]", {240, 255, 255}, args) --- 9, 81, 3
    TriggerClientEvent('tarp-notify:client:SendAlert', src, { type = 'inform', text = "ID : "..source })
end, false)

RegisterCommand('clear', function(source, args, rawCommand)
    local src = source
    TriggerClientEvent('chat:clear', source)
    TriggerClientEvent('tarp-notify:client:SendAlert', src, { type = 'inform', text = "reset chat" })
end, false)

RegisterCommand('ooc', function(source, args, rawCommand)
    local source = source
    local playerName
    args = table.concat(args, ' ')
    local name = GetPlayerName(source)
    local User = VorpCore.getUser(source)
    local Character = User.getUsedCharacter
    local playerName = Character.firstname..' '..Character.lastname
    TriggerClientEvent("chatMessage", -1, "[OOC] ["..name.."]", {240, 255, 255}, args) --- 9, 81, 3
end, false)

RegisterCommand('admin', function(source, args, rawCommand)
    local src = source
    local playerName
    args = table.concat(args, ' ')
    local name = GetPlayerName(source)
    local User = VorpCore.getUser(source)
    local Character = User.getUsedCharacter
    local rwt = User.getGroup
    local playerName = Character.firstname..' '..Character.lastname
    if rwt == 'admin' then
        TriggerClientEvent("chatMessage", src, "[team - "..name.."]", {240, 255, 255}, args) --- 9, 81, 3
    else
        TriggerClientEvent('tarp-notify:client:SendAlert', src, { type = 'inform', text = "you dont have permission" })
    end 
end, false)

--job&gang

--[[RegisterCommand('berita', function(source, args, rawCommand)
    local _source = source
    local playerName
    args = table.concat(args, ' ')
    local User = VorpCore.getUser(source)
    local Character = User.getUsedCharacter
    --local playerName = Character.firstname..' '..Character.lastname
    local job = Character.job
    if job == 'police'  then
     TriggerClientEvent("chatMessage", -1, "[SHERIFF] ", {0, 0, 255}, args) --- 9, 81, 3
    elseif job == 'medic' then
     TriggerClientEvent("chatMessage", -1, "[MEDIC] ", {255, 0, 0}, args) --- 9, 81, 3
    elseif job == 'indian' then
        TriggerClientEvent("chatMessage", -1, "[INDIAN] ", {0, 128, 0}, args) --- 9, 81, 3 
    elseif job == 'bastard' then
        TriggerClientEvent("chatMessage", -1, "[BASTARD] ", {139, 0, 0}, args) --- 9, 81, 3
    elseif job == 'gua' then
        TriggerClientEvent("chatMessage", -1, "[CAVEMAN] ", {128, 128, 0}, args) --- 9, 81, 3
    else
     TriggerClientEvent("vorp:TipBottom", _source, 'kamu bukan anggota ', 5000)    
    end
end, false)]]--

-- COMMERCE COMMAND
--[[RegisterCommand('anuncio', function(source, args, rawCommand)
    local source = source
    local playerName
    args = table.concat(args, ' ')
    local User = VorpCore.getUser(source)
    local Character = User.getUsedCharacter
    local playerName = Character.firstname..' '..Character.lastname
    TriggerClientEvent("chatMessage", -1, "[Comercio] ["..playerName.."]", {9, 81, 3}, args)
end, false)

-- PRIVATE MESSAGE
RegisterCommand('pm', function(source, args, user)
    local player = tonumber(args[1])
    local message = args[2]
    table.remove(args, 1)
    if player then
        if message then
            TriggerClientEvent("chatMessage", player, "[PM] ["..source.."] ["..GetPlayerName(source).."]", {158, 65, 0}, table.concat(args," "))
            TriggerClientEvent("chatMessage", source, "[Sistema]", {255, 0, 0}, "Tu mensaje privado ha sido enviado")
        end
    end
end, false)]]--

-- SEND CALL
RegisterServerEvent('poke_rpchat:sendcall')
AddEventHandler('poke_rpchat:sendcall', function(targetCoords, msg, emergency)
    local _source = source
    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local sourcename = Character.firstname..' '..Character.lastname
    if emergency == 'testigo' then
        TriggerClientEvent("chatMessage", -1, "[Testigo] [".._source.."] ["..sourcename.."]", {255, 0, 0}, msg)
        TriggerClientEvent('poke_rpchat:marcador', -1, targetCoords, emergency, -1747825963)
    elseif emergency == 'auxilio' then
        TriggerClientEvent("chatMessage", -1, "[Auxilio] [".._source.."] ["..sourcename.."]", {255, 0, 0}, msg)
        TriggerClientEvent('poke_rpchat:marcador', -1, targetCoords, emergency, 1000514759)
    end
end)
