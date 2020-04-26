local trees = {
--1			2		3			4		5			6		7			8		9			10		11		12			13			14				15			16		17		18
--name, 	time, 	to plant,	plants,	cool(sec),	seeds, 	stack size,	plant?,	seed?,	edible?,	straws,	compost,	type,	debug map color,	starting,	size,	result,	chance
{"apple", 	1300, 	5,			4,		0.1,		3.4, 	10,			true,	true,		true,	3.0,	"3J",		"tree", {r=1,g=0.2,b=0},	20,			0.16,	6,		0.25},
{"orange", 	1570, 	8,			5,		0.3,		2.6, 	10,			true,	true,		true,	5.0,	"2J",		"tree", {r=0.6,g=0.6,b=0},	15,			0.16,	4,		0.12},
}

for index, crop in pairs(trees) do
	data:extend({
		-- Fruits
		{
			type = "item",
			name = crop[1].."-"..crop[13],
			icon = "__FoodIndustry__/graphics/icons/trees/"..crop[1].."-"..crop[13]..".png",
			icon_size = 32,

			subgroup = crop[1],
			order = "w-e-"..index.."-y",
			stack_size = 10
		},
		-- recipe when click on -fertile-tree
		{
			type = "recipe",
			name = crop[1].."-pick",
			subgroup = crop[1],
			order = "w-e-b-y",
			enabled = false,
			icon = "__FoodIndustry__/graphics/icons/foods/"..crop[1]..".png",
			icon_size = 32,
			category = "crafting",
			energy_required = 0.75,
			hidden = true,
			ingredients =
			{
			},
			results =
			{
				{type = "item", name = "wood", amount = 1, probability = 0.15},
				{type = "item", name = "raw-straw", amount = 1, probability = 0.5},
				--{type = "item", name = crop[1], amount_min = 1, amount_max = 2}
				{type = "item", name = crop[1], amount = 1, probability = math.floor(crop[18])}
			}
		},
	})

	-- Fruit seeds item, recipe
	data:extend({
		{
			type = "item",
			name = crop[1].."-seeds",
			icon = "__FoodIndustry__/graphics/icons/trees/"..crop[1].."-seeds.png",
			icon_size = 32,

			subgroup = crop[1],
			order = "w-e-"..index.."-y",
			stack_size = 100
		},
		-- Fruit seeds recipe
		{
			type = "recipe",
			name = crop[1].."-seeds",
			order = "w-e-b-y",
			enabled = true,
			icon = "__FoodIndustry__/graphics/icons/trees/"..crop[1].."-seeds.png",
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


	-- Fruit capsule (as food)
	data:extend({
		{
			type = "capsule",
			name = crop[1],
			icon = "__FoodIndustry__/graphics/icons/foods/"..crop[1]..".png",
			icon_size = 32,

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
					cooldown = crop[5]*60,
					range = 0,
					type = "projectile"
				},
				type = "use-on-self"
			},
			fuel_category = "plant",
			fuel_value = crop[12],
		},
	})

	-- item subgroup
	data:extend({
		{
			type = "item-subgroup",
			name = crop[1],
			group = "food-industry-foods",
			order = "w-f-"..index,
		},
	})

	-- seedlings
	data:extend({

		-- seedlings
		-- seedling item
		---- Seedling
		{
			type = "item",
			name = crop[1].."-seedling",
			icon = "__FoodIndustry__/graphics/icons/trees/"..crop[1].."-seedling-icon.png",
			icon_size = 32,

			subgroup = crop[1],
			order = "b",
			place_result=crop[1].."-seedling",
			fuel_value = "1MJ",
			fuel_category = "chemical",
			stack_size= 400
		},

		 --seedling entity
		{
			type = "land-mine",
			name = crop[1].."-seedling",
			icon = "__FoodIndustry__/graphics/icons/trees/"..crop[1].."-seedling-icon.png",
			icon_size = 32,
			order = "b",
			flags = {"placeable-neutral", "placeable-player", "player-creation", "breaths-air",},
			minable =
			{
				mining_particle = "wooden-particle",
				mining_time = 0.45,
				result = crop[1].."-seedling",
				count = 1
			},
			emissions_per_second = -0.0006 * 60,
			max_health = 40,
			collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
			selection_box = {{-0.35, -0.35}, {0.35, 0.35}},
			subgroup = "intermediate-product",
			vehicle_impact_sound = { filename = "__base__/sound/car-wood-impact.ogg", volume = 1.0 },
			picture_safe =
			{
				filename = "__FoodIndustry__/graphics/entity/trees/"..crop[1].."-seedling_safe.png",
				priority = "extra-high",
				width = 64,
				height = 52,
				--size = 0.8,
				shift = {0.39, -0.662},
			},
			picture_set =
			{
				filename = "__FoodIndustry__/graphics/entity/trees/"..crop[1].."-seedling.png",
				priority = "extra-high",
				width = 64, -- TODO check sizes
				height = 52,
				--size = 0.8,
				shift = {0.39, -0.662},
			},
			trigger_radius = 0,
		},

		-- basic seedling growing recipe
		{
			type = "recipe",
			name = crop[1].."-growth-seedling",
			order = "w-d-a-a",
			enabled = false,
			icon = "__FoodIndustry__/graphics/icons/trees/"..crop[1].."-seedling-icon.png",
			icon_size = 32,
			category = "basic-crop-growth",
			subgroup = crop[1],
			energy_required = crop[2],
			ingredients =
			{
				{type="item", name=crop[1].."-seeds", amount=crop[3]},
			},
			  results = 
			{
				{type="item", name=crop[1].."-seedling", amount=1, probability = 0.35},
				{type="item", name=crop[1].."-seedling", amount=1, probability = 0.35},
				{type="item", name=crop[1].."-seedling", amount=1, probability = 0.35},
				{type = "item", name = "straw", amount_min = crop[11]*9, amount_max = crop[11]*17},
				{type = "item", name = "raw-straw", amount_min = crop[11]*2.8, amount_max = crop[11]*4.2},
			},
			allow_as_intermediate = false,
		},	
		table.insert(data.raw.technology["trees-growth-1"].effects,{recipe = crop[1].."-growth-seedling", type = "unlock-recipe"})
	})

	data:extend({
		-- seedling recipe
		{
			type = "recipe",
			name = crop[1].."-basic-growth-seedling",
			icon = "__FoodIndustry__/graphics/icons/trees/"..crop[1].."-seedling-icon.png",
			icon_size = 32,
			category = "basic-tree-growth",
			subgroup = crop[1],
			energy_required = crop[2] / 1.8,
			ingredients =
			{
				{type="item", name=crop[1].."-seeds", amount=crop[3]},
				{type = "fluid", name = "water", amount = 300},
			},
			results=
			{
				{type="item", name=crop[1].."-seedling", amount=crop[4]-2},
				{type="item", name=crop[1].."-seedling", amount=1, probability=0.4},
			},
			enabled = false,
			always_show_made_in = true,
			allow_decomposition = false,
		},
		{
			type = "recipe",
			name = crop[1].."-advanced-growth-seedling",
			icon = "__FoodIndustry__/graphics/icons/trees/"..crop[1].."-seedling-icon.png",
			icon_size = 32,
			category = "advanced-tree-growth",
			subgroup = crop[1],
			energy_required = crop[2] / 1.8,
			ingredients =
			{
				{type="item", name=crop[1].."-seeds", amount=crop[3]},
				{type = "fluid", name = "compost-water", amount = 1000},
			},
			results=
			{
				{type="item", name=crop[1].."-seedling", amount=crop[4]+2},
				{type="item", name=crop[1].."-seedling", amount=1, probability=0.4},
				{type="item", name=crop[1].."-seedling", amount=1, probability=0.4},
				{type="item", name=crop[1].."-seedling", amount=1, probability=0.4},
			},
			enabled = false,
			always_show_made_in = true,
			allow_decomposition = false,
		},
		
	})

	-- trees
	data:extend({
		{
			type = "tree",
			name = crop[1].."-tree",
			order = "w",
			collision_box = {{-0.2,-0.2},{0.2,0.2}},
			collision_mask = {"item-layer", "object-layer", "water-tile", "player-layer"},
			darkness_of_burnt_tree = 0.5,
			emissions_per_second = -0.001 * 60,
			flags = {
				"placeable-neutral",
				"placeable-off-grid",
				"breaths-air",
				"placeable-player",
				"player-creation"
			},
			icon = "__FoodIndustry__/graphics/icons/trees/"..crop[1].."-tree.png",
			icon_size = 32,
			max_health = 150,
			healing_per_tick = 0,
			repair_speed_modifier = 0,
			minable = {
				mining_particle = "wooden-particle",
				mining_hardness = 1,
				mining_time = 2.5,
				count = crop[17],
				results = {
					{type = "item", name = "wood", amount_min = 8, amount_max = 15},
					{type = "item", name = "raw-straw", amount = 3, probability = 0.8},
					{type = "item", name = crop[1], amount_min = math.floor(crop[17]), amount_max = math.floor(crop[17]*2.2) }
				},
			},
			selection_box = { { -0.4, -0.4 }, { 0.4, 0.4 } },
			subgroup = "trees",
			pictures = {
				{
					filename = "__FoodIndustry__/graphics/entity/trees/"..crop[1].."-fertile-tree.png",
					priority = "high",
					width = 945,
					height = 771,
					scale = crop[16],
					shift = {0.89, -1.71},
				}
			},
			map_color={r=1, g=0.533333333, b=0},
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
			collision_box = {{-0.2, -0.2}, {0.2, 0.2}},
			collision_mask = {"item-layer", "object-layer", "water-tile"},
			darkness_of_burnt_tree = 0.5,
			emissions_per_second = -0.001 * 60,
			flags = {
				"placeable-neutral",
				"placeable-off-grid",
				"breaths-air"
			},
			icon = "__FoodIndustry__/graphics/icons/trees/"..crop[1].."-tree.png",
			icon_size = 32,
			max_health = 120,
			healing_per_tick = 0.001,
			repair_speed_modifier = 0,
			minable = {
				count = crop[17],
				mining_hardness = 1,
				mining_time = 3.5,
				results = {
					{type = "item", name = "wood", amount_min = 6, amount_max = 12},
					--{type = "item", name = "raw-straw", amount = 3, probability = 0.8},
					{type = "item", name = "raw-straw", amount_min = 15, amount_max = 45},
					{type = "item", name = crop[1], amount_min = math.floor(crop[17]), amount_max = math.floor(crop[17]*1.6) }
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
					filename = "__FoodIndustry__/graphics/entity/trees/"..crop[1].."-wild-tree.png",
					priority = "high",
					width = 945,
					height = 771,
					scale = crop[16],
					shift = {0.89, -1.71},
				}
			},
			map_color={r=0.858823529, g=0.82745098, b=0},
		},

		{
			type = "noise-layer",
			name = "wild-"..crop[1]
		}
	})
end

