local QBCore = exports['qb-core']:GetCoreObject()
hasHackedPhone = false

CreateThread(function()
    QBCore.Functions.LoadModel(Config.ChatSeller)

    local ped = CreatePed(5, 'csb_sol', Config.SellerLocation, false, false)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_STAND_MOBILE_UPRIGHT_CLUBHOUSE', 0, true)

    exports['qb-target']:AddTargetModel(Config.ChatSeller, {
        options = {
            {
                type = "client",
                event = "qb-phone:client:openChannelMenu",
                icon = 'fas fa-comment-dots',
                label = 'Purchase Chat Channel',
                --targeticon = 'fas fa-comments', 
            },
            {
                type = "client",
                event = "qb-phone:client:openChannelHackedMenu",
                icon = 'fas fa-user-secret',
                label = 'Purchase Secured Channel',
               -- targeticon = 'fas fa-comments',
                canInteract = function()
                    QBCore.Functions.TriggerCallback('qb-phone:server:hasHackedPhone', function(result)
                        hasHackedPhone = result                     
                    end)
                    Wait(500)
                    return hasHackedPhone
                end
            }
        }, 
        distance = 5.0
    })
end)

RegisterNetEvent('qb-phone:client:openChannelMenu', function() 
    PlayerData = QBCore.Functions.GetPlayerData()
    local dialog = exports['qb-input']:ShowInput({
        header = "Purchase Chat Channel",
        submitText = "Purchase Room ($250) $15 for every tsunami",
        --info = "Rent your own chat channel. Renews for $15 every tsunami.",
        inputs = {
            {
                text = "Channel Name",
                type = "text",
                isRequired = true,
                name = "channel-name", 
            },
            {
                text = "Passcode (Optional)",
                type = "number",
                name = "channel-passcode", 
                isRequired = false,
                -- placeholder = "Leave Blank for Public Access"
            },
        },
    })

    if dialog then
        local roomData = {
            room_owner_name = PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname
        }

        local allGood = false

        for k,v in pairs(dialog) do
            if k == 'channel-name' then
                roomData.room_name = v

                allGood = true
            end

            if k == 'channel-passcode' then
                roomData.room_pin = v
            end
        end

        if allGood then
            QBCore.Functions.TriggerCallback("qb-phone:server:PurchaseRoom",function(status) 
                if status then
                    TriggerServerEvent("qb-phone:server:CreateRoom", PlayerData.source, roomData)
                end
            end, 250)
        end
    end
end)

RegisterNetEvent('qb-phone:client:openChannelHackedMenu', function() 
    PlayerData = QBCore.Functions.GetPlayerData()
    local dialog = exports['qb-input']:ShowInput({
        header = "Purchase Secured Channel",
        submitText = "Purchase Room ($5000)",
        --info = "Rent your own chat channel. Renews for $75 every tsunami.",
        inputs = {
            {
                text = "Channel Name",
                name = "channel-name", 
                type = "text"
            },
            {
                text = "Passcode (Optional)",
                name = "channel-passcode", 
                type = "number",
            },
        },
    })

    if dialog then
        local roomData = {
            room_owner_name = PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname
        }

        local allGood = false

        for k,v in pairs(dialog) do
            if k == 'channel-name' then
                roomData.room_name = v

                allGood = true
            end

            if k == 'channel-passcode' then
                roomData.room_pin = v
            end
        end

        if allGood then
            QBCore.Functions.TriggerCallback("qb-phone:server:PurchaseRoom",function(status) 
                if status then
                    TriggerServerEvent("qb-phone:server:CreateRoom", PlayerData.source, roomData, true)
                end
            end, 5000)
        end
    end
end)

RegisterNetEvent('qb-phone:client:TriggerPhoneHack', function(src)
    PlayerData = QBCore.Functions.GetPlayerData()
    QBCore.Functions.Progressbar("hack_gate", "Plugging in the usb...", math.random(5000, 10000), false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "missheistdockssetup1clipboard@base",
        anim = "base",
    }, {}, {}, function() -- Done
        StopAnimTask(PlayerPedId(), "missheistdockssetup1clipboard@base", "base", 1.0)

        local success = exports['boostinghack']:StartHack()
        if success then
            TriggerServerEvent("QBCore:Server:RemoveItem", "phone_dongle", 1)
            TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["phone_dongle"], "remove")
            TriggerServerEvent('qb-phone:server:HackPhone', PlayerData.source)
        else
            QBCore.Functions.Notify("You have failed to hack your phone.", PlayerData.source, "error")
            TriggerServerEvent("QBCore:Server:RemoveItem", "phone_dongle", 1)
            TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["phone_dongle"], "remove")
        end
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "missheistdockssetup1clipboard@base", "base", 1.0)
    end)
end)