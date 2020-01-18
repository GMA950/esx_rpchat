local messages = {}
local offset = 0.125
local chat = false -- if you want messages to be duplicated in chat
local messagesColor = {164, 98, 193, 215} -- r,g,b,a
local colores ={}

local function DrawText3D(x ,y, z, text, color)
	local r,g,b,a = {255, 255, 255, 215}
	if color then
		r,g,b = table.unpack(color)
	end
	a = 215
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local p = GetGameplayCamCoords()
  local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
  local scale = (1 / distance) * 2
  local fov = (1 / GetGameplayCamFov()) * 100
  local scale = scale * fov
  if onScreen then
		SetTextScale(0.6, 0.6)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(r, g, b, a)
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		--DrawText(_x,_y)
		EndTextCommandDisplayText(_x, _y)
		--esto es para background i think
		-- local factor = (string.len(text)) / 370
		-- DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
    end
end

local function AddMessage(type, msg, color, owner, timeout)
	if not messages[owner] then
		messages[owner] = {}
	end

	table.insert(messages[owner], {
		--type = type,
		type = string.sub(type,4),
		--msg = msg,
		msg = string.sub(msg,3),
		color = color
	})
	SetTimeout(timeout, function()
		table.remove(messages[owner], 1)
		if #messages[owner] == 0 then
			messages[owner] = nil
		end
	end)
end

Citizen.CreateThread(function()
	while true do
		for k,v in pairs(messages) do
			for i,d in pairs(messages[k]) do
				local x,y,z = table.unpack(GetEntityCoords(k))
				z = z + 0.9 + offset*i
				--DrawText3D(x, y, z, d.type..' | '..d.msg, d.color)
				if d.type == 'Resultado' then
					local initColor = ''
					local recorte = string.sub(d.msg,4)
					if recorte == 'Éxito' then
						initColor = '~g~'
					else
						initColor = '~r~'
					end
					DrawText3D(x, y, z, d.type..'~w~: '..initColor..recorte..'~w~', d.color)
				else
					DrawText3D(x, y, z, d.type..' '..d.msg, d.color)
				end
			end
		end
		
		Wait(0)
	end
end)

RegisterNetEvent('esx_rpchat:sendProximityMessage')
AddEventHandler('esx_rpchat:sendProximityMessage', function(playerId, title, message, color, to3d, type, color2)
	local source = PlayerId()
	local target = GetPlayerFromServerId(playerId)

	local sourcePed, targetPed = PlayerPedId(), GetPlayerPed(target)
	local sourceCoords, targetCoords = GetEntityCoords(sourcePed), GetEntityCoords(targetPed)

	if target == source then

		if type == 'ooc' then
			TriggerEvent('chat:addMessage', { 
				template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 3px;"><i class="fas fa-user-friends"></i> {0}:{1}</div>',
				args = { title, message }, color = color 
			})
		elseif type == 'me' then
			TriggerEvent('chat:addMessage', { 
				template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(170, 102, 204, 0.6); border-radius: 3px;"><i class="fas fa-user"></i> {0} {1}</div>',
				args = { title, message }, color = color 
			})
		elseif type == 'do' then
			TriggerEvent('chat:addMessage', { 
				template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 187, 51, 0.6); border-radius: 3px;"><i class="fas fa-user"></i> {0} {1}</div>',
				args = { title, message }, color = color 
			})
		elseif type == 'try' then
			TriggerEvent('chat:addMessage', { 
				template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 128, 0, 0.6); border-radius: 3px;"><i class="fas fa-dice"></i> {0} {1}</div>',
				args = { title, message }, color = color 
			})
		elseif type == 'res' then
			TriggerEvent('chat:addMessage', { 
				template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 128, 0, 0.6); border-radius: 3px;"><i class="fas fa-dice"></i> {0}: {1}</div>',
				args = { title, message }, color = color 
			})
		end
		--TriggerEvent('chat:addMessage', { args = { title, message }, color = color })
		--
		if to3d then
			AddMessage(title, message, color2, sourcePed, 10000)
		end
	elseif GetDistanceBetweenCoords(sourceCoords, targetCoords, true) < 20 then
	
		if type == 'ooc' then
			TriggerEvent('chat:addMessage', { 
				template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 3px;"><i class="fas fa-user-friends"></i> {0}: {1}</div>',
				args = { title, message }, color = color 
			})
		elseif type == 'me' then
			TriggerEvent('chat:addMessage', { 
				template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(170, 102, 204, 0.6); border-radius: 3px;"><i class="fas fa-user"></i> {0} {1}</div>',
				args = { title, message }, color = color 
			})
		elseif type == 'do' then
			TriggerEvent('chat:addMessage', { 
				template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 187, 51, 0.6); border-radius: 3px;"><i class="fas fa-user"></i> {0} {1}</div>',
				args = { title, message }, color = color 
			})
		elseif type == 'try' then
			TriggerEvent('chat:addMessage', { 
				template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 128, 0, 0.6); border-radius: 3px;"><i class="fas fa-dice"></i> {0} {1}</div>',
				args = { title, message }, color = color 
			})
		elseif type == 'res' then
			TriggerEvent('chat:addMessage', { 
				template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 128, 0, 0.6); border-radius: 3px;"><i class="fas fa-dice"></i> {0}: {1}</div>',
				args = { title, message }, color = color 
			})
		end

		--TriggerEvent('chat:addMessage', { args = { title, message }, color = color })
		if to3d and HasEntityClearLosToEntity(sourcePed, targetPed, 17) == 1 then
			AddMessage(title, message, color2, targetPed, 10000)
		end
	end
end)

Citizen.CreateThread(function()
	TriggerEvent('chat:addSuggestion', '/twt',  _U('twt_help'),  { { name = _U('generic_argument_name'), help = _U('generic_argument_help') } } )
	TriggerEvent('chat:addSuggestion', '/me',   _U('me_help'),   { { name = _U('generic_argument_name'), help = _U('generic_argument_help') } } )
	TriggerEvent('chat:addSuggestion', '/do',   _U('do_help'),   { { name = _U('generic_argument_name'), help = _U('generic_argument_help') } } )
	TriggerEvent('chat:addSuggestion', '/ooc',  _U('ooc_help'),  { { name = _U('generic_argument_name'), help = _U('generic_argument_help') } } )	
	TriggerEvent('chat:addSuggestion', '/intentar',  _U('try_help'),  { { name = _U('generic_argument_name'), help = _U('generic_argument_help') } } )
	TriggerEvent('chat:addSuggestion', '/ad',   _U('try_help'),  { { name = _U('generic_argument_name'), help = _U('generic_argument_help') } } )	
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('chat:removeSuggestion', '/twt')
		TriggerEvent('chat:removeSuggestion', '/me')
		TriggerEvent('chat:removeSuggestion', '/do')
		TriggerEvent('chat:removeSuggestion', '/ooc')
		TriggerEvent('chat:removeSuggestion', '/ad')
	end
end)

RegisterCommand("getpos", function(source, args, raw)
	local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 0.0, 0.0))
	
	TriggerEvent('chat:addMessage', { args = {'^*^1Location', 'Your location is X: '..x..' Y: '..y..' Z: '..z }, color = {255,255,255} })
end)