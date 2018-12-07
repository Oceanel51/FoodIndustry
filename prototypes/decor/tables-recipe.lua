data:extend({
  
  {
	type = "recipe",
	name = "fi-table-logo",
	enabled = true,
	icon = "__FoodIndustry__/graphics/icons/decor/fi-table-logo-icon.png",
	icon_size = 64,
	category = "crafting",
	subgroup = "food-decor",
	energy_required = 8.0,
	ingredients =
	{
		{"iron-stick", 6},
		{"copper-plate", 4},
		{"stone", 10},
		{"wood", 40}
	},
	  results = 
	{
		{"fi-table-logo", 1}
	}
  },
	
  {
    type = "recipe",
    name = "fi-table-logo-lamp",
    enabled = false,
	icon = "__FoodIndustry__/graphics/icons/decor/fi-table-logo-lamp-icon.png",
	icon_size = 64,
	category = "crafting",
	subgroup = "food-decor",
	energy_required = 8.0,
    ingredients =
    {
		{"small-lamp", 1},
		{"electronic-circuit", 6},
		{"iron-stick", 6},
		{"copper-plate", 4},
		{"stone", 10},
		{"wood", 24}
    },
      results = 
	{
		{"fi-table-logo-lamp", 1}
	}
  },
  
})
