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
                local fullness_diff = (settings.global["food-industry-hunger-speed"].value * (global.fi_character_digestion_modifier[index]+1) / 400 / 4)
                
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
                -- add excess of Drinks to fat_modifier
                if global.drinks[index] + ( food[4] - ( food[4] * 100 / food[6] ) * ( food[6] - fullness_diff ) / 100 ) > global.drinks_max[index] then
                    global.drinks[index] = global.drinks_max[index]
                    -- добавляем излишки Energy к fat только уменьшив в 40 раз
                    global.fi_character_fat_modifier[index] = global.fi_character_fat_modifier[index] + ( food[4] - ( food[4] * 100 / food[6] ) * ( food[6] - fullness_diff ) / 100 ) / 40
                else
                    -- TODO excess -Drinks affect to Thirst x2
                    --@                               thirst %, ticks, bool
                    --@ global.effects[index]["thirst"] = {0, -14400, false}
                    global.drinks[index] = global.drinks[index] + ( food[4] - ( food[4] * 100 / food[6] ) * ( food[6] - fullness_diff ) / 100 )
                end

                -- Substances subtraction and summation or destroy excess of Substances
                if global.substances[index]["v"] + ( food[5][1] - ( food[5][1] * 100 / food[6] ) * ( food[6] - fullness_diff ) / 100 ) > 100 then
                    global.substances[index]["v"] = 100
				elseif global.substances[index]["v"] + ( food[5][1] - ( food[5][1] * 100 / food[6] ) * ( food[6] - fullness_diff ) / 100 ) <= 0 then
                    global.substances[index]["v"] = 0
                else
                    global.substances[index]["v"] = global.substances[index]["v"] + ( food[5][1] - ( food[5][1] * 100 / food[6] ) * ( food[6] - fullness_diff ) / 100 )
                end
                if global.substances[index]["m"] + ( food[5][2] - ( food[5][2] * 100 / food[6] ) * ( food[6] - fullness_diff ) / 100 ) > 100 then
                    global.substances[index]["m"] = 100
				elseif global.substances[index]["m"] + ( food[5][2] - ( food[5][2] * 100 / food[6] ) * ( food[6] - fullness_diff ) / 100 ) <= 0 then
                    global.substances[index]["m"] = 0
                else
                    global.substances[index]["m"] = global.substances[index]["m"] + ( food[5][2] - ( food[5][2] * 100 / food[6] ) * ( food[6] - fullness_diff ) / 100 )
                end
                if global.substances[index]["c"] + ( food[5][3] - ( food[5][3] * 100 / food[6] ) * ( food[6] - fullness_diff ) / 100 ) > 100 then
                    global.substances[index]["c"] = 100
				elseif global.substances[index]["c"] + ( food[5][3] - ( food[5][3] * 100 / food[6] ) * ( food[6] - fullness_diff ) / 100 ) <= 0 then
                    global.substances[index]["c"] = 0
                else
                    global.substances[index]["c"] = global.substances[index]["c"] + ( food[5][3] - ( food[5][3] * 100 / food[6] ) * ( food[6] - fullness_diff ) / 100 )
                end
                if global.substances[index]["f"] + ( food[5][4] - ( food[5][4] * 100 / food[6] ) * ( food[6] - fullness_diff ) / 100 ) > 100 then
                    global.substances[index]["f"] = 100
				elseif global.substances[index]["f"] + ( food[5][4] - ( food[5][4] * 100 / food[6] ) * ( food[6] - fullness_diff ) / 100 ) <= 0 then
                    global.substances[index]["f"] = 0
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
    
    -- TODO добавить к расходу Energy fi_energy_ussage_modifier с учетом sleep
    global.used[index] = global.used[index] + global.usage[index]
	--writeDebug("global.used["..index.."] "..global.used[index])

    --								100%	*		1
    if global.used[index] >= (default_delay * (global.update_delay[index] - (global.fi_energy_ussage_modifier[index]))) then
        global.used[index] = global.used[index] - (default_delay * (global.update_delay[index] - (global.fi_energy_ussage_modifier[index])))
        if global.energy[index] > -50 then
            global.energy[index] = global.energy[index] - 1
            --writeDebug("global.energy["..index.."] "..global.energy[index])
            --writeDebug("global.fi_energy_ussage_modifier["..index.."] "..global.fi_energy_ussage_modifier[index])
        end
        

        -- OPTIMIZE это преобразовать в Effect
        if global.energy[index] < global.energy_max[index] * 0.25 then -- if Energy level down below 25% - decrease running speed
            --player.character_running_speed_modifier = (global.energy[index] - 25)/100
            player.character_running_speed_modifier = (global.energy[index] - (global.energy_max[index] * 0.2))/global.energy_max[index]
        else
            player.character_running_speed_modifier = 0
        end
        if global.effects[index]["Speed"] and global.effects[index]["Speed"] > 0 then
            player.character_running_speed_modifier = (player.character_running_speed_modifier+1)*1.75-1
        end
          
    end

end


-- Drinks usage
function drinks_reduction(index, player)
	local default_delay = 10000 / settings.global["food-industry-hunger-speed"].value -- default 10000 / 100 = 100%
	--writeDebug("default_delay "..default_delay)
	--writeDebug("global.used[index] "..global.used[index])
	--writeDebug("global.update_delay[index] "..global.update_delay[index])
	
	-- TODO проверить работу -Drinks
    global.drinks_used[index] = global.drinks_used[index] + global.usage[index]
	--writeDebug("global.drinks_used[index] "..global.drinks_used[index].." + global.usage"..global.usage[index])
	
	-- drinks ussage в отличии от energy usage не зависит от global.update_delay, который исследуется с помощью technology
	-- зависит только от global.usage.
	-- TODO Но может сделать его постоянным? @medium
    if global.drinks_used[index] >= (default_delay * (1 - global.fi_drinks_ussage_modifier[index])) then
        global.drinks_used[index] = global.drinks_used[index] - (default_delay * (1 - global.fi_drinks_ussage_modifier[index]))
        if global.drinks[index] <= 0 then
            -- TODO Add Thirst effect @high
			-- Thirst preparation (4 min)
			global.drinks[index] = 0
		else
			if global.drinks[index] > -100 then
				global.drinks[index] = global.drinks[index] - 1
				if global.drinks[index] < 0 then
					global.drinks[index] = 0
				end
				--writeDebug("global.drinks[index] "..global.drinks[index])
			end
        end
    end
    
end


-- Substances usage
function substances_reduction(index)

    if global.substances[index]["v"] - 1 >= 0 then
        global.substances[index]["v"] = global.substances[index]["v"] - 1
    else
        global.substances[index]["v"] = 0
    end
    if global.substances[index]["m"] - 1 >= 0 then
        global.substances[index]["m"] = global.substances[index]["m"] - 1
    else
        global.substances[index]["m"] = 0
    end
    if global.substances[index]["c"] - 1 >= 0 then
        global.substances[index]["c"] = global.substances[index]["c"] - 1
    else
        global.substances[index]["c"] = 0
    end
    if global.substances[index]["f"] - 1 >= 0 then
        global.substances[index]["f"] = global.substances[index]["f"] - 1
    else
        global.substances[index]["f"] = 0
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
-- add new effect to table global.effects[index]
function effects_add(index, item_name, effect_data)
	local effect_exist_bool = false
	
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
	--@ global.effects[index]["speed"]	 = {false,	0,	0,}
	--@ global.effects[index]["digestion"]	 = {false,	0,	0,}
	--@	global.effects_active[index] = {
	--@ 														{"simple-speed-capsule",0.3,5400},
	--@ 														{"vmc_above_20",0.2,0},
	--@ 														{"all_substances_above_40",0.4,0},
	--@ 														{"simple-digestive-capsule",0.5,14400},
	--@ 													}

	-- TODO effects_add function: от капсул и еды
	writeDebug(dump(global.effects[index]))
	writeDebug("---------------0")
	--writeDebug(dump(effect_data))
	--writeDebug(item_name)
	
	-- OPTIMIZE find effect key in a table
	for _,ef in pairs(effect_data) do
		--writeDebug(dump(global.effects[index][ef[1]][4]))
		--writeDebug("i "..i..", ef "..dump(ef))
		if table.maxn(global.effects[index][ef[1]][4]) > 0 then
			for i,e in pairs(global.effects[index][ef[1]][4]) do
				if e[1] == item_name then
					-- update effect
					writeDebug("update digestion")
					e[2] = ef[2]
					e[3] = ef[3]
				else
					-- insert effect
					writeDebug("insert digestion")
					table.insert(global.effects[index][ef[1]][4], item_name)
				end
			end
		end
		--writeDebug(table.find(global.effects[index], item_name))
	end

	writeDebug("---------------1")
	writeDebug(dump(global.effects[index]))

		--if table.findTree(global.effects[index], nil, nil, nil, ef[1], true) then
		--	writeDebug("effect exist "..ef[1])
		--end
	
end
-- calculate effect usages
--@ table contents is:
--@ effect_name_key={item or event, modifier, action time}
function effects_calc_on_tick(index, player)
	
	----------------- consider the effect Drinks fullness on the Energy consumption ---------------
	local drinks_for_energy_ussage_modifier = -1 * (settings.global["food-industry-drinks-modifier"].value / 100)
	if global.drinks[index] > 0 then
		if global.effects[index]["drinks_for_energy_usage"] and global.effects[index]["drinks_for_energy_usage"][3] == 0 then
			global.effects[index]["drinks_for_energy_usage"]={true, drinks_for_energy_ussage_modifier, 1, {"Drinks is present"}}
			if global.fi_energy_ussage_modifier[index] + drinks_for_energy_ussage_modifier > 1 then
				writeDebug("[Debug] Warning: global.fi_energy_ussage_modifier["..index.."] ="..global.fi_energy_ussage_modifier[index]..">1")
				global.fi_energy_ussage_modifier[index] = 0.99
			else
				global.fi_energy_ussage_modifier[index] = global.fi_energy_ussage_modifier[index] + drinks_for_energy_ussage_modifier
			end
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
			global.effects[index]["drinks_for_energy_usage"]={false, 0, 0, {"Drinks is present"}}
		end
	end


    ----------------- consider the effect Substances fullness on the Energy consumption ---------------
	--if global.substances[index]["v"] > 50 and global.substances[index]["m"] > 50 and global.substances[index]["c"] > 50 and global.substances[index]["f"] > 50 then
		--writeDebug("[Debug] All Substances > 50%")
		--local subst_min = math.min(global.substances[index]["v"], global.substances[index]["m"], global.substances[index]["c"], global.substances[index]["f"]) - 50
		--local subst_min_d = subst_min * 0.12 / 20
		--substances_for_energy_ussage_modifier = -1 * ((settings.global["food-industry-substances-modifier"].value / 100) + ((math.min(global.substances[index]["v"], global.substances[index]["m"], global.substances[index]["c"], global.substances[index]["f"]) - 50) * 0.12 / 20))
	--else
	substances_for_energy_ussage_modifier = -1 * (settings.global["food-industry-substances-modifier"].value / 100)
	--end
		
	-- reduce Energy usage when substances <80% additionaly for 10%
	if global.substances[index]["v"] > 80 and global.substances[index]["m"] > 80 and global.substances[index]["c"] > 80 and global.substances[index]["f"] > 80 then
		if global.effects[index]["substances_for_energy_usage"] and global.effects[index]["substances_for_energy_usage"][3] == 2 then
			global.effects[index]["substances_for_energy_usage"]={true, substances_for_energy_ussage_modifier-0.1, 3, {"All Substances is > 80%"}}
			if global.fi_energy_ussage_modifier[index] - 0.1 > 1 then
				writeDebug("[Debug] Warning: global.fi_energy_ussage_modifier["..index.."] ="..global.fi_energy_ussage_modifier[index]..">1")
				global.fi_energy_ussage_modifier[index] = 0.99
			else
				global.fi_energy_ussage_modifier[index] = global.fi_energy_ussage_modifier[index] - 0.1
			end
		end
	-- reduce Energy usage when substances <50% additionaly for 10%
	elseif global.substances[index]["v"] > 50 and global.substances[index]["m"] > 50 and global.substances[index]["c"] > 50 and global.substances[index]["f"] > 50 then
		if global.effects[index]["substances_for_energy_usage"] and global.effects[index]["substances_for_energy_usage"][3] == 1 then
			global.effects[index]["substances_for_energy_usage"]={true, substances_for_energy_ussage_modifier-0.1, 2, {"All Substances is > 50%"}}
			if global.fi_energy_ussage_modifier[index] - 0.1 > 1 then
				writeDebug("[Debug] Warning: global.fi_energy_ussage_modifier["..index.."] ="..global.fi_energy_ussage_modifier[index]..">1")
				global.fi_energy_ussage_modifier[index] = 0.99
			else
				global.fi_energy_ussage_modifier[index] = global.fi_energy_ussage_modifier[index] - 0.1
			end
		end
	elseif (global.substances[index]["v"] * global.substances[index]["m"] * global.substances[index]["c"] * global.substances[index]["f"] > 0) then
		if global.effects[index]["substances_for_energy_usage"] and global.effects[index]["substances_for_energy_usage"][3] == 0 then
			global.effects[index]["substances_for_energy_usage"]={true, substances_for_energy_ussage_modifier, 1, {"All Substances is > 0%"}}
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
			global.effects[index]["substances_for_energy_usage"]={false, 0, 0, {"Substances is not present"}}
		elseif global.effects[index]["substances_for_energy_usage"] and global.effects[index]["substances_for_energy_usage"][3] == 2 then
			if global.fi_energy_ussage_modifier[index] - substances_for_energy_ussage_modifier+0.1 > 1 then
				writeDebug("[Debug] Warning: global.fi_energy_ussage_modifier["..index.."] ="..global.fi_energy_ussage_modifier[index]..">1")
				global.fi_energy_ussage_modifier[index] = 0.99
			else
				global.fi_energy_ussage_modifier[index] = global.fi_energy_ussage_modifier[index] - substances_for_energy_ussage_modifier+0.1
			end
			global.effects[index]["substances_for_energy_usage"]={false, 0, 0, {"Substances is not present"}}
		elseif global.effects[index]["substances_for_energy_usage"] and global.effects[index]["substances_for_energy_usage"][3] == 3 then
			if global.fi_energy_ussage_modifier[index] - substances_for_energy_ussage_modifier+0.2 > 1 then
				writeDebug("[Debug] Warning: global.fi_energy_ussage_modifier["..index.."] ="..global.fi_energy_ussage_modifier[index]..">1")
				global.fi_energy_ussage_modifier[index] = 0.99
			else
				global.fi_energy_ussage_modifier[index] = global.fi_energy_ussage_modifier[index] - substances_for_energy_ussage_modifier+0.2
			end
			global.effects[index]["substances_for_energy_usage"]={false, 0, 0, {"Substances is not present"}}
		end
	end
	--writeDebug("[Debug] global.fi_energy_ussage_modifier["..index.."] ="..global.fi_energy_ussage_modifier[index])
	

	------------------- consider the digestion effect ----------------
	-- check effects substances on digestion speed
	local substances_to_digestion = 0.4
	if math.min(global.substances[index]["v"], global.substances[index]["m"], global.substances[index]["c"], global.substances[index]["f"]) > 10 then
		--local tf = table.find(global.effects[index]["digestion"][4], "vmcf_above_40")
		--writeDebug("tf "..tf)
		writeDebug(" > 10")
		if table.maxn(global.effects[index]["digestion"][4]) == 0 then
			writeDebug(" == nil")
			-- add substances_to_digestion
			global.effects[index]["digestion"][1] = true
			global.effects[index]["digestion"][2] = global.effects[index]["digestion"][2] + substances_to_digestion
			table.insert(global.effects[index]["digestion"][4], "vmcf_above_40")
			global.fi_character_digestion_modifier[index] = global.fi_character_digestion_modifier[index] + substances_to_digestion
		else
			-- check if present digestion effect influenses
			-- check effects substances on digestion speed
			for i,ef in pairs(global.effects[index]["digestion"][4]) do
				writeDebug(" i "..i..", ef "..ef)
				if not ef == "vmcf_above_40" then
					writeDebug(" if not")
					global.effects[index]["digestion"][1] = true
					global.effects[index]["digestion"][2] = global.effects[index]["digestion"][2] + substances_to_digestion
					table.insert(global.effects[index]["digestion"][4], "vmcf_above_40")
					global.fi_character_digestion_modifier[index] = global.fi_character_digestion_modifier[index] + substances_to_digestion
				end
			end
		end
		
	elseif math.min(global.substances[index]["v"], global.substances[index]["m"], global.substances[index]["c"], global.substances[index]["f"]) <= 0 then
		writeDebug(" <= 10")
		if table.maxn(global.effects[index]["digestion"][4]) > 0 then
			for i,ef in pairs(global.effects[index]["digestion"][4]) do
				if ef == "vmcf_above_40" then
					global.effects[index]["digestion"][2] = global.effects[index]["digestion"][2] - substances_to_digestion
					table.remove(global.effects[index]["digestion"][4], i)
					writeDebug(" remove substances_to_digestion")
					-- off digestion effect
					if table.maxn(global.effects[index]["digestion"][4]) == 0 then global.effects[index]["digestion"][1] = false end
				end
			end
		end
	end
	writeDebug(dump(global.effects[index]["digestion"]))
	
	-- TODO make digestion effect
	if table.maxn(global.effects[index]["digestion"][4]) > 0 then
		
	end
	


	-- TODO remade effects: Long reach, Speed, Fast crafting, Fast mining
	-- TODO remade effects: Regeneration, Health buffer, Invulnerability
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
					--	elseif t == 0 and player.character then
					--		global.effects[index][effect] = -1
					--		if effect == "Long reach" then
					--			player.character_build_distance_bonus = 0
					--			player.character_item_drop_distance_bonus = 0
					--			player.character_reach_distance_bonus = 0
					--		elseif effect == "Fast crafting" then
					--			player.character_crafting_speed_modifier = 0
					--		elseif effect == "Fast mining" then
					--			player.character_mining_speed_modifier = 0
					--		elseif effect == "Invulnerability" then
					--			if global.effects[index]["Health buffer"] and global.effects[index]["Health buffer"] > 0 then
					--				player.character_health_bonus = 1250
					--			else
					--				player.character_health_bonus = 0
					--			end
					--		elseif effect == "Health buffer" then
					--			if global.effects[index]["Invulnerability"] and global.effects[index]["Invulnerability"] > 0 then
					--				player.character_health_bonus = 9750
					--			else
					--				player.character_health_bonus = 0
					--			end
					--		elseif effect == "Speed" then
					--			if global.energy[index] < global.energy_max[index] * 0.25 then -- if Energy level down below 25% - decrease running speed
					--				player.character_running_speed_modifier = (global.energy[index] - (global.energy_max[index] * 0.2))/global.energy_max[index]
					--			else
					--				player.character_running_speed_modifier = 0
					--			end
					--			if global.effects[index]["Speed"] and global.effects[index]["Speed"] > 0 then
					--				player.character_running_speed_modifier = (player.character_running_speed_modifier+1)*1.75-1
					--			end
					--		end
					--	end
					--end
    
end


-- TODO make Sleep function
function sleep_trg_on_tick(index, player)
	-- размещается в гланом on_tick там где бег и ставит маркер начала сна:
	if not global.effects[index]["sleep"][1] then
		-- включаем подготовку ко сну 1 этап
		global.effects[index]["sleep"][1] = true
		global.effects[index]["sleep"][3] = 1
	end
	writeDebug(dump(global.effects[index]["sleep"]))
end
function sleep_calc_on_tick(index, player)
	-- OPTIMIZE translate coooments
	--@ есть 3 стадии
	--@ 1 этап - подготовка ко сну 4 минуты
	if global.effects[index]["sleep"][1] and global.effects[index]["sleep"][3] == 1 then
		if global.effects[index]["sleep"][2] + 1200 > 0 then
			global.effects[index]["sleep"][2] = global.effects[index]["sleep"][2] + 1200
		else
			global.effects[index]["sleep"][3] = 2
			global.effects[index]["sleep"][2] = -21600
		end
	--@ 6 мин - длится "лекгий сон" = 25% Energy usage
	elseif global.effects[index]["sleep"][1] and global.effects[index]["sleep"][3] == 2 then
		if global.effects[index]["sleep"][2] + 1200 > 0 then
			global.effects[index]["sleep"][2] = global.effects[index]["sleep"][2] + 1200
		--@ итого - прошло 10 мин
		else
			global.effects[index]["sleep"][3] = 3
			global.effects[index]["sleep"][2] = 0
		end
	--@ затем начинается "глубокий сон" - расход 0%
	elseif global.effects[index]["sleep"][1] and global.effects[index]["sleep"][3] == 3 then
		-- @ global.effects[index]["sleep"] = {0, -14400, false}
	end
	writeDebug(dump(global.effects[index]["sleep"]))
end
