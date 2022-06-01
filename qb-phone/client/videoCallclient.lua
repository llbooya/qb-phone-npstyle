RegisterNUICallback("startCallId", function(data)
    local cal = GetPlayerServerId(PlayerId())
    TriggerServerEvent("nakres_videocall:sendCall", data.id , cal)
end)

RegisterNetEvent("nakres_videocall:sendCall")
AddEventHandler("nakres_videocall:sendCall", function(id,cal)
    SendNUIMessage({
        type = "answer",
        serverId = id ,
        callerId = cal
    })
end)

RegisterNUICallback("sendData", function(data)
    if data.serverId == nil then
        data.serverId = GetPlayerServerId(PlayerId())
  end
    TriggerServerEvent("nakres_videocall:sendData", data)
end)

RegisterNUICallback("stopVideoCall", function(data)
    TriggerServerEvent("nakres_videocall:stopCall", data.callId)
end)

RegisterNUICallback("deletServerUser", function()
    local id = GetPlayerServerId(PlayerId())
    TriggerServerEvent("nakres_videocall:deletServerUser", id)
end)

RegisterNetEvent("nakres_videocall:stopCall")
AddEventHandler("nakres_videocall:stopCall", function()
    SendNUIMessage({
        type = "stopCall"
    })
end)

RegisterNetEvent("nakres_videocall:sendData")
AddEventHandler("nakres_videocall:sendData", function(data)
    SendNUIMessage({
        data = data,
        type = "sendData"
    })
end)

RegisterNetEvent("videoCall")
AddEventHandler("videoCall",function(id)
    SendNUIMessage({
        action = "startVideoCall",
        callId = id
    })
end)