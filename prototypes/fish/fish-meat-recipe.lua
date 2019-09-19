data:extend({

-- fish-meat
  {
    type = "recipe",
    name = "fish-meat",
    enabled = false,
    icon = "__FoodIndustry__/graphics/icons/recipes/fish-meat.png",
    icon_size = 32,
    category = "crafting-with-fluid",
    subgroup = "foods-fish",
    order = "w-b-1",
    energy_required = 30.0,
    ingredients =
    {
        {"raw-fish", 5},
        {type = "fluid", name = "water", amount = 20},
    },
    results = 
    {
        {"fish-meat-red", 4},
        {"fish-bone", 1},
        {type = "fluid", name = "water", amount = 15},
    },
  },
  {
    type = "recipe",
    name = "sturgeon-meat",
    enabled = false,
    icon = "__FoodIndustry__/graphics/icons/recipes/sturgeon-meat.png",
    icon_size = 32,
    category = "crafting-with-fluid",
    subgroup = "foods-fish",
    order = "w-c-1",
    energy_required = 30.0,
    ingredients =
    {
        {"fi-raw-sturgeon", 1},
        {type = "fluid", name = "water", amount = 60},
    },
    results = 
    {
        {"fish-meat-red", 20},
        {"fish-bone", 4},
        {type = "fluid", name = "water", amount = 50},
    },
  },

-- fish-meat with fish-caviar-red
  {
    type = "recipe",
    name = "fish-meat-fish-caviar-red",
    enabled = false,
    icon = "__FoodIndustry__/graphics/icons/recipes/fish-meat-fish-caviar-red.png",
    icon_size = 32,
    category = "crafting-with-fluid",
    subgroup = "foods-fish",
    order = "w-b-2",
    energy_required = 40.0,
    ingredients =
    {
        {"raw-fish", 5},
        {type = "fluid", name = "pure-water", amount = 20},
    },
    results = 
    {
        {"fish-meat-red", 5},
        {"fish-bone", 1},
        {type = "item", name = "fish-caviar-red", amount = 1, probability = 0.25},
        {type = "fluid", name = "water", amount = 20},
    },
  },
  {
    type = "recipe",
    name = "sturgeon-fish-meat-fish-caviar-red",
    enabled = false,
    icon = "__FoodIndustry__/graphics/icons/recipes/sturgeon-fish-meat-fish-caviar-red.png",
    icon_size = 32,
    category = "crafting-with-fluid",
    subgroup = "foods-fish",
    order = "w-c-2",
    energy_required = 40.0,
    ingredients =
    {
        {"fi-raw-sturgeon", 1},
        {type = "fluid", name = "pure-water", amount = 60},
    },
    results = 
    {
        {"fish-meat-red", 12},
        {"fish-bone", 3},
        {type = "item", name = "fish-caviar-red", amount = 1, probability = 0.75},
        {type = "item", name = "fish-caviar-red", amount = 1, probability = 0.5},
        {type = "fluid", name = "water", amount = 60},
    },
  },

})
