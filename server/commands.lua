local QBCore = exports['qb-core']:GetCoreObject()

lib.locale()

QBCore.Functions.CreateCallback('nd-adminmenu/CheckPerms', function(source, cb)
  local src = source                                      
  if QBCore.Functions.HasPermission(src, 'admin') or IsPlayerAceAllowed(src, 'command') then
    cb(true)
  else
    cb(true)
  end
end)

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
RegisterNetEvent('nd-adminmenu/server/ban', function(player, time, reason, perma)
  local src = source
  
  local banTime = os.time() + time
  if perma then
    time2 = 99999999999
  end
  local src = source
local timestamp = math.floor(time / 1000)
local date = os.date('%Y-%m-%d %H:%M:%S', timestamp)
  local timeTable = os.date('*t', banTime)
  MySQL.insert('INSERT INTO bans (name, license, discord, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)', {
    GetPlayerName(player),
    QBCore.Functions.GetIdentifier(player, 'license'),
    QBCore.Functions.GetIdentifier(player, 'discord'),
    QBCore.Functions.GetIdentifier(player, 'ip'),
    reason,
    timestamp,
    GetPlayerName(src)
  })

  if perma then
    DropPlayer(player, 'Ki lettél bannolva!\nOka: ' .. reason .. '\nBannod végleges!')
  else
    DropPlayer(player,
      'Ki lettél bannolva!\nOka: ' ..
      reason ..
      '\nBannod vége: ' ..
      timeTable['day'] ..
      '/' ..
      timeTable['month'] ..
      '/' ..
      timeTable['year'] ..
      ' ' ..
      timeTable['hour'] .. ':' .. timeTable['min'] .. '\n🔸 Több információért: Csatlakozz a discord szerverünkre!')
  end
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


