-- functions of calculate usages
require "libs.helper-functions"


-- function adds used food table line to all fullnesses
--@ also for adds fictive food: "drink-to-add-more-energy"
function eat_food(player, index, food, food_item)
	
	----------------------- append new used food to all fullnesses
	if global.fullness then
		if global.fullness_stomach[index] and type(global.fullness_stomach[index]) == 'table' then
			-- append food fullness to global.fullness
			global.fullness[index] = global.fullness[index] + food[6]

			--local new_food = table.deepcopy(food)
			table.insert(global.fullness_stomach[index], food)

			-- TODO тут будет инфо о съеденой пище если есть "Eating" button или food-feeder equipment
			
		else
			player.print("[Debug] Warning: "..food[1].." is not a table!")
		end
	end
	-----------------------

end


-- Fullness calculation
--@ it's like a stomach in the human body, You put the food and its digestion takes place in turns.
--@     1          2         3       4       5         6            7             8
--@ {food_name, food_type, energy, water, {V,M,C,F}, fullness, fullness_digest, health,}
function fullness_calc_on_tick(index)

    if not global.fullness[index] then
        return
    end

    if table.maxn(global.fullness_stomach[index]) > 0 then
        --writeDebug("fullness_stomach[index]) > 0")
        
        --game.players[index].print(dump(global.fullness_stomach[index]))
        for i,food in pairs(global.fullness_stomach[index]) do
            --writeDebug(dump(food))
            --game.players[index].print(dump(food))
            if food[7] > 0 then
                -- назначаем стандартную скорость расхода Fullness
                local fullness_diff = (settings.global["food-industry-hunger-speed"].value * (global.effects[index]["digestion"][2]+1) / 400 / 4)
                
                -- перевариваем еду - добавляем каждой еде в желудке степень переваривания в column 7
                -- Fullness subtraction
                global.fullness[index] = global.fullness[index] - fullness_diff
                -- TODO доделать fullness_calc
                global.fullness_stomach[index][i][7] = global.fullness_stomach[index][i][7] - fullness_diff
                --writeDebug("global.fullness["..index.."] - "..global.fullness[index])
                
                -- Energy subtraction and summation
                -- add excess of Energy to fat_modifier
                if global.energy[index] + ( food[3] - ( food[3] * 100 / food[6] ) * ( food[6] - fullness_diff ) / 100 ) > global.energy_max[index] then
                    global.energy[index] = global.energy_max[index]
                    -- добавляем излишки Energy к fat только уменьшив в 10 раз
                    global.fi_character_fat_modifier[index] = global.fi_character_fat_modifier[index] + ( food[3] - ( food[3] * 100 / food[6] ) * ( food[6] - fullness_diff ) / 100 ) / 10
                else
                -- добавляем к global Energy разницу в процентах от единицы Fullness
                -- if Energy is 3 and Fullness is 8 then Energy=Energy+(3-(3*100/8)*(8-1)/100)
                    global.energy[index] = global.energy[index] + ( food[3] - ( food[3] * 100 / food[6] ) * ( food[6] - fullness_diff ) / 100 )
                end

                -- Water subtraction and summation
                if global.drinks[index] + ( food[4] - ( food[4] * 100 / food[6] ) * ( food[6] - fullness_diff ) / 100 ) > global.drinks_max[index] then
                    global.drinks[index] = global.drinks_max[index]
                	-- add excess of Drinks/20 to fat_modifier
                    global.fi_character_fat_modifier[index] = global.fi_character_fat_modifier[index] + ( food[4] - ( food[4] * 100 / food[6] ) * ( food[6] - fullness_diff ) / 100 ) / 20
				elseif global.drinks[index] + ( food[4] - ( food[4] * 100 / food[6] ) * ( food[6] - fullness_diff ) / 100 ) < 0 then
                    -- TODO excess -Drinks affect to Thirst x2
					if ( food[4] - ( food[4] * 100 / food[6] ) * ( food[6] - fullness_diff ) / 100 ) > 0 then
						-- when thirst add drinks*2
						global.drinks[index] = global.drinks[index] + ( food[4] - ( food[4] * 100 / food[6] ) * ( food[6] - fullness_diff ) / 100 ) * 2
						-- append time when thirst with 10x values drinks
						global.effects[index]["thirst"][3] = global.effects[index]["thirst"][3] + ( food[4] - ( food[4] * 100 / food[6] ) * ( food[6] - fullness_diff ) / 100 ) * 800
					else
						-- when thirst remove drinks/3
						global.drinks[index] = global.drinks[index] + ( food[4] - ( food[4] * 100 / food[6] ) * ( food[6] - fullness_diff ) / 100 ) / 3
						-- reduce time when thirst with 5x values drinks
						global.effects[index]["thirst"][3] = global.effects[index]["thirst"][3] + ( food[4] - ( food[4] * 100 / food[6] ) * ( food[6] - fullness_diff ) / 100 ) * 200
					end
                else
					global.drinks[index] = global.drinks[index] + ( food[4] - ( food[4] * 100 / food[6] ) * ( food[6] - fullness_diff ) / 100 )
                end

                -- Substances subtraction and summation or destroy excess of Substances
                if global.substances[index]["v"] + ( food[5][1] - ( food[5][1] * 100 / food[6] ) * ( food[6] - fullness_diff ) / 100 ) > 100 then
                    global.substances[index]["v"] = 100
				elseif global.substances[index]["v"] + ( food[5][1] - ( food[5][1] * 100 / food[6] ) * ( food[6] - fullness_diff ) / 100 ) <= -10 then
                    global.substances[index]["v"] = -10
                else
                    global.substances[index]["v"] = global.substances[index]["v"] + ( food[5][1] - ( food[5][1] * 100 / food[6] ) * ( food[6] - fullness_diff ) / 100 )
                end
                if global.substances[index]["m"] + ( food[5][2] - ( food[5][2] * 100 / food[6] ) * ( food[6] - fullness_diff ) / 100 ) > 100 then
                    global.substances[index]["m"] = 100
				elseif global.substances[index]["m"] + ( food[5][2] - ( food[5][2] * 100 / food[6] ) * ( food[6] - fullness_diff ) / 100 ) <= -10 then
                    global.substances[index]["m"] = -10
                else
                    global.substances[index]["m"] = global.substances[index]["m"] + ( food[5][2] - ( food[5][2] * 100 / food[6] ) * ( food[6] - fullness_diff ) / 100 )
                end
                if global.substances[index]["c"] + ( food[5][3] - ( food[5][3] * 100 / food[6] ) * ( food[6] - fullness_diff ) / 100 ) > 100 then
                    global.substances[index]["c"] = 100
				elseif global.substances[index]["c"] + ( food[5][3] - ( food[5][3] * 100 / food[6] ) * ( food[6] - fullness_diff ) / 100 ) <= -10 then
                    global.substances[index]["c"] = -10
                else
                    global.substances[index]["c"] = global.substances[index]["c"] + ( food[5][3] - ( food[5][3] * 100 / food[6] ) * ( food[6] - fullness_diff ) / 100 )
                end
                if global.substances[index]["f"] + ( food[5][4] - ( food[5][4] * 100 / food[6] ) * ( food[6] - fullness_diff ) / 100 ) > 100 then
                    global.substances[index]["f"] = 100
				elseif global.substances[index]["f"] + ( food[5][4] - ( food[5][4] * 100 / food[6] ) * ( food[6] - fullness_diff ) / 100 ) <= -10 then
                    global.substances[index]["f"] = -10
                else
                    global.substances[index]["f"] = global.substances[index]["f"] + ( food[5][4] - ( food[5][4] * 100 / food[6] ) * ( food[6] - fullness_diff ) / 100 )
                end

                -- Health subtraction and summation
                if (game.players[index].character) then
                    game.players[index].character.health = game.players[index].character.health + ( food[8] - ( food[8] * 100 / food[6] ) * ( food[6] - fullness_diff ) / 100 )
                    if game.players[index].character.health <= 0 then
                        game.players[index].character.health = 1
                        game.players[index].character.damage(900000,"neutral")
                        return
                    end
                end
            else
                -- remove depleted food
                table.remove(global.fullness_stomach[index], i)

                --writeDebug("global.fullness_stomach["..index.."] remove from table")
                --writeDebug(dump(global.fullness_stomach[index]))
            end
        end
    else
        global.fullness[index] = 0
        --writeDebug("fullness_stomach["..index.."]) = "..global.fullness[index].." !!!")
    end
	
end


function energy_reduction(index, player)
	local default_delay = 10000 / settings.global["food-industry-hunger-speed"].value -- default 10000 / 100 = 100%
    
    global.used[index] = global.used[index] + global.usage[index]
	--writeDebug("global.used["..index.."] "..global.used[index])

    --								100%	*		1					-				0							+	(reduce additionaly for 10%)
    if global.used[index] >= (default_delay * (global.update_delay[index] - global.fi_energy_ussage_modifier[index] + 0.1)) then
        global.used[index] = global.used[index] - (default_delay * (global.update_delay[index] - global.fi_energy_ussage_modifier[index] + 0.1))
        if global.energy[index] > -50 then
            global.energy[index] = global.energy[index] - 1
            --writeDebug("global.energy["..index.."] "..global.energy[index])
            --writeDebug("global.fi_energy_ussage_modifier["..index.."] "..global.fi_energy_ussage_modifier[index])
        end
    end

end


-- Drinks usage
function drinks_reduction(index, player)
	local default_delay = 10000 / settings.global["food-industry-hunger-speed"].value -- default 10000 / 100 = 100%
	
	global.drinks_used[index] = global.drinks_used[index] + global.usage[index]
	
	-- drinks ussage в отличии от energy usage не зависит от global.update_delay, который исследуется с помощью technology
	-- depends only from global.usage
	if global.drinks_used[index] >= (default_delay * (1 - global.fi_drinks_ussage_modifier[index])) then
		global.drinks_used[index] = global.drinks_used[index] - (default_delay * (1 - global.fi_drinks_ussage_modifier[index]))
		if global.drinks[index] <= 0 then
			if global.effects[index]["thirst"][1] and global.effects[index]["thirst"][2] == 1 then -- if thirst preparation (6 min)
				global.drinks[index] = global.drinks[index] - 0.55
			elseif global.effects[index]["thirst"][1] and global.effects[index]["thirst"][2] == 2 then -- if thirst active (30 min)
				if math.ceil(math.abs(global.effects[index]["thirst"][3])/108000*100) >= 40 then
					global.drinks[index] = global.drinks[index] - 1.25
				elseif math.ceil(math.abs(global.effects[index]["thirst"][3])/108000*100) >= 20 then
					global.drinks[index] = global.drinks[index] - 1.0
				else
					global.drinks[index] = global.drinks[index] - 0.75
				end
			else -- before thirst preparation (4 min)
				global.drinks[index] = global.drinks[index] - 0.1
			end
			-- drinks could not be lower then -drinks_max
			if global.drinks[index] < global.drinks_max[index] * -1 then
				global.drinks[index] = global.drinks_max[index] * -1
			end
		else
			if global.drinks[index] > global.drinks_max[index] * -1 then
				global.drinks[index] = global.drinks[index] - 1
				if global.drinks[index] < 0 then
					global.drinks[index] = 0
				end
			end
		end
	end

end


-- Substances usage
function substances_reduction(index)
	-- maintain levels not lower than -10
	-- and if levels lower than -10 - restore to 0
	if global.substances[index]["v"] - 1 >= 1 then
		global.substances[index]["v"] = global.substances[index]["v"] - 1
	elseif global.substances[index]["v"] - 1 <= -1.01 then
		global.substances[index]["v"] = global.substances[index]["v"] + 1
	elseif global.substances[index]["v"] - 1 <= -10 then
		global.substances[index]["v"] = -10
	else
		global.substances[index]["v"] = 0
	end
	
	if global.substances[index]["m"] - 1 >= 1 then
		global.substances[index]["m"] = global.substances[index]["m"] - 1
	elseif global.substances[index]["m"] - 1 <= -1.01 then
		global.substances[index]["m"] = global.substances[index]["m"] + 1
	elseif global.substances[index]["m"] - 1 <= -10 then
		global.substances[index]["m"] = -10
	else
		global.substances[index]["m"] = 0
	end

	if global.substances[index]["c"] - 1 >= 1 then
		global.substances[index]["c"] = global.substances[index]["c"] - 1
	elseif global.substances[index]["c"] - 1 <= -1.01 then
		global.substances[index]["c"] = global.substances[index]["c"] + 1
	elseif global.substances[index]["c"] - 1 <= -10 then
		global.substances[index]["c"] = -10
	else
		global.substances[index]["c"] = 0
	end

	if global.substances[index]["f"] - 1 >= 1 then
		global.substances[index]["f"] = global.substances[index]["f"] - 1
	elseif global.substances[index]["f"] - 1 <= -1.01 then
		global.substances[index]["f"] = global.substances[index]["f"] + 1
	elseif global.substances[index]["f"] - 1 <= -10 then
		global.substances[index]["f"] = -10
	else
		global.substances[index]["f"] = 0
	end
end


function thirst_reduction(index,reduce_value)
	if global.drinks[index] <= 0 then
		global.effects[index]["thirst"][3] = global.effects[index]["thirst"][3] - reduce_value * global.usage[index] -- countdown to thirst
	elseif global.drinks[index] > 0 and global.effects[index]["thirst"][2] == 0 and global.effects[index]["thirst"][3] < 14400 then
		global.effects[index]["thirst"][3] = global.effects[index]["thirst"][3] + reduce_value -- restore thirst preparation timer
	end
end


function fat_modifier_reduction(index,reduce_value)
    -- TODO доделать расход global.fi_character_fat_modifier[index]
    if global.fi_character_fat_modifier[index] < 0 then
        global.fi_character_fat_modifier[index] = 0
    else
        global.fi_character_fat_modifier[index] = global.fi_character_fat_modifier[index] - reduce_value
    end
end


-- Effects assignment
-- add new effect data values
function effects_add(index, item_name, effect_data)
	--  where:
	--@ index = Player index
	--@ item_name = "simple-speed-capsule"
	--@ effect_data = {"crafting",1,12000}

	--  conception 1
	--@ global.effects[index]["speed"]	 = {false,	0,	0,	{
	--@ 														{"simple-speed-capsule",0.3,5400},
	--@ 														{"vmc_above_20",0.2,14400},
	--@ 													} }
	--@ global.effects[index]["digestion"]	 = {false,	0,	0,	{
	--@ 														{"vmcf_above_40",0.4,0},
	--@ 														{"simple-digestive-capsule",0.5,14400},
	--@ 													} }
	--@
	--@ OR
	--@
	--  conception 2
	--@ global.effects[index]["speed"]	 = {false,	0,	0,}
	--@ global.effects[index]["digestion"]	 = {false,	0,	0,}
	--@	global.effects_active[index] = {
	--@ 														{"simple-speed-capsule",0.3,5400},
	--@ 														{"vmc_above_20",0.2,0},
	--@ 														{"all_substances_above_40",0.4,0},
	--@ 														{"simple-digestive-capsule",0.5,14400},
	--@ 													}

	-- TODO effects_add function: от капсул и еды
	--@ когда добавляется эффект, то:
	--@ - данные эфекта добавляются в global.effects[index]["key"]	: 
	--@ - 															- имя-ключ от от какого элемента эффект
	--@ - 															- значение/модификатор эффекта
	--@ - 															- время действия эффекта
	--@ - затем время эффекта начинает отниматься в effects_time_reduction(index)
	--@ - 															- проверяется его время
	--@ - 															- если время вышло - эффект удаляется и го значение/модификатор отнимается с общей суммы в своей глобальной переменной
	--@ - а обрабатываться эфект effects_calc_on_tick(index, player):
	--@ - 															- тут проверяются эфекты зашитые в коде

	-- OPTIMIZE find effect key in a table
	if table.maxn(global.effects[index][effect_data[1]][5]) <= 0 then
		-- insert first new effect
		writeDebug("No effects for '"..effect_data[1].."', insert new ")
		effects_add_insert(index, item_name, effect_data)

	elseif table.maxn(global.effects[index][effect_data[1]][5]) > 0 then
		for i5,e5 in pairs(global.effects[index][effect_data[1]][5]) do
			--writeDebug("i5="..i5..",")
			writeDebug(dump(e5))
			if e5[1] == item_name then
				-- update effect
				--if string.match(effect_data[1], "fi_") == "fi_" then
				--	writeDebug("update fi "..effect_data[1])
				--	effects_fi_add_update(index, item_name, effect_data, i5)
				--else
				writeDebug("update "..effect_data[1])
				--end
				effects_add_update(index, item_name, effect_data, i5)
			
			elseif string.match(e5[1], "%w+%-%w+$") == string.match(item_name, "%w+%-%w+$") then
				writeDebug("update capsule "..effect_data[1])
				
				writeDebug(index..", "..i5..", "..effect_data[1]..", "..e5[2])
				effects_remove(index, i5, effect_data[1], e5[2]) -- remove old data
				effects_add_insert(index, item_name, effect_data)
			else
				-- insert effect
				--if string.match(effect_data[1], "fi_") == "fi_" then
				--	writeDebug("insert fi "..effect_data[1])
				--	effects_fi_add_insert(index, item_name, effect_data)
				--else
					writeDebug("insert "..effect_data[1])
					effects_add_insert(index, item_name, effect_data)
				--end
			end
		end
	end

end


function effects_add_update(index, item_name, effect_data, i5)
	global.effects[index][effect_data[1]][1] = true
	global.effects[index][effect_data[1]][3] = global.effects[index][effect_data[1]][3] + effect_data[3]
	global.effects[index][effect_data[1]][5][i5][2] = effect_data[2]
	global.effects[index][effect_data[1]][5][i5][3] = effect_data[3]
	-- TODO check with delay
	global.effects[index][effect_data[1]][4] = global.effects[index][effect_data[1]][4] + table.maxn(global.effects[index][effect_data[1]][5]) * 20
	
	--effects_vanilla_add_or_remove(true, index, effect_data[1], effect_data[2])
	--global.effects[index][effect_data[1]][2] = global.effects[index][effect_data[1]][2] + effect_data[2]
	global.effects[index][effect_data[1]][2] = effect_data[2]
end


function effects_add_insert(index, item_name, effect_data)
	--local new_table_line = {item_name, effect_data[2], effect_data[3]}
	global.effects[index][effect_data[1]][1] = true
	global.effects[index][effect_data[1]][2] = global.effects[index][effect_data[1]][2] + effect_data[2]
	global.effects[index][effect_data[1]][3] = global.effects[index][effect_data[1]][3] + effect_data[3]
	--@ effect_data[4] may be = nil or table or number
	if effect_data[4] ~= nil and type(effect_data[4]) == "number" then
		global.effects[index][effect_data[1]][4] = effect_data[4]
		table.insert(global.effects[index][effect_data[1]][5], {item_name, effect_data[2], effect_data[3], effect_data[4]})
	elseif effect_data[4] ~= nil and type(effect_data[4]) == "table" then
		if effect_data[1] == "drink_to_add_more_energy" then
			for i,e in pairs(effect_data[4]) do
				--						in effect_key[5]				item,	energy * modifier	time of action
				global.effects[index][effect_data[1]][1] = true
				global.effects[index][effect_data[1]][3] = effect_data[3]
				table.insert(global.effects[index][effect_data[1]][5], {e[1], e[2]*effect_data[2], effect_data[3]})
			end
		else
			writeDebug("[A bug]: this fi type of effect is not be insert! Contact the developer.")
		end
	else
		table.insert(global.effects[index][effect_data[1]][5], {item_name, effect_data[2], effect_data[3]})
		effects_vanilla_add_or_remove(true, index, effect_data[1], effect_data[2])
	end

	-- add 1 effect count
	effects_counter_add_or_remove(true, index, 1)
end


-- remove effect data when time is left
function effects_fi_remove(index, effect_index, effect_name, effect_modifier)
	--global.effects[index][effect_name][2] = global.effects[index][effect_name][2] - effect_modifier
	--table.remove(global.effects[index][effect_name][5], effect_index)
	
end
function effects_remove(index, effect_index, effect_name, effect_modifier)
	writeDebug("removed - "..index..", "..effect_index..", "..effect_name..", "..effect_modifier)
	
	table.remove(global.effects[index][effect_name][5], effect_index)
	effects_vanilla_add_or_remove(false, index, effect_name, effect_modifier)
	
	-- remove 1 effect count
	effects_counter_add_or_remove(false, index, 1)
end


function effects_counter_add_or_remove(add_bool, index, value)
	-- remove counter
	local leftGui = game.players[index].gui.left
	if leftGui.frame.flow3.flow34.label_effects_count then
		if add_bool then
			leftGui.frame.flow3.flow34.label_effects_count.caption = leftGui.frame.flow3.flow34.label_effects_count.caption + value
		else
			if leftGui.frame.flow3.flow34.label_effects_count.caption - value < 0 then
				leftGui.frame.flow3.flow34.label_effects_count.caption = 0
			else
				leftGui.frame.flow3.flow34.label_effects_count.caption = leftGui.frame.flow3.flow34.label_effects_count.caption - value
			end
		end
	end
end


function effects_vanilla_add_or_remove(add_bool, index, effect_name, effect_modifier)
	if effect_name == "speed" then
		if add_bool then
			game.players[index].character_running_speed_modifier = game.players[index].character_running_speed_modifier + effect_modifier
		else
			game.players[index].character_running_speed_modifier = game.players[index].character_running_speed_modifier - effect_modifier
		end
	elseif effect_name == "crafting" then
		if add_bool then
			game.players[index].character_crafting_speed_modifier = game.players[index].character_crafting_speed_modifier + effect_modifier
		else
			game.players[index].character_crafting_speed_modifier = game.players[index].character_crafting_speed_modifier - effect_modifier
		end
	elseif effect_name == "mining" then
		if add_bool then
			game.players[index].character_mining_speed_modifier = game.players[index].character_mining_speed_modifier + effect_modifier
		else
			game.players[index].character_mining_speed_modifier = game.players[index].character_mining_speed_modifier - effect_modifier
		end
	elseif effect_name == "long_reach" then
		if add_bool then
			--if character_build_distance_bonus = 100%
			game.players[index].character_build_distance_bonus = game.players[index].character_build_distance_bonus + effect_modifier					-- if this is 100%
			game.players[index].character_item_drop_distance_bonus = game.players[index].character_item_drop_distance_bonus + effect_modifier * 0.2		-- then this = 20%
			game.players[index].character_reach_distance_bonus = game.players[index].character_reach_distance_bonus + effect_modifier * 1.2				-- then this = 120%
		else
			game.players[index].character_build_distance_bonus = game.players[index].character_build_distance_bonus - effect_modifier					-- if this is 100%
			game.players[index].character_item_drop_distance_bonus = game.players[index].character_item_drop_distance_bonus - effect_modifier * 0.2		-- then this = 20%
			game.players[index].character_reach_distance_bonus = game.players[index].character_reach_distance_bonus - effect_modifier * 1.2				-- then this = 120%
		end
	elseif effect_name == "health_buffer" or effect_name == "invulnerability"  then
		if add_bool then
			game.players[index].character_health_bonus = game.players[index].character_health_bonus + effect_modifier
		else
			game.players[index].character_health_bonus = game.players[index].character_health_bonus - effect_modifier
		end
	end
end


-- reduce effects time values
function effects_time_reduction(index) -- after -60 ticks

	for i,effect in pairs(global.effects[index]) do
		--writeDebug(i)
		--writeDebug(dump(effect[5]))
		if i ~= "fat" and i ~= "thirst" and i ~= "sleep" and i ~= "drinks_for_energy_usage" and i ~= "substances_for_energy_usage" then
			if global.effects[index][i][3] - 60 > 0 then
				global.effects[index][i][3] = global.effects[index][i][3] - 60
			end
			--writeDebug(global.effects[index][i][3])
			if effect[5] ~= nil then
				for i5,e5 in pairs(effect[5]) do
					if e5[3] > 0 and e5[3] - 60 > 0 then
						e5[3] = e5[3] - 60
					elseif e5[3] <= -100000 then
					-- TODO skip effect
					else
						e5[3] = 0
						writeDebug("to remove: "..e5[1])
						effects_remove(index, i5, i, e5[2])
					end
				end
			end
		end
		
	end
end
-- calculate effect usages
--@ table contents is:
--@ effect_name_key={item or event, modifier, action time}
function effects_calc_on_tick(index, player)
	
	-- reduce speed when Energy is below 20%
	if global.energy[index] <= global.energy_max[index] * 0.20 then -- energy <= 20%
		effects_add(index, "code_energy_below_20%", {"speed",-0.4,-100000})
	else
		for i,ef in pairs(global.effects[index]["speed"][5]) do
			if ef[1] == "code_thirst_above_20%" then
				effects_remove(index, i,"speed", -0.2)
			end
		end
	end
	
	
	----------------- consider the effect Drinks fullness on the Energy consumption ---------------
	local drinks_for_energy_ussage_modifier = -1 * (settings.global["food-industry-drinks-modifier"].value / 100)
	if global.drinks[index] > 0 then
		if global.effects[index]["drinks_for_energy_usage"] and global.effects[index]["drinks_for_energy_usage"][3] == 0 then
			global.effects[index]["drinks_for_energy_usage"][1] = true
			global.effects[index]["drinks_for_energy_usage"][2] = drinks_for_energy_ussage_modifier
			global.effects[index]["drinks_for_energy_usage"][3] = 1
			global.effects[index]["drinks_for_energy_usage"][5][1]={"code_drinks_above_0",drinks_for_energy_ussage_modifier,60*60}
			if global.fi_energy_ussage_modifier[index] + drinks_for_energy_ussage_modifier > 1 then
				writeDebug("[Debug] Warning: global.fi_energy_ussage_modifier["..index.."] ="..global.fi_energy_ussage_modifier[index]..">1")
				global.fi_energy_ussage_modifier[index] = 0.99
			else
				global.fi_energy_ussage_modifier[index] = global.fi_energy_ussage_modifier[index] + drinks_for_energy_ussage_modifier
			end
		end
		-- disable Thirst
		if global.effects[index]["thirst"][1] then
			--writeDebug("[Debug]: deactivate Thirst.")
			global.effects[index]["thirst"][1] = false
			global.effects[index]["thirst"][2] = 0
			global.effects[index]["thirst"][3] = 14400
		end
	elseif global.drinks[index] <= 0 then
		-- reset effect value
		if global.effects[index]["drinks_for_energy_usage"] and global.effects[index]["drinks_for_energy_usage"][3] == 1 then
			if global.fi_energy_ussage_modifier[index] - drinks_for_energy_ussage_modifier > 1 then
				writeDebug("[Debug] Warning: global.fi_energy_ussage_modifier["..index.."] ="..global.fi_energy_ussage_modifier[index]..">1")
				global.fi_energy_ussage_modifier[index] = 0.99
			else
				global.fi_energy_ussage_modifier[index] = global.fi_energy_ussage_modifier[index] - drinks_for_energy_ussage_modifier
			end
			global.effects[index]["drinks_for_energy_usage"][1] = false
			global.effects[index]["drinks_for_energy_usage"][2] = 0
			global.effects[index]["drinks_for_energy_usage"][3] = 0
			global.effects[index]["drinks_for_energy_usage"][5][1]={"code_drinks_is_0",0,0}
		end

		-- enable predisposition to Thirst
		if not global.effects[index]["thirst"][1] and global.effects[index]["thirst"][2] == 0 and global.effects[index]["thirst"][3] <= 0 then
			--writeDebug("[Debug]: activate Thirst preparation")
			global.effects[index]["thirst"][1] = true
			global.effects[index]["thirst"][2] = 1
			global.effects[index]["thirst"][3] = 21600
		-- enable Thirst
		elseif global.effects[index]["thirst"][1] and global.effects[index]["thirst"][2] == 1 and global.effects[index]["thirst"][3] <= 0 then
			--writeDebug("[Debug]: activate Thirst!")
			global.effects[index]["thirst"][1] = true
			global.effects[index]["thirst"][2] = 2
		end
	end

		-- ----------------------- Thirst effects -------------------------------
	if global.effects[index]["thirst"][1] and global.effects[index]["thirst"][2] == 2 and math.ceil(math.abs(global.effects[index]["thirst"][3])/108000*100) >= 20 then
		-- speed -0.2, crafting -0.2, mining -0.4
		effects_add(index, "code_thirst_above_20%", {"speed",-0.2,-100000})
		effects_add(index, "code_thirst_above_20%", {"crafting",-0.2,-100000})
		effects_add(index, "code_thirst_above_20%", {"mining",-0.4,-100000})
	else
		for i,ef in pairs(global.effects[index]["speed"][5]) do
			if ef[1] == "code_thirst_above_20%" then
				effects_remove(index, i,"speed", -0.2)
			end
		end
		for i,ef in pairs(global.effects[index]["crafting"][5]) do
			if ef[1] == "code_thirst_above_20%" then
				effects_remove(index, i,"crafting", -0.2)
			end
		end
		for i,ef in pairs(global.effects[index]["mining"][5]) do
			if ef[1] == "code_thirst_above_20%" then
				effects_remove(index, i,"mining", -0.4)
			end
		end
	end
	if global.effects[index]["thirst"][1] and global.effects[index]["thirst"][2] == 2 and math.ceil(math.abs(global.effects[index]["thirst"][3])/108000*100) >= 80 then
		-- TODO add when ready - energy_usage +2
		effects_add(index, "code_thirst_above_80%", {"digestion",-0.5,-100000})
	else
		for i,ef in pairs(global.effects[index]["digestion"][5]) do
			if ef[1] == "code_thirst_above_80%" then
				effects_remove(index, i,"digestion", -0.5)
			end
		end
	end


	-- more speed when drinks >= 90%!
	if global.drinks[index] >= global.drinks_max[index] * 0.9 then -- >= 90%
		-- activate speed effect to 0.1
		if global.effects[index]["speed"] and global.effects[index]["speed"][2] >= 0 then
			if table.maxn(global.effects[index]["speed"][5]) > 0 then
				local founded = false
				for i,ef in pairs(global.effects[index]["speed"][5]) do
					if ef[1] == "code_drinks_above_90%" then
						founded = true
					end
				end
				if founded then
					--effects_add_update(index, "code_drinks_above_90%", {"speed",0.1,-100000}, i)
					effects_add(index, "code_drinks_above_90%", {"speed",0.1,-100000})
					--writeDebug("[Debug]: update global.effects["..index.."][speed] by +"..global.effects[index]["speed"][2])
				else
					effects_add_insert(index, "code_drinks_above_90%", {"speed",0.1,-100000})
					--writeDebug("[Debug]: activate global.effects["..index.."][speed] by +"..global.effects[index]["speed"][2])
				end
			else
				effects_add_insert(index, "code_drinks_above_90%", {"speed",0.1,-100000})
				--writeDebug("[Debug]: activate first global.effects["..index.."][speed] by +"..global.effects[index]["speed"][2])
			end
		end
	elseif global.drinks[index] < global.drinks_max[index] * 0.9 then -- >= 90%
		if global.effects[index]["speed"] and global.effects[index]["speed"][2] > 0 then
			for i,ef in pairs(global.effects[index]["speed"][5]) do
				if ef[1] == "code_drinks_above_90%" then
					effects_remove(index, i,"speed", 0.1)
					--writeDebug("[Debug]: deactivate global.effects["..index.."][speed] ="..global.effects[index]["speed"][2])
				end
			end
		end
	end


    ----------------- consider the effect Substances fullness on the Energy consumption ---------------
	substances_for_energy_ussage_modifier = -1 * (settings.global["food-industry-substances-modifier"].value / 100)
	
	-- reduce Energy usage when substances >80% additionaly reduce by 10%
	if global.substances[index]["v"] > 80 and global.substances[index]["m"] > 80 and global.substances[index]["c"] > 80 and global.substances[index]["f"] > 80 then
		if global.effects[index]["substances_for_energy_usage"] and global.effects[index]["substances_for_energy_usage"][3] == 2 then
			global.effects[index]["substances_for_energy_usage"][1] = true
			global.effects[index]["substances_for_energy_usage"][2] = substances_for_energy_ussage_modifier - 0.1
			global.effects[index]["substances_for_energy_usage"][3]= 3
			global.effects[index]["substances_for_energy_usage"][5][1]={"code_vmcf_above_80%",substances_for_energy_ussage_modifier - 0.1,60*60}
			if global.fi_energy_ussage_modifier[index] - 0.1 > 1 then
				writeDebug("[Debug] Warning: global.fi_energy_ussage_modifier["..index.."] ="..global.fi_energy_ussage_modifier[index]..">1")
				global.fi_energy_ussage_modifier[index] = 0.99
			else
				global.fi_energy_ussage_modifier[index] = global.fi_energy_ussage_modifier[index] - 0.1
			end
		end
	-- reduce Energy usage when substances >50% additionaly reduce by 10%
	elseif global.substances[index]["v"] > 50 and global.substances[index]["m"] > 50 and global.substances[index]["c"] > 50 and global.substances[index]["f"] > 50 then
		if global.effects[index]["substances_for_energy_usage"] and global.effects[index]["substances_for_energy_usage"][3] == 1 then
			global.effects[index]["substances_for_energy_usage"][1] = true
			global.effects[index]["substances_for_energy_usage"][2] = substances_for_energy_ussage_modifier - 0.1
			global.effects[index]["substances_for_energy_usage"][3] = 2
			global.effects[index]["substances_for_energy_usage"][5][1]={"code_vmcf_above_50%",substances_for_energy_ussage_modifier - 0.1,60*60}
			if global.fi_energy_ussage_modifier[index] - 0.1 > 1 then
				writeDebug("[Debug] Warning: global.fi_energy_ussage_modifier["..index.."] ="..global.fi_energy_ussage_modifier[index]..">1")
				global.fi_energy_ussage_modifier[index] = 0.99
			else
				global.fi_energy_ussage_modifier[index] = global.fi_energy_ussage_modifier[index] - 0.1
			end
		end
	elseif (global.substances[index]["v"] * global.substances[index]["m"] * global.substances[index]["c"] * global.substances[index]["f"] > 0) then
		if global.effects[index]["substances_for_energy_usage"] and global.effects[index]["substances_for_energy_usage"][3] == 0 then
			global.effects[index]["substances_for_energy_usage"][1] = true
			global.effects[index]["substances_for_energy_usage"][2] = substances_for_energy_ussage_modifier
			global.effects[index]["substances_for_energy_usage"][3] = 1
			global.effects[index]["substances_for_energy_usage"][5][1]={"code_vmcf_above_0",substances_for_energy_ussage_modifier,60*60}
			if global.fi_energy_ussage_modifier[index] + substances_for_energy_ussage_modifier > 1 then
				writeDebug("[Debug] Warning: global.fi_energy_ussage_modifier["..index.."] ="..global.fi_energy_ussage_modifier[index]..">1")
				global.fi_energy_ussage_modifier[index] = 0.99
			else
				global.fi_energy_ussage_modifier[index] = global.fi_energy_ussage_modifier[index] + substances_for_energy_ussage_modifier
			end
		end
	elseif (global.substances[index]["v"] * global.substances[index]["m"] * global.substances[index]["c"] * global.substances[index]["f"] <= 0) then
		-- reset effect value
		if global.effects[index]["substances_for_energy_usage"] and global.effects[index]["substances_for_energy_usage"][3] == 1 then
			if global.fi_energy_ussage_modifier[index] - substances_for_energy_ussage_modifier > 1 then
				writeDebug("[Debug] Warning: global.fi_energy_ussage_modifier["..index.."] ="..global.fi_energy_ussage_modifier[index]..">1")
				global.fi_energy_ussage_modifier[index] = 0.99
			else
				global.fi_energy_ussage_modifier[index] = global.fi_energy_ussage_modifier[index] - substances_for_energy_ussage_modifier
			end
			global.effects[index]["substances_for_energy_usage"][1] = false
			global.effects[index]["substances_for_energy_usage"][2] = 0
			global.effects[index]["substances_for_energy_usage"][3] = 0
			global.effects[index]["substances_for_energy_usage"][5][1] = {"code_vmcf_is_0",0,0}
		elseif global.effects[index]["substances_for_energy_usage"] and global.effects[index]["substances_for_energy_usage"][3] == 2 then
			if global.fi_energy_ussage_modifier[index] - substances_for_energy_ussage_modifier+0.1 > 1 then
				writeDebug("[Debug] Warning: global.fi_energy_ussage_modifier["..index.."] ="..global.fi_energy_ussage_modifier[index]..">1")
				global.fi_energy_ussage_modifier[index] = 0.99
			else
				global.fi_energy_ussage_modifier[index] = global.fi_energy_ussage_modifier[index] - substances_for_energy_ussage_modifier+0.1
			end
			global.effects[index]["substances_for_energy_usage"][1] = false
			global.effects[index]["substances_for_energy_usage"][2] = 0
			global.effects[index]["substances_for_energy_usage"][3] = 0
			global.effects[index]["substances_for_energy_usage"][5][1] = {"code_vmcf_is_0",0,0}
		elseif global.effects[index]["substances_for_energy_usage"] and global.effects[index]["substances_for_energy_usage"][3] == 3 then
			if global.fi_energy_ussage_modifier[index] - substances_for_energy_ussage_modifier+0.2 > 1 then
				writeDebug("[Debug] Warning: global.fi_energy_ussage_modifier["..index.."] ="..global.fi_energy_ussage_modifier[index]..">1")
				global.fi_energy_ussage_modifier[index] = 0.99
			else
				global.fi_energy_ussage_modifier[index] = global.fi_energy_ussage_modifier[index] - substances_for_energy_ussage_modifier+0.2
			end
			global.effects[index]["substances_for_energy_usage"][1] = false
			global.effects[index]["substances_for_energy_usage"][2] = 0
			global.effects[index]["substances_for_energy_usage"][3] = 0
			global.effects[index]["substances_for_energy_usage"][5][1] = {"code_vmcf_is_0",0,0}
		end
	end
	--writeDebug("[Debug] global.fi_energy_ussage_modifier["..index.."] ="..global.fi_energy_ussage_modifier[index])
	

	------------------- consider the digestion effect ----------------
	-- check effects substances on digestion speed
	local substances_to_digestion = 0.25
	if math.min(global.substances[index]["v"], global.substances[index]["m"], global.substances[index]["c"], global.substances[index]["f"]) > 30 then
		--writeDebug(" > 10")
		if table.maxn(global.effects[index]["digestion"][5]) == 0 then
			--writeDebug(" == nil")
			-- add substances_to_digestion
			global.effects[index]["digestion"][1] = true
			global.effects[index]["digestion"][2] = global.effects[index]["digestion"][2] + substances_to_digestion
			table.insert(global.effects[index]["digestion"][5], {"code_vmcf_above_40",substances_to_digestion,60*60})
			--global.fi_character_digestion_modifier[index] = global.fi_character_digestion_modifier[index] + substances_to_digestion
		else
			-- check if present digestion effect influenses
			-- check effects substances on digestion speed
			for i,ef in pairs(global.effects[index]["digestion"][5]) do
				--writeDebug(" i "..i..", ef "..ef)
				if not ef == "code_vmcf_above_40" then
					writeDebug(" if not")
					global.effects[index]["digestion"][1] = true
					global.effects[index]["digestion"][2] = global.effects[index]["digestion"][2] + substances_to_digestion
					table.insert(global.effects[index]["digestion"][5], {"code_vmcf_above_40",substances_to_digestion,60*60})
					--global.fi_character_digestion_modifier[index] = global.fi_character_digestion_modifier[index] + substances_to_digestion
				end
			end
		end
		
	elseif math.min(global.substances[index]["v"], global.substances[index]["m"], global.substances[index]["c"], global.substances[index]["f"]) <= 30 then
		--writeDebug(" <= 10")
		if table.maxn(global.effects[index]["digestion"][5]) > 0 then
			for i,ef in pairs(global.effects[index]["digestion"][5]) do
				if ef == "code_vmcf_above_40" then
					global.effects[index]["digestion"][2] = global.effects[index]["digestion"][2] - substances_to_digestion
					table.remove(global.effects[index]["digestion"][5], i)
					--writeDebug(" remove substances_to_digestion")
					-- off digestion effect
					if table.maxn(global.effects[index]["digestion"][5]) == 0 then global.effects[index]["digestion"][1] = false end
				end
			end
		end
	end
	--writeDebug("global.effects[digestion] is:")
	--writeDebug(dump(global.effects[index]["digestion"]))
	
	
	-- TODO make effects: add_more_energy
	-- TODO make effects: add_more_drinks
	-- если в "животе" есть нужный напиток то...

	-- TODO remade effects: Regeneration
	--elseif effect == "Regeneration" then
	--player.character.health = player.character.health + 5


					---------------------- effects assignment -----------------------
					--for effect,t in pairs(global.effects[index]) do
					--	if t > 0 and player.character then
					--		global.effects[index][effect] = t - 5
					--		if effect == "Long reach" then
					--			player.character_build_distance_bonus = 100
					--			player.character_item_drop_distance_bonus = 20
					--			player.character_reach_distance_bonus = 120
					--		elseif effect == "Regeneration" then
					--			player.character.health = player.character.health + 5
					--		elseif effect == "Fast crafting" then
					--			player.character_crafting_speed_modifier = 50
					--		elseif effect == "Fast mining" then
					--			player.character_mining_speed_modifier = 20
					--		elseif effect == "Health buffer" then
					--			if global.effects[index]["Invulnerability"] and global.effects[index]["Invulnerability"] > 0 then
					--				player.character_health_bonus = 9750
					--			else
					--				player.character_health_bonus = 1250
					--			end
					--		end
	
	-- TODO сделать это как негативный эфект
	--		if effect == "Speed" then
	--			if global.energy[index] < global.energy_max[index] * 0.25 then -- if Energy level down below 25% - decrease running speed
	--				player.character_running_speed_modifier = (global.energy[index] - (global.energy_max[index] * 0.2))/global.energy_max[index]
	--			else
	--				player.character_running_speed_modifier = 0
	--			end
	--			if global.effects[index]["Speed"] and global.effects[index]["Speed"] > 0 then
	--				player.character_running_speed_modifier = (player.character_running_speed_modifier+1)*1.75-1
	--			end
	--		end

end


-- TODO make check some achievements function
function achievements_check(index, player)
	--global.fi_achievements[index]["gourmet"]
end


-- TODO make Sleep function
-- start or stop Sleep
function sleep_trg_on_tick(index, player)
	-- размещается в гланом on_tick там где "usage" activity и ставит маркер начала сна:
	
	-- TODO записать у вики: сон начинает считаться между -10 и 0
	if global.usage[index] > 0 and global.usage[index] < -10 then
		if global.effects[index]["sleep"][1] then
			-- сбрасываем значения сна
			global.effects[index]["sleep"][1] = false
			global.effects[index]["sleep"][2] = 0
			global.effects[index]["sleep"][3] = 14400
			global.effects[index]["sleep"][4] = 0
		end
	else
		if not global.effects[index]["sleep"][1] then
			-- включаем подготовку ко сну 1 этап
			global.effects[index]["sleep"][1] = true
			global.effects[index]["sleep"][4] = 1
			global.effects[index]["sleep"][5][1] = {"self_sleep_1", 1, 0, 1}
		end
	end
	
	--writeDebug("sleep is:")
	--writeDebug(dump(global.effects[index]["sleep"]))
end
function sleep_calc_on_tick(index, player)
	-- OPTIMIZE translate coooments
	--@ есть 3 стадии
	--@ 1 этап - подготовка ко сну 4 минуты
	if global.effects[index]["sleep"][1] and global.effects[index]["sleep"][4] == 1 then
		if global.effects[index]["sleep"][3] - 1200 > 0 then
			global.effects[index]["sleep"][3] = global.effects[index]["sleep"][3] - 1200
		else
			global.effects[index]["sleep"][3] = 21600
			global.effects[index]["sleep"][4] = 2
		end
		--@ 6 мин - длится "лекгий сон" = 25% Energy usage
	elseif global.effects[index]["sleep"][1] and global.effects[index]["sleep"][4] == 2 then
		if global.effects[index]["sleep"][3] - 1200 > 0 then
			global.effects[index]["sleep"][3] = global.effects[index]["sleep"][3] - 1200
		--@ итого - прошло 10 мин
		else
			global.effects[index]["sleep"][2] = 0.25
			global.effects[index]["sleep"][3] = 0
			global.effects[index]["sleep"][4] = 3
		end
		--@ затем начинается "глубокий сон" - расход 0%
	elseif global.effects[index]["sleep"][1] and global.effects[index]["sleep"][4] == 3 then
		-- @ global.effects[index]["sleep"] = {0, 14400, false}
		--@ включаем "глубокий сон"
		global.effects[index]["sleep"][2] = 1
		global.effects[index]["sleep"][3] = 0
		global.effects[index]["sleep"][4] = 4
	end

	--writeDebug("sleep is:")
	--writeDebug(dump(global.effects[index]["sleep"]))
end
