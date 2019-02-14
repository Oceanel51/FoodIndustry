require "prototypes.tables.fi-foods-table"
local foods = collect_all_foods_table()

--@ stage 1 of nutrient extraction

-- TODO make recipes of substances
for index, food in pairs(foods) do
	local liquid_result = ""

	if food[4] > food[3] then
		liquid_result = ""
	else
		liquid_result = ""
	end
	

	data:extend({
		-- simple substance making 1
		{
			type = "recipe",
			--      food-to-substances
			name = food[1].."-to-substances-1",
			enabled = false,
			icon = "__FoodIndustry__/graphics/icons/items/compost.png",
			icon_size = 32,
			category = "cooking",
			subgroup = "foods-substances",
			energy_required = food[6],
			ingredients = {
				--{type = "fluid", name = "compost-water", amount = ingredient[2]*10},
				{ food[1], 1 }
			},
			results = {
				-- (each substance - math.min(vmcf)) * 0.6
				{type = "item", name = "compost", amount = math.max(ingredient[3],1), probability = math.min(ingredient[3],1)}
			},
		}
	})
end
