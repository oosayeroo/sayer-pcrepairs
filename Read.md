Discord - https://discord.gg/3WYz3zaqG5

## Dependencies
[qb-core](https://github.com/qbcore-framework/qb-core)
[qb-target](https://github.com/qbcore-framework/qb-target)

## Insert into @qb-core/Shared/Items.lua
```
	-- sayer-pcrepairs
    -- new items
	new_monitor				    = {name = 'new_monitor', 			    label = 'Monitor',	            			weight = 100,     type = 'item',      image = 'new_monitor.png',         	unique = false,     useable = true,     shouldClose = true,     combinable = nil,   description = ''},
	new_keyboard 			    = {name = 'new_keyboard', 			    label = 'Keyboard',	            			weight = 100,     type = 'item',      image = 'new_keyboard.png',         	unique = false,     useable = true,     shouldClose = true,     combinable = nil,   description = ''},
	new_mouse 				    = {name = 'new_mouse', 				    label = 'Mouse',                			weight = 100,     type = 'item',      image = 'new_mouse.png',         	    unique = false,     useable = true,     shouldClose = true,     combinable = nil,   description = ''},
	new_case 			        = {name = 'new_case', 			        label = 'Computer Case',           			weight = 100,     type = 'item',      image = 'new_case.png',         	    unique = false,     useable = true,     shouldClose = true,     combinable = nil,   description = ''},
	new_powersupply 		    = {name = 'new_powersupply', 		    label = 'Power Supply',           			weight = 100,     type = 'item',      image = 'new_powersupply.png',       	unique = false,     useable = true,     shouldClose = true,     combinable = nil,   description = ''},
	pc_toolbox 				    = {name = 'pc_toolbox', 			    label = 'Toolbox',	            			weight = 100,     type = 'item',      image = 'pc_toolbox.png',         	unique = false,     useable = true,     shouldClose = true,     combinable = nil,   description = ''},
	new_cpu 					= {name = 'new_cpu', 				    label = 'CPU',		            			weight = 100,     type = 'item',      image = 'new_cpu.png',         	    unique = false,     useable = true,     shouldClose = true,     combinable = nil,   description = ''},
	new_cpucooler 			    = {name = 'new_cpucooler', 			    label = 'CPU Cooler',            			weight = 100,     type = 'item',      image = 'new_cpucooler.png',         	unique = false,     useable = true,     shouldClose = true,     combinable = nil,   description = ''},
	new_motherboard 			= {name = 'new_motherboard', 		    label = 'Motherboard',            			weight = 100,     type = 'item',      image = 'new_motherboard.png',       	unique = false,     useable = true,     shouldClose = true,     combinable = nil,   description = ''},
	new_memory 				    = {name = 'new_memory', 			    label = '8GB Ram Memory',            		weight = 100,     type = 'item',      image = 'new_memory.png',         	unique = false,     useable = true,     shouldClose = true,     combinable = nil,   description = ''},
	new_graphiccard 			= {name = 'new_graphiccard', 		    label = 'Graphic Card',            			weight = 100,     type = 'item',      image = 'new_graphiccard.png',       	unique = false,     useable = true,     shouldClose = true,     combinable = nil,   description = ''},
	new_ssd 					= {name = 'new_ssd', 				    label = '1TB SSD',            				weight = 100,     type = 'item',      image = 'new_ssd.png',         	    unique = false,     useable = true,     shouldClose = true,     combinable = nil,   description = ''},
	new_cables 				    = {name = 'new_cables', 		        label = 'Cables',            				weight = 100,     type = 'item',      image = 'new_cables.png',         	unique = false,     useable = true,     shouldClose = true,     combinable = nil,   description = ''},
    -- broken items
    broken_monitor 				= {name = 'broken_monitor', 			label = 'Broken Monitor',	            	weight = 100,     type = 'item',      image = 'broken_monitor.png',         unique = false,     useable = true,     shouldClose = true,     combinable = nil,   description = ''},
	broken_keyboard 		    = {name = 'broken_keyboard', 			label = 'Broken Keyboard',	            	weight = 100,     type = 'item',      image = 'broken_keyboard.png',        unique = false,     useable = true,     shouldClose = true,     combinable = nil,   description = ''},
	broken_mouse 			    = {name = 'broken_mouse', 				label = 'Broken Mouse',                	    weight = 100,     type = 'item',      image = 'broken_mouse.png',         	unique = false,     useable = true,     shouldClose = true,     combinable = nil,   description = ''},
	broken_case 			    = {name = 'broken_case', 			    label = 'Broken Computer Case',           	weight = 100,     type = 'item',      image = 'broken_case.png',         	unique = false,     useable = true,     shouldClose = true,     combinable = nil,   description = ''},
	broken_powersupply 		    = {name = 'broken_powersupply', 		label = 'Broken Power Supply',           	weight = 100,     type = 'item',      image = 'broken_powersupply.png',     unique = false,     useable = true,     shouldClose = true,     combinable = nil,   description = ''},
	broken_cpu 					= {name = 'broken_cpu', 				label = 'Broken CPU',		            	weight = 100,     type = 'item',      image = 'broken_cpu.png',         	unique = false,     useable = true,     shouldClose = true,     combinable = nil,   description = ''},
	broken_cpucooler 			= {name = 'broken_cpucooler', 			label = 'Broken CPU Cooler',            	weight = 100,     type = 'item',      image = 'broken_cpucooler.png',       unique = false,     useable = true,     shouldClose = true,     combinable = nil,   description = ''},
	broken_motherboard 			= {name = 'broken_motherboard', 		label = 'Broken Motherboard',            	weight = 100,     type = 'item',      image = 'broken_motherboard.png',     unique = false,     useable = true,     shouldClose = true,     combinable = nil,   description = ''},
	broken_memory 			    = {name = 'broken_memory', 			    label = 'Broken 8GB Ram Memory',            weight = 100,     type = 'item',      image = 'broken_memory.png',         	unique = false,     useable = true,     shouldClose = true,     combinable = nil,   description = ''},
	broken_graphiccard 			= {name = 'broken_graphiccard', 		label = 'Broken Graphic Card',            	weight = 100,     type = 'item',      image = 'broken_graphiccard.png',     unique = false,     useable = true,     shouldClose = true,     combinable = nil,   description = ''},
	broken_ssd 					= {name = 'broken_ssd', 				label = 'Broken 1TB SSD',            		weight = 100,     type = 'item',      image = 'broken_ssd.png',         	unique = false,     useable = true,     shouldClose = true,     combinable = nil,   description = ''},
	broken_cables 			    = {name = 'broken_cables', 		        label = 'Broken Cables',            		weight = 100,     type = 'item',      image = 'broken_cables.png',         	unique = false,     useable = true,     shouldClose = true,     combinable = nil,   description = ''},
    
  
```

## Insert into @qb-core/shared/jobs.lua 
```
pcrepairs = {
		label = "PC Repairs LTD",
		defaultDuty = false,
		grades = {
			['0'] = { name = "Employee", payment = 0},
			['1'] = { name = "Management", payment = 0},
			['2'] = { name = "Boss", payment = 0, isboss = true},
		},
	},
```

## Insert images into your inventory images folder
