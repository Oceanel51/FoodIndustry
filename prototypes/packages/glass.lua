if data.raw.item["glass"] then

data:extend({
  
  --TODO add glass tara: item, recipes
  {
    type = "item",
    name = "glass-bottle",
    icon = "__FoodIndustry__/graphics/icons/items/raw-straw.png",
    icon_size = 32,
    flags = {"goes-to-main-inventory"},
    subgroup = "drink-empty-packages",
    order = "a-e",
    stack_size = 20,
    --fuel_category = "ore",
    --fuel_value = "5J"
  },


})

end
