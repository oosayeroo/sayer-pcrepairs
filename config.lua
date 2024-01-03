Config = {}
Config.Debug = false --spams F8 with info (INCLUDING COORDS/ITEMS etc) (ONLY USE WHEN DEVVING)

-- Script Intergrations -- ONLY UNCOMMENT THE SCRIPT YOURE USING
-- PHONE --
Config.PhoneScript = 'qb'
-- Config.PhoneScript = 'gks'
-- Config.PhoneScript = 'qs'
-- Config.PhoneScript = 'road'

-- NOTIFY --
Config.NotifyScript = 'qb'
-- Config.NotifyScript = 'okok'
-- Config.NotifyScript = 'qs'

-- SHOP --
Config.ShopScript = 'qb'
-- Config.ShopScript = 'jim'

Config.ShowImages = true
Config.ImageLink = 'qb-inventory/html/images/'
Config.CheckMark = 'checkmark.png'

-- MINIGAME --
Config.UseMinigame = true
Config.MinigameTime = 20 --in seconds
Config.Minigame = 'circle' --edit in client_utils
-- Config.Minigame = 'alphabet'
-- Config.Minigame = 'maze'
-- Config.Minigame = 'var'
-- Config.Minigame = 'numeric'
-- Config.Minigame = 'greek'
-- Config.Minigame = 'braille'
-- Config.Minigame = 'runes'

Config.Peds = {
    {
        Model = 'a_m_m_tourist_01',
        Coords = vector4(-1085.59, -248.51, 37.76, 217.54),
        Type = 'shop', --to buy toolbox or new parts / also for trading materials
        Blip = false,
        BlipName = "IT Shop",
    },
    {
        Model = 'a_f_y_business_01',
        Coords = vector4(-1079.44, -245.69, 37.76, 171.12),
        Type = 'job', --used to get job or collect wage
        Blip = true,
        BlipName = "PC Repairs LTD",
    },
}

Config.CompanyName = "PC Repairs LTD"
Config.JobName = 'pcrepairs'
Config.ComputerModel = 'prop_monitor_w_large' --used for spawning pc if interior doesnt have one
Config.Locations = {
    {
        Outside = vector3(232.22, 672.12, 189.98),
        Inside = vector3(-174.27, 497.83, 137.65),
        Computer = {
            Coords = vector3(-169.25, 492.70, 130.04),
            Spawn = false, -- if Spawn = true then the above Coords must be vector4
        },
        InsideMessage = "The Computer is Downstairs!",
    },
    {
        Outside = vector3(-1733.14, 379.04, 89.73),
        Inside = vector3(-18.46, -591.44, 90.11),
        Computer = {
            Coords = vector3(-22.3, -592.58, 90.27),
            Spawn = false,
        },
        InsideMessage = "The Computer is in the side room!",
    },
    {
        Outside = vector3(-1130.96, 784.31, 163.89),
        Inside = vector3(-1450.1, -525.73, 56.93),
        Computer = {
            Coords = vector3(-1451.12, -529.83, 57.03),
            Spawn = false,
        },
        InsideMessage = "The Computer is in the side room!",
    },
    {
        Outside = vector3(-474.27, 585.9, 128.68),
        Inside = vector3(-1452.29, -540.71, 74.04),
        Computer = {
            Coords = vector3(-1472.13, -529.6, 73.45),
            Spawn = false,
        },
        InsideMessage = "The Computer is down the hall!",
    },
    {
        Outside = vector3(-842.77, 466.91, 87.6),
        Inside = vector3(-787.36, 315.7, 217.64),
        Computer = {
            Coords = vector3(-797.09, 321.16, 217.14),
            Spawn = false,
        },
        InsideMessage = "The Computer is down the hall!",
    },
    -- offices
    {
        Outside = vector3(-58.89, -616.26, 37.36),
        Inside = vector3(-141.65, -621.06, 168.82),
        Computer = {
            Coords = vector3(-126.86, -641.55, 168.96),
            Spawn = false,
        },
        InsideMessage = "Please Fix The Bosses Computer!",
    },
    {
        Outside = vector3(-297.53, -829.14, 32.42),
        Inside = vector3(-75.43, -827.03, 243.39),
        Computer = {
            Coords = vector3(-79.73, -802.27, 243.72),
            Spawn = false,
        },
        InsideMessage = "Please Fix The Bosses Computer!",
    },
    {
        Outside = vector3(-1580.97, -558.5, 34.95),
        Inside = vector3(-1579.53, -565.36, 108.52),
        Computer = {
            Coords = vector3(-1556.66, -575.48, 108.76),
            Spawn = false,
        },
        InsideMessage = "Please Fix The Bosses Computer!",
    },
}

Config.Timings = { --in seconds
    Knocking = 5,
    Checking = 5,
    Fixing = 5,
}

Config.Parts = { --used for fixing computers
    ['new_monitor'] = {      FixReward = {Min = 100,Max = 200}, BrokenItem = 'broken_monitor'},
    ['new_keyboard'] = {     FixReward = {Min = 100,Max = 200}, BrokenItem = 'broken_keyboard'},
    ['new_mouse'] = {        FixReward = {Min = 100,Max = 200}, BrokenItem = 'broken_mouse'},
    ['new_case'] = {         FixReward = {Min = 100,Max = 200}, BrokenItem = 'broken_case'},
    ['new_powersupply'] = {  FixReward = {Min = 100,Max = 200}, BrokenItem = 'broken_powersupply'},
    ['new_cables'] = {       FixReward = {Min = 100,Max = 200}, BrokenItem = 'broken_cables'},
    ['new_cpu'] = {          FixReward = {Min = 100,Max = 200}, BrokenItem = 'broken_cpu'},
    ['new_cpucooler'] = {    FixReward = {Min = 100,Max = 200}, BrokenItem = 'broken_cpucooler'},
    ['new_motherboard'] = {  FixReward = {Min = 100,Max = 200}, BrokenItem = 'broken_motherboard'},
    ['new_memory'] = {       FixReward = {Min = 100,Max = 200}, BrokenItem = 'broken_memory'},
    ['new_graphiccard'] = {  FixReward = {Min = 100,Max = 200}, BrokenItem = 'broken_graphiccard'},
    ['new_ssd'] = {          FixReward = {Min = 100,Max = 200}, BrokenItem = 'broken_ssd'},
}

Config.BrokenPartsTrading = { -- used for trading broken parts for materials
    ['broken_monitor'] = {PossibleItems = {'plastic', 'copper', 'metalscrap'}, AmountToReceive = {Min = 1,Max = 3}},
    ['broken_keyboard'] = {PossibleItems = {'plastic', 'copper', 'metalscrap'}, AmountToReceive = {Min = 1,Max = 3}},
    ['broken_mouse'] = {PossibleItems = {'plastic', 'copper', 'metalscrap'}, AmountToReceive = {Min = 1,Max = 3}},
    ['broken_case'] = {PossibleItems = {'plastic', 'copper', 'metalscrap'}, AmountToReceive = {Min = 1,Max = 3}},
    ['broken_powersupply'] = {PossibleItems = {'plastic', 'copper', 'metalscrap'}, AmountToReceive = {Min = 1,Max = 3}},
    ['broken_cables'] = {PossibleItems = {'plastic', 'copper', 'metalscrap'}, AmountToReceive = {Min = 1,Max = 3}},
    ['broken_cpu'] = {PossibleItems = {'plastic', 'copper', 'metalscrap'}, AmountToReceive = {Min = 1,Max = 3}},
    ['broken_cpucooler'] = {PossibleItems = {'plastic', 'copper', 'metalscrap'}, AmountToReceive = {Min = 1,Max = 3}},
    ['broken_motherboard'] = {PossibleItems = {'plastic', 'copper', 'metalscrap'}, AmountToReceive = {Min = 1,Max = 3}},
    ['broken_memory'] = {PossibleItems = {'plastic', 'copper', 'metalscrap'}, AmountToReceive = {Min = 1,Max = 3}},
    ['broken_graphiccard'] = {PossibleItems = {'plastic', 'copper', 'metalscrap'}, AmountToReceive = {Min = 1,Max = 3}},
    ['broken_ssd'] = {PossibleItems = {'plastic', 'copper', 'metalscrap'}, AmountToReceive = {Min = 1,Max = 3}},
}

Config.ShopItems = { --used for buying parts
label = 'PC Repairs LTD',
    slots = 13,
    items = {
        [1] = {name = 'new_monitor',        price = 50,amount = 100,info = {},type = 'item',slot = 1,},
        [2] = {name = 'new_keyboard',       price = 50,amount = 100,info = {},type = 'item',slot = 2,},
        [3] = {name = 'new_mouse',          price = 50,amount = 100,info = {},type = 'item',slot = 3,},
        [4] = {name = 'new_case',           price = 50,amount = 100,info = {},type = 'item',slot = 4,},
        [5] = {name = 'new_powersupply',    price = 50,amount = 100,info = {},type = 'item',slot = 5,},
        [6] = {name = 'new_cables',         price = 50,amount = 100,info = {},type = 'item',slot = 6,},
        [7] = {name = 'pc_toolbox',         price = 50,amount = 100,info = {},type = 'item',slot = 7,},
        [8] = {name = 'new_cpu',            price = 50,amount = 100,info = {},type = 'item',slot = 8,},
        [9] = {name = 'new_cpucooler',      price = 50,amount = 100,info = {},type = 'item',slot = 9,},
        [10] = {name = 'new_motherboard',   price = 50,amount = 100,info = {},type = 'item',slot = 10,},
        [11] = {name = 'new_memory',        price = 50,amount = 100,info = {},type = 'item',slot = 11,},
        [12] = {name = 'new_graphiccard',   price = 50,amount = 100,info = {},type = 'item',slot = 12,},
        [13] = {name = 'new_ssd',           price = 50,amount = 100,info = {},type = 'item',slot = 13,},
    }
}
