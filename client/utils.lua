local QBCore = exports['qb-core']:GetCoreObject()

-- Minigame System (edit to your liking)
function StartMiniGame(callback)
    local hackpath = Config.Minigame
    local hacktime = Config.MinigameTime
    local result = false
    if hackpath == 'alphabet' then
        exports['ps-ui']:Scrambler(function(success)
            result = success
            callback(result)
        end, 'alphabet', hacktime, 0)
    elseif hackpath == 'circle' then
        exports['ps-ui']:Circle(function(success)
            result = success
            callback(result)
        end, 5, hacktime) -- NumberOfCircles, MS
    elseif hackpath == 'maze' then
        exports['ps-ui']:Maze(function(success)
            result = success
            callback(result)
        end, hacktime) -- Hack Time Limit
    elseif hackpath == 'var' then
        exports['ps-ui']:VarHack(function(success)
            result = success
            callback(result)
        end, 5, hacktime) -- Number of Blocks, Time (seconds)
    elseif hackpath == 'numeric' then
        exports['ps-ui']:Scrambler(function(success)
            result = success
            callback(result)
        end, 'numeric', hacktime, 0)
    elseif hackpath == 'greek' then
        exports['ps-ui']:Scrambler(function(success)
            result = success
            callback(result)
        end, 'greek', hacktime, 0)
    elseif hackpath == 'braille' then
        exports['ps-ui']:Scrambler(function(success)
            result = success
            callback(result)
        end, 'braille', hacktime, 0)
    elseif hackpath == 'runes' then 
        exports['ps-ui']:Scrambler(function(success)
            result = success
            callback(result)
        end, 'runes', hacktime, 0)
    end 
end

function SendPhoneEmail(sender,subject,msg)
    if not sender then sender = Config.CompanyName end
    if Config.PhoneScript == 'qb' then
        TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender =  sender,
            subject = subject,
            message = msg,
            button = {}
        })
    elseif Config.PhoneScript == 'qs' then
        TriggerServerEvent('qs-smartphone:server:sendNewMail', {
            sender =  sender,
            subject = subject,
            message = msg,
            button = {}
        })
    elseif Config.PhoneScript == 'gks' then
        TriggerServerEvent('gksphone:NewMail', {
            sender =  sender,
            subject = subject,
            message = msg,
        })
    elseif Config.PhoneScript == 'road' then
        TriggerServerEvent('roadphone:receiveMail', {sender = sender,subject = subject,
            message = msg,
            image = '/public/html/static/img/icons/app/mail.png',
            button = {}
        })
    elseif Config.PhoneScript == 'other' then
        --add your trigger here
        TriggerServerEvent('otherphone:otherevent', {
            sender =  sender,
            subject = subject,
            message = msg,
        })
    end
end

function SendNotify(msg,type,time, title)
    if not title then title = Config.CompanyName end
    if not time then time = 5000 end
    if not type then type = 'success' end
    if not msg then DebugCode("Notify Sent With No Message") return end
    if Config.NotifyScript == 'qb' then
        QBCore.Functions.Notify(msg,type,time)
    elseif Config.NotifyScript == 'okok' then
        exports['okokNotify']:Alert(title, msg, time, type, false)
    elseif Config.NotifyScript == 'qs' then
        exports['qs-notify']:Alert(msg, time, type)
    elseif Config.NotifyScript == 'other' then
        -- add your notify here
        exports['yournotifyscript']:Notify(msg,time,type)
    end
end

function OpenShopMenu()
    if Config.ShopScript == 'qb' then
        TriggerServerEvent('sayer-pcrepairs:TriggerServerShop', Config.ShopItems)
        -- TriggerServerEvent('inventory:server:OpenInventory', 'shop', 'pc_parts', Config.ShopItems)
    elseif Config.ShopScript == 'jim' then
        TriggerServerEvent(' jim-shops:ShopOpen', 'shop', 'pc_parts', Config.ShopItems)
    elseif Config.ShopScript == 'other' then
        TriggerServerEvent('yourshopscriptevent')
    end
end

function AddTargetEntity(Entity, Options)
    exports['qb-target']:AddTargetEntity(Entity,{
        options = Options,
        distance = 2.5,
    })
end

function CreateTargets(CurrentPCJobHouse)
    PCJobDoorwayIn["DoorIn"] =
    exports['qb-target']:AddCircleZone('DoorIn', vector3(CurrentPCJobHouse.Outside.x, CurrentPCJobHouse.Outside.y, CurrentPCJobHouse.Outside.z), 2.0,{
        name = 'DoorIn',
        debugPoly = false, 
        useZ=true
    }, {
        options = {
            {
                label = "Knock For Customer",
                icon = 'fas fa-hand',
                event = 'sayer-pcrepairs:EnterHouse',
                job = Config.JobName
            },
        },
        distance = 3.0
    })
    PCJobComputer["Computer"] = 
    exports['qb-target']:AddCircleZone('CheckPC', vector3(CurrentPCJobHouse.Computer.Coords.x, CurrentPCJobHouse.Computer.Coords.y, CurrentPCJobHouse.Computer.Coords.z), 1.0,{
        name = 'CheckPC',
        debugPoly = false, 
        useZ=true
    }, {
        options = {
            {
                label = "Check PC",
                icon = 'fas fa-hand',
                action = function()
                    FixPCMenu() 
                end,
                job = Config.JobName
            },
        },
        distance = 3.0
    })
    if CurrentPCJobHouse.Computer.Spawn then
        LoadComputerModel(CurrentPCJobHouse)
    end
    PCJobDoorwayOut["DoorOut"] = 
    exports['qb-target']:AddCircleZone('DoorOut', vector3(CurrentPCJobHouse.Inside.x, CurrentPCJobHouse.Inside.y, CurrentPCJobHouse.Inside.z), 2.0,{
        name = 'DoorOut',
        debugPoly = false, 
        useZ=true
    }, {
        options = {
            {
                label = "Leave The House",
                icon = 'fas fa-hand', 
                event = 'sayer-pcrepairs:LeaveHouse',
                job = Config.JobName
            },
        },
        distance = 3.0
    })
end

function CreatePCBlips(CurrentPCJobHouse)
    targetBlip = AddBlipForCoord(CurrentPCJobHouse.Outside.x, CurrentPCJobHouse.Outside.y, CurrentPCJobHouse.Outside.z)
    SetBlipSprite(targetBlip, 374)
    SetBlipColour(targetBlip, 1)
    SetBlipAlpha(targetBlip, 90)
    SetBlipScale(targetBlip, 0.5)
    SetBlipRoute(targetBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.BlipName)
    EndTextCommandSetBlipName(targetBlip)
    SendNotify("Customers Location Added To Your GPS!", "success")
end

function DebugCode(msg)
    if Config.Debug then
        print(msg)
    end
end