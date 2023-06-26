local QBCore = exports['qb-core']:GetCoreObject()

lib.locale()

QBCore.Functions.CreateCallback('nd-adminmenu/CheckPerms', function(source, cb)
  local src = source                                      
  if QBCore.Functions.HasPermission(src, 'admin') or IsPlayerAceAllowed(src, 'command') then
    cb(true)
  else
    cb(false)
  end
end)

-- lib.callback.register('nd-adminmenu/CheckPerms', function(source, cb)                                    
--   if QBCore.Functions.HasPermission(source, 'admin') or IsPlayerAceAllowed(source, 'command') then
--     cb(true)
--   else
--     cb(false)
--   end
-- end)

--maga a parancs
lib.addCommand(Config.menucommand, {
    help = locale('open_menu_help'),
}, function(source, args, raw)
 TriggerClientEvent('nd-adminmenu/openmenu', source)
end)



RegisterNetEvent('nd-adminmenu/announcment', function(msg)
  local players = GetPlayers()
  for _, playerId in ipairs(players) do
     -- print("Player ID: " .. playerId)
      TriggerClientEvent('nd-adminmenu/cannouncment', playerId, msg)
  end
end)


RegisterNetEvent('nd-adminmenu/server/revive', function(player)
  TriggerEvent('hospital:client:Revive', player)
end)


--ban system server side! (Imported from qb-adminmenu but modified by drazox to fit the admin menu!)
RegisterNetEvent('nd-adminmenu/server/ban', function(input)
  player = input[1]
  local BanDuration = (input[3] or 0) * 3600 + (input[4] or 0) * 86400 + (input[5] or 0) * 2629743
  -- print('ID: ' ..input[1].. ' Ki lett bannolva! Oka: ' ..input[2].. ' Végetér: ' ..BanDuration)
  MySQL.insert('INSERT INTO bans (name, license, discord, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)', {
    GetPlayerName(input[1]),
    QBCore.Functions.GetIdentifier(input[1], 'license'),
    QBCore.Functions.GetIdentifier(input[1], 'discord'),
    QBCore.Functions.GetIdentifier(input[1], 'ip'),
    input[2],
    BanDuration,
    GetPlayerName(source)
  })
    DropPlayer(player, 'ID: ' ..input[1].. ' Ki lett bannolva! Oka: ' ..input[2])
end)




Citizen.CreateThread(function()
	Citizen.Wait(5000)
    local resName = GetCurrentResourceName()

		print("^2["..resName.."] - NightDream Developments - Advanced Admin Menu.")
		print("^2["..resName.."] - Started! Checking for TxAdmin! ")
    Wait(2000)
    if GetResourceState('monitor') == 'started' then
      print("^2["..resName.."] - TxAdmin Has been detected!")
      print("^1["..resName.."] - This script is using Spectate functions from the TxAdmin menu!")
    else
    print("^1["..resName.."] - Make sure that TxAdmin is installed and menu is on!")
    print("^1["..resName.."] - This script is using Spectate functions from the TxAdmin menu!")
  end
end)


