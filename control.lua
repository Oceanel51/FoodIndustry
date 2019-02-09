require("prototypes.scripts.fishing-inserter")
require("prototypes.scripts.food-picker")
require("prototypes.scripts.fruittrees")
require("prototypes.scripts.fruit-scissors")

local foods = {
--name,            energy, fullness,  ?, effect
{"corn", 			10, 	30, 	-20},
{"cucumber", 		8, 		20, 	-20},
{"tomato", 			4, 		10, 	-15},
{"lettuce", 		3, 		8, 		-10},
{"cooked-corn", 	15, 	40, 	-40},
{"corn-bread", 		25, 	65, 	-30},
{"popcorn", 		4, 		9, 		-10},
{"food-capsule", 	50, 	50, 	-200},
{"basic-salad", 	25, 	40, 	-100},
{"cooked-soy", 		2,		5, 		-5},
{"cooked-fish", 	2,		5, 		-5},
{"baked-potato", 	10, 	30, 	-40},
{"fries", 			20, 	55, 	-50},
{"ketchup-fries", 	25, 	70, 	-50},
{"biter-meat", 		15, 	55, 	100},
{"biter-steak", 	30, 	70, 	30},
{"fish-steak", 		30, 	70, 	30},
{"schnitzel", 		35, 	80, 	40},
{"pickles", 		3, 		5, 		-5},
{"tofu", 			25, 	60, 	-15},
{"pizza", 			70, 	95, 	-60},
{"burger", 			75, 	100, 	-60},
{"tofu-pizza", 		65, 	95, 	-80},
{"tofu-burger", 	60, 	100, 	-80},
{"fish-pizza", 		65, 	95, 	-80},
{"fish-burger", 	60, 	100, 	-80},
{"best-salad", 		45, 	70, 	-200},
{"fish-salad", 		45, 	70, 	-200},
{"fish-and-chips", 	75, 	100, 	-200},
{"vegan-food-capsule",50, 	50, 	-80},
{"cooked-biter-meat",20, 	60, 	50},
{"long-reach-capsule",50, 	50, 	0,	"Long reach"},
{"speed-capsule", 	50, 	50, 	0,	"Speed"},
{"regen-capsule", 	50, 	50, 	0,	"Regeneration"},
{"crafting-capsule",50, 	50, 	0,	"Fast crafting"},
{"mining-capsule", 	50, 	50, 	0,	"Fast mining"},
{"invulnerability-capsule",50,50, 	0,	"Invulnerability"},
{"neutralizing-capsule",50, 50, 	0},
{"health-buffer-capsule",50,50, 	0, 	"Health buffer"},
{"apple", 			6, 	20,		-10},
{"orange", 			8, 	25,		-10},
}

local effectcolors = {}
effectcolors["Long reach"] = {r=1,g=0.8,b=0,a=1}
effectcolors["Speed"] = {r=0,g=0.5,b=1,a=1}
effectcolors["Regeneration"] = {r=0,g=1,b=0,a=1}
effectcolors["Fast crafting"] = {r=0.8,g=0.5,b=0,a=1}
effectcolors["Fast mining"] = {r=0.9,g=0,b=0,a=1}
effectcolors["Invulnerability"] = {r=1,g=1,b=0,a=1}
effectcolors["Health buffer"] = {r=1,g=0,b=1,a=1}

-- maximum times for effect duration, val/60=seconds
local maxtimes = {}
maxtimes["Long reach"] = 21600
maxtimes["Speed"] = 5400
maxtimes["Regeneration"] = 1800
maxtimes["Fast crafting"] = 1200
maxtimes["Fast mining"] = 3600
maxtimes["Invulnerability"] = 900
maxtimes["Health buffer"] = 2700

function setupFi()

	if not foodi then foodi = {} end
	if not foodi.ticks then foodi.ticks = {} end
	if not foodi.on_added then foodi.on_added = {} end
	if not foodi.on_remove then foodi.on_remove = {} end
	if not foodi.on_adjust then foodi.on_adjust = {} end
	if not foodi.on_mod_item_opened then foodi.on_mod_item_opened = {} end
	if not foodi.on_selected_entity_changed then foodi.on_selected_entity_changed = {} end
	if not foodi.on_player_selected_area then foodi.on_player_selected_area = {} end
	if not foodi.on_pick_up then foodi.on_pick_up = {} end

	if global ~= nil then
		if not global.foodi then global.foodi = {} end
		if not global.foodi.fishing_inserters then global.foodi.fishing_inserters = {} end
		if not global.players then global.players = {} end
		if not global.foodi.players then global.foodi.players = {} end
	end
end

function OnInit()
	setupFi()
	initFishingInserter()
	initFoodPicker()
	initFruitTrees()
	initFruitScissors()
end

function OnLoad()
	OnInit()
end

script.on_init(OnInit)
script.on_load(OnLoad)

script.on_event({defines.events.on_tick}, function (e)

	for k=1, #foodi.ticks do
		local v = foodi.ticks[k]
		v(e)
	end

	local default_delay = 10000 / settings.global["food-industry-hunger-speed"].value
	if not global.energy_max then -- maximum value of Energy
		global.energy_max = {}
	end
	if not global.energy then
		global.energy = {}
	end
	if not global.fullness then
		global.fullness = {}
	end
	if not global.update_delay then
		global.update_delay = {}
	end
	if not global.used then
		global.used = {}
	end
	if not global.usage then
		global.usage = {}
	end
	if not global.foods then
		global.foods = {}
	end
	if not global.full_time then
		global.full_time = {}
	end
	if not global.effects then
		global.effects = {}
	end
	if e.tick % 5 == 0 then
		for index,player in pairs(game.players) do
			if player.connected then
				if not global.energy_max[index] then
					global.energy_max[index] = 100 -- set initial max Energy for connected players
				end
				if not global.energy[index] then
					global.energy[index] = global.energy_max[index] -- set initial Energy for connected players
				end
				if not global.fullness[index] then
					global.fullness[index] = 0
				end	
				if not global.foods[index] then
					global.foods[index] = {}
					for i,f in pairs(foods) do
						global.foods[index][i] = 0
					end
				end		
				if not global.full_time[index] then
					global.full_time[index] = 0
				end
				if not global.update_delay[index] then
					global.update_delay[index] = 1
				end
				if not global.used[index] then
					global.used[index] = 0
				end
				if not global.usage[index] then
					global.usage[index] = 1
				end	
				if not global.effects[index] then
					global.effects[index] = {}
				end
					
				if global.energy[index] > global.energy_max[index] * 0.9 then -- for achievement "overweight" > 90% of 30 minutes
					global.full_time[index] = global.full_time[index] + 5
					if global.full_time[index] > 108000 then
						player.unlock_achievement("overweight")
					end
				else
					global.full_time[index] = 0
				end
				
				if not player.character then -- for sandbox mode
					global.energy[index] = 50
					global.fullness[index] = 0
					global.used[index] = 0
					global.usage[index] = 0
					for effect,t in pairs(global.effects[index]) do
						global.effects[index][effect] = 0
					end
				else ---- calculate character Energy usage data
					local slots = 0  
					local durability = 0
					if player.walking_state.walking then -- if walking
						if player.get_inventory(defines.inventory.player_armor) and player.get_inventory(defines.inventory.player_armor).valid then
							if player.get_inventory(defines.inventory.player_armor).get_item_count() > 0 and player.get_inventory(defines.inventory.player_armor)[1] and player.get_inventory(defines.inventory.player_armor)[1].valid then
								local armor = player.get_inventory(defines.inventory.player_armor)[1]
								if armor and armor.prototype then
									durability = armor.prototype.durability
								end
							end
						end
						if player.character.grid then
							for x = 0, player.character.grid.width do
								for y = 0, player.character.grid.height do
									if player.character.grid.get({x,y}) then
										slots = slots + 1
									end
								end
							end
						end
						global.usage[index] = 1.5 + settings.global["food-industry-slots"].value * slots + settings.global["food-industry-durability"].value * durability * 0.001 -- calculate usage data
					elseif player.mining_state.mining then -- if mining, if player have mining-tool in player_tools - get it mining speed
						mining_speed = 1.6
						if player.get_inventory(defines.inventory.player_tools) and player.get_inventory(defines.inventory.player_tools).valid then
							if player.get_inventory(defines.inventory.player_tools).get_item_count() > 0 and player.get_inventory(defines.inventory.player_tools)[1] and player.get_inventory(defines.inventory.player_tools)[1].valid then
								local tool = player.get_inventory(defines.inventory.player_tools)[1]
								if tool and tool.prototype then
									mining_speed = tool.prototype.speed
								end
							end
						end
						global.usage[index] = math.ceil((0.125 * mining_speed + 1) / 0.01) / 100
						-- player.print("mining with speed " .. mining_speed)
					elseif player.driving then -- if driving
						global.usage[index] = 0.4
					elseif player.picking_state then -- if picking
						if player.get_inventory(defines.inventory.player_armor) and player.get_inventory(defines.inventory.player_armor).valid then
							if player.get_inventory(defines.inventory.player_armor).get_item_count() > 0 and player.get_inventory(defines.inventory.player_armor)[1] and player.get_inventory(defines.inventory.player_armor)[1].valid then
								local armor = player.get_inventory(defines.inventory.player_armor)[1]
								if armor and armor.prototype then
									durability = armor.prototype.durability
								end
							end
						end
						if player.character.grid then
							for x = 0, player.character.grid.width do
								for y = 0, player.character.grid.height do
									if player.character.grid.get({x,y}) then
										slots = slots + 1
									end
								end
							end
						end
						global.usage[index] = 1.4 + settings.global["food-industry-slots"].value * slots + settings.global["food-industry-durability"].value * durability * 0.001
						-- player.print("picking...")
					elseif player.repair_state.repairing then -- if repairing
						if player.get_inventory(defines.inventory.player_armor) and player.get_inventory(defines.inventory.player_armor).valid then
							if player.get_inventory(defines.inventory.player_armor).get_item_count() > 0 and player.get_inventory(defines.inventory.player_armor)[1] and player.get_inventory(defines.inventory.player_armor)[1].valid then
								local armor = player.get_inventory(defines.inventory.player_armor)[1]
								if armor and armor.prototype then
									durability = armor.prototype.durability
								end
							end
						end
						if player.character.grid then
							for x = 0, player.character.grid.width do
								for y = 0, player.character.grid.height do
									if player.character.grid.get({x,y}) then
										slots = slots + 1
									end
								end
							end
						end
						global.usage[index] = 1.6 + settings.global["food-industry-slots"].value * slots + settings.global["food-industry-durability"].value * durability * 0.001
						-- player.print("repairing...")
					else
						global.usage[index] = 1
					end
					
					-------------------- used energy calculation --------------------
					global.used[index] = global.used[index] + global.usage[index]
					
					if global.used[index] >= (default_delay * global.update_delay[index]) then
						global.used[index] = global.used[index] - (default_delay * global.update_delay[index])
						if global.energy[index] > -50 then
							global.energy[index] = global.energy[index] - 1
						end
  					
						if global.energy[index] < global.energy_max[index] * 0.25 then -- if Energy level down below 25% - decrease running speed
							player.character_running_speed_modifier = (global.energy[index] - (global.energy_max[index] * 0.2))/global.energy_max[index]
						else
							player.character_running_speed_modifier = 0
						end
						if global.effects[index]["Speed"] and global.effects[index]["Speed"] > 0 then
							player.character_running_speed_modifier = (player.character_running_speed_modifier+1)*1.75-1
						end
  					
						u_gui()
					end
						
					---------------------- fullness calculation ---------------------
					if global.fullness[index] > 0 then
						global.fullness[index] = global.fullness[index] - (settings.global["food-industry-hunger-speed"].value / 400)
					end
				  
					if global.fullness[index] < 0 then
						global.fullness[index] = 0	
					end
					
					if e.tick % 30 == 0 and global.energy[index] < 0 then
						player.character.health = player.character.health -5.75 + global.energy[index]/10
						if player.character.health <= 0 then
							player.character.health = 1 
							player.character.damage(900000,"neutral")
							return
						end
					end	
					
					--------------------- effects assignment ------------------------
					for effect,t in pairs(global.effects[index]) do
						if t > 0 and player.character then
							global.effects[index][effect] = t - 5
							if effect == "Long reach" then
								player.character_build_distance_bonus = 100
								player.character_item_drop_distance_bonus = 20
								player.character_reach_distance_bonus = 120
							elseif effect == "Regeneration" then
								player.character.health = player.character.health + 5
							elseif effect == "Fast crafting" then
								player.character_crafting_speed_modifier = 50
							elseif effect == "Fast mining" then
								player.character_mining_speed_modifier = 20
							elseif effect == "Health buffer" then
								if global.effects[index]["Invulnerability"] and global.effects[index]["Invulnerability"] > 0 then
									player.character_health_bonus = 9750
								else
									player.character_health_bonus = 1250
								end
							end
						elseif t == 0 and player.character then
							global.effects[index][effect] = -1
							if effect == "Long reach" then
								player.character_build_distance_bonus = 0
								player.character_item_drop_distance_bonus = 0
								player.character_reach_distance_bonus = 0
							elseif effect == "Fast crafting" then
								player.character_crafting_speed_modifier = 0
							elseif effect == "Fast mining" then
								player.character_mining_speed_modifier = 0
							elseif effect == "Invulnerability" then
								if global.effects[index]["Health buffer"] and global.effects[index]["Health buffer"] > 0 then
									player.character_health_bonus = 1250
								else
									player.character_health_bonus = 0
								end
							elseif effect == "Health buffer" then
								if global.effects[index]["Invulnerability"] and global.effects[index]["Invulnerability"] > 0 then
									player.character_health_bonus = 9750
								else
									player.character_health_bonus = 0
								end
							elseif effect == "Speed" then
								if global.energy[index] < global.energy_max[index] * 0.25 then -- if Energy level down below 25% - decrease running speed
									player.character_running_speed_modifier = (global.energy[index] - (global.energy_max[index] * 0.2))/global.energy_max[index]
								else
									player.character_running_speed_modifier = 0
								end
								if global.effects[index]["Speed"] and global.effects[index]["Speed"] > 0 then
									player.character_running_speed_modifier = (player.character_running_speed_modifier+1)*1.75-1
								end
							end
						end
					end
					
					u_gui()
				end
			end
		end
	end
	
	if global.effects then
		for index,player in pairs(game.players) do
			if player.connected and player.character and global.effects[index] then
				if global.effects[index]["Invulnerability"] and global.effects[index]["Invulnerability"] > 0 then
					player.character.health = 10000
					player.character_health_bonus = 9750
				end 
			end
		end
	end
	
	if settings.global["food-industry-remove-meat"].value then
		if e.tick % 600 == 0 then
			for i,surface in pairs(game.surfaces) do
				local meats = surface.find_entities_filtered{name = "item-on-ground", force = "neutral"}
				for j,meat in pairs(meats) do
					if j % 7 == e.tick % 7 and meat.stack.name == "biter-meat" and meat.to_be_looted then
						if surface.count_entities_filtered{area = {{meat.position["x"] - 1, meat.position["y"] - 1}, {meat.position["x"] + 1, meat.position["y"] + 1}}, type = "corpse", force = "neutral"} == 0 then 
							meat.destroy()
						end
					end
				end
			end
		end
	end
end)
local local_on_added = function(event)
	local entity = event.created_entity
	if entity ~= nil then
		for k=1, #foodi.on_added do
			local v = foodi.on_added[k]
			v(entity, event)
		end
	end
end
local local_on_removed = function(event)
	local entity = event.entity
	if entity ~= nil then
		for k=1, #foodi.on_remove do
			local v = foodi.on_remove[k]
			v(entity, event)
		end
	end
end

script.on_event(defines.events.on_built_entity,
    function(event)
	    local_on_added(event)

--	    local entity = event.created_entity
--		if (entity.name == "fi-basic-farmland") and entity.burner and entity.burner.remaining_burning_fuel then
--			event.created_entity.burner.currently_burning="wood"
--			event.created_entity.burner.remaining_burning_fuel=2000000
--		end
	end
)


-- when new Player is created/joined
script.on_event(defines.events.on_player_created, function(event)
	local player = game.players[event.player_index]
	player.insert({name="vegan-food-capsule", count=20})
	player.insert({name="crafting-capsule", count=2})
	player.insert({name="speed-capsule", count=2})
	player.insert({name="mining-capsule", count=2})
end
)


script.on_event(defines.events.on_player_used_capsule, function(event)
	if event.item.name == "raw-fish" then
		local player = game.players[event.player_index]
		player.insert{name = "raw-fish", count = 1}
		player.print({'print.dont-eat-fish'})
		return
	end	
	if event.item.name == "neutralizing-capsule" then
		for effect,t in pairs(global.effects[event.player_index]) do
			global.effects[event.player_index][effect] = 0
		end
	end
	for i,food in pairs(foods) do
		if not global.foods[event.player_index][i] then
			global.foods[event.player_index][i] = 0
		end
		if event.item.name == food[1] then
			if global.fullness[event.player_index] + food[3] > 100 then
				local player = game.players[event.player_index]
				player.insert{name = food[1], count = 1}
				player.print({'print.too-full'})
			else
				local player = game.players[event.player_index]
				global.energy[event.player_index] = global.energy[event.player_index] + food[2]
				global.fullness[event.player_index] = global.fullness[event.player_index] + food[3]
				global.foods[event.player_index][i] = global.foods[event.player_index][i] + 1
				
				if(game.players[event.player_index].character) then
					game.players[event.player_index].character.health = game.players[event.player_index].character.health - food[4]
					if game.players[event.player_index].character.health <= 0 then
						game.players[event.player_index].character.health = 1 
						game.players[event.player_index].character.damage(900000,"neutral")
						return
					end
				end
				
				if global.energy[event.player_index] > global.energy_max[event.player_index] then
					global.energy[event.player_index] = global.energy_max[event.player_index]
				end
				
				if food[5] then
					global.effects[event.player_index][food[5]] = maxtimes[food[5]]
				end
				
				if global.energy[event.player_index] < global.energy_max[event.player_index] * 0.25 then
					game.players[event.player_index].character_running_speed_modifier = math.max((global.energy[event.player_index] - (global.energy_max[event.player_index] * 0.2))/global.energy_max[event.player_index],-0.99)
				else
					game.players[event.player_index].character_running_speed_modifier = 0
				end
				if global.effects[event.player_index]["Speed"] and global.effects[event.player_index]["Speed"] > 0 then
					game.players[event.player_index].character_running_speed_modifier = (game.players[event.player_index].character_running_speed_modifier+1)*1.75-1
				end
				
				-- update GUI
				u_gui()
				
				if string.find(food[1], "food") == 1 or string.find(food[1], "food") == 7 then
					player.play_sound({path = "use-food-capsule-sound",volume_modifier = 0.7}) -- play sound when eat food-capsule
				end

				for j,k in pairs(global.foods[event.player_index]) do
					if j > #foods then
						break
					end
					if k < 3 then
						return
					end
					
				end
				
				game.players[event.player_index].unlock_achievement("gourmet")
				
			end
			return
		end
	end
end
)


script.on_event(defines.events.on_research_finished, function(event)
	if event.research.name == "food-energy-efficiency-1" then
		local force = event.research.force
		for index,player in pairs(game.players) do
			if player.force == force then
				global.update_delay[index] = 1.1
				u_gui()
			end
		end
	elseif event.research.name == "food-energy-efficiency-2" then
		local force = event.research.force
		for index,player in pairs(game.players) do
			if player.force == force then
				global.update_delay[index] = 1.2
				u_gui()
			end
		end
	elseif event.research.name == "food-energy-efficiency-3" then
		local force = event.research.force
		for index,player in pairs(game.players) do
			if player.force == force then
				global.update_delay[index] = 1.3
				u_gui()
			end
		end
	elseif event.research.name == "food-energy-efficiency-4" then
		local force = event.research.force
		for index,player in pairs(game.players) do
			if player.force == force then
				global.update_delay[index] = 1.4
				u_gui()
			end
		end
	elseif event.research.name == "food-energy-efficiency-5" then
		local force = event.research.force
		for index,player in pairs(game.players) do
			if player.force == force then
				global.update_delay[index] = 1.5
				u_gui()
			end
		end
	elseif event.research.name == "food-energy-efficiency-6" then
		local force = event.research.force
		for index,player in pairs(game.players) do
			if player.force == force then
				global.update_delay[index] = 1.6
				u_gui()
			end
		end
	elseif event.research.name == "food-energy-efficiency-7" then
		local force = event.research.force
		for index,player in pairs(game.players) do
			if player.force == force then
				global.update_delay[index] = 1.7
				u_gui()
			end
		end
	elseif event.research.name == "food-energy-efficiency-8" then
		local force = event.research.force
		for index,player in pairs(game.players) do
			if player.force == force then
				global.update_delay[index] = 1.8
				u_gui()
			end
		end
	elseif event.research.name == "food-energy-efficiency-9" then
		local force = event.research.force
		for index,player in pairs(game.players) do
			if player.force == force then
				global.update_delay[index] = 1.9
				u_gui()
			end
		end
	elseif event.research.name == "food-energy-efficiency-10" then
		local force = event.research.force
		for index,player in pairs(game.players) do
			if player.force == force then
				global.update_delay[index] = 2
				u_gui()
			end
		end
	elseif event.research.name == "food-energy-efficiency-11" then
		local force = event.research.force
		for index,player in pairs(game.players) do
			if player.force == force then
				global.update_delay[index] = 0.9 + event.research.level * 0.1
				if event.research.level > 50 then
					player.unlock_achievement("hibernation")
				end
				u_gui()
			end
		end
	end
	--------------- if tech "fi-tech-more-energy" researched
	local force = event.research.force
	if event.research.name == "fi-tech-more-energy-1" then
		for index,player in pairs(game.players) do
			if player.valid and player.connected and player.character then
				if player.force == force then
					local leftGui = player.gui.left
					if leftGui and leftGui.valid then
						global.energy_max[index] = 150
						player.print({'print.fi-tech-more-energy', "150"})
						leftGui.frame.flow1.energylabel.tooltip = {'label.energylabel-tooltip', global.energy_max[index]}
					end
				end
			end
		end
	elseif event.research.name == "fi-tech-more-energy-2" then
		for index,player in pairs(game.players) do
			if player.valid and player.connected and player.character then
				if player.force == force then
					local leftGui = player.gui.left
					if leftGui and leftGui.valid then
						global.energy_max[index] = 200
						player.print({'print.fi-tech-more-energy', "200"})
						leftGui.frame.flow1.energylabel.tooltip = {'label.energylabel-tooltip', global.energy_max[index]}
					end
				end
			end
		end
	elseif event.research.name == "fi-tech-more-energy-3" then
		for index,player in pairs(game.players) do
			if player.valid and player.connected and player.character then
				if player.force == force then
					local leftGui = player.gui.left
					if leftGui and leftGui.valid then
						global.energy_max[index] = 300
						player.print({'print.fi-tech-more-energy', "300"})
						leftGui.frame.flow1.energylabel.tooltip = {'label.energylabel-tooltip', global.energy_max[index]}
					end
				end
			end
		end
	elseif event.research.name == "fi-tech-more-energy-4" then
		for index,player in pairs(game.players) do
			if player.valid and player.connected and player.character then
				if player.force == force then
					local leftGui = player.gui.left
					if leftGui and leftGui.valid then
						global.energy_max[index] = 400
						player.print({'print.fi-tech-more-energy', "400"})
						leftGui.frame.flow1.energylabel.tooltip = {'label.energylabel-tooltip', global.energy_max[index]}
					end
				end
			end
		end
	elseif event.research.name == "fi-tech-more-energy-5" then
		for index,player in pairs(game.players) do
			if player.valid and player.connected and player.character then
				if player.force == force then
					local leftGui = player.gui.left
					if leftGui and leftGui.valid then
						global.energy_max[index] = 500
						player.print({'print.fi-tech-more-energy', "500"})
						leftGui.frame.flow1.energylabel.tooltip = {'label.energylabel-tooltip', global.energy_max[index]}
					end
				end
			end
		end
	end
	
end
)


script.on_event(defines.events.on_rocket_launched, function(event)
		if event.rocket.get_item_count("satellite") > 0 then
			for index,player in pairs(game.players) do
				if player.force == event.rocket.force then
					if not global.foods[index] then
						return
					end
					
					local total = 0
					for j,k in pairs(global.foods[index]) do
						total = total + k
					end
					if global.foods[index][14] + global.foods[index][15] + global.foods[index][16] + global.foods[index][25] == total then
						player.unlock_achievement("carnivore")
					end
					if global.foods[index][14] + global.foods[index][15] + global.foods[index][16] + global.foods[index][19] + global.foods[index][20] + global.foods[index][8] + global.foods[index][25] == 0 then
						player.unlock_achievement("vegan")
					end
					
				end
			end
		end
	end
)


function u_gui()
	if global.energy and global.fullness then
		for index, player in pairs(game.players) do
			if global.energy[index] and global.fullness[index] then -- if exists values in global.energy table
				if player.valid and player.connected then
					local leftGui = player.gui.left
					
					if leftGui.bar then
						leftGui.bar.destroy()
					end
					

					-- initialize main .frame
					if not leftGui.frame then
						leftGui.add{type = "frame", name = "frame", direction = "vertical"}
					end
					
					
					-- initialize labels and bars of .flow1
					if not leftGui.frame.flow1 then
						leftGui.frame.add{type = "flow", name = "flow1", right_padding = 0, left_padding = 0, direction = "horizontal"}
					end
					if not leftGui.frame.flow1.energylabel then
						-- "Energy: " .. energylabel .. " (usage: ".. ussagelabel .."%)"
						leftGui.frame.flow1.add({type="label", name="label_energy", caption={'label.label-energy', ": "}, style = "fi-label", align="right",})
						leftGui.frame.flow1.add({type="label", name="energylabel", caption="", tooltip = {'label.energylabel-tooltip', global.energy_max[index]},})
						leftGui.frame.flow1.add({type="label", name="label_usage", caption={'label.label-usage', " (", ": "}, style = "fi-label",})
						leftGui.frame.flow1.add({type="label", name="usagelabel", caption="", style = "fi-label",})
						leftGui.frame.flow1.add({type="label", name="label_percent", caption="%)", style = "fi-label",})
					end
					if not leftGui.frame.energybar then
						leftGui.frame.add({type="progressbar", name="energybar"})
						leftGui.frame.energybar.style.width = 200
					end	
						
					-- initialize labels and bars of .flow2
					if not leftGui.frame.flow2 then
						leftGui.frame.add{type = "flow", name = "flow2", direction = "horizontal"}
					end
					if not leftGui.frame.flow2.fullnesslabel then
						--"Fullness: " .. fullnessbar .."%"
						leftGui.frame.flow2.add({type="label", name="label_fullness", caption={'label.label-fullness', ": "},})
						leftGui.frame.flow2.add({type="label", name="fullnesslabel", caption=""})
						leftGui.frame.flow2.add({type="label", name="label_percent", caption="%",})
					end
					if not leftGui.frame.fullnessbar then
						leftGui.frame.add({type="progressbar", name="fullnessbar"})
						leftGui.frame.fullnessbar.style.width = 200
						leftGui.frame.fullnessbar.style.color = {r = 1, g = 0.6, a = 1}
					end

				-- .flow 3,4,5 rezerved for "Balance of Substances"
				
				-- initialize labels and bars of .flow6

					if pcall(function () leftGui.frame.flow1.usagelabel.caption = (math.floor((100 * settings.global["food-industry-hunger-speed"].value * global.usage[index] / global.update_delay[index]) + 0.5) * 0.01) end) then
						leftGui.frame.flow1.energylabel.caption = global.energy[index]
						leftGui.frame.flow1.usagelabel.caption = (math.floor((100 * settings.global["food-industry-hunger-speed"].value * global.usage[index] / global.update_delay[index]) + 0.5) * 0.01)
					else
						leftGui.frame.flow1.energylabel.caption = global.energy[index]
						leftGui.frame.flow1.usagelabel.caption = "---"
					end
					
					leftGui.frame.energybar.value = math.abs(global.energy[index]/global.energy_max[index])
					
					leftGui.frame.flow2.fullnesslabel.caption = math.ceil(global.fullness[index])
					leftGui.frame.fullnessbar.value = global.fullness[index]/100			
					
					-- .flow8 for Starving
					if global.energy[index] < 0 then
						if not leftGui.frame.flow8 then
							leftGui.frame.add{ type = "flow", name = "flow8", align = "left", direction = "horizontal"}
						end
						if not (leftGui.frame.flow8.starvinglabel and leftGui.frame.starvingbar) then
							-- "Starving: -" ..  .."HP/s (< " ..  .. " to death)"
							leftGui.frame.flow8.add({type="label", name="label_starving", caption={'label.label-starving', ": "}, style = "fi-label", align="left",})
							leftGui.frame.flow8.add({type="label", name="starvinglabel", caption=""})
							leftGui.frame.flow8.add({type="label", name="label_starving1", caption={'label.label-hppersec', " (<"}, style = "fi-label", align="right",})
							leftGui.frame.flow8.add({type="label", name="starvingtimelabel", caption=""})
							leftGui.frame.flow8.add({type="label", name="label_todeath", caption={'label.label-to-death', ")"}, style = "fi-label", align="right",})
							
							leftGui.frame.add({type="progressbar", name="starvingbar"})
							leftGui.frame.starvingbar.style.width = 200
							leftGui.frame.starvingbar.style.color = {r = 1, a = 1}
						end
						leftGui.frame.starvingbar.value = (2.5 - global.energy[index]/5)/12.5
						if player.character then
							leftGui.frame.flow8.starvinglabel.caption = (math.floor(global.energy_max[index] * 0.25 - global.energy[index]/0.5)/10)
							leftGui.frame.flow8.starvingtimelabel.caption = getTime(player.character.health*60/(2.5 - global.energy[index]/5))
						end
						
					elseif leftGui.frame.starvingbar and leftGui.frame.flow8.starvinglabel then
						leftGui.frame.flow8.destroy()
						leftGui.frame.starvingbar.destroy()
					end
					
					-- .flow7 for Hunger slowness
					if not leftGui.frame.flow7 then
						leftGui.frame.add{ type = "flow", name = "flow7", align = "left", direction = "horizontal"}
					end
					if global.energy[index] < global.energy_max[index] * 0.25 then -- add hunger slowness when Energy level below 25%
						if not (leftGui.frame.flow7.hungerspeedlabel and leftGui.frame.hungerspeedbar) then
							--"Hunger slowness: " ..  .."%"
							leftGui.frame.flow7.add({type="label", name="label_hungerspeed", caption={'label.label-hunger-slowness', ": "}, style = "fi-label", align="left",})
							leftGui.frame.flow7.add({type="label", name="hungerspeedlabel", caption=""})
							leftGui.frame.flow7.add({type="label", name="label_hungerspeed_percent", caption="%", style = "fi-label", align="right",})
							leftGui.frame.add({type="progressbar", name="hungerspeedbar"})
							leftGui.frame.hungerspeedbar.style.width = 200
							leftGui.frame.hungerspeedbar.style.color = {r = 0.7, g = 0.7, b = 0.9, a = 1}
						end
						leftGui.frame.hungerspeedbar.value = -(global.energy[index] - global.energy_max[index] * 0.25)/global.energy_max[index]
						if player.character then
							leftGui.frame.flow7.hungerspeedlabel.caption = math.max(global.energy[index] - global.energy_max[index] * 0.25,-99)
						end
						
					elseif leftGui.frame.hungerspeedbar and leftGui.frame.flow7.hungerspeedlabel then
						leftGui.frame.flow7.destroy()
						leftGui.frame.hungerspeedbar.destroy()
					end
					
					-- rezerved .flow8 for buttons how activate "capsule effects"
					
					-- initialize .flow10 - Effects
					--if not leftGui.frame.flow10 then
					--	leftGui.frame.add{ type = "flow", name = "flow10", direction = "vertical" }
					--end
					if global.effects[index] then
						for effect,t in pairs(global.effects[index]) do
							if t > 0 then
								if not (leftGui.frame[effect.."label"] and leftGui.frame[effect.."bar"] ) then
									leftGui.frame.add({type="label", name=effect.."label", caption=""})				
									leftGui.frame.add({type="progressbar", name=effect.."bar"})
									leftGui.frame[effect.."bar"].style.width = 200
									leftGui.frame[effect.."bar"].style.color = effectcolors[effect]
								end
								leftGui.frame[effect.."bar"].value = t/maxtimes[effect]
								if player.character then
									leftGui.frame[effect.."label"].caption = effect..": " .. getTime(t)
								end
								
							elseif leftGui.frame[effect.."bar"] and leftGui.frame[effect.."label"] then
								leftGui.frame[effect.."label"].destroy()
								leftGui.frame[effect.."bar"].destroy()
							end
						end
					end
					
					-- ------------------
					
					if global.energy[index] >= global.energy_max[index] * 1 then -- >=100%
						leftGui.frame.energybar.style.color = {g = 1, a = 1}
					elseif global.energy[index] >= global.energy_max[index] * 0.25 then -- >=20%
						leftGui.frame.energybar.style.color = {r = 1, g = 1, a = 1}
					elseif global.energy[index] >= 0 then
						leftGui.frame.energybar.style.color = {r = 1, g = 0.6, a = 1}
					else 
						leftGui.frame.energybar.style.color = {r = 1, a = 1}
					end
					if settings.get_player_settings(player)["food-industry-bottom"].value then
						leftGui.style.top_padding = player.display_resolution.height - 200 - settings.get_player_settings(player)["food-industry-padding"].value
					else
						leftGui.style.top_padding = 0
					end
				end
			end
		end
	end
end


function getTime(ticks)
	if  math.floor((ticks/60)%60) >=10 then
		return math.floor(ticks/3600) .. ":" .. math.floor((ticks/60)%60)
	else
		return math.floor(ticks/3600) .. ":0" .. math.floor((ticks/60)%60)
	end
end

local mod_item_opened = function(event)
	for k=1, #foodi.on_mod_item_opened do
		local v = foodi.on_mod_item_opened[k]
		v(event)
	end
end

local player_selected_area = function(event)
	for k=1, #foodi.on_player_selected_area do
		local v = foodi.on_player_selected_area[k]
		v(event)
	end
end

local selected_entity_changed = function(event)
	for k=1, #foodi.on_selected_entity_changed do
		local v = foodi.on_selected_entity_changed[k]
		v(event)
	end
end

local remove_events = {defines.events.on_entity_died,defines.events.on_robot_pre_mined,defines.events.on_robot_mined_entity,defines.events.on_pre_player_mined_entity,defines.events.on_player_mined_entity}

script.on_event(defines.events.on_robot_built_entity, local_on_added)
script.on_event(remove_events, local_on_removed)
script.on_event(defines.events.on_mod_item_opened, mod_item_opened)
script.on_event(defines.events.on_player_selected_area, player_selected_area)
script.on_event(defines.events.on_selected_entity_changed, selected_entity_changed)

