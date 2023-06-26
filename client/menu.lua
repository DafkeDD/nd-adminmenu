local QBCore = exports['qb-core']:GetCoreObject() --Boy what the hell boy
lib.locale()

RegisterNetEvent('nd-adminmenu/openmenu', function()
    --print('megyen-e?')

    -- Jármű menü
    lib.registerMenu({
        id = 'vehiclemenu',
        title = locale('vehicle_menu_title'),
        position = 'top-right',
        onClose = function(keyPressed)
            lib.showMenu('adminmenu')
        end,
        options = {
            {label = locale('Vehicle_Spawn'), description = locale('vehicle_spawn_desc')},
            {label = locale('vehicle_delete'), description = locale('vehicle_delete_decs')},
            {label = locale('vehicle_fix'), description = locale('vehicle_fix_desc')},
        },
    }, function(selected, scrollIndex, args)
        --print('Kiválasztott jármű opció: '..selected)
        if selected == 1 then
            TriggerEvent('nd-adminmenu/spawnVehicle')
        elseif selected == 2 then
            TriggerEvent('nd-adminmenu/deleteVehicle')
            lib.showMenu('vehiclemenu')
        elseif selected == 3 then
            TriggerEvent('nd-adminmenu/repairVehicle')
            lib.showMenu('vehiclemenu')
        end
    end)

    -- Játékos menü
    lib.registerMenu({
        id = 'playermenu',
        title = locale('player_option_title'),
        position = 'top-right',
        onClose = function(keyPressed)
            lib.showMenu('adminmenu')
        end,
        options = {
            {label = locale('noclip'), description = locale('noclip_desc')},
            {label = locale('show_id'), description = locale('show_id_desc')},
            {label = locale('god_mode'), description = locale('god_mode_desc')},
            {label = locale('spectate'), description = locale('spectate_desc')},
            {label = locale('staff_announcment'), description = locale('staff_announcment_desc')},
            {label = locale('ban_player'), description = locale('ban_player_desc')},
            {label = locale('player_revive'), description = locale('player_revive_desc')},
            {label = locale('invisible')},
        },
    }, function(selected, scrollIndex, args)
       -- print('Kiválasztott játékos opció: '..selected)
        if selected == 1 then
            TriggerEvent('nd-adminmenu/togglenoclip')
            lib.showMenu('playermenu')
        elseif selected == 2 then
            TriggerEvent('nd-adminmenu/togglePlayerIDs')
            lib.showMenu('playermenu')
        elseif selected == 3 then
            TriggerEvent('nd-adminmenu/togglegodmode')
            lib.showMenu('playermenu')
        elseif selected == 4 then
            TriggerEvent('nd-adminmenu/spectateplayer')
        elseif selected == 5 then
            TriggerEvent('nd-adminmenu/annountcmentsender')
        elseif selected == 6 then
            TriggerEvent('nd-adminmenu/banplayer/client')
        elseif selected == 7 then
            TriggerEvent('nd-adminmenu/revive/client')
        elseif selected == 8 then
            TriggerEvent('nd-adminmenu/invisible/client')
            lib.showMenu('playermenu')
        end

    end)

    -- Főmenü
    lib.registerMenu({
        id = 'adminmenu',
        title = locale('menu_title'),
        position = 'top-right',
        onClose = function(keyPressed)
            print('Menü bezárva')
        end,
        options = {
            {label = locale('vehicle_options'), description = locale('vehicle_options_desc'), menuId = 'vehiclemenu'},
            {label = locale('player_options'), description = locale('player_options_desc'), menuId = 'playermenu'},
        },
    }, function(selected, scrollIndex, args)
        --print('Kiválasztott menüpont: '..selected)
        if selected == 1 then
            lib.showMenu('vehiclemenu')
        elseif selected == 2 then
            lib.showMenu('playermenu')
        end        
    end)

    QBCore.Functions.TriggerCallback('nd-adminmenu/CheckPerms', function(result)
        if result == true then
            lib.showMenu('adminmenu')
        else
            lib.notify({
                id = 'no perm',
                title = locale('menu_title'),
                description = locale('no_perm'),
                position = 'top',
                style = {
                    backgroundColor = '#141517',
                    color = '#C1C2C5',
                    ['.description'] = {
                        color = '#909296'
                    }
                },
                icon = 'ban',
                iconColor = '#C53030'
            })
        end
    end)
end)
CreateThread(function()
lib.addKeybind({
    name = 'openmenu',
    description = locale('keybind_name'),
    defaultKey = Config.menukeybind,
    onReleased = function(self)
       TriggerEvent('nd-adminmenu/openmenu')
    end,
})
end)