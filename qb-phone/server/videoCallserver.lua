local QBCore = exports['qb-core']:GetCoreObject()
local users = {}
RegisterServerEvent("nakres_videocall:sendData")
AddEventHandler("nakres_videocall:sendData", function(data)
    local user = findUser(data.callId)
    if data.type == "store_user" then
        if user then return print(("[nakres_videocall]: Bu kişi zaten bir aktif bir görüntülü konuşmada | USER ID : %s"):format(data.callId)) end
        local newUser = {
            serverId = data.serverId,
            callId = data.callId
        }
        table.insert(users, newUser)
    end

    if not user then return print(("[nakres_videocall]: Arayan kişinin ice datası bulunamadı | USER ID : %s"):format(data.callId)) end

    if data.type == "store_offer" then
        user.offer = data.offer
    elseif data.type == "store_candidate" then
        if user.candidates == nil then
            user.candidates = {}
        end
        table.insert(user.candidates, data.candidate)
    elseif data.type == "send_answer" then
        sendData({
            type = "answer",
            answer = data.answer
        }, user.serverId)
    elseif data.type == "send_candidate" then
        sendData({
            type = "candidate",
            candidate = data.candidate
        }, user.serverId)
    elseif data.type == "join_call" then
        sendData({
            type = "offer",
            offer = user.offer
        }, user.callId)
        for index, value in ipairs(user.candidates) do
            sendData({
                type = "candidate",
                candidate = value
            }, user.callId)
        end
    end
end)

function sendData(data, src)
    TriggerClientEvent("nakres_videocall:sendData", src, data)
end

function findUser(callId)
    for i, user in ipairs(users) do
        if user.callId == callId then
            return user
        end
    end
end

RegisterServerEvent("nakres_videocall:sendCall")
AddEventHandler("nakres_videocall:sendCall", function(id ,cal)
    TriggerClientEvent("nakres_videocall:sendCall", id , id , cal)
end)

RegisterServerEvent("nakres_videocall:stopCall")
AddEventHandler("nakres_videocall:stopCall", function(id)
    TriggerClientEvent("nakres_videocall:stopCall", id)
end)

RegisterServerEvent("nakres_videocall:deletServerUser")
AddEventHandler("nakres_videocall:deletServerUser", function(id)
    for i, user in ipairs(users) do
        if user.serverId == id then
            table.remove(users,i)
        end
    end
end)

RegisterServerEvent("StartCallVideo")
AddEventHandler("StartCallVideo",function(t)
    local src = source
    -- local Target = GetPlayerFromPhone(t.TargetData.number)
    local Target = QBCore.Functions.GetPlayerByPhone(t.TargetData.number)
    TriggerClientEvent("videoCall",src,Target.PlayerData.source)
end)
