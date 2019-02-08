data:extend({
	
	{
    type = "recipe",
    name = "straw",
    enabled = true,
	icon = "__FoodIndustry__/graphics/icons/items/straw.png",
	icon_size = 32,
	category = "crafting",
	subgroup = "food-items",
	energy_required = 0.5,
    ingredients =
    {
		{"raw-straw", 5}
    },
      results = 
	{
		{"straw", 16}
	}
    },
	{
    type = "recipe",
    name = "compressed-straw",
    enabled = false,
	icon = "__FoodIndustry__/graphics/icons/items/compressed-straw.png",
	icon_size = 32,
	category = "advanced-crafting",
	subgroup = "food-items",
	energy_required = 1.5,
    ingredients =
    {
		{"straw", 60}
    },
      results = 
	{
		{"compressed-straw", 1}
	}
    },	
	{
    type = "recipe",
    name = "fish-to-meat",
    enabled = true,
	icon = "__FoodIndustry__/graphics/icons/items/biter-meat.png",
	icon_size = 32,
	category = "crafting",
	subgroup = "foods-other",
	energy_required = 0.5,
    ingredients =
    {
		{"raw-fish", 5}
    },
      results = 
	{
		{type = "item", name = "biter-meat", amount = 1, probability = 0.2}
	}
    },	
	
	
	
	
	{
    type = "recipe",
    name = "compost-1",
    enabled = false,
	icon = "__FoodIndustry__/graphics/icons/recipes/compost-1.png",
	icon_size = 32,
	category = "composting",
	subgroup = "food-items",
	energy_required = 25.0,
    ingredients =
    {
		{"raw-straw", 10},
    },
      results = 
	{
		{"compost", 20} -- OPTIMIZE receipt results
	},
	allow_as_intermediate = false,
    },
	{
    type = "recipe",
    name = "compost-2",
    enabled = false,
	icon = "__FoodIndustry__/graphics/icons/recipes/compost-2.png",
	icon_size = 32,
	category = "composting",
	subgroup = "food-items",
	energy_required = 200.0,
    ingredients =
    {
		{"landfill", 1},
    },
      results = 
	{
		{"compost", 100}
	},
	allow_as_intermediate = false,	
    },
	
	
	
	
	{
    type = "recipe",
    name = "compost-cracking",
    enabled = false,
	icon = "__FoodIndustry__/graphics/icons/recipes/compost-cracking.png",
	icon_size = 32,
	category = "chemistry",
	subgroup = "food-fluids",
	energy_required = 30.0,
    ingredients =
    {
		{"compost", 30},
		{type = "fluid", name = "water", amount = 120},
		{type = "fluid", name = "petroleum-gas", amount = 360},
		
    },
      results = 
	{
		{"unprocessed-fertilizer", 20},
		{type = "fluid", name = "fertilizer-oil", amount = 480}
	},
	crafting_machine_tint = { primary = {r=0.5,g=0.3,b=0.3,a=1}, secondary = {r=0.8,g=0,b=0.7,a=1}, tertiary = {r=0.6,g=0,b=0.5,a=1}}	
    },
	{
    type = "recipe",
    name = "fertilizer",
    enabled = false,
	icon = "__FoodIndustry__/graphics/icons/items/fertilizer.png",
	icon_size = 32,
	category = "chemistry",
	subgroup = "food-items",
	energy_required = 20.0,
    ingredients =
    {
		{"unprocessed-fertilizer", 15},
		{"crystal", 4},
		{type = "fluid", name = "sulfuric-acid", amount = 10},
		{type = "fluid", name = "steam", amount = 180}
    },
      results = 
	{
		{"fertilizer", 10}
	},
	crafting_machine_tint = { primary = {r=0.8,g=0.6,b=0.7,a=1}, secondary = {r=0.8,g=0,b=0.7,a=1}, tertiary = {r=0.8,g=0,b=0.7,a=1}}	
    },
	{
    type = "recipe",
    name = "fertilizer-oil-cracking",
    enabled = false,
	icon = "__FoodIndustry__/graphics/icons/recipes/fertilizer-oil-cracking.png",
	icon_size = 32,
	category = "oil-processing",
	subgroup = "food-fluids",
	energy_required = 0.8,
    ingredients =
    {
		{type = "fluid", name = "fertilizer-oil", amount = 20},
		{type = "fluid", name = "light-oil", amount = 30}
    },
      results = 
	{
		{type = "fluid", name = "heavy-oil", amount = 20},
		{type = "fluid", name = "water", amount = 30},
		{type = "fluid", name = "petroleum-gas", amount = 5}
	},
	allow_as_intermediate = false,
    },
	{
    type = "recipe",
    name = "crystal",
    enabled = false,
	icon = "__FoodIndustry__/graphics/icons/items/crystal.png",
	icon_size = 32,
	category = "mixing",
	subgroup = "food-items",
	energy_required = 20.0,
    ingredients =
    {
		{type = "fluid", name = "water", amount = 250},
		{ "stone", 4 }
    },
      results = 
	{
		{type = "item", name = "crystal", amount = 1, probability = 0.3}
	},
},

{
    type = "recipe",
    name = "crystal-steam",
	order = "w-b-e-2",
    enabled = false,
	icon = "__FoodIndustry__/graphics/icons/recipes/crystal-steam.png",
	icon_size = 32,
	category = "chemistry",
	subgroup = "food-items",
	energy_required = 2.0,
    ingredients =
    {
		{type = "fluid", name = "steam", amount = 5},
		{type = "fluid", name = "water", amount = 10},
		{ "crystal", 24 }
    },
      results = 
	{
		{type = "item", name = "crystal", amount = 24},
		{type = "item", name = "crystal", amount = 1, probability = 0.2}
	},
	crafting_machine_tint = { primary = {r=0.8,g=0.8,b=1,a=1}, secondary = {r=0.9,g=0.9,b=0.9,a=1}, tertiary = {r=0.8,g=0.8,b=0.8,a=1}},
	allow_as_intermediate = false,
},

{
	type = "recipe",
	name = "canola-oil",
	enabled = false,
	icon = "__FoodIndustry__/graphics/icons/fluids/canola-oil.png",
	icon_size = 32,
	-- TODO разобраться почему не работает categories
	--categories = {"mixing", "chemistry"},
	category = "chemistry",
	subgroup = "food-intermediates",
	energy_required = 2.5,
	ingredients =
	{
		{type = "fluid", name = "steam", amount = 10},
		{ "rapeseed", 2 }
	},
	results = 
	{
		{type = "fluid", name = "canola-oil", amount = 40}
	},
},

{
    type = "recipe",
    name = "canola-oil-processing",
    enabled = false,
	icon = "__FoodIndustry__/graphics/icons/recipes/canola-oil-processing.png",
	icon_size = 32,
	category = "oil-processing",
	subgroup = "food-intermediates",
	energy_required = 5.0,
    ingredients =
    {
		{type = "fluid", name = "steam", amount = 25},
		{type = "fluid", name = "canola-oil", amount = 100},
    },
      results = 
	{	
		{type = "fluid", name = "water", amount = 30},
		{type = "fluid", name = "light-oil", amount = 60},
		{type = "fluid", name = "petroleum-gas", amount = 10},
	},
    },
	{
    type = "recipe",
    name = "canola-oil-lubricant",
    enabled = false,
	icon = "__FoodIndustry__/graphics/icons/recipes/canola-oil-lubricant.png",
	icon_size = 32,
	category = "chemistry",
	subgroup = "food-intermediates",
	energy_required = 1.0,
    ingredients =
    {
		{type = "fluid", name = "canola-oil", amount = 10},
    },
      results = 
	{
		{type = "fluid", name = "lubricant", amount = 15},
	},
    },
	
	
	
	
	
	
	
	
	{
    type = "recipe",
    name = "compost-water",
    enabled = false,
	icon = "__FoodIndustry__/graphics/icons/fluids/compost-water.png",
	icon_size = 32,
	category = "mixing",
	subgroup = "food-fluids",
	energy_required = 1.0,
    ingredients =
    {
		{type = "fluid", name = "water", amount = 55},
		{ "compost", 1 }
    },
      results = 
	{
		{type = "fluid", name = "compost-water", amount = 50}
	},
    },
	{
    type = "recipe",
    name = "fertilizer-water",
    enabled = false,
	icon = "__FoodIndustry__/graphics/icons/fluids/fertilizer-water.png",
	icon_size = 32,
	category = "chemistry",
	subgroup = "food-fluids",
	energy_required = 2.0,
    ingredients =
    {
		{type = "fluid", name = "fertilizer-oil", amount = 6},
		{type = "fluid", name = "water", amount = 44},
		{ "fertilizer", 1 }
    },
      results = 
	{
		{type = "fluid", name = "fertilizer-water", amount = 50}
	},
	crafting_machine_tint = { primary = {r=0,g=0.8,b=1,a=1}, secondary = {r=0,g=0.34,b=0.6,a=1}, tertiary = {r=0.34,g=0.2,b=0.6,a=1}}	
    },
	
	
	
	
	
	{
    type = "recipe",
    name = "fi-basic-farmland",
    enabled = true,
	icon = "__FoodIndustry__/graphics/icons/entities/fi-basic-farmland.png",
	icon_size = 32,
	category = "crafting",
	subgroup = "food-machines",
	energy_required = 30.0,
    ingredients =
    {
		{"iron-axe", 1},
		{"wood", 32}
    },
      results = 
	{
		{"fi-basic-farmland", 2}
	}
    },
	{
    type = "recipe",
    name = "fi-composter",
    enabled = false,
	icon = "__FoodIndustry__/graphics/icons/entities/fi-composter-icon.png",
	icon_size = 64,
	category = "crafting",
	subgroup = "food-machines",
	energy_required = 8.0,
    ingredients =
    {
		{"stone", 10},
		{"wood", 24}
    },
      results = 
	{
		{"fi-composter", 1}
	}
    },
	{
    type = "recipe",
    name = "fi-electric-composter",
    enabled = false,
	icon = "__FoodIndustry__/graphics/icons/entities/fi-electric-composter-icon.png",
	icon_size = 64,
	category = "crafting-with-fluid",
	subgroup = "food-machines",
	energy_required = 20.0,
    ingredients =
    {
		{"fi-composter", 8},
		{"speed-module-2", 1},
		{"processing-unit", 4},
		{"electric-furnace", 2},
		{"compost", 400},
		{type = "fluid", name = "fertilizer-oil", amount = 800}
    },
      results = 
	{
		{"fi-electric-composter", 1}
	}
    },
	{
    type = "recipe",
    name = "fi-greenhouse",
    enabled = false,
	icon = "__FoodIndustry__/graphics/icons/entities/fi-greenhouse-icon.png",
	icon_size = 64,
	category = "crafting",
	subgroup = "food-machines",
	energy_required = 10.0,
    ingredients =
    {
		{"small-lamp", 4},
		{"pipe", 5},
		{"landfill", 4},
		{"electronic-circuit", 8},
    },
      results = 
	{
		{"fi-greenhouse", 1}
	}
    },
	{
    type = "recipe",
    name = "fi-big-greenhouse",
    enabled = false,
	icon = "__FoodIndustry__/graphics/icons/entities/fi-big-greenhouse-icon.png",
	icon_size = 64,
	category = "crafting",
	subgroup = "food-machines",
	energy_required = 15.0,
    ingredients =
    {
		{"fi-greenhouse", 4},
		{"advanced-circuit", 8},
		{"stone-brick", 20},
		{"crystal", 12},
    },
      results = 
	{
		{"fi-big-greenhouse", 1}
	}
    },
	{
    type = "recipe",
    name = "fi-incubator",
    enabled = false,
	icon = "__FoodIndustry__/graphics/icons/entities/fi-incubator-icon.png",
	icon_size = 64,
	category = "crafting-with-fluid",
	subgroup = "food-machines",
	energy_required = 30.0,
    ingredients =
    {
		{"fi-big-greenhouse", 1},
		{"productivity-module-3", 1},
		{"electric-furnace", 8},
		{"fertilizer", 40},
		{type = "fluid", name = "fertilizer-oil", amount = 800}
    },
      results = 
	{
		{"fi-incubator", 1}
	}
    },	
	{
    type = "recipe",
    name = "burner-cooker",
    enabled = false,
	icon = "__FoodIndustry__/graphics/icons/entities/burner-cooker.png",
	icon_size = 32,
	category = "crafting",
	subgroup = "food-machines",
	energy_required = 1.5,
    ingredients =
    {
		{"stone-brick", 4},
		{"stone-furnace", 1},
		{"iron-plate", 5}
    },
      results = 
	{
		{"burner-cooker", 1}
	}
    },	
	{
    type = "recipe",
    name = "electric-cooker",
    enabled = false,
	icon = "__FoodIndustry__/graphics/icons/entities/electric-cooker.png",
	icon_size = 32,
	category = "crafting",
	subgroup = "food-machines",
	energy_required = 2.5,
    ingredients =
    {
		{"burner-cooker", 1},
		{"electronic-circuit", 4},
		{"copper-cable", 10},
		{"steel-plate", 2},
    },
      results = 
	{
		{"electric-cooker", 1}
	}
    },	
	
	
	
		
	{
    type = "recipe",
    name = "corn-flour",
    enabled = false,
	icon = "__FoodIndustry__/graphics/icons/items/corn-flour.png",
	icon_size = 32,
	category = "advanced-crafting",
	subgroup = "food-intermediates",
	energy_required = 1.0,
    ingredients =
    {
		{"corn-seeds", 10},
    },
      results = 
	{
		{"corn-flour", 3}
	}
    },
	{
    type = "recipe",
    name = "soy-milk",
    enabled = false,
	icon = "__FoodIndustry__/graphics/icons/fluids/soy-milk.png",
	icon_size = 32,
	category = "crafting-with-fluid",
	subgroup = "food-intermediates",
	energy_required = 0.5,
    ingredients =
    {
		{"cooked-soy", 4},
		{type = "fluid", name = "water", amount = 1}
    },
      results = 
	{
		{type = "fluid", name = "soy-milk", amount = 1}
	}
    },
	{
    type = "recipe",
    name = "soy-sauce",
    enabled = false,
	icon = "__FoodIndustry__/graphics/icons/fluids/soy-sauce.png",
	icon_size = 32,
	category = "chemistry",
	subgroup = "food-intermediates",
	energy_required = 0.5,
    ingredients =
    {
		{"soy", 30},
		{type = "fluid", name = "water", amount = 1}
    },
      results = 
	{
		{type = "fluid", name = "soy-sauce", amount = 2}
	}
    },
	{
    type = "recipe",
    name = "raw-fries",
    enabled = false,
	icon = "__FoodIndustry__/graphics/icons/items/raw-fries.png",
	icon_size = 32,
	category = "crafting",
	subgroup = "food-intermediates",
	energy_required = 2.0,
    ingredients =
    {
		{"potato", 2},
    },
      results = 
	{
		{"raw-fries", 1}
	}
    },
	{
    type = "recipe",
    name = "ketchup",
    enabled = false,
	icon = "__FoodIndustry__/graphics/icons/fluids/ketchup.png",
	icon_size = 32,
	category = "cooking",
	subgroup = "food-intermediates",
	energy_required = 10.0,
    ingredients =
    {
		{"tomato", 20},
		{type = "fluid", name = "water", amount = 20}
    },
      results = 
	{
		{type = "fluid", name = "ketchup", amount = 5} -- TODO сделать в рецепте больше единиц жидкости
	}
    },
	
	
	
	{
    type = "recipe",
    name = "food-science-pack",
    enabled = false,
	icon = "__FoodIndustry__/graphics/icons/items/food-science-pack.png",
	icon_size = 32,
	category = "crafting",
	subgroup = "science-pack",
	energy_required = 3.0,
    ingredients =
    {
		{"science-pack-1", 1},
		{"compost", 5},
    },
      results = 
	{
		{"food-science-pack", 1}
	}
	},
	
	-- Drinks
	{
		type = "recipe",
		name = "flask",
		order = "a-b-a",
		enabled = true,
		icon = "__FoodIndustry__/graphics/icons/items/flask.png",
		icon_size = 64,
		category = "crafting",
		subgroup = "drink-empty-packages",
		energy_required = 4.5,
		ingredients =
		{
			{"iron-plate", 1},
		},
		results =
		{
			{"flask", 1}
		}
	},
	{
		type = "recipe",
		name = "flask-recycle",
		order = "a-b-b",
		enabled = true,
		icon = "__FoodIndustry__/graphics/icons/items/flask-recycle.png",
		icon_size = 64,
		category = "crafting",
		subgroup = "drink-empty-packages",
		energy_required = 6,
		ingredients =
		{
			{"flask", 4}
		},
		results =
		{
			{"iron-plate", 1},
		},
		hide_from_stats = true,
		--allow_decomposition = false,
		allow_as_intermediate = false,
		allow_intermediates = false,
	},

	{
		type = "recipe",
		name = "plastic-bottle",
		order = "a-c-a",
		enabled = false,
		icon = "__FoodIndustry__/graphics/icons/items/plastic-bottle.png",
		icon_size = 64,
		category = "crafting",
		subgroup = "drink-empty-packages",
		energy_required = 3.0,
		ingredients =
		{
			{"plastic-bar", 1},
		},
		results =
		{
			{"plastic-bottle", 4}
		}
	},

})