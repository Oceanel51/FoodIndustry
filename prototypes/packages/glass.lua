if data.raw.item["glass"] then

data:extend({
  
  --TODO add glass tara: item, recipes
  {
    type = "item",
    name = "glass-bottle",
    icon = "__FoodIndustry__/graphics/icons/items/raw-straw.png",
    icon_size = 32,

    subgroup = "drink-empty-packages",
    order = "a-e",
    stack_size = 20,
    --fuel_category = "ore",
    --fuel_value = "5J"
  },

  {
    type = "recipe",
    name = "glass-bottle",
    order = "a-d-a",
    enabled = false,
    icon = "__FoodIndustry__/graphics/icons/items/plastic-bottle.png",
    icon_size = 64,
    category = "crafting",
    subgroup = "drink-empty-packages",
    energy_required = 4.0,
    ingredients =
    {
      {"glass", 1},
    },
    results =
    {
      {"glass-bottle", 2}
    }
    },
  
})

end
