data:extend({
	
	-- Fluid storage-tanks
	{
	type = "recipe",
	name = "fi-fluid-tank",
	enabled = false,
	icon = "__FoodIndustry__/graphics/icons/storages/fi-fluid-tank-icon.png",
	icon_size = 64,
	category = "crafting",
	subgroup = "food-decor",
	energy_required = 2.0,
	ingredients =
	{
		{"iron-plate", 8},
		{"steel-plate", 2},
		{"wood", 4}
	},
	results = 
	{
		{"fi-fluid-tank", 1}
	}
	},
	
})