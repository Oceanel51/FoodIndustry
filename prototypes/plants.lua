local plants = {
--name			suffix		autoplace-control	debug color			starting	size
{"lettuce", 	"",			"food-plant",		{r=0,g=1,b=0},		15,			0.4},
{"cucumber",	"-plant",	"food-plant",		{r=0,g=1,b=1},		15,			0.4},
{"tomato", 		"-plant",	"food-plant",		{r=1,g=0,b=1},		15,			0.35},
{"potato", 		"-plant",	"food-plant",		{r=1,g=0,b=0},		0,			0.35},
{"corn", 		"-plant",	"food-plant",		{r=1,g=1,b=0},		0,			0.45},
{"soy", 		"-plant",	"food-plant",		{r=1,g=0.6,b=0},	0,			0.3},
{"rapeseed", 	"-plant",	"oil-plant",		{r=1,g=1,b=1},		0,			0.3},
}


for i, plant in pairs(plants) do
data:extend({
  {
	type = "tree",
	name = plant[1].."-plant",
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
	icon = "__FoodIndustry__/graphics/icons/items/"..plant[1]..plant[2]..".png",
	icon_size = 32,
	max_health = 5,
	minable = {
		count = 1,
		mining_hardness = 0.1,
		mining_time = 0.5,
		result = plant[1]..plant[2]
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
			filename = "__FoodIndustry__/graphics/entity/plants/"..plant[1]..".png",
			priority = "high",
			width = 256,
			height = 256,
			scale = plant[6],
			shift = {0.0, 0.0},
		}
	},
	map_color = {r=0.1, g= 0.7, b=0, a=0.9}--[[plant[4]],
  },
	
  {
	type = "noise-layer",
	name = "wild-"..plant[1]
  }

})
end
