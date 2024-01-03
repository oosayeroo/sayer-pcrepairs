local QBCore = exports['qb-core']:GetCoreObject()

local JobAvailable = true
local IsOnJob = false
local PCRepaired = false
ITCompPeds = {}
PCJobDoorwayIn = {}
PCJobDoorwayOut = {}
PCJobComputer = {}
local BrokenParts = {}
local CurrentPCJobHouse = nil
local CurrentWage = 0
local CheckedParts = {} 

local PedOptions = {
    ['shop'] = {
        {
            action = function() OpenShopMenu() end,
            icon = 'fas fa-basket-shopping',
            label = "Buy Parts",
            job = Config.JobName
        },
        {
            action = function() OpenTradingMenu() end,
            icon = 'fas fa-clipboard',
            label = "Trade Broken Parts",
            job = Config.JobName
        },
    },
    ['job'] = {
    	{
    		event = 'sayer-pcrepairs:RequestJob',
    		icon = 'fas fa-clipboard',
    		label = "Check Jobs",
            job = Config.JobName
    	},
        {
            event = 'sayer-pcrepairs:CollectWages',
            icon = 'fas fa-money-bill',
            label = "Collect Wages",
            job = Config.JobName
        },
    },
}

CreateThread(function()
    for k,v in pairs(Config.Peds) do
        local model = ''
        local entity = ''
        model = v.Model
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(0)
        end
      
        entity = CreatePed(0, model, v.Coords.x,v.Coords.y,v.Coords.z-1,v.Coords.w, false, false)
        SetEntityInvincible(entity,true)
        FreezeEntityPosition(entity,true)
        SetBlockingOfNonTemporaryEvents(entity,true)
        local P = PedOptions[v.Type]
        ITCompPeds["Ped"..k..v.Coords] = AddTargetEntity(entity, P)
        if v.Blip then
            ItCompJob = AddBlipForCoord(v.Coords.x,v.Coords.y,v.Coords.z)
            SetBlipSprite (ItCompJob, 606)
            SetBlipDisplay(ItCompJob, 4)
            SetBlipScale  (ItCompJob, 0.8)
            SetBlipAsShortRange(ItCompJob, true)
            SetBlipColour(ItCompJob, 3)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(v.BlipName)
            EndTextCommandSetBlipName(ItCompJob)
        end
    end
end)

RegisterNetEvent('sayer-pcrepairs:RequestJob', function()
    for k,v in pairs(Config.Parts) do
        DebugCode("Config Entry: "..k)
    end
    local numParts = 0
    for _ in pairs(Config.Parts) do
        numParts = numParts + 1
    end
    -- Now numParts contains the count of items in Config.Parts
    DebugCode("Number of parts:"..numParts)

    
    if JobAvailable then
        JobAvailable = false
        IsOnJob = true
        BrokenParts = {}
        CheckedParts = {}

        if not next(Config.Parts) then
            SendNotify("Config.Parts is empty!", 'error')
            return
        end

        local numPartsToBreak = math.random(1, numParts)
        
        DebugCode(numPartsToBreak)

        local partsList = {}
        for k, v in pairs(Config.Parts) do
            table.insert(partsList, k)
            DebugCode("k = "..k.." !")
        end

        for i = 1, numPartsToBreak do
            if #partsList > 0 then
                local randomIndex = math.random(1, #partsList)
                local randomPart = partsList[randomIndex]
                table.insert(BrokenParts, randomPart)
                table.remove(partsList, randomIndex)  -- Remove the chosen part from the list to avoid duplicates
            else
                SendNotify("Not enough parts in Config.Parts!", 'error')
                return
            end
        end
        for _, brokenPartKey in ipairs(BrokenParts) do
            local brokenPartValue = Config.Parts[brokenPartKey]
            DebugCode("Broken Part Key: " .. brokenPartKey)
            DebugCode("Broken Part Value: " .. tostring(brokenPartValue))
        end

        QBCore.Functions.Progressbar("pickup", "Discussing Jobs", 5000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },{})
        Wait(5000)

        TriggerEvent('sayer-pcrepairs:ChooseHouseFromConfig')
    else
        SendNotify("No Jobs Available Right Now", 'error')
    end
end)


RegisterNetEvent('sayer-pcrepairs:CollectWages', function()
    if IsOnJob then
        if PCRepaired then
            TriggerEvent('sayer-pcrepairs:MoneyChoice')
        else
            SendNotify("You Havent Finished Your Current Job", 'error')
        end
    else
        SendNotify("Try Doing Some Work First", 'error')
    end
end)

RegisterNetEvent("sayer-pcrepairs:ChooseHouseFromConfig", function()
    CurrentPCJobHouse = Config.Locations[math.random(#Config.Locations)]
    CreatePCBlips(CurrentPCJobHouse)
    CreateTargets(CurrentPCJobHouse)
end)

function LoadComputerModel()
    local coords = vector4(CurrentPCJobHouse.Computer.Coords.x,CurrentPCJobHouse.Computer.Coords.y,CurrentPCJobHouse.Computer.Coords.z,CurrentPCJobHouse.Computer.Coords.w)
    local model = ''
    local entity = ''
    model = Config.ComputerModel
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end
    SpawnedPC = CreateObject(model, coords.x,coords.y,coords.z-1,coords.w, true, false, true)
    SetEntityAsMissionEntity(SpawnedPC)
end

RegisterNetEvent("sayer-pcrepairs:EnterHouse", function()
    if IsOnJob then
        ExecuteCommand('e knock')
        QBCore.Functions.Progressbar("pickup", "Entering...", Config.Timings.Knocking*1000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },{})
        Wait(Config.Timings.Knocking*1000)
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent('InteractSound_SV:PlayOnSource', 'houses_door_open', 0.25)
        SetEntityCoords(PlayerPedId(), CurrentPCJobHouse.Inside.x, CurrentPCJobHouse.Inside.y, CurrentPCJobHouse.Inside.z)
        TriggerEvent("sayer-pcrepairs:createpc", CurrentPCJobHouse)
        SendNotify(CurrentPCJobHouse.InsideMessage, 'success', 8000)
    else
        SendNotify("You Arent Working Right Now", 'error')
    end
end)

RegisterNetEvent("sayer-pcrepairs:LeaveHouse", function()
    SetEntityCoords(PlayerPedId(), CurrentPCJobHouse.Outside.x, CurrentPCJobHouse.Outside.y, CurrentPCJobHouse.Outside.z)
    if PCRepaired then
        SendNotify("Thank You For All Your Help!")
    else
        SendNotify("Where Are You Going?", 'error')
    end
end)

function CheckPart(part)
    if IsOnJob then
        if QBCore.Functions.HasItem('pc_toolbox') then
            QBCore.Functions.Progressbar("check_part", "Checking Part: " .. QBCore.Shared.Items[part].label, Config.Timings.Checking * 1000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "mini@repair",
                anim = "fixing_a_ped",
                flags = 8,
            })

            Wait(Config.Timings.Checking * 1000)

            for _, brokenPartKey in ipairs(BrokenParts) do
                if brokenPartKey == part then
                    TriggerEvent('sayer-pcrepairs:BrokenPartFound', part)
                    CheckedParts[part] = true
                    return
                end
            end

            SendNotify("This Part Is Not Broken")
            CheckedParts[part] = true
            for _, v in pairs(CheckedParts) do
                DebugCode("V = "..tostring(v))
            end
        else
            SendNotify("You don't have your toolbox with you!", 'error')
        end
    end
end

function FixPCMenu()
    if PCRepaired then
        SendNotify("This PC Is Running Healthy Again", 'error')
    else
        local menuItems = {
            {
                header = "Current PC Parts Fitted",
                isMenuHeader = true
            },
        }

        for k,v in pairs(Config.Parts) do
            local item = {}
            item.header = QBCore.Shared.Items[k].label
            if Config.ShowImages then
                item.icon = k
            end
            local text = ""
            DebugCode("CheckedParts[" .. k .. "] = " .. tostring(CheckedParts[k]))
            if CheckedParts[k] then
                text = "<img src='nui://"..Config.ImageLink..Config.CheckMark.."' width='35px' style='margin-right: 10px'> " .. "Already Checked The "..QBCore.Shared.Items[k].label
            else
                text = " Check The " .. QBCore.Shared.Items[k].label
            end
            item.text = text
            item.params = {event = 'sayer-pcrepairs:CheckPart',args = {part = k}}
            table.insert(menuItems, item)
        end

        table.insert(menuItems, {
            header = "Close (ESC)",
            isMenuHeader = true
        })

        exports['qb-menu']:openMenu(menuItems)
    end
end

RegisterNetEvent('sayer-pcrepairs:CheckPart', function(args)
    DebugCode("CheckPart : Part = "..args.part)
    CheckPart(args.part)
end)

RegisterNetEvent("sayer-pcrepairs:BrokenPartFound", function(part)
    local delmenu = nil
    delmenu = exports['qb-input']:ShowInput({
        header = "Looks Like The "..QBCore.Shared.Items[part].label.." Needs Replacing",
		submitText = "Fix!",
        inputs = {
            {
                text = "Fix?",        
                name = "fix",      
                type = "radio",     
                isRequired = true,
                options = {
                    { value = "true", text = "Yes" }, 
                    { value = "false", text = "No" },
                },
            },
        }
    })
    if delmenu ~= nil then
        if delmenu.fix == nil then return DebugCode("DELMENU NIL") end
        if delmenu.fix  == 'true' then
            TriggerEvent("sayer-pcrepairs:SwapOutPart",part)
        end
    end
end)

RegisterNetEvent('sayer-pcrepairs:SwapOutPart', function(part)
    DebugCode(" Part = "..part)
    if QBCore.Functions.HasItem(part) then
        QBCore.Functions.Progressbar("pickup", "Swapping Old Part For New!", Config.Timings.Fixing*1000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },{
            animDict = "mini@repair",
            anim = "fixing_a_ped",
            flags = 8,
            }
        )
        Wait(Config.Timings.Fixing*1000)
        if Config.UseMinigame then
            StartMiniGame(function(result)
                if result then
                    TriggerServerEvent('sayer-pcrepairs:RemoveItem', part, 1)
                    RemovePartFromBroken(part)
                    local broken = Config.Parts[part].BrokenItem
                    TriggerServerEvent('sayer-pcrepairs:GiveItem', broken, 1)
                    local addedwage = math.random(Config.Parts[part].FixReward.Min, Config.Parts[part].FixReward.Max)
                    CurrentWage = CurrentWage + addedwage
                else
                    SendNotify("You Failed To Repair Part", 'error')
                end
            end)
        else
            TriggerServerEvent('sayer-pcrepairs:RemoveItem', part, 1)
            RemovePartFromBroken(part)
            local broken = Config.Parts[part].BrokenItem
            TriggerServerEvent('sayer-pcrepairs:GiveItem', broken, 1)
            local addedwage = math.random(Config.Parts[part].FixReward.Min, Config.Parts[part].FixReward.Max)
            CurrentWage = CurrentWage + addedwage
        end
    else
        SendNotify("You Need a "..QBCore.Shared.Items[part].label.." To Replace This With!", 'error')
    end
end)

RegisterNetEvent("sayer-pcrepairs:MoneyChoice", function(data)
    local delmenu = nil
    delmenu = exports['qb-input']:ShowInput({
        header = "How You Wanna Be Paid? </br> Current Wage Is $"..CurrentWage.."!",
		submitText = "Collect Wage!",
        inputs = {
            {
                text = "Cash/Bank(#)",    
                name = "account",    
                type = "radio",    
                isRequired = true,
                options = {
                    { value = "cash", text = "Cash" }, 
                    { value = "bank", text = "Bank" },
                },
            },
        }
    })
    if delmenu ~= nil then
        if delmenu.account == nil then return DebugCode("DELMENU NIL") end
        if delmenu.account  ~= nil then
            TriggerEvent("sayer-pcrepairs:CollectMoney",delmenu.account)
        end
    end
end)

RegisterNetEvent('sayer-pcrepairs:CollectMoney', function(payment)
    DebugCode("CurrentWage = "..CurrentWage)
    DebugCode("Payment Type = "..payment)
    local wage = CurrentWage
    TriggerServerEvent('sayer-pcrepairs:GiveMoney', wage, payment)
    CurrentWage = 0
    JobAvailable = true
    IsOnJob = false
    PCRepaired = false
    CurrentPCJobHouse = nil
    BrokenParts = {}
    CheckedParts = {}
    RemoveTargetStuff()
    if DoesEntityExist(SpawnedPC) then DeleteEntity(SpawnedPC) end
end)

function RemovePartFromBroken(part)
    for i, v in ipairs(BrokenParts) do
        if v == part then
            table.remove(BrokenParts, i)
            if #BrokenParts == 0 then
                SendPhoneEmail(Config.CompanyName, "PC Repairs", "PC is all fixed. Please return for your wages")
                TriggerEvent('sayer-pcrepairs:fixedpc')
                PCRepaired = true
                RemoveBlip(targetBlip)
            end
            return
        end
    end
end

function OpenTradingMenu()
    local columns = {
        {header = "Trade Broken Parts",isMenuHeader = true,}, 
    }
    for k,v in pairs(Config.BrokenPartsTrading) do
        if QBCore.Shared.Items[k] ~= nil then
            if QBCore.Functions.HasItem(k) then
                local item = {}
                item.header = QBCore.Shared.Items[k].label
                local text = ""
                text = "Trade in "..QBCore.Shared.Items[k].label.."'s for materials!"
                item.text = text
                item.params = {event = 'sayer-pcrepairs:TradePackages',args = {taken = k}}
                table.insert(columns, item)
            end
        else
            DebugCode("Cannot Find : "..k.."In Shared/Items.lua")
        end
    end 
    exports['qb-menu']:openMenu(columns)
end

RegisterNetEvent("sayer-pcrepairs:TradePackages", function(args) 
    if QBCore.Functions.HasItem(args.taken) then
		QBCore.Functions.Progressbar("pickup_sla", "Trading Parts..", 1000, false, true, 
		{disableMovement = true,disableCarMovement = true,disableMouse = false,disableCombat = true,}, 
		{animDict = "mp_common",anim = "givetake1_a",flags = 8,}, {}, {}, function() -- Done
			TriggerServerEvent('sayer-pcrepairs:TradingPackage',args.taken)
		end, function()
			QBCore.Functions.Notify("Cancelled..", "error")
		end)
	else
   		QBCore.Functions.Notify("You dont have any of those", "error")
	end
end)

function RemoveTargetStuff()
    for k in pairs(PCJobDoorwayIn) do exports['qb-target']:RemoveZone(k) end
    for k in pairs(PCJobDoorwayOut) do exports['qb-target']:RemoveZone(k) end
    for k in pairs(PCJobComputer) do exports['qb-target']:RemoveZone(k) end
end

--used to reset peds/zones when restarting script
AddEventHandler('onResourceStop', function(t) if t ~= GetCurrentResourceName() then return end
    for k in pairs(ITCompPeds) do exports['qb-target']:RemoveTargetEntity(k) end
    for k in pairs(PCJobDoorwayIn) do exports['qb-target']:RemoveZone(k) end
    for k in pairs(PCJobDoorwayOut) do exports['qb-target']:RemoveZone(k) end
    for k in pairs(PCJobComputer) do exports['qb-target']:RemoveZone(k) end
    if DoesEntityExist(SpawnedPC) then DeleteEntity(SpawnedPC) end
end)