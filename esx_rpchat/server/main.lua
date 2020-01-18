ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('es:invalidCommandHandler', function(source, command_args, user)
	CancelEvent()
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', _U('unknown_command', command_args[1]) } })
end)


--
RegisterCommand('intentar', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.EnableESXIdentity then name = GetCharacterName(source) end
	local result = math.random(1, 2)
	local resultMessages = {"^*^2Éxito", "^*^1Fallido"}
	local resultMessage = resultMessages[result]

	TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, _U('try_prefix', name), '^*'..args, { 255, 255, 255 }, true, 'try', { 255, 128, 0 }) -- { 255, 128, 0 }
	TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, '^* Resultado', ' '..resultMessage, { 255, 255, 255 }, true, 'res', { 255, 128, 0 })
	--print(('%s: %s'):format(name, args))
end, false)
--
AddEventHandler('chatMessage', function(source, name, message)
	if string.sub(message, 1, string.len('/')) ~= '/' then
		CancelEvent()

	if Config.EnableESXIdentity then name = GetCharacterName(source) end
		--TriggerClientEvent('chat:addMessage', -1, { args = { _U('ooc_prefix', name), message }, color = { 128, 128, 128 } })
		TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, _U('ooclocal_prefix', name), '^*'..message, { 255, 255, 255 }, false, 'ooc', {128, 128, 128}) --128, 128, 128
	end
end)

--
RegisterCommand('ooc', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.EnableESXIdentity then name = GetCharacterName(source) end

	--TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, _U('me_prefix', name), args, { 255, 0, 0 })
	--TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, _U('ooc_prefix', name), args, { 128, 128, 128 })
	TriggerClientEvent('chat:addMessage', -1, { 
		template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 3px;"><i class="fas fa-globe"></i> {0}: {1}</div>', --{0}:<br> {1}</div>
		args = { _U('ooc_prefix', name), '^*'..args }, color = { 255, 255, 255 } -- 128, 128, 128
	})
	--print(('%s: %s'):format(name, args))
end, false)
--

RegisterCommand('twt', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.EnableESXIdentity then name = GetCharacterName(source) end

	TriggerClientEvent('chat:addMessage', -1, {
		template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(28, 160, 242, 0.6); border-radius: 3px;"><i class="fab fa-twitter"></i> {0}: {1}</div>', --@{0}:<br> {1}
		args = { _U('twt_prefix', name), '^*'..args }, color = { 255, 255, 255 } --{ 0, 153, 204 }
	})

	--TriggerClientEvent('chat:addMessage', -1, { args = { _U('twt_prefix', name), '^*  '..args }, color = { 0, 153, 204 } }) --{0, 153, 204}  '^*^4'
	--print(('%s: %s'):format(name, args))
end, false)

RegisterCommand('ad', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end
	local xPlayer = ESX.GetPlayerFromId(source)
	local costo = 500000
	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.EnableESXIdentity then name = GetCharacterName(source) end

	if xPlayer.getAccount('bank').money >= costo then
		xPlayer.removeAccountMoney('bank', costo)
		TriggerClientEvent('chat:clear', -1)
		TriggerClientEvent('chat:addMessage', -1, { 
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 255, 255, 1.0); border-radius: 3px; text-align: center;"><i class="fas fa-ad"></i> {0}<br><br> {1}</div>',
			args = { _U('ad_prefix'), '^*^11'..args }, color = {0, 0, 0} 
		})
		xPlayer.showNotification('Haz publicado un anuncio por $'..costo..' pesos')
	else
		xPlayer.showNotification('No tienes suficiente dinero para publicar un anuncio')
	end
end, false)

RegisterCommand('me', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.EnableESXIdentity then name = GetCharacterName(source) end

	TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, _U('me_prefix', name), '^*'..args, { 255, 255, 255 }, true, 'me', { 170, 102, 204 }) --{255, 0 , 0} ^*^6 --{ 170, 102, 204 }
	--print(('%s: %s'):format(name, args))
end, false)

RegisterCommand('do', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.EnableESXIdentity then name = GetCharacterName(source) end

	TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, _U('do_prefix', name), '^*'..args, { 255, 255, 255 }, true, 'do', { 255, 187, 51 }) --{0, 0, 255} ^*^3 --{ 255, 187, 51 }
	--print(('%s: %s'):format(name, args))
end, false)

function GetCharacterName(source)
	local result = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
		['@identifier'] = GetPlayerIdentifiers(source)[1]
	})

	if result[1] and result[1].firstname and result[1].lastname then
		if Config.OnlyFirstname then
			return result[1].firstname
		else
			return ('%s %s'):format(result[1].firstname, result[1].lastname)
		end
	else
		return GetPlayerName(source)
	end
end
