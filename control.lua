local foods = {
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
{"baked-potato", 	10, 	30, 	-40},
{"fries", 			20, 	55, 	-50},
{"ketchup-fries", 	25, 	70, 	-50},
{"biter-meat", 		15, 	55, 	100},
{"biter-steak", 	30, 	70, 	30},
{"schnitzel", 		35, 	80, 	40},
{"pickles", 		3, 		5, 		-5},
{"tofu", 			25, 	60, 	-15},
{"pizza", 			70, 	95, 	-60},
{"burger", 			75, 	100, 	-60},
{"tofu-pizza", 		65, 	95, 	-80},
{"tofu-burger", 	60, 	100, 	-80},
{"best-salad", 		45, 	70, 	-200},
{"vegan-food-capsule",50, 	50, 	-200},
{"cooked-biter-meat",20, 	60, 	50},
{"long-reach-capsule",50, 	50, 	0,	"Long reach"},
{"speed-capsule", 	50, 	50, 	0,	"Speed"},
{"regen-capsule", 	50, 	50, 	0,	"Regeneration"},
{"crafting-capsule",50, 	50, 	0,	"Fast crafting"},
{"mining-capsule", 	50, 	50, 	0,	"Fast mining"},
{"invulnerability-capsule",50,50, 	0,	"Invulnerability"},
{"neutralizing-capsule",50, 50, 	0},
{"health-buffer-capsule",50,50, 	0, 	"Health buffer"},
}

local effectcolors = {}
effectcolors["Long reach"] = {r=1,g=0.8,b=0,a=1}
effectcolors["Speed"] = {r=0,g=0.5,b=1,a=1}
effectcolors["Regeneration"] = {r=0,g=1,b=0,a=1}
effectcolors["Fast crafting"] = {r=0.8,g=0.5,b=0,a=1}
effectcolors["Fast mining"] = {r=0.9,g=0,b=0,a=1}
effectcolors["Invulnerability"] = {r=1,g=1,b=0,a=1}
effectcolors["Health buffer"] = {r=1,g=0,b=1,a=1}


local maxtimes = {}
maxtimes["Long reach"] = 21600
maxtimes["Speed"] = 5400
maxtimes["Regeneration"] = 1800
maxtimes["Fast crafting"] = 1200
maxtimes["Fast mining"] = 3600
maxtimes["Invulnerability"] = 900
maxtimes["Health buffer"] = 2700



script.on_event({defines.events.on_tick}, function (e)  
	local default_delay = 10000 / settings.global["food-industry-hunger-speed"].value
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
				if not global.energy[index] then
					global.energy[index] = 200
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
					
				if global.energy[index] > 180 then
					global.full_time[index] = global.full_time[index] + 5
					if global.full_time[index] > 108000 then
						player.unlock_achievement("overweight")
					end
				else
					global.full_time[index] = 0
				end      
        
				
				if not player.character then
					global.energy[index] = 50
					global.fullness[index] = 0
					global.used[index] = 0
					global.usage[index] = 0
					for effect,t in pairs(global.effects[index]) do
						global.effects[index][effect] = 0
					end
				else					
					if player.walking_state.walking then
						local slots = 0  
						local durability = 0
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
						global.usage[index] = 1.5 + settings.global["food-industry-slots"].value * slots + settings.global["food-industry-durability"].value * durability * 0.001
					else
						global.usage[index] = 1
					end
					  
					global.used[index] = global.used[index] + global.usage[index]
					  
					if global.used[index] >= (default_delay * global.update_delay[index]) then					  
						global.used[index] = global.used[index] - (default_delay * global.update_delay[index])  				
						if global.energy[index] > -50 then
							global.energy[index] = global.energy[index] - 1
						end				
  					
						if global.energy[index] < 25 then
							player.character_running_speed_modifier = (global.energy[index] - 25)/100
						else
							player.character_running_speed_modifier = 0
						end
						if global.effects[index]["Speed"] and global.effects[index]["Speed"] > 0 then
							player.character_running_speed_modifier = (player.character_running_speed_modifier+1)*1.75-1
						end
  					
						u_gui()
					end
						
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
								if global.energy[index] < 25 then
									player.character_running_speed_modifier = (global.energy[index] - 25)/100
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

script.on_event(defines.events.on_built_entity, function(event)
	local entity = event.created_entity
		if (entity.name == "basic-farmland") and entity.burner and entity.burner.remaining_burning_fuel then 
			event.created_entity.burner.currently_burning="wood"
			event.created_entity.burner.remaining_burning_fuel=2000000				
		end
	end
)

script.on_event(defines.events.on_player_created, function(event)
	local player = game.players[event.player_index]
	player.insert({name="vegan-food-capsule", count=25})	
end
)

script.on_event(defines.events.on_player_used_capsule, function(event)
	if event.item.name == "raw-fish" then
		local player = game.players[event.player_index]
		player.insert{name = "raw-fish", count = 1}
		player.print("There are bones in this, you don't want to eat this.")
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
				player.print("You are too full to eat this.")
			else
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
				
				if global.energy[event.player_index] > 200 then
					global.energy[event.player_index] = 200
				end
				
				if food[5] then
					global.effects[event.player_index][food[5]] = maxtimes[food[5]]
				end
				
				if global.energy[event.player_index] < 25 then
					game.players[event.player_index].character_running_speed_modifier = math.max((global.energy[event.player_index] - 25)/100,-0.99)
				else
					game.players[event.player_index].character_running_speed_modifier = 0
				end
				if global.effects[event.player_index]["Speed"] and global.effects[event.player_index]["Speed"] > 0 then
					game.players[event.player_index].character_running_speed_modifier = (game.players[event.player_index].character_running_speed_modifier+1)*1.75-1
				end
				
				
				u_gui()				
				
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
			if global.energy[index] and global.fullness[index] then
				if player.valid and player.connected then
					local leftGui = player.gui.left
					
					if leftGui.bar then
						leftGui.bar.destroy()
					end
					
					if not leftGui.frame then
						leftGui.add{
						type = "frame",
						name = "frame",
						direction = "vertical"
						}			
					end	

						if not leftGui.frame.energylabel then
							leftGui.frame.add({type="label", name="energylabel", caption=""})
						end	
						if not leftGui.frame.energybar then
							leftGui.frame.add({type="progressbar", name="energybar"})
							leftGui.frame.energybar.style.width = 200
						end	
						if not leftGui.frame.fullnesslabel then
							leftGui.frame.add({type="label", name="fullnesslabel", caption=""})
						end	
						if not leftGui.frame.fullnessbar then
							leftGui.frame.add({type="progressbar", name="fullnessbar"})
							leftGui.frame.fullnessbar.style.width = 200
							leftGui.frame.fullnessbar.style.color = {r = 1, g = 0.6, a = 1}
						end			
						
					if pcall(function () leftGui.frame.energylabel.caption = "Energy: " .. global.energy[index] .. " (usage: ".. (math.floor((100 * settings.global["food-industry-hunger-speed"].value * global.usage[index] / global.update_delay[index]) + 0.5) * 0.01) .."%)" end) then
						leftGui.frame.energylabel.caption = "Energy: " .. global.energy[index] .. " (usage: ".. (math.floor((100 * settings.global["food-industry-hunger-speed"].value * global.usage[index] / global.update_delay[index]) + 0.5) * 0.01) .."%)"
					else
						leftGui.frame.energylabel.caption = "Energy: " .. global.energy[index] .. " (usage: ---%)"
					end
					
					leftGui.frame.energybar.value = math.abs(global.energy[index]/200)
					leftGui.frame.fullnesslabel.caption = "Fullness: " .. math.ceil(global.fullness[index]) .."%"
					leftGui.frame.fullnessbar.value = global.fullness[index]/100			
					
					if global.energy[index] < 0	then
						if not (leftGui.frame.starvinglabel and leftGui.frame.starvingbar) then
							leftGui.frame.add({type="label", name="starvinglabel", caption=""})				
							leftGui.frame.add({type="progressbar", name="starvingbar"})
							leftGui.frame.starvingbar.style.width = 200
							leftGui.frame.starvingbar.style.color = {r = 1, a = 1}
						end
						leftGui.frame.starvingbar.value = (2.5 - global.energy[index]/5)/12.5
						if player.character then
							leftGui.frame.starvinglabel.caption = "Starving: -" .. (math.floor(25 - global.energy[index]/0.5)/10) .."HP/s (< " .. getTime(player.character.health*60/(2.5 - global.energy[index]/5)) .. " to death)"
						end
						
					elseif leftGui.frame.starvingbar and leftGui.frame.starvinglabel then
						leftGui.frame.starvingbar.destroy()
						leftGui.frame.starvinglabel.destroy()
					end
					
					if global.energy[index] < 25 then
						if not (leftGui.frame.hungerspeedlabel and leftGui.frame.hungerspeedbar) then
							leftGui.frame.add({type="label", name="hungerspeedlabel", caption=""})				
							leftGui.frame.add({type="progressbar", name="hungerspeedbar"})
							leftGui.frame.hungerspeedbar.style.width = 200
							leftGui.frame.hungerspeedbar.style.color = {r = 0.7, g = 0.7, b = 0.9, a = 1}
						end
						leftGui.frame.hungerspeedbar.value = -(global.energy[index] - 25)/100
						if player.character then
							leftGui.frame.hungerspeedlabel.caption = "Hunger slowness: " .. math.max(global.energy[index] - 25,-99) .."%"
						end
						
					elseif leftGui.frame.hungerspeedbar and leftGui.frame.hungerspeedlabel then
						leftGui.frame.hungerspeedlabel.destroy()
						leftGui.frame.hungerspeedbar.destroy()
					end
					
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
					
					
					
					if global.energy[index] >= 100 then
						leftGui.frame.energybar.style.color = {g = 1, a = 1}
					elseif global.energy[index] >= 25 then
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
