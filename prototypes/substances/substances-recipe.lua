require "prototypes.tables.fi-foods-table"
local foods = collect_all_foods_table()


for index, food in pairs(foods) do

	----------------------- stage 1 of nutrient extraction - only growth items -----------------------
	-- 20% of one max substance is extracted substance, remaining 80% is substances-dust
	-- also 20% of Energy/3 and Drinks/6 is substances-dust, remaining 80% is raw-straw
	local substance_name = ""
	local substance_order = 0
	local substances1_max = 0
	local substancesdust1_val = 0
	local rawstraw1_name = "raw-straw"
	local rawstraw1_val = 0
	local substances_results = {}

	substances1_max = math.max(food[5][1],food[5][2],food[5][3],food[5][4])

	if substances1_max == food[5][1] then
		substance_name = "substance-v"
		substance_order = 1
	elseif substances1_max == food[5][2] then
		substance_name = "substance-m"
		substance_order = 2
	elseif substances1_max == food[5][3] then
		substance_name = "substance-c"
		substance_order = 3
	elseif substances1_max == food[5][4] then
		substance_name = "substance-f"
		substance_order = 4
	end
	if string.match(food[2], "meat") == "meat" or string.match(food[2], "fish") == "fish" then
		rawstraw1_name = "raw-mince"
	end

	if food[3] > food[4] and string.match(food[2], "substances1") == "substances1" then -- make dust
		substancesdust1_val = (food[3] / 3 + food[4] / 6) * 0.2 + substances1_max * 0.8
		rawstraw1_val = (food[3] / 3 + food[4] / 6) * 0.8

		if substances1_max * 0.2 == math.floor(substances1_max * 0.2) then -- integer
			substances_results = 
			{
				{type = "item", name = substance_name, amount = substances1_max * 0.2},
			}
		else --- double
			if substances1_max * 0.2 < 1 then
				substances_results = 
				{
					{type = "item", name = substance_name, amount = 1, probability = tonumber(string.format("%.1f", substances1_max * 0.2)) % 1},
				}
			else
				substances_results = 
				{
					{type = "item", name = substance_name, amount = math.floor(substances1_max * 0.2)},
					{type = "item", name = substance_name, amount = 1, probability = tonumber(string.format("%.1f", substances1_max * 0.2)) % 1},
				}
			end
		end
		if substancesdust1_val == math.floor(substancesdust1_val) then -- integer
			table.insert(substances_results, {type = "item", name = "substances-dust", amount = substancesdust1_val})
		else --- double
			if substancesdust1_val < 1 then
				table.insert(substances_results, {type = "item", name = "substances-dust", amount = 1, probability = substancesdust1_val})
			else
				table.insert(substances_results, {type = "item", name = "substances-dust", amount = math.floor(substancesdust1_val)})
				table.insert(substances_results, {type = "item", name = "substances-dust", amount = 1, probability = tonumber(string.format("%.1f", substancesdust1_val)) % 1})
			end
		end
		if rawstraw1_val == math.floor(rawstraw1_val) then -- integer
			table.insert(substances_results, {type = "item", name = rawstraw1_name, amount = rawstraw1_val})
		else --- double
			if rawstraw1_val < 1 then
				table.insert(substances_results, {type = "item", name = rawstraw1_name, amount = 1, probability = rawstraw1_val})
			else
				table.insert(substances_results, {type = "item", name = rawstraw1_name, amount = math.floor(rawstraw1_val)})
				table.insert(substances_results, {type = "item", name = rawstraw1_name, amount = 1, probability = tonumber(string.format("%.1f", rawstraw1_val)) % 1})
			end
		end

		data:extend({
		{
			type = "recipe",
			--      food-to-substances
			name = food[1].."-to-substances-1",
			enabled = false,
			icon = "__FoodIndustry__/graphics/icons/substances/"..substance_name..".png",
			icon_size = 32,
			category = "cooking",
			subgroup = "foods-substances1",
			order = "w-s1-"..substance_order,
			energy_required = food[6],
			ingredients = {
				--{type = "fluid", name = "compost-water", amount = ingredient[2]*10},
				{ food[1], 1 }
			},
			results = substances_results,
			main_product = substance_name,
			allow_as_intermediate = false,
			allow_intermediate = false,
		},
		
		})
		
		-- add recipe to technology "nutrient-extraction"
		table.insert(data.raw.technology["nutrient-extraction"].effects,{recipe = food[1].."-to-substances-1", type = "unlock-recipe"})
		
	end

	----------------------- stage 2 of nutrient extraction = 60% of two max substances, remaining 40% is substances-dust -----------------------
	-- growth items and simple cooked food
	
	-- TODO make recipes of substances stage 2
	-- с общего меню крафта их скрыть, только с машин
	--	if food[4] < food[3] then -- liquid
		--result = {type = "fluid", name = "compost-water", amount = ingredient[2]*10}
		

	----------------------- stage 3 of nutrient extraction = 100% of all substances (with positive values) -----------------------
	-- all variations of food
	
	-- TODO make recipes of substances stage 3

end


