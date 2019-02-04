local crops = {
--1			2		3			4		5		6		7			8		9			10		11		12			13
--name, 	time, 	to plant,	plants,	result,	seeds, 	stack size,	plant?,	seed?,	edible?,	straws,	compost,	type
{"lettuce", 300, 	5,        	6,		0.0, 	0.0, 	10,			false,	false,		true,	0.0,	"4J",		""},
{"cucumber",600, 	60,        	4,		2.0, 	8.5, 	10,			true,	true,		true,	1.0,	"8J",		"plant"},
{"tomato", 	800, 	30,        	6,		3.0, 	2.0, 	10,			true,	true,		true,	1.0,	"6J",		"plant"},
{"potato", 	1200, 	8,        	10,		1.0, 	0.0, 	10,			true,	false,		false,	0.0,	"10J",		"plant"},
{"corn", 	1200, 	35,        	4,		2.5, 	4.5, 	10,			true,	true,		true,	3.5,	"10J",		"plant"},
{"soy", 	2400, 	50,        	6,		9.5, 	0.0, 	50,			true,	false,		false,	0.0,	"3J",		"plant"},
{"rapeseed",900, 	90,        	8,		11.5, 	0.0, 	100,		true,	false,		false,	0.0,	"1J",		"plant"},
{"apple", 	1500, 	8,        	9,		6.0, 	2.6, 	10,			true,	true,		true,	0.0,	"3J",		"tree"},
{"orange", 	1300, 	6,        	5,		4.0, 	1.8, 	10,			true,	true,		true,	0.0,	"2J",		"tree"},
}

for index, crop in pairs(crops) do
	local ing = ""
	local str = ""
	if crop[8] then
		str = "-"..crop[13]
		data:extend({
			{
				type = "item",
				name = crop[1].."-"..crop[13],
				icon = "__FoodIndustry__/graphics/icons/items/"..crop[1].."-"..crop[13]..".png",
				icon_size = 32,
				flags = {"goes-to-main-inventory"},
				subgroup = crop[1],
				order = "w-d-"..index.."-y",
				stack_size = 10
			},
			{
				type = "recipe",
				name = crop[1],
				order = "w-d-b-x",
				enabled = true,
				icon = "__FoodIndustry__/graphics/icons/items/"..crop[1]..".png",
				icon_size = 32,
				category = "crafting",
				subgroup = crop[1],
				energy_required = 2.0,
				ingredients =
				{
					{crop[1].."-"..crop[13], 1}
				},
				  results = 
				{
					{type = "item", name = crop[1], amount_min = math.floor(crop[5]-0.4), amount_max = math.floor(crop[5]+1.4)},
					{type = "item", name = "raw-straw", amount = 3, probability = 0.8},
					{type = "item", name = "straw", amount_min = 1, amount_max = 2},
				}
			},
		})	
	end
	if crop[9] then
		ing = "-seeds"
		data:extend({		
			{
				type = "item",
				name = crop[1].."-seeds",
				icon = "__FoodIndustry__/graphics/icons/items/"..crop[1].."-seeds.png",
				icon_size = 32,
				flags = {"goes-to-main-inventory"},
				subgroup = crop[1],
				order = "w-d-"..index.."-z",
				stack_size = 100
			},
			{
				type = "recipe",
				name = crop[1].."-seeds",
				order = "w-d-b-y",
				enabled = true,
				icon = "__FoodIndustry__/graphics/icons/items/"..crop[1].."-seeds.png",
				icon_size = 32,
				category = "crafting",
				subgroup = crop[1],
				energy_required = 0.75,
				ingredients =
				{
					{crop[1], 1}
				},
				  results = 
				{
					{type = "item", name = crop[1].."-seeds", amount_min = math.floor(crop[6]-0.4), amount_max = math.floor(crop[6]+1.4)},
					{type = "item", name = "raw-straw", amount = 1, probability = 0.75},
					{type = "item", name = "straw", amount_min = crop[11]*1, amount_max = crop[11]*2},
				}
			},
		})	
	end
	if crop[10] then
		data:extend({
			{
				type = "capsule",
				name = crop[1],
				icon = "__FoodIndustry__/graphics/icons/items/"..crop[1]..".png",
				icon_size = 32,
				flags = {"goes-to-main-inventory"},
				subgroup = crop[1],
				order = "w-d-"..index.."-x",
				stack_size = crop[7],
				capsule_action = {
					attack_parameters = {
						ammo_category = "capsule",
						ammo_type = {
							action = {
								action_delivery = {
									target_effects = {
										damage = {
											amount = 0,
											type = "physical"
										},
										type = "damage"
									},
									type = "instant"
								},
								type = "direct"
							},
							category = "capsule",
							target_type = "position"
						},
						cooldown = 30,
						range = 0,
						type = "projectile"
					},
					type = "use-on-self"
				},
				fuel_category = "plant",
				fuel_value = crop[12],
			},
		})
	else
		data:extend({
			{
				type = "item",
				name = crop[1],
				icon = "__FoodIndustry__/graphics/icons/items/"..crop[1]..".png",
				icon_size = 32,
				flags = {"goes-to-main-inventory"},
				subgroup = crop[1],
				order = "w-d-"..index.."-x",
				stack_size = crop[7],
				fuel_category = "plant",
				fuel_value = crop[12],
			},
		})
		
	end

	data:extend({
		{
			type = "item-subgroup",
			name = crop[1],
			group = "food-industry",
			order = "w-d-"..index,
		},
	})
	if crop[4] > 0 then
		data:extend({
			{
				type = "recipe",
				name = crop[1].."-growth",
				order = "w-d-a-a",
				enabled = false,
				icon = "__FoodIndustry__/graphics/icons/items/"..crop[1]..str..".png",
				icon_size = 32,
				category = "basic-crop-growth",
				subgroup = crop[1],
				energy_required = crop[2] / 2,
				ingredients =
				{
					{crop[1]..ing, crop[3] / 2}
				},
				  results =
				{
					{type = "item", name = crop[1]..str, amount_min = crop[4] / 2, amount_max = crop[4]*0.75},
					{type = "item", name = "straw", amount_min = 7, amount_max = 12},
					{type = "item", name = "raw-straw", amount_min = 0, amount_max = 1},
				},
				allow_as_intermediate = false,
			},

			{
				type = "recipe",
				name = crop[1].."-growth-w",
				order = "w-d-a-b",
				enabled = false,
				icon = "__FoodIndustry__/graphics/icons/items/"..crop[1]..str..".png",
				icon_size = 32,
				category = "advanced-crop-growth",
				subgroup = crop[1],
				energy_required = crop[2],
				ingredients =
				{
					{crop[1]..ing, crop[3]},
					{type = "fluid", name = "water", amount = 1000}
				},
				  results =
				{
					{type = "item", name = crop[1]..str, amount_min = crop[4], amount_max = crop[4]*2},
					{type = "item", name = "straw", amount_min = 8, amount_max = 16},
					{type = "item", name = "raw-straw", amount_min = 1, amount_max = 3},
				},
				allow_as_intermediate = false,
			},
			{
				type = "recipe",
				name = crop[1].."-growth-c",
				order = "w-d-a-c",
				enabled = false,
				icon = "__FoodIndustry__/graphics/icons/items/"..crop[1]..str..".png",
				icon_size = 32,
				category = "advanced-crop-growth",
				subgroup = crop[1],
				energy_required = crop[2]*0.9,
				ingredients =
				{
					{crop[1]..ing, crop[3]},
					{type = "fluid", name = "compost-water", amount = 1000},
				},
				  results =
				{
					{type = "item", name = crop[1]..str, amount_min = crop[4]*1.5, amount_max = crop[4]*2.5},
					{type = "item", name = "straw", amount_min = 4, amount_max = 12},
					{type = "item", name = "raw-straw", amount_min = 1, amount_max = 5},
				},
				allow_as_intermediate = false,
			},
			{
				type = "recipe",
				name = crop[1].."-growth-f",
				order = "w-d-a-d",
				enabled = false,
				icon = "__FoodIndustry__/graphics/icons/items/"..crop[1]..str..".png",
				icon_size = 32,
				category = "advanced-crop-growth",
				subgroup = crop[1],
				energy_required = crop[2]*0.625,
				ingredients =
				{
					{crop[1]..ing, crop[3]},
					{type = "fluid", name = "fertilizer-water", amount = 1000}
				},
				  results =
				{
					{type = "item", name = crop[1]..str, amount_min = crop[4]*2, amount_max = crop[4]*3},
					{type = "item", name = "straw", amount_min = 1, amount_max = 4},
					{type = "item", name = "raw-straw", amount_min = 3, amount_max = 7},
				},
				allow_as_intermediate = false,
			},
		})
	end
end

data.raw.recipe["lettuce-growth"].enabled=true
data.raw.recipe["tomato-growth"].enabled=true
data.raw.recipe["cucumber-growth"].enabled=true
