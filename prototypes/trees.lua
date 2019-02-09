local trees = {
--1			2		3			4		5		6		7			8		9			10		11		12			13			14				15		16		17		18
--name, 	time, 	to plant,	plants,	result,	seeds, 	stack size,	plant?,	seed?,	edible?,	straws,	compost,	type,	debug color,	starting,	size,	result,	change
{"apple", 	1500, 	8,        	9,		6.0, 	2.6, 	10,			true,	true,		true,	0.0,	"3J",		"tree", {r=1,g=0.2,b=0},	20,		1.2,	5,		0.25},
{"orange", 	1300, 	6,        	5,		4.0, 	1.8, 	10,			true,	true,		true,	0.0,	"2J",		"tree", {r=0.6,g=0.6,b=0},	20,		0.75,	4,		0.12},
}

for index, crop in pairs(trees) do
		data:extend({
			-- Fruits
			{
				type = "item",
				name = crop[1].."-"..crop[13],
				icon = "__FoodIndustry__/graphics/icons/items/"..crop[1].."-"..crop[13]..".png",
				icon_size = 32,
				flags = {"goes-to-main-inventory"},
				subgroup = crop[1],
				order = "a",
				stack_size = 10
			},
			-- Fruit seeds recipe
			{
				type = "recipe",
				name = crop[1].."-pick",
				order = "w-d-b-y",
				enabled = true,
				icon = "__FoodIndustry__/graphics/icons/items/"..crop[1]..".png",
				icon_size = 32,
				category = "crafting",
				subgroup = crop[1],
				energy_required = 0.75,
				hidden=true,
				ingredients =
				{
				},
				results =
				{
					{type = "item", name = crop[1], amount_min = 1, amount_max = 2}
				}
			},

		})
		data:extend({
			-- Fruit seeds
			{
				type = "item",
				name = crop[1].."-seeds",
				icon = "__FoodIndustry__/graphics/icons/items/"..crop[1].."-seeds.png",
				icon_size = 32,
				flags = {"goes-to-main-inventory"},
				subgroup = crop[1],
				order = "a",
				stack_size = 100
			},
			-- Fruit seeds recipe
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
					{type = "item", name = crop[1].."-seeds", amount_min = math.floor(crop[6]-0.4), amount_max = math.floor(crop[6]+1.4)}
				}
			},
		})	
		data:extend({
			-- Fruit as food
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

	data:extend({
		{
			type = "item-subgroup",
			name = crop[1],
			group = "food-industry",
			order = "w-d-"..index,
		},
	})
	data:extend({

		-- seedlings
		-- seedling item
		---- Seedling
			{
				type = "item",
				name = crop[1].."-seedling",
				icon = "__FoodIndustry__/graphics/entity/trees/"..crop[1].."-Seedling.png",
				icon_size = 32,
				flags = {"goes-to-main-inventory"},
				subgroup = crop[1],
				order = "b",
				place_result=crop[1].."-seedling",
				fuel_value = "1MJ",
				fuel_category = "chemical",
				stack_size= 400
			},

		-- seedling entity
			{
				type = "land-mine",
				name = crop[1].."-seedling",
				icon = "__FoodIndustry__/graphics/entity/trees/"..crop[1].."-Seedling.png",
				icon_size = 32,
				order = "b",
				flags = {"placeable-neutral", "placeable-player", "player-creation", "breaths-air",},
				minable =
				{
					mining_particle = "wooden-particle",
					mining_time = 0.25,
					result = crop[1].."-seedling",
					count = 1
				},
				emissions_per_tick = -0.0006,
				max_health = 5,
				collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
				selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
				subgroup = "intermediate-product",
				vehicle_impact_sound = { filename = "__base__/sound/car-wood-impact.ogg", volume = 1.0 },
				picture_safe =
				{
					filename = "__FoodIndustry__/graphics/entity/trees/"..crop[1].."-Seedling_a.png",
					priority = "extra-high",
					width = 32,
					height = 32,
				},
				picture_set =
				{
					filename = "__FoodIndustry__/graphics/entity/trees/"..crop[1].."-Seedling_b.png",
					priority = "extra-high",
					width = 32,
					height = 32,
				},
				trigger_radius = 0,
			},

		-- seedling recipe
			{
				type = "recipe",
				name = crop[1].."-seedling",
				icon = "__FoodIndustry__/graphics/entity/trees/"..crop[1].."-Seedling.png",
				icon_size = 32,
				category = "fi-mod-tree-greenhouse",
				energy_required = 50,
				ingredients =
				{
					{type="item", name=crop[1].."-seeds", amount=5},
				},
				results=
				{
					{type="item", name=crop[1].."-seedling", amount=5},
				},
				enabled = false,
				always_show_made_in = true,
				allow_decomposition = false,
			},
		})

	data:extend({
		{
			type = "tree",
			name = crop[1].."-tree",
			order = "w",
			collision_box = {{-0.2,-0.2},{0.2,0.2}},
			collision_mask = {"item-layer", "object-layer", "water-tile"},
			darkness_of_burnt_tree = 0.5,
			emissions_per_tick = -0.001,
			flags = {
				"placeable-neutral",
				"placeable-off-grid",
				"breaths-air",
				"placeable-player",
				"player-creation"
			},
			icon = "__FoodIndustry__/graphics/icons/items/"..crop[1].."-tree.png",
			icon_size = 32,
			max_health = 5,
			minable = {
				count = crop[17],
				mining_hardness = 0.1,
				mining_time = 0.5,
				results = {
					{type = "item", name = "raw-wood", amount = 5 },
					{type = "item", name = "raw-straw", amount = 3, probability = 0.8},
					{type = "item", name = crop[1], amount = 1, probability = crop[18] }
				},
			},
			selection_box = {
				{
					-0.4,
					-0.4
				},
				{
					0.4,
					0.4
				}
			},
			subgroup = "trees",
			pictures = {
				{
					filename = "__FoodIndustry__/graphics/entity/trees/"..crop[1]..".png",
					priority = "high",
					width = 256,
					height = 256,
					scale = crop[16],
					shift = {0.0, 0.0},
				}
			},
			map_color = {r=0.1, g= 0.7, b=0}--[[crop[4]],
		},

		{
			type = "tree",
			name = crop[1].."-wild-tree",
			order = "w",
			autoplace = {
				control = "food-plant",
				max_probability = 0.006,
				coverage = 0.0003,
				order = "c",
				peaks = {
					{
						noise_layer = "wild-"..crop[1],
						noise_octaves_difference = -0.85,
						noise_persistence = 0.4
					}
				},
				sharpness = 0.9375,
				starting_area_amount = 1600,
				starting_area_size = crop[15]
			},
			collision_box = {{-0.2,-0.2},{0.2,0.2}},
			collision_mask = {"item-layer", "object-layer", "water-tile"},
			darkness_of_burnt_tree = 0.5,
			emissions_per_tick = -0.001,
			flags = {
				"placeable-neutral",
				"placeable-off-grid",
				"breaths-air"
			},
			icon = "__FoodIndustry__/graphics/icons/items/"..crop[1].."-tree.png",
			icon_size = 32,
			max_health = 5,
			healing_per_tick = 0,
			repair_speed_modifier = 0,
			minable = {
				count = crop[17],
				mining_hardness = 0.1,
				mining_time = 0.5,
				results = {
					{type = "item", name = "raw-wood", amount = 5 },
					{type = "item", name = "raw-straw", amount = 3, probability = 0.8},
					{type = "item", name = crop[1], amount = 1, probability = crop[18] }
				},
			},
			selection_box = {
				{
					-0.4,
					-0.4
				},
				{
					0.4,
					0.4
				}
			},
			subgroup = "trees",
			pictures = {
				{
					filename = "__FoodIndustry__/graphics/entity/trees/"..crop[1]..".png",
					priority = "high",
					width = 256,
					height = 256,
					scale = crop[16],
					shift = {0.0, 0.0},
				}
			},
			map_color = {r=0.1, g= 0.7, b=0}--[[crop[4]],
		},

		{
			type = "noise-layer",
			name = "wild-"..crop[1]
		}
	})
end

