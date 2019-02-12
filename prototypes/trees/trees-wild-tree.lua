local trees = {
--1				2			3					4					5			6		7
--name,			suffix,		autoplace-control,	debug color,		starting,	size,	result
{"apple", 		"tree",		"food-plant",		{r=1,g=0.2,b=0},	20,			0.3,	5},
{"orange", 		"tree",		"food-plant",		{r=0.6,g=0.6,b=0},	20,			0.3,	4},
}

for i, plant in pairs(trees) do
data:extend({

  {
	type = "tree",
	name = plant[1].."-wild-"..plant[2],
	order = "w",
	autoplace = {
		control = plant[3],
		max_probability = 0.006,
		coverage = 0.0003,
		order = "w",
		peaks = {
			{
				noise_layer = "wild-"..plant[1],
				noise_octaves_difference = -0.85,
				noise_persistence = 0.4
			}
		},
		sharpness = 0.9375,
		starting_area_amount = 1600,
		starting_area_size = plant[5]
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
	icon = "__FoodIndustry__/graphics/icons/trees/"..plant[1].."-"..plant[2]..".png",
	icon_size = 32,
	max_health = 5,
	minable = {
		count = plant[7],
		mining_hardness = 0.1,
		mining_time = 0.5,
		result = plant[1]
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
			filename = "__FoodIndustry__/graphics/entity/trees/"..plant[1].."-wild-"..plant[2]..".png",
			priority = "high",
			width = 945,
			height = 771,
			scale = plant[6],
			shift = {2.97, 0.44},
		}
	},
	map_color = {r=1.0, g= 0.7, b=0, a=0.9},
  },
	
  {
	type = "noise-layer",
	name = "wild-"..plant[1]
  }

})
end
