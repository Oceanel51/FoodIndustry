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
    energy_required = 30.0,
    ingredients =
    {
        {"raw-fish", 1},
        {type = "fluid", name = "water", amount = 20},
    },
    results = 
    {
        {"fish-meat-red", 4},
        {"fish-bone", 1},
        {type = "fluid", name = "water", amount = 15},
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
    energy_required = 40.0,
    ingredients =
    {
        {"raw-fish", 1},
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

})
