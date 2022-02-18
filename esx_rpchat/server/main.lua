ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('chatMessage', function(playerId, playerName, message)
	CancelEvent()
end)

RegisterCommand(Config.commandOOC, function(playerId, args, rawComand, playerName)
	local message = rawComand:sub(5)
	local playerName = GetRealPlayerName(playerId)
	TriggerClientEvent('chat:addMessage', -1,{
	template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.9); border-radius: 5px; width: 400px;"><i class="fas fa-globe"></i><em>{0}:</em><br> {1}</div>',
		args = {_U('ooc_prefix', playerName), message}})
end)


RegisterCommand(Config.commandSYS, function(playerId, args, rawComand, playerName)
	local message = rawComand:sub(5)
	local playerName = GetRealPlayerName(playerId)
	local xPlayer = ESX.GetPlayerFromId(playerId)
	if xPlayer.getGroup() == 'admin' then
		TriggerClientEvent('chat:addMessage', -1,{
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(189, 30, 30, 0.9); border-radius: 5px; width: 400px;"><i class="fas fa-bullhorn"></i>{0}:<br> {1}</div>',
			args = {_U('system_prefix', _U('system_prefix2')), message}})
	end
end)

RegisterCommand(Config.commandTWT, function(playerId, args, rawComand, playerName)
	local message = rawComand:sub(5)
	local playerName = GetRealPlayerName(playerId)
	TriggerClientEvent('chat:addMessage', -1,{
	template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(28, 160, 242, 0.9); border-radius: 5px; width: 400px;"><i class="fab fa-twitter"></i><em>{0}:</em><br> {1}</div>',
		args = {_U('twt_prefix', playerName), message}})
end)

RegisterCommand(Config.commandME, function(playerId, args, rawCommand)
	if playerId == 0 then
		print('esx_rpchat: you can\'t use this command from console!')
	else
		args = table.concat(args, ' ')
		local playerName = GetRealPlayerName(playerId)

		TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, _U('me_prefix', playerName), args, {255, 0, 0})
	end
end, false)

RegisterCommand(Config.commandREKLAME, function(playerId, args, rawCommand)
	local message = rawCommand:sub(9)
	local playerName = GetRealPlayerName(playerId)
	TriggerClientEvent('chat:addMessage', -1, {
		template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 205, 0, 0.9); border-radius: 5px; width: 400px;"><i class="fas fa-briefcase"></i><em>{0}:</em><br> {1}</div>',
		args = {_U('reklame_prefix', _U('reklame_prefix2')), message}
	})
end, false)

RegisterCommand(Config.commandDO, function(playerId, args, rawCommand)
	if playerId == 0 then
		print('esx_rpchat: you can\'t use this command from console!')
	else
		args = table.concat(args, ' ')
		local playerName = GetRealPlayerName(playerId)

		TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, _U('do_prefix', playerName), args, {0, 0, 255})
	end
end, false)

function GetRealPlayerName(playerId)
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if xPlayer then
		if Config.EnableESXIdentity then
			if Config.OnlyFirstname then
				return xPlayer.get('firstName')
			else
				return xPlayer.getName()
			end
		else
			return xPlayer.getName()
		end
	else
		return GetPlayerName(playerId)
	end
end

