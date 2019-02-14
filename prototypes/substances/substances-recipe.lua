require "prototypes.tables.fi-foods-table"
local foods = collect_all_foods_table()


local ingredients = {
	--1						2				3
	--plant					energy/water	result	?
	{"raw-straw",			3.0,			4},		--3.4
	{"straw",				0.2,			0.1},	--0.06
	{"compressed-straw",	15.0,			6},		--3.0
	{"lettuce",				3.0,			6},		--5.4
	{"cucumber",			4.5,			6},		--5.1
	{"tomato",				2.0,			4},		--3.6
	{"potato",				5.0,			8},		--7.0
	{"corn",				4.0,			8},		--7.2
	{"soy",					0.5,			1},		--0.9
	{"rapeseed",			0.4,			0.4}	--0.32
}

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
