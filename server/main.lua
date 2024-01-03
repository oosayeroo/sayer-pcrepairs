local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('sayer-pcrepairs:GiveItem', function(item, amount)
    if not amount then amount = 1 end
    local Player = QBCore.Functions.GetPlayer(source)

    Player.Functions.AddItem(item, amount)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[item], 'add')
end)

RegisterServerEvent('sayer-pcrepairs:RemoveItem', function(item, amount)
    if QBCore.Shared.Items[item] ~= nil then
        if not amount then amount = 1 end
        local Player = QBCore.Functions.GetPlayer(source)
        
        Player.Functions.RemoveItem(item, amount)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[item], 'remove')
    else
        print("Item = "..item.." Does Not Exist")
    end
end)

RegisterServerEvent('sayer-pcrepairs:GiveMoney', function(amount, type)
    local Player = QBCore.Functions.GetPlayer(source)
    
    Player.Functions.AddMoney(type, amount)
end)

RegisterNetEvent('sayer-pcrepairs:TradingPackage', function(item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local givepath = Config.BrokenPartsTrading[item].PossibleItems[math.random(1,#Config.BrokenPartsTrading[item].PossibleItems)]
    DebugCode("givepath = "..givepath)
    local giveamount = math.random(Config.BrokenPartsTrading[item].AmountToReceive.Min,Config.BrokenPartsTrading[item].AmountToReceive.Max)
    DebugCode("giveamount = "..giveamount)

    local PlayerItems = Player.PlayerData.items
    if PlayerItems ~= nil then
        for k,v in pairs(PlayerItems) do
            if v.name == item then
                if Config.Debug then print("Has Item : "..item.."!") end
                if Config.Debug then print("Item Amount : "..PlayerItems[k].amount.."!") end
                Player.Functions.RemoveItem(item, PlayerItems[k].amount)
                local finalamount = giveamount*PlayerItems[k].amount
                Player.Functions.AddItem(givepath, finalamount)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[givepath], 'add')
                TriggerClientEvent('QBCore:Notify', src, "You Traded "..PlayerItems[k].amount.."x "..QBCore.Shared.Items[item].label.." for "..finalamount.."x "..QBCore.Shared.Items[givepath].label.."!")
            end
        end
    else
        print("PlayerItems[item] is Nil")
    end
end)

function DebugCode(msg)
    if Config.Debug then
        print(msg)
    end
end
