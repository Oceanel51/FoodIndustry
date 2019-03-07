require "prototypes.functions.fi-GUI"
require "prototypes.tables.fi-foods-table"
require "prototypes.functions.fi-global-variables"
require "prototypes.functions.fi-calculations"
--require "prototypes.functions.fi-modifiers"
require "libs.helper-functions"

require("prototypes.scripts.fishing-inserter")
require("prototypes.fish.fishing-boat-control")
require("prototypes.fish.shovel-control")

require("prototypes.scripts.food-picker")
require("prototypes.scripts.fruittrees")
require("prototypes.scripts.fruit-scissors")
require("prototypes.scripts.cattle")
require("prototypes.scripts.cattle-grabber")

require("prototypes.drinks.get-drink")


script.on_init(OnInit)
script.on_load(OnLoad)
--script.on_configuration_changed(OnLoad)


--local foods = foods_table()
local foods = collect_all_foods_table()


-- TODO перенести в effects function
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
	if not foodi.on_changedPosition then foodi.on_changedPosition = {} end

	if not foodi.on_pick_up then foodi.on_pick_up = {} end

	if global ~= nil then
		if not global.foodi then global.foodi = {} end
		if not global.players then global.players = {} end
		if not global.foodi.players then global.foodi.players = {} end
	end
end


function OnInit()
	setupFi()
	
	initFishingInserter()
	initFishingBoatNet()
	initFoodPicker()
	initFruitTrees()
	initFruitScissors()
	initCattle()
	initCattleGrabber()
	initGetDrink()
	initShovel()

	for index,player in pairs(game.players) do
		if player.connected then
			fi_global_variables_init()
			fi_global_variables_set(index) -- set global variables default data of connected players
			if settings.global["food-industry-calculate"].value then
				figui.create(index, player)
			else
				local leftGui = player.gui.left
				if not leftGui then
					if not leftGui.frame then
						leftGui.frame.destroy()
					end
				end
			end
		end
	end
end
function OnLoad()
	OnInit()
end



script.on_event({defines.events.on_tick}, function (e)
	OnInit() -- TODO Why do you need to perform this function every tick?
	for k=1, #foodi.ticks do
		local v = foodi.ticks[k]
		v(e)
	end

	-- TODO добавить сюда sleep modifier, это основной блок по которому считаются все расходы
	if e.tick % 5 == 0 and settings.global["food-industry-calculate"].value then
		for index,player in pairs(game.players) do
			if player.connected then
				
				fi_global_variables_set(index) -- set global variables default data of connected players
				-----------------------------------------------------
				
				if not player.character then -- for sandbox mode
					global.energy_max[index] = 100
					global.energy[index] = 50
					global.drinks_max[index] = 100
					global.drinks[index] = 0
					global.foods_eaten[index] = {}
					global.fullness[index] = 0
					global.used[index] = 0
					global.usage[index] = 0
					global.substances[index] = {v=0,m=0,c=0,f=0}
					for effect,t in pairs(global.effects[index]) do
						global.effects[index][effect] = 0
					end
					if player.gui.left.frame.flow1.usagelabel then
						player.gui.left.frame.flow1.energylabel.caption = global.energy[index]
						player.gui.left.frame.energybar.value = global.energy[index]/100
						player.gui.left.frame.flow1.usagelabel.caption = "---"
						player.gui.left.frame.flow22.drinkslabel.caption = "0"
					end

				else ---- calculate character Energy usage data
					--figui.create(index, player)
					
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
						--if player.get_inventory(defines.inventory.player_tools) and player.get_inventory(defines.inventory.player_tools).valid then
						--	if player.get_inventory(defines.inventory.player_tools).get_item_count() > 0 and player.get_inventory(defines.inventory.player_tools)[1] and player.get_inventory(defines.inventory.player_tools)[1].valid then
						--		local tool = player.get_inventory(defines.inventory.player_tools)[1]
						--		if tool and tool.prototype then
						--			mining_speed = tool.prototype.speed
						--		end
						--	end
						--end
						--global.usage[index] = math.ceil((0.125 * mining_speed + 1) / 0.01) / 100
						global.usage[index] = math.ceil(mining_speed)
						-- player.print("mining with speed " .. mining_speed)
					--elseif player.riding_state.riding.acceleration then ---- if riding
					elseif player.driving then -- if driving
						global.usage[index] = 0.4
						--player.print("driving...")
					-- TODO make shooting_state
					--@ https://lua-api.factorio.com/latest/LuaControl.html#LuaControl.shooting_state
					--elseif player.shooting_state.state and player.shooting_state.state(defines.shooting.shooting_selected).valid then ---- if shooting selected
					--elseif player.shooting_state.state and player.shooting_state.state(defines.shooting.shooting_enemies).valid then ---- if shooting enemies
						--defines.shooting.not_shooting	
						--player.print("shooting enemy...")
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
					elseif  player.crafting_queue_size > 0 then -- if manual crafting
						-- также увеличивается дополнительно в зависимости от количества предметов в очереди крафта, не сильно +0.05% за единицу
						local crafting_counts = 0
						--writeDebug(dump(player.crafting_queue))
						--writeDebug(serpent.block(player.crafting_queue))
						--writeDebug("======================")
						for craft_index,craft_item in pairs(player.crafting_queue) do
							crafting_counts = crafting_counts + ( craft_item["count"] * 0.05 )
						end
						global.usage[index] = 1.5 + crafting_counts
						-- TODO в идеале извлечь время текущего рецепта и от него вычислять расход Энергии
						--writeDebug(data.raw.recipe[player.crafting_queue[1].recipe].energy_required)
						--global.usage[index] = 1.5 + ( data.raw.recipe[player.crafting_queue[1].recipe].energy_required / 10 )
						--player.print("manual crafting "..player.crafting_queue_size.." items")
					else
						global.usage[index] = 1
					end
					
					---------------------- fullness calculation ---------------------
					fullness_calc_on_tick(index)
					figui.update(index, player)

					------------------------- sleep marking -------------------------
					if e.tick % 1200 == 0 then
						sleep_trg_on_tick(index, player) -- start or stop Sleep
						sleep_calc_on_tick(index, player)
					end
					
					-------------------- used energy calculation --------------------
					energy_reduction(index, player)
					drinks_reduction(index, player)
					
					---------------------- starving calculation ---------------------
					if e.tick % 30 == 0 and global.energy[index] < 0 then
						player.character.health = player.character.health -5.75 + global.energy[index]/10
						if player.character.health <= 0 then
							player.character.health = 1
							player.character.damage(900000,"neutral")
							return
						end
					end
					
					---------------------- thirst calculation -----------------------
					thirst_reduction(index,5)
					
					------------------------ fat calculation ------------------------
					if global.fi_character_fat_modifier and global.fi_character_fat_modifier[index] then
						-- DEBUG потестировать сколько нужно для уменьшения Fat effect
						if e.tick % 120 == 0 then
							local reduce_value = 1 * global.usage[index]
							fat_modifier_reduction(index,reduce_value)
						end
					end
					
					----------------------- substances update -----------------------
					figui.update_substances(index, player)
					-- DEBUG увеличить расход Substances до -1 в 40 сек.
					if e.tick % ( 60 * settings.global["food-industry-substances-update"].value ) == 0 then
						substances_reduction(index)
					end
					
					--------------------- effects calculation -----------------------
					if e.tick % 60 == 0 then
						effects_time_reduction(index)
						--effects_remove(index)
					end
					if e.tick % ( 60 * settings.global["food-industry-effects-update"].value ) == 0 then
						effects_calc_on_tick(index, player)
						--writeDebug(dump(global.effects[index]))
						figui.update_effects(index, player)
					end
					
					
					u_gui()

					-- for achievement "overweight" > 90% for 30 minutes
					if global.energy[index] > global.energy_max[index] * 0.9 then
						global.fi_achievements[index]["overweight"][3] = global.fi_achievements[index]["overweight"][3] + 5
						if global.fi_achievements[index]["overweight"][3] > 108000 then
							player.unlock_achievement("overweight")
							global.fi_achievements[index]["overweight"][1] = true
						end
					else
						global.fi_achievements[index]["overweight"][3] = 0
					end
					
				end
			end
		end
	end
	
	-- TODO move to effects_add(...)/effects_remove(...)
	---if global.effects then
	---	for index,player in pairs(game.players) do
	---		if player.connected and player.character and global.effects[index] then
	---			if global.effects[index]["Invulnerability"] and global.effects[index]["Invulnerability"] > 0 then
	---				player.character.health = 10000
	---				player.character_health_bonus = 9750
	---			end 
	---		end
	---	end
	---end
	
	-- remove meat from surfaces
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

script.on_event(defines.events.on_built_entity, function(event)
	local_on_added(event)
	
	-- TODO Fix this! removed this as it seems to be buggy
	local entity = event.created_entity
	if (entity.name == "fi-basic-farmland") and entity.burner and entity.burner.remaining_burning_fuel then 
		event.created_entity.burner.currently_burning="wood"
		event.created_entity.burner.remaining_burning_fuel=2000000
	end
end
)


-- when new Player is created/joined
script.on_event(defines.events.on_player_created, function(event)
	local player = game.players[event.player_index]
	
	player.insert({name="food-1-capsule", count=1})
	player.insert({name="simple-digestive-capsule", count=3})
	player.insert({name="simple-speed-capsule", count=3})
	player.insert({name="simple-crafting-capsule", count=3})
	player.insert({name="simple-mining-capsule", count=3})
	player.insert({name="flask-pure-water", count=4})
	
	-- DEBUG remove this
	--player.insert({name="basic-digestive-capsule", count=5})
	--player.insert({name="lettuce", count=10})
	--player.insert({name="tomato", count=10})
	--player.insert({name="corn", count=10})
	--player.insert({name="popcorn", count=10})
	--player.insert({name="plastic-bottle-pure-water", count=10})
	--player.insert({name="basic-speed-capsule", count=5})
	--player.insert({name="advanced-speed-capsule", count=5})
	--player.insert({name="simple-long-reach-capsule", count=5})
	--player.insert({name="basic-long-reach-capsule", count=5})
end
)


script.on_event(defines.events.on_player_used_capsule, function(event)
	-- some warnings of using food
	local player = game.players[event.player_index]
	if event.item.name == "raw-fish" then
		player.insert{name = "raw-fish", count = 1}
		--player.print("There are bones in this, you don't want to eat this.")
		player.print({'print.dont-eat-raw-fish'})
		return
	elseif event.item.name == "fi-raw-sturgeon" then
		player.insert{name = "fi-raw-sturgeon", count = 1}
		player.print({'print.dont-eat-raw-fish'})
		return
	end
	
	
	-- check how food is used
	for i,food in pairs(foods) do
		if not global.foods[event.player_index][i] then
			global.foods[event.player_index][i] = 0
		end
		if event.item.name == food[1] then
			
			local player = game.players[event.player_index]
			--if player.connected and player.character and global.effects[event.player_index] then
				if global.fullness[event.player_index] and global.fullness[event.player_index] > 180 then
				-- TODO потеря сознания персонажа выше Fullness 181 единниц
				--if global.fullness[event.player_index] + food[3] > 100 then
					player.insert{name = food[1], count = 1}
					--player.print("You are too full to eat this.")
					player.print({'print.too-full'})
				else
					local player = game.players[event.player_index]
					local food_item = event.item
					
					-- [Debug]
					--player.print(dump(food))
					--player.print(dump(food_item.type))
					--player.print(print_table(food))
					--player.print(print_table(food_item))
					--player.print("[Debug] Eaten food - "..tostring(food[4]))

					local food_copy = table.deepcopy(food)
					eat_food(player, event.player_index, food_copy, food_item)
					
					-- add effect to global.effects
					if food_copy[9] and food_copy[9][1] then
						--writeDebug(dump(food_copy[9]))
						-- TODO обрабатываем каждый эфект отдельно
						for _,ef in pairs(food_copy[9]) do
							effects_add(event.player_index, food_copy[1], ef)
						end
						--writeDebug(dump(global.effects[event.player_index]["digestion"]))
						effects_calc_on_tick(event.player_index, player)
					end

					-- количество единиц еды в сумме
					global.foods[event.player_index][i] = global.foods[event.player_index][i] + 1
					
					-- TODO перенести в effects_add
					-- activate effect timer
					--if food[5] then
					--	global.effects[event.player_index][food[5]] = maxtimes[food[5]]
					--end
					
					--TODO перенести в eat_food(
					--local player = game.players[event.player_index]
					local item_count = 0
					if string.match(event.item.name, "flask") == "flask" then
						player.insert{name = "flask", count = 1}
					elseif string.match(event.item.name, "plastic%-bottle") == "plastic-bottle" then
						player.insert{name = "plastic-bottle-used", count = 1}
					elseif string.match(event.item.name, "^apple$") == "apple" then
						item_count = math.floor(math.random(8,30)/10)
						if item_count ~= 0 then
							player.insert{name = "raw-straw", count = item_count}
						end
						item_count = math.floor(math.random(2,14)/10)
						if item_count ~= 0 then
							player.insert{name = "apple-seeds", count = item_count}
						end
					elseif string.match(event.item.name, "^orange$") == "orange" then
						item_count = math.floor(math.random(16,34)/10)
						if item_count ~= 0 then
							player.insert{name = "raw-straw", count = item_count}
						end
						item_count = math.floor(math.random(1,21)/10)
						if item_count ~= 0 then
							player.insert{name = "orange-seeds", count = item_count}
						end
				end

					---if global.energy[event.player_index] < global.energy_max[event.player_index] * 0.25 then -- if Energy level down below 25% - decrease running speed
					---	game.players[event.player_index].character_running_speed_modifier = math.max((global.energy[event.player_index] - (global.energy_max[event.player_index] * 0.2))/global.energy_max[event.player_index],-0.99)
					---else
					---	game.players[event.player_index].character_running_speed_modifier = 0
					---end
					---if global.effects[event.player_index]["Speed"] and global.effects[event.player_index]["Speed"] > 0 then
					---	game.players[event.player_index].character_running_speed_modifier = (game.players[event.player_index].character_running_speed_modifier+1)*1.75-1
					---end
					
					-- update GUI
					---u_gui()
					-- figui.update(index, player)
					
					-- play some eated food sounds
					if string.match(event.item.name, "food") == "food" then
					--if string.find(food[1], "food") == 1 or string.find(food[1], "food") == 7 then
						--player.print("You eat "..food[1])
						player.play_sound({path = "use-food-capsule-sound",volume_modifier = 0.7}) -- play sound when eat food-capsule
					end

					-- TODO сделать "gourmet"
					-- for achievement "gourmet"
					--for j,k in pairs(global.foods[event.player_index]) do
					--	if j > #foods then
					--		break
					--	end
					--	if k < 3 then
					--		return
					--	end
					--	
					--end
					--game.players[event.player_index].unlock_achievement("gourmet")
					
				end
			--end
			return
		end
	end
end
)


local techs_on_research_finished = {
--tech,						ver,	data1	data2
{"fi-tech-more-energy",		1,		50,		150},
{"fi-tech-more-energy",		2,		50,		200},
{"fi-tech-more-energy",		3,		100,	300},
{"fi-tech-more-energy",		4,		100,	400},
{"fi-tech-more-energy",		5,		100,	500},
}
script.on_event(defines.events.on_research_finished, function(event)
	if not settings.global["food-industry-calculate"].value then
		return
	end
	if event.research.name == "food-energy-efficiency-1" then
		local force = event.research.force
		for index,player in pairs(game.players) do
			if player.force == force then
				-- TODO уменьшить эти все коеффициенты на -0.4
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
				global.update_delay[index] = 0.6 + event.research.level * 0.1
				if event.research.level > 50 then
					player.unlock_achievement("hibernation")
				end
				u_gui()
			end
		end
	end
	--------------- if tech "fi-tech-more-energy" researched
	--for i,tech in pairs(techs_on_research_finished) do
	local force = event.research.force
	if event.research.name == "fi-tech-more-energy-1" then
		--if  pcall(function () event.research.name = tech[1] .. "-" tech[2] end) then
			for index,player in pairs(game.players) do
				if player.valid and player.connected and player.character then
					if player.force == force then
						local leftGui = player.gui.left
						if leftGui and leftGui.valid then
							global.energy_max[index] = 150
							global.drinks_max[index] = 150
							player.print({'print.fi-tech-more-energy', "150"})
							--leftGui.frame.flow1.energylabel.tooltip = 'label.energylabel_tooltip' .. " - " .. "150" .. 'label.energylabelunits_tooltip'
							leftGui.frame.flow1.energylabel.tooltip = {'label.label-energylabel-tooltip', global.energy_max[index]}
							leftGui.frame.flow22.drinkslabel.tooltip = {'label.label-drinkslabel-tooltip', global.drinks_max[index]}
							--u_gui()
						end
					end
				end
			end
		--end
	elseif event.research.name == "fi-tech-more-energy-2" then
		for index,player in pairs(game.players) do
			if player.valid and player.connected and player.character then
				if player.force == force then
					local leftGui = player.gui.left
					if leftGui and leftGui.valid then
						global.energy_max[index] = 200
						global.drinks_max[index] = 200
						player.print({'print.fi-tech-more-energy', "200"})
						leftGui.frame.flow1.energylabel.tooltip = {'label.label-energylabel-tooltip', global.energy_max[index]}
						leftGui.frame.flow22.drinkslabel.tooltip = {'label.label-drinkslabel-tooltip', global.drinks_max[index]}
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
						global.drinks_max[index] = 300
						player.print({'print.fi-tech-more-energy', "300"})
						leftGui.frame.flow1.energylabel.tooltip = {'label.label-energylabel-tooltip', global.energy_max[index]}
						leftGui.frame.flow22.drinkslabel.tooltip = {'label.label-drinkslabel-tooltip', global.drinks_max[index]}
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
						global.drinks_max[index] = 400
						player.print({'print.fi-tech-more-energy', "400"})
						leftGui.frame.flow1.energylabel.tooltip = {'label.label-energylabel-tooltip', global.energy_max[index]}
						leftGui.frame.flow22.drinkslabel.tooltip = {'label.label-drinkslabel-tooltip', global.drinks_max[index]}
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
						global.drinks_max[index] = 500
						player.print({'print.fi-tech-more-energy', "500"})
						leftGui.frame.flow1.energylabel.tooltip = {'label.label-energylabel-tooltip', global.energy_max[index]}
						leftGui.frame.flow22.drinkslabel.tooltip = {'label.label-drinkslabel-tooltip', global.drinks_max[index]}
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
					
					-- TODO переработать Achievements code
					local total = 0
					for j,k in pairs(global.foods[index]) do
						total = total + k
					end
					-- for achievement "carnivore"
					if global.foods[index][14] + global.foods[index][15] + global.foods[index][16] + global.foods[index][25] == total then
						player.unlock_achievement("carnivore")
					end
					-- for achievement "vegan"
					if global.foods[index][14] + global.foods[index][15] + global.foods[index][16] + global.foods[index][19] + global.foods[index][20] + global.foods[index][8] + global.foods[index][25] == 0 then
						player.unlock_achievement("vegan")
					end
					
				end
			end
		end
	end
)


function u_gui()
	if not settings.global["food-industry-calculate"].value then
		return
	end
	if global.energy and global.drinks and global.fullness then
		for index, player in pairs(game.players) do
			if global.energy[index] and global.drinks[index] and global.fullness[index] then -- if exists values in global tables
				if player.valid and player.connected then
					
					--figui.create(index, player)
					--figui.update(index, player)
					
					
					local leftGui = player.gui.left
					
					
					--if pcall(function () leftGui.frame.energylabel.caption = "Energy: " .. global.energy[index] .. " (usage: ".. (math.floor((100 * settings.global["food-industry-hunger-speed"].value * global.usage[index] / global.update_delay[index]) + 0.5) * 0.01) .."%)" end) then
					---if pcall(function () leftGui.frame.flow1.usagelabel.caption = (math.floor((100 * settings.global["food-industry-hunger-speed"].value * global.usage[index] / global.update_delay[index]) + 0.5) * 0.01) end) then
					---	--old leftGui.frame.energylabel.caption = "Energy: " .. global.energy[index] .. " (usage: ".. (math.floor((100 * settings.global["food-industry-hunger-speed"].value * global.usage[index] / global.update_delay[index]) + 0.5) * 0.01) .."%)"
					---	leftGui.frame.flow1.energylabel.caption = global.energy[index]
					---	leftGui.frame.flow1.usagelabel.caption = (math.floor((100 * settings.global["food-industry-hunger-speed"].value * global.usage[index] / global.update_delay[index]) + 0.5) * 0.01)
					---else
					---	-- old  leftGui.frame.energylabel.caption = "Energy: " .. global.energy[index] .. " (usage: ---%)"
					---	leftGui.frame.flow1.energylabel.caption = global.energy[index]
					---	leftGui.frame.flow1.usagelabel.caption = "---"
					---end
					---leftGui.frame.energybar.value = math.abs(global.energy[index]/global.energy_max[index])
					
					--leftGui.frame.flow2.fullnesslabel.caption = "Fullness: " .. math.ceil(global.fullness[index]) .."%"
					---leftGui.frame.flow2.fullnesslabel.caption = math.ceil(global.fullness[index])
					---leftGui.frame.fullnessbar.value = global.fullness[index]/100
					
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
							--leftGui.frame.starvinglabel.caption = "Starving: -" .. (math.floor(25 - global.energy[index]/0.5)/10) .."HP/s (< " .. getTime(player.character.health*60/(2.5 - global.energy[index]/5)) .. " to death)"
							leftGui.frame.flow8.starvinglabel.caption = (math.floor(global.energy_max[index] * 0.25 - global.energy[index]/0.5)/10)
							leftGui.frame.flow8.starvingtimelabel.caption = getTime(player.character.health*60/(2.5 - global.energy[index]/5))
						end
						
					elseif leftGui.frame.starvingbar and leftGui.frame.flow8.starvinglabel then
						--leftGui.frame.starvinglabel.destroy()
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
							--leftGui.frame.flow7.hungerspeedlabel.caption = "Hunger slowness: " .. math.max(global.energy[index] - 25,-99) .."%"
							leftGui.frame.flow7.hungerspeedlabel.caption = math.floor(math.max(global.energy[index] - global.energy_max[index] * 0.25,-99))
						end
						
					elseif leftGui.frame.hungerspeedbar and leftGui.frame.flow7.hungerspeedlabel then
						leftGui.frame.flow7.destroy()
						--leftGui.frame.flow7.hungerspeedlabel.destroy()
						leftGui.frame.hungerspeedbar.destroy()
					end
					
					-- rezerved .flow8 for buttons how activate "capsule effects"
					
					-- initialize .flow10 - Effects
					-- TODO move to figui.update_effects(...)
					--if global.effects[index] then
					--	for effect,t in pairs(global.effects[index]) do
					--		if t > 0 then
					--			if not (leftGui.frame[effect.."label"] and leftGui.frame[effect.."bar"] ) then
					--				leftGui.frame.add({type="label", name=effect.."label", caption=""})
					--				leftGui.frame.add({type="progressbar", name=effect.."bar"})
					--				leftGui.frame[effect.."bar"].style.width = 200
					--				leftGui.frame[effect.."bar"].style.color = effectcolors[effect]
					--			end
					--			leftGui.frame[effect.."bar"].value = t/maxtimes[effect]
					--			if player.character then
					--				leftGui.frame[effect.."label"].caption = effect..": " .. getTime(t)
					--			end
					--			
					--		elseif leftGui.frame[effect.."bar"] and leftGui.frame[effect.."label"] then
					--			leftGui.frame[effect.."label"].destroy()
					--			leftGui.frame[effect.."bar"].destroy()
					--		end
					--	end
					--end
					
					-- ------------------
					
					
					-- set GUI top_padding
					if settings.get_player_settings(player)["food-industry-bottom"].value then
						leftGui.style.top_padding = player.display_resolution.height - 200 - settings.get_player_settings(player)["food-industry-padding"].value
					else
						leftGui.style.top_padding = 0
					end

					-- DEBUG
					if player.character then
						figui.debug_create(index, player)
						figui.debug_update(index, player)
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


-- TODO When eat_button is clicked
script.on_event(defines.events.on_gui_click, function(event)
	for index,player in pairs(game.players) do
		if player.connected then
			if event.element.name == "eat_button" then
				--element
				--player_index
				player.print(event.player_index .. " " .. player.name .. " - Click Eat button!")
				--debug_print("version cut = ")
				--writeDebug("Drill has been built")
			end
		end
	end
end
)


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

local OnPlayerChangedPosition = function(event)
	for k=1, #foodi.on_changedPosition do
		local v = foodi.on_changedPosition[k]
		v(event)
	end
end

local selected_entity_changed = function(event)
	if foodi == nil then return end
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
script.on_event(defines.events.on_player_changed_position, OnPlayerChangedPosition)

script.on_event(defines.events.on_selected_entity_changed, selected_entity_changed)

