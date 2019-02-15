require "prototypes.tables.fi-foods-table"
local foods = collect_all_foods_table()


for index, food in pairs(foods) do

	----------------------- stage 1 of nutrient extraction = 20% of one max substance -----------------------
	-- TODO оставить только growth items
	local substance_type = ""
	local substances_results = {}

	if math.max(food[5][1],food[5][2],food[5][3],food[5][4]) == food[5][1] then
		substance_type = "substance-v"
	elseif math.max(food[5][1],food[5][2],food[5][3],food[5][4]) == food[5][2] then
		substance_type = "substance-m"
	elseif math.max(food[5][1],food[5][2],food[5][3],food[5][4]) == food[5][3] then
		substance_type = "substance-c"
	elseif math.max(food[5][1],food[5][2],food[5][3],food[5][4]) == food[5][4] then
		substance_type = "substance-f"
	end

	if food[3] > food[4] and string.match(food[2], "substance1") == "substance1" then -- dust
		if math.max(food[5][1],food[5][2],food[5][3],food[5][4]) * 0.2 == math.floor(math.max(food[5][1],food[5][2],food[5][3],food[5][4]) * 0.2) then -- integer
			substances_results = 
			{
				{type = "item", name = substance_type, amount = math.max(food[5][1],food[5][2],food[5][3],food[5][4]) * 0.2}
			}
		else --- double
			substances_results = 
			{
				{type = "item", name = substance_type, amount = math.max(food[5][1],food[5][2],food[5][3],food[5][4]) * 0.2},
				{type = "item", name = substance_type, amount = 1, probability = tonumber(string.format("%.1f", math.max(food[5][1],food[5][2],food[5][3],food[5][4]) * 0.2)) % 1}
			}
	
		end

		data:extend({
		{
			type = "recipe",
			--      food-to-substances
			name = food[1].."-to-substances-1",
			enabled = true,
			icon = "__FoodIndustry__/graphics/icons/substances/"..substance_type..".png",
			icon_size = 32,
			category = "cooking",
			subgroup = "foods-substances",
			energy_required = food[6],
			ingredients = {
				--{type = "fluid", name = "compost-water", amount = ingredient[2]*10},
				{ food[1], 1 }
			},
			results = substances_results,
			allow_as_intermediate = false,
			allow_intermediate = false,
		},
		-- TODO тут сразу сделать свою подкатегорию для рецептов
		{
			type = "item-subgroup",
			name = "substance1",
			group = "food-industry-foods",
			order = "w-s-a",
		},
		
		})
		
	end

	----------------------- stage 2 of nutrient extraction = 60% of two max substances -----------------------
	-- TODO make recipes of substances
	-- с общего меню крафта их скрыть, только с машин
	--	if food[4] < food[3] then -- liquid
		--result = {type = "fluid", name = "compost-water", amount = ingredient[2]*10}
		

	----------------------- stage 3 of nutrient extraction = 100% of all positive substances -----------------------

end


