data:extend({

-- fish-meat-red
  {
    type = "item",
    name = "fish-meat-red",
    icon = "__FoodIndustry__/graphics/icons/items/fish-meat-red.png",
    icon_size = 32,
    flags = {"goes-to-main-inventory"},
    subgroup = "foods-fish",
    order = "w-a-a",
    stack_size = 50
  },

  {
    type = "item",
    name = "caviar-red",
    icon = "__FoodIndustry__/graphics/icons/foods/caviar-red.png",
    icon_size = 32,
    flags = {"goes-to-main-inventory"},
    subgroup = "foods-fish",
    order = "w-a-b",
    stack_size = 100
  },

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
        {type = "fluid", name = "water", amount = 15},
    },
  },

-- fish-meat with caviar-red
  {
    type = "recipe",
    name = "fish-meat-caviar-red",
    enabled = false,
    icon = "__FoodIndustry__/graphics/icons/recipes/fish-meat-caviar-red.png",
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
        {"fish-meat-red", 4},
        {type = "item", name = "caviar-red", amount = 1, probability = 0.25},
        {type = "fluid", name = "water", amount = 20},
    },
  },

})
