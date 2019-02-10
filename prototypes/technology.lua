data:extend({  
{
    type = "technology",
    name = "food-energy-efficiency-1",
    icon = "__FoodIndustry__/graphics/technology/food-energy-efficiency.png",
    icon_size = 128,
    prerequisites =
    {
      "cooking"
    },
    effects =
    {      
    },
    unit =
    {
      time = 60,
      count = 150,
      ingredients =
      {
        {"science-pack-1", 1},
		{"science-pack-2", 1},
		{"food-science-pack", 1},
      },
    },
    order = "w",
  },
  {
    type = "technology",
    name = "food-energy-efficiency-2",
    icon = "__FoodIndustry__/graphics/technology/food-energy-efficiency.png",
    icon_size = 128,
    prerequisites =
    {
      "food-energy-efficiency-1",
    },
    effects =
    {      
    },
    unit =
    {
      time = 60,
      count = 200,
      ingredients =
      {
        {"science-pack-1", 1},
		{"science-pack-2", 1},
		{"food-science-pack", 1},
      },
    },
    order = "w",
  },
  {
    type = "technology",
    name = "food-energy-efficiency-3",
    icon = "__FoodIndustry__/graphics/technology/food-energy-efficiency.png",
    icon_size = 128,
    prerequisites =
    {
      "food-energy-efficiency-2","advanced-electronics"
    },
    effects =
    {      
    },
    unit =
    {
      time = 60,
      count = 250,
      ingredients =
      {
        {"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"food-science-pack", 1},
      },
    },
    order = "w",
  },
  {
    type = "technology",
    name = "food-energy-efficiency-4",
    icon = "__FoodIndustry__/graphics/technology/food-energy-efficiency.png",
    icon_size = 128,
    prerequisites =
    {
      "food-energy-efficiency-3",
    },
    effects =
    {      
    },
    unit =
    {
      time = 60,
      count = 300,
      ingredients =
      {
        {"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"food-science-pack", 1},
      },
    },
    order = "w",
  },
  {
    type = "technology",
    name = "food-energy-efficiency-5",
    icon = "__FoodIndustry__/graphics/technology/food-energy-efficiency.png",
    icon_size = 128,
    prerequisites =
    {
      "food-energy-efficiency-4","modular-armor"
    },
    effects =
    {      
    },
    unit =
    {
      time = 60,
      count = 350,
      ingredients =
      {
        {"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"food-science-pack", 1},
      },
    },
    order = "w",
  },
  {
    type = "technology",
    name = "food-energy-efficiency-6",
    icon = "__FoodIndustry__/graphics/technology/food-energy-efficiency.png",
    icon_size = 128,
    prerequisites =
    {
      "food-energy-efficiency-5",
    },
    effects =
    {      
    },
    unit =
    {
      time = 60,
      count = 400,
      ingredients =
      {
        {"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"food-science-pack", 1},
      },
    },
    order = "w",
  },
  {
    type = "technology",
    name = "food-energy-efficiency-7",
    icon = "__FoodIndustry__/graphics/technology/food-energy-efficiency.png",
    icon_size = 128,
    prerequisites =
    {
      "food-energy-efficiency-6","power-armor"
    },
    effects =
    {      
    },
    unit =
    {
      time = 60,
      count = 500,
      ingredients =
      {
        {"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"production-science-pack", 1},
		{"food-science-pack", 1},
      },
    },
    order = "w",
  },
  {
    type = "technology",
    name = "food-energy-efficiency-8",
    icon = "__FoodIndustry__/graphics/technology/food-energy-efficiency.png",
    icon_size = 128,
    prerequisites =
    {
      "food-energy-efficiency-7",
    },
    effects =
    {      
    },
    unit =
    {
      time = 60,
      count = 600,
      ingredients =
      {
        {"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"production-science-pack", 1},
		{"food-science-pack", 1},
      },
    },
    order = "w",
  },
  {
    type = "technology",
    name = "food-energy-efficiency-9",
    icon = "__FoodIndustry__/graphics/technology/food-energy-efficiency.png",
    icon_size = 128,
    prerequisites =
    {
      "food-energy-efficiency-8","power-armor-2"
    },
    effects =
    {      
    },
    unit =
    {
      time = 60,
      count = 750,
      ingredients =
      {
        {"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},		
		{"production-science-pack", 1},		
		{"high-tech-science-pack", 1},
		{"food-science-pack", 1},
      },
    },
    order = "w",
  },
  {
    type = "technology",
    name = "food-energy-efficiency-10",
    icon = "__FoodIndustry__/graphics/technology/food-energy-efficiency.png",
    icon_size = 128,
    prerequisites =
    {
      "food-energy-efficiency-9",
    },
    effects =
    {      
    },
    unit =
    {
      time = 60,
      count = 1000,
      ingredients =
      {
        {"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},		
		{"production-science-pack", 1},		
		{"high-tech-science-pack", 1},
		{"food-science-pack", 1},
      },
    },
    order = "w",
  },
  
  
  {
    type = "technology",
    name = "food-energy-efficiency-11",
    icon = "__FoodIndustry__/graphics/technology/food-energy-efficiency.png",
    icon_size = 128,
    prerequisites =
    {
      "power-armor-2", "food-energy-efficiency-10", "advanced-nutrient-extraction"
    },
    effects =
    {      
    },
    unit =
    {
      time = 60,
      count_formula = "1000+8.333333334*(L-9)*(L-8)*(L-7)",
      ingredients =
      {
        {"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"production-science-pack", 1},
		{"high-tech-science-pack", 1},
		{"space-science-pack", 1},
		{"food-science-pack", 1},
      },
    },
    order = "e-p-b-c-6",
	upgrade = true,
	max_level = "infinite"
  },
    
  
  
  
  {
    type = "technology",
    name = "composting",
    icon = "__FoodIndustry__/graphics/technology/composting.png",
    icon_size = 128,
    prerequisites = {},
    effects =
    {  
		{type = "unlock-recipe", recipe = "fi-composter"},
		{type = "unlock-recipe", recipe = "compost-1"},
		{type = "unlock-recipe", recipe = "food-science-pack"},
    },
    unit =
    {
      time = 10,
      count = 10,
      ingredients =
      {        
		{"science-pack-1", 1},
      },
    },
    order = "w",
  },   
  {
    type = "technology",
    name = "potato-growth",
    icon = "__FoodIndustry__/graphics/technology/potato-growth.png",
    icon_size = 128,
    prerequisites = {"composting"},
    effects =
    {  
		{type = "unlock-recipe", recipe = "potato-growth"},
    },
    unit =
    {
      time = 40,
      count = 5,
      ingredients =
      {        
		{"food-science-pack", 1},
      },
    },
    order = "w",
  },
  {
    type = "technology",
    name = "corn-growth",
    icon = "__FoodIndustry__/graphics/technology/corn-growth.png",
    icon_size = 128,
    prerequisites = {"composting"},
    effects =
    {  
		{type = "unlock-recipe", recipe = "corn-growth"},
    },
    unit =
    {
      time = 40,
      count = 5,
      ingredients =
      {        
		{"food-science-pack", 1},
      },
    },
    order = "w",
  },
  {
    type = "technology",
    name = "soy-growth",
    icon = "__FoodIndustry__/graphics/technology/soy-growth.png",
    icon_size = 128,
    prerequisites = {"composting"},
    effects =
    {  
		{type = "unlock-recipe", recipe = "soy-growth"},
    },
    unit =
    {
      time = 40,
      count = 5,
      ingredients =
      {        
		{"food-science-pack", 1},
      },
    },
    order = "w",
  },
  {
    type = "technology",
    name = "rapeseed-growth",
    icon = "__FoodIndustry__/graphics/technology/rapeseed-growth.png",
    icon_size = 128,
    prerequisites = {"composting"},
    effects =
    {  
		{type = "unlock-recipe", recipe = "rapeseed-growth"},
    },
    unit =
    {
      time = 40,
      count = 5,
      ingredients =
      {        
		{"food-science-pack", 1},
      },
    },
    order = "w",
  },
  {
    type = "technology",
    name = "trees-growth",
    icon = "__FoodIndustry__/graphics/technology/trees-growth.png",
    icon_size = 128,
    prerequisites = {"composting"},
    effects =
    {
        {type = "unlock-recipe", recipe = "fi_recipe_tree_greenhouse"},
		{type = "unlock-recipe", recipe = "apple-seedling"},
		{type = "unlock-recipe", recipe = "orange-seedling"},
    },
    unit =
    {
      time = 40,
      count = 15,
      ingredients =
      {
		{"food-science-pack", 1},
      },
    },
    order = "w",
  },

  {
    type = "technology",
    name = "cattle",
    icon = "__base__/graphics/icons/small-biter.png",
    icon_size = 32,
    prerequisites = {"composting", "automation"},
    effects =
    {
      {type = "unlock-recipe", recipe = "cattle-spawner"},
      {type = "unlock-recipe", recipe = "cattle-feeder"},
      {type = "unlock-recipe", recipe = "cattle-grabber"},
      {type = "unlock-recipe", recipe = "cattle-butcher"},
      {type = "unlock-recipe", recipe = "cattle-meat"},
      {type = "unlock-recipe", recipe = "cattle-wood-fence"},
      {type = "unlock-recipe", recipe = "cattle-wood-gate"},
    },
    unit =
    {
      time = 40,
      count = 15,
      ingredients =
      {
        {"food-science-pack", 1},
      },
    },
    order = "x",
  },
  
  {
    type = "technology",
    name = "advanced-composting",
    icon = "__FoodIndustry__/graphics/technology/advanced-composting.png",
    icon_size = 128,
    prerequisites = {"composting", "landfill"},
    effects =
    {  
		{type = "unlock-recipe", recipe = "compost-2"},
    },
    unit =
    {
      time = 20,
      count = 25,
      ingredients =
      {        
		{"science-pack-2", 1},
		{"food-science-pack", 1},
      },
    },
    order = "w",
  },
  {
    type = "technology",
    name = "cooking",
    icon = "__FoodIndustry__/graphics/technology/cooking.png",
    icon_size = 128,
    prerequisites = {"automation"},
    effects =
    {  
		{type = "unlock-recipe", recipe = "burner-cooker"},
		{type = "unlock-recipe", recipe = "cooked-corn"},
		{type = "unlock-recipe", recipe = "cooked-soy"},
		{type = "unlock-recipe", recipe = "baked-potato"},
        {type = "unlock-recipe", recipe = "cooked-fish"},
		{type = "unlock-recipe", recipe = "cooked-biter-meat"},
    },
    unit =
    {
      time = 10,
      count = 10,
      ingredients =
      {        
		{"science-pack-1", 1},
      },
    },
    order = "w",
  },
  {
    type = "technology",
    name = "electric-heating",
    icon = "__FoodIndustry__/graphics/technology/electric-heating.png",
    icon_size = 128,
    prerequisites = {"steel-processing", "electronics", "cooking"},
    effects =
    {  
		{type = "unlock-recipe", recipe = "electric-cooker"},
    },
    unit =
    {
      time = 60,
      count = 15,
      ingredients =
      {        
		{"science-pack-1", 2},
		{"science-pack-2", 2},
		{"food-science-pack", 1},
      },
    },
    order = "w",
  },
 {
    type = "technology",
    name = "canola-oil",
    icon = "__FoodIndustry__/graphics/technology/canola-oil.png",
    icon_size = 128,
    prerequisites = {"electric-heating", "rapeseed-growth"},
    effects =
    {  
		{type = "unlock-recipe", recipe = "canola-oil"},
    },
    unit =
    {
      time = 30,
      count = 30,
      ingredients =
      {        
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"food-science-pack", 1},
      },
    },
    order = "w",
  },
  {
    type = "technology",
    name = "canola-oil-processing",
    icon = "__base__/graphics/technology/oil-processing.png",
    icon_size = 128,
    prerequisites = {"canola-oil", "oil-processing"},
    effects =
    {  
		{type = "unlock-recipe", recipe = "canola-oil-processing"},
		{type = "unlock-recipe", recipe = "canola-oil-lubricant"},
    },
    unit =
    {
      time = 30,
      count = 70,
      ingredients =
      {        
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"food-science-pack", 1},
      },
    },
    order = "w",
  },
  {
    type = "technology",
    name = "advanced-farming",
    icon = "__FoodIndustry__/graphics/technology/advanced-farming-1.png",
    icon_size = 128,
    prerequisites = {"landfill", "electronics", "logistics", "potato-growth", "corn-growth", "soy-growth", "rapeseed-growth"},
    effects =
    {  
		{type = "unlock-recipe", recipe = "fi-greenhouse"},
		{type = "unlock-recipe", recipe = "lettuce-growth-w"},
		{type = "unlock-recipe", recipe = "cucumber-growth-w"},
		{type = "unlock-recipe", recipe = "tomato-growth-w"},
		{type = "unlock-recipe", recipe = "potato-growth-w"},
		{type = "unlock-recipe", recipe = "corn-growth-w"},
		{type = "unlock-recipe", recipe = "soy-growth-w"},
		{type = "unlock-recipe", recipe = "rapeseed-growth-w"},
--		{type = "unlock-recipe", recipe = "apple-growth-w"},
--		{type = "unlock-recipe", recipe = "orange-growth-w"},
    },
    unit =
    {
      time = 60,
      count = 25,
      ingredients =
      {        
		{"science-pack-1", 2},
		{"science-pack-2", 2},
		{"food-science-pack", 1},
      },
    },
    order = "w",
  },
  {
    type = "technology",
    name = "advanced-farming-2",
    icon = "__FoodIndustry__/graphics/technology/advanced-farming-2.png",
    icon_size = 128,
    prerequisites = {"advanced-farming", "advanced-electronics"},
    effects =
    {  
		{type = "unlock-recipe", recipe = "fi-big-greenhouse"},
    },
    unit =
    {
      time = 30,
      count = 150,
      ingredients =
      {        
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"food-science-pack", 1},
      },
    },
    order = "w",
  },
  {
    type = "technology",
    name = "advanced-farming-3",
    icon = "__FoodIndustry__/graphics/technology/advanced-farming-3.png",
    icon_size = 128,
    prerequisites = {"advanced-farming-2", "productivity-module-3", "fertilization-2", "advanced-material-processing-2"},
    effects =
    {  
		{type = "unlock-recipe", recipe = "fi-incubator"},
    },
    unit =
    {
      time = 60,
      count = 800,
      ingredients =
      {        
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"production-science-pack", 1},
		{"high-tech-science-pack", 1},
		{"food-science-pack", 1},
      },
    },
    order = "w",
  },
  {
    type = "technology",
    name = "crystal-extraction",
    icon = "__FoodIndustry__/graphics/technology/crystal-extraction.png",
    icon_size = 128,
    prerequisites = {"electric-heating", "fluid-handling"},
    effects =
    {  
		{type = "unlock-recipe", recipe = "crystal"},
    },
    unit =
    {
      time = 30,
      count = 40,
      ingredients =
      {        
		{"science-pack-1", 1},
		{"science-pack-2", 1},
      },
    },
    order = "w",
  },
  {
    type = "technology",
    name = "crystal-extraction-2",
    icon = "__FoodIndustry__/graphics/technology/crystal-extraction.png",
    icon_size = 128,
    prerequisites = {"crystal-extraction", "oil-processing"},
    effects =
    {  
		{type = "unlock-recipe", recipe = "crystal-steam"},
    },
    unit =
    {
      time = 40,
      count = 200,
      ingredients =
      {        
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"food-science-pack", 1},
      },
    },
    order = "w",
  },
  {
    type = "technology",
    name = "fertilization",
    icon = "__FoodIndustry__/graphics/technology/fertilization.png",
    icon_size = 128,
    prerequisites = {"electric-heating", "advanced-farming", "advanced-composting"},
    effects =
    {  
		{type = "unlock-recipe", recipe = "compost-water"},
		{type = "unlock-recipe", recipe = "lettuce-growth-c"},
		{type = "unlock-recipe", recipe = "cucumber-growth-c"},
		{type = "unlock-recipe", recipe = "tomato-growth-c"},
		{type = "unlock-recipe", recipe = "potato-growth-c"},
		{type = "unlock-recipe", recipe = "corn-growth-c"},
		{type = "unlock-recipe", recipe = "soy-growth-c"},		
		{type = "unlock-recipe", recipe = "rapeseed-growth-c"},
--		{type = "unlock-recipe", recipe = "apple-growth-c"},
--		{type = "unlock-recipe", recipe = "orange-growth-c"},
    },
    unit =
    {
      time = 30,
      count = 50,
      ingredients =
      {        
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"food-science-pack", 1},
      },
    },
    order = "w",
  },
  {
    type = "technology",
    name = "fertilization-2",
    icon = "__FoodIndustry__/graphics/technology/fertilization.png",
    icon_size = 128,
    prerequisites = {"fertilization", "advanced-farming-2", "advanced-oil-processing"},
    effects =
    {  
		{type = "unlock-recipe", recipe = "compost-cracking"},
		{type = "unlock-recipe", recipe = "fertilizer"},
		{type = "unlock-recipe", recipe = "fertilizer-water"},
		{type = "unlock-recipe", recipe = "lettuce-growth-f"},
		{type = "unlock-recipe", recipe = "cucumber-growth-f"},
		{type = "unlock-recipe", recipe = "tomato-growth-f"},
		{type = "unlock-recipe", recipe = "potato-growth-f"},
		{type = "unlock-recipe", recipe = "corn-growth-f"},
		{type = "unlock-recipe", recipe = "soy-growth-f"},
		{type = "unlock-recipe", recipe = "rapeseed-growth-f"},
--		{type = "unlock-recipe", recipe = "apple-growth-f"},
--		{type = "unlock-recipe", recipe = "orange-growth-f"},
    },
    unit =
    {
      time = 30,
      count = 200,
      ingredients =
      {        
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"food-science-pack", 1},
      },
    },
    order = "w",
  },
  {
    type = "technology",
    name = "fertilizer-oil-cracking",
    icon = "__base__/graphics/technology/oil-processing.png",
    icon_size = 128,
    prerequisites = {"fertilization-2"},
    effects =
    {  
		{type = "unlock-recipe", recipe = "fertilizer-oil-cracking"},
    },
    unit =
    {
      time = 60,
      count = 80,
      ingredients =
      {        
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"production-science-pack", 1},
		{"food-science-pack", 1},
      },
    },
    order = "w",
  },
  {
    type = "technology",
    name = "electric-composting",
    icon = "__FoodIndustry__/graphics/technology/electric-composting.png",
    icon_size = 128,
    prerequisites = {"fertilization-2", "advanced-material-processing-2", "speed-module-2"},
    effects =
    {  
		{type = "unlock-recipe", recipe = "fi-electric-composter"},
		{type = "unlock-recipe", recipe = "compost-raw-straw"},
		{type = "unlock-recipe", recipe = "compost-straw"},
		{type = "unlock-recipe", recipe = "compost-compressed-straw"},
		{type = "unlock-recipe", recipe = "compost-lettuce"},
		{type = "unlock-recipe", recipe = "compost-cucumber"},
		{type = "unlock-recipe", recipe = "compost-tomato"},
		{type = "unlock-recipe", recipe = "compost-potato"},
		{type = "unlock-recipe", recipe = "compost-corn"},
		{type = "unlock-recipe", recipe = "compost-soy"},
		{type = "unlock-recipe", recipe = "compost-rapeseed"},
    },
    unit =
    {
      time = 60,
      count = 450,
      ingredients =
      {        
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"production-science-pack", 1},
		{"food-science-pack", 1},
      },
    },
    order = "w",
  },
  
  
  
  {
    type = "technology",
    name = "salad",
    icon = "__FoodIndustry__/graphics/technology/salad.png",
    icon_size = 128,
    prerequisites = {"cooking"},
    effects =
    {  
		{type = "unlock-recipe", recipe = "basic-salad"},
    },
    unit =
    {
      time = 20,
      count = 10,
      ingredients =
      {   		
		{"food-science-pack", 1},
      },
    },
    order = "w",
  },
  {
    type = "technology",
    name = "frying",
    icon = "__FoodIndustry__/graphics/technology/frying.png",
    icon_size = 128,
    prerequisites = {"canola-oil", "potato-growth", "flour"},
    effects =
    {  
		{type = "unlock-recipe", recipe = "raw-fries"},
		{type = "unlock-recipe", recipe = "fries"},
        {type = "unlock-recipe", recipe = "fish-steak"},
		{type = "unlock-recipe", recipe = "biter-steak"},
		{type = "unlock-recipe", recipe = "schnitzel"},
		{type = "unlock-recipe", recipe = "popcorn"},
        {type = "unlock-recipe", recipe = "fish-and-chips"},
    },
    unit =
    {
      time = 20,
      count = 30,
      ingredients =
      {   		
		{"food-science-pack", 1},
      },
    },
    order = "w",
  },
  {
    type = "technology",
    name = "fermentation",
    icon = "__FoodIndustry__/graphics/technology/fermentation.png",
    icon_size = 128,
    prerequisites = {"oil-processing", "cooking", "soy-growth"},
    effects =
    {  
		{type = "unlock-recipe", recipe = "soy-milk"},
		{type = "unlock-recipe", recipe = "tofu"},
		{type = "unlock-recipe", recipe = "pickles"},
    },
    unit =
    {
      time = 20,
      count = 40,
      ingredients =
      {        
		{"food-science-pack", 1},
      },
    },
    order = "w",
  },
  {
    type = "technology",
    name = "flour",
    icon = "__FoodIndustry__/graphics/technology/flour.png",
    icon_size = 128,
    prerequisites = {"cooking", "corn-growth"},
    effects =
    {  
		{type = "unlock-recipe", recipe = "corn-flour"},
		{type = "unlock-recipe", recipe = "corn-bread"},
    },
    unit =
    {
      time = 20,
      count = 20,
      ingredients =
      {        
		{"food-science-pack", 1},
      },
    },
    order = "w",
  },  
  {
    type = "technology",
    name = "seasoning",
    icon = "__FoodIndustry__/graphics/technology/seasoning.png",
    icon_size = 128,
    prerequisites = {"frying", "fermentation"},
    effects =
    {  
		{type = "unlock-recipe", recipe = "soy-sauce"},
		{type = "unlock-recipe", recipe = "best-salad"},
        {type = "unlock-recipe", recipe = "fish-salad"},
		{type = "unlock-recipe", recipe = "ketchup"},
		{type = "unlock-recipe", recipe = "ketchup-fries"},
    },
    unit =
    {
      time = 20,
      count = 50,
      ingredients =
      {        
		{"food-science-pack", 1},
      },
    },
    order = "w",
  },
  {
    type = "technology",
    name = "complex-foods",
    icon = "__FoodIndustry__/graphics/technology/complex-foods.png",
    icon_size = 128,
    prerequisites = {"seasoning", "salad"},
    effects =
    {  
		{type = "unlock-recipe", recipe = "burger"},
        {type = "unlock-recipe", recipe = "fish-burger"},
		{type = "unlock-recipe", recipe = "tofu-burger"},
		{type = "unlock-recipe", recipe = "pizza"},
        {type = "unlock-recipe", recipe = "fish-pizza"},
		{type = "unlock-recipe", recipe = "tofu-pizza"},
    },
    unit =
    {
      time = 60,
      count = 200,
      ingredients =
      {        
		{"food-science-pack", 1},
      },
    },
    order = "w",
  },
  {
    type = "technology",
    name = "advanced-nutrient-extraction",
    icon = "__FoodIndustry__/graphics/technology/advanced-nutrient-extraction.png",
    icon_size = 128,
    prerequisites = {"complex-foods", "nuclear-power"},
    effects =
    {  
		{type = "unlock-recipe", recipe = "food-capsule"},
		{type = "unlock-recipe", recipe = "vegan-food-capsule"},
    },
    unit =
    {
      time = 60,
      count = 600,
      ingredients =
      {        
		{"food-science-pack", 1},
		{"high-tech-science-pack", 1},
      },
    },
    order = "w",
  },
  {
    type = "technology",
    name = "effect-capsules",
    icon = "__FoodIndustry__/graphics/technology/effect-capsules.png",
    icon_size = 128,
    prerequisites = {"advanced-nutrient-extraction", "food-energy-efficiency-10"},
    effects =
    {  
		{type = "unlock-recipe", recipe = "long-reach-capsule-food-capsule"},
		{type = "unlock-recipe", recipe = "speed-capsule-food-capsule"},
		{type = "unlock-recipe", recipe = "regen-capsule-food-capsule"},
		{type = "unlock-recipe", recipe = "crafting-capsule-food-capsule"},
		{type = "unlock-recipe", recipe = "mining-capsule-food-capsule"},
		{type = "unlock-recipe", recipe = "neutralizing-capsule-food-capsule"},
		{type = "unlock-recipe", recipe = "health-buffer-capsule-food-capsule"},
		{type = "unlock-recipe", recipe = "invulnerability-capsule-health-buffer-capsule"},
		{type = "unlock-recipe", recipe = "long-reach-capsule-vegan-food-capsule"},
		{type = "unlock-recipe", recipe = "speed-capsule-vegan-food-capsule"},
		{type = "unlock-recipe", recipe = "regen-capsule-vegan-food-capsule"},
		{type = "unlock-recipe", recipe = "crafting-capsule-vegan-food-capsule"},
		{type = "unlock-recipe", recipe = "mining-capsule-vegan-food-capsule"},
		{type = "unlock-recipe", recipe = "neutralizing-capsule-vegan-food-capsule"},
		{type = "unlock-recipe", recipe = "health-buffer-capsule-vegan-food-capsule"},
    },
    unit =
    {
      time = 60,
      count = 2000,
      ingredients =
      {        
		{"food-science-pack", 1},
		{"high-tech-science-pack", 1},
		{"production-science-pack", 1},
		{"science-pack-3", 1},
      },
    },
    order = "w",
  },
  
  -- More Energy technologies

  {
    type = "technology",
    name = "fi-tech-more-energy-1",
    icon = "__FoodIndustry__/graphics/technology/fi-tech-more-energy-1.png",
    icon_size = 128,
    prerequisites = {"composting"},
    effects = {
      {
          type = "nothing",
          effect_description = {'technology-effect.fi-tech-more-energy-bonus', "50"},
      },
      {
        type = "give-item",
        item = "vegan-food-capsule",
        count = 3
      }
  },
  unit =
    {
      time = 30,
      count = 10,
      ingredients =
      {
		{"science-pack-1", 1},
		{"food-science-pack", 1},
      },
    },
    order = "w",
  },
  {
    type = "technology",
    name = "fi-tech-more-energy-2",
    icon = "__FoodIndustry__/graphics/technology/fi-tech-more-energy-2.png",
    icon_size = 128,
    prerequisites = {"fi-tech-more-energy-1"},
    effects = {
      {
          type = "nothing",
          effect_description = {'technology-effect.fi-tech-more-energy-bonus', "50"}
      },
      {
        type = "give-item",
        item = "vegan-food-capsule",
        count = 5
      },
      {
        type = "give-item",
        item = "speed-capsule",
        count = 1
      },
      {
        type = "give-item",
        item = "crafting-capsule",
        count = 1
      }
  },
  unit =
    {
      time = 30,
      count = 25,
      ingredients =
      {
		{"science-pack-1", 1},
		{"food-science-pack", 1},
      },
    },
    order = "w",
  },
  -- fi-tech-more-energy-3 +100 = 300,
  {
    type = "technology",
    name = "fi-tech-more-energy-3",
    icon = "__FoodIndustry__/graphics/technology/fi-tech-more-energy-3.png",
    icon_size = 128,
    prerequisites = {"fi-tech-more-energy-2"},
    effects = {
      {
          type = "nothing",
          effect_description = {'technology-effect.fi-tech-more-energy-bonus', "100"}
      },
      {
        type = "give-item",
        item = "speed-capsule",
        count = 2
      },
      {
        type = "give-item",
        item = "crafting-capsule",
        count = 2
      }
  },
  unit =
    {
      time = 30,
      count = 100,
      ingredients =
      {        
		{"science-pack-2", 2},
		{"science-pack-3", 1},
		{"food-science-pack", 2},
      },
    },
    order = "w",
  },
  -- fi-tech-more-energy-4 +100 = 400, and
  {
    type = "technology",
    name = "fi-tech-more-energy-4",
    icon = "__FoodIndustry__/graphics/technology/fi-tech-more-energy-3.png",
    icon_size = 128,
    prerequisites = {"fi-tech-more-energy-3", "advanced-farming-3"},
    effects = {
      {
          type = "nothing",
          effect_description = {'technology-effect.fi-tech-more-energy-bonus', "100"}
      },
      {
        type = "give-item",
        item = "speed-capsule",
        count = 5
      },
      {
        type = "give-item",
        item = "crafting-capsule",
        count = 5
      }
  },
  unit =
    {
      time = 30,
      count = 100,
      ingredients =
      {
		{"science-pack-3", 2},
		{"high-tech-science-pack", 1},
		{"food-science-pack", 4},
      },
    },
    order = "w",
  },
  -- fi-tech-more-energy-5 +100 = 500 max.
  {
    type = "technology",
    name = "fi-tech-more-energy-5",
    icon = "__FoodIndustry__/graphics/technology/fi-tech-more-energy-5.png",
    icon_size = 128,
    prerequisites = {"fi-tech-more-energy-4", "advanced-nutrient-extraction"},
    effects = {
      {
          type = "nothing",
          effect_description = {'technology-effect.fi-tech-more-energy-bonus', "100"}
      },
  },
  unit =
    {
      time = 30,
      count = 200,
      ingredients =
      {        
		{"science-pack-3", 2},
		{"high-tech-science-pack", 1},
		{"space-science-pack", 1},
		{"food-science-pack", 4},
      },
    },
    order = "w",
  },


})