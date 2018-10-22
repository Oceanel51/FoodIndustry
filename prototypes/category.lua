data:extend(
{
  {
    type = "item-group",
    name = "food-industry",
    order = "e-a",
    inventory_order = "c-a",
    icon = "__FoodIndustry__/graphics/icons/fi-logo-icon.png",
    icon_size = 128,
  },
  {
    type = "item-subgroup",
    name = "food-machines",
    group = "food-industry",
    order = "w-a",
  },
  {
    type = "item-subgroup",
    name = "food-items",
    group = "food-industry",
    order = "w-b-a",
  },
  {
    type = "item-subgroup",
    name = "food-fluids",
    group = "food-industry",
    order = "w-b-c",
  },
  {
    type = "item-subgroup",
    name = "foods",
    group = "food-industry",
    order = "w-d",
  },
  {
    type = "item-subgroup",
    name = "effect",
    group = "food-industry",
    order = "w-e",
  },
  {
    type = "item-subgroup",
    name = "food-intermediates",
    group = "food-industry",
    order = "w-f",
  },
  {
    type = "item-subgroup",
    name = "food-composting",
    group = "food-industry",
    order = "w-g",
  },
  {
    type = "recipe-category",
    name = "basic-crop-growth",	
  } ,
  {
    type = "recipe-category",
    name = "advanced-crop-growth",	
  },
  {
    type = "recipe-category",
    name = "composting",	
  },
  {
    type = "recipe-category",
    name = "auto-composting",	
  },  
  {
    type = "recipe-category",
    name = "cooking",	
  },
  {
    type = "recipe-category",
    name = "mixing",	
  },
  {
    type = "fuel-category",
    name = "plant",	
  },
  {
    type = "fuel-category",
    name = "humus",	 -- changed by Oceanel
  },
	{
    type = "autoplace-control",
    category = "resource",
    name = "food-plant",
    order = "w",
    richness = false,
	}, 
	{
    type = "autoplace-control",
    category = "resource",
    name = "oil-plant",
    order = "w",
    richness = false,
	}, 	
})