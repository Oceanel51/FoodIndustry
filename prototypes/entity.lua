data:extend(
{

  {
    type = "assembling-machine",
    name = "basic-farmland",
    icon = "__FoodIndustry__/graphics/icons/entities/basic-farmland.png",
    icon_size = 32,
    flags = {"placeable-neutral", "placeable-player", "player-creation", "not-repairable"},
    minable = {hardness = 0.2, mining_time = 0.5},
    max_health = 100,
    resistances =
    {
      {
        type = "physical",
        percent = 10
      }
    },  
    selection_box = {{-2.75, -2.75}, {2.75, 2.75}}, 
    collision_box = {{-2.75, -2.75}, {2.75, 2.75}},    
	collision_mask = {"item-layer", "object-layer", "water-tile", "resource-layer", "player-layer"},
	animation =
	{
      layers =
      {
        {
			filename = "__FoodIndustry__/graphics/entity/farms/basic-farmland.png",
			priority = "high",
			width = 559,
			height = 467,
			scale = 0.4,
			frame_count = 1,
			line_length = 1,
			shift = {0.45, 0.0},
        }
      }
    },
    open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
    close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
    working_sound =
    {
      sound = {
        {
          filename = "__base__/sound/assembling-machine-t2-1.ogg",
          volume = 0.0
        }
      },
      idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.0 },
      apparent_volume = 0.0,
    },
    crafting_categories = {"basic-crop-growth"},
    crafting_speed = 0.6,
	energy_source =
    {
		type = "burner",
		usage_priority = "secondary-input",
		fuel_categories = {"landfill"},		
		fuel_inventory_size = 1,
		emissions = -0.02,
		light_flicker = { intensity = 0, size = 0}, color = { r = 0.0, g = 0.0, b = 0.0 },
    },
    energy_usage = "500W", 
	ingredient_count = 1,
    module_specification =
    {
      module_slots = 0,
      module_info_icon_shift = {0, 0.5},
      module_info_multi_row_initial_height_modifier = -0.3
    },
    order = "d-a",
    allowed_effects = {}
  },  
  


	{
    type = "assembling-machine",
    name = "greenhouse",
    icon = "__FoodIndustry__/graphics/icons/entities/greenhouse.png",
    icon_size = 32,    
	flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {hardness = 0.5, mining_time = 3, result = "greenhouse"},
    max_health = 400,
    resistances =
    {
      {
        type = "acid",
        percent = 40
      },
	  {
        type = "fire",
        percent = 20
      }
    },
    fluid_boxes =
    {
      {
        production_type = "input",
        pipe_picture = assembler2pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -2,
        pipe_connections = {{ type="input", position = {0, -3} }}
      },
      off_when_no_fluid_recipe = false
    },
    selection_box = {{-2.25, -2.25}, {2.25, 2.25}}, 
    collision_box = {{-2.25, -2.25}, {2.25, 2.25}},    
	collision_mask = {"item-layer", "object-layer", "water-tile", "player-layer"},
	animation =
	{
      layers =
      {
        {
			filename = "__FoodIndustry__/graphics/entity/farms/greenhouse.png",
			priority = "high",
			width = 480,
			height = 380,
			scale = 0.5,
			frame_count = 1,
			line_length = 1,
			shift = {0.0, 0.0},
        }
      }
    },
    open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
    close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
    working_sound =
    {
      sound = {
        {
          filename = "__base__/sound/boiler.ogg",
          volume = 0.4
        }
      },
      idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.4 },
      apparent_volume = 0.9,
    },
    crafting_categories = {"advanced-crop-growth"},
    crafting_speed = 1,
	energy_source =
    {
		type = "electric",
		usage_priority = "secondary-input"
    },
    energy_usage = "150kW", 
	ingredient_count = 1,
    module_specification =
    {
      module_slots = 2,
      module_info_icon_shift = {0, 0.5},
      module_info_multi_row_initial_height_modifier = -0.3
    },
    order = "d-b",
    allowed_effects = {"consumption"}
  },
  
  {
    type = "assembling-machine",
    name = "big-greenhouse",
    icon = "__FoodIndustry__/graphics/icons/entities/big-greenhouse.png",
    icon_size = 32,    
	flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {hardness = 0.5, mining_time = 4, result = "big-greenhouse"},
    max_health = 600,
    resistances =
    {
      {
        type = "acid",
        percent = 40
      },
	  {
        type = "fire",
        percent = 20
      }
    },
    fluid_boxes =
    {
      {
        production_type = "input",
        pipe_picture = assembler2pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -2,
        pipe_connections = {{ type="input", position = {2.5, -4.5}},{ type="input", position = {-2.5, -4.5} }}
      },
      off_when_no_fluid_recipe = false
    },
    selection_box = {{-3.75, -3.75}, {3.75, 3.75}}, 
    collision_box = {{-3.75, -3.75}, {3.75, 3.75}},    
	collision_mask = {"item-layer", "object-layer", "water-tile", "player-layer"},
	animation =
	{
      layers =
      {
        {
			filename = "__FoodIndustry__/graphics/entity/farms/big-greenhouse.png",
			priority = "high",
			width = 768,
			height = 608,
			scale = 0.5,
			frame_count = 1,
			line_length = 1,
			shift = {0.0, 0.0},
        }
      }
    },
    open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
    close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
    working_sound =
    {
      sound = {
        {
          filename = "__base__/sound/boiler.ogg",
          volume = 0.4
        }
      },
      idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.4 },
      apparent_volume = 1.3,
    },
    crafting_categories = {"advanced-crop-growth"},
    crafting_speed = 2.5,
	energy_source =
    {
		type = "electric",
		usage_priority = "secondary-input"
    },
    energy_usage = "360kW", 
	ingredient_count = 1,
    module_specification =
    {
      module_slots = 3,
      module_info_icon_shift = {0, 0.5},
      module_info_multi_row_initial_height_modifier = -0.3
    },
    order = "d-c",
    allowed_effects = {"consumption"}
  },
  
  
  {
    type = "assembling-machine",
    name = "incubator",
    icon = "__FoodIndustry__/graphics/icons/entities/incubator.png",
    icon_size = 32,    
	flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {hardness = 0.6, mining_time = 3, result = "incubator"},
    max_health = 700,
    resistances =
    {
      {
        type = "acid",
        percent = 80
      },
	  {
        type = "fire",
        percent = 60
      }
    },
    fluid_boxes =
    {
      {
        production_type = "input",
        pipe_picture = assembler2pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -2,
        pipe_connections = {{ type="input", position = {2.0, -4.0}},{ type="input", position = {-2.0, -4.0} }}
      },
      off_when_no_fluid_recipe = false
    },
    selection_box = {{-3.25, -3.25}, {3.25, 3.25}}, 
    collision_box = {{-3.25, -3.25}, {3.25, 3.25}},    
	collision_mask = {"item-layer", "object-layer", "water-tile", "player-layer"},
	animation =
	{
      layers =
      {
        {
			filename = "__FoodIndustry__/graphics/entity/farms/incubator.png",
			priority = "high",
			width = 672,
			height = 532,
			scale = 0.5,
			frame_count = 1,
			line_length = 1,
			shift = {0.0, 0.0},
        }
      }
    },
    open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
    close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
    working_sound =
    {
      sound = {
        {
          filename = "__base__/sound/boiler.ogg",
          volume = 0.4
        }
      },
      idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.4 },
      apparent_volume = 1.3,
    },
    crafting_categories = {"advanced-crop-growth"},
    crafting_speed = 4,
	energy_source =
    {
		type = "electric",
		usage_priority = "secondary-input"
    },
    energy_usage = "1MW", 
	ingredient_count = 1,
    module_specification =
    {
      module_slots = 3,
      module_info_icon_shift = {0, 0.5},
      module_info_multi_row_initial_height_modifier = -0.3
    },
    order = "d-c",
    allowed_effects = {"consumption", "speed", "productivity", "pollution"}
  },
  
  
  
  
  {
    type = "furnace",
    name = "fi-composter",
    icon = "__FoodIndustry__/graphics/icons/entities/composter.png",
    icon_size = 32,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {hardness = 0.3, mining_time = 1, result = "fi-composter"},
    max_health = 200,
    resistances =
    {
      {
        type = "acid",
        percent = 20
      }
    },    
    selection_box = {{-0.75, -0.75}, {0.75, 0.75}}, 
    collision_box = {{-0.75, -0.75}, {0.75, 0.75}},    
	collision_mask = {"item-layer", "object-layer", "water-tile", "player-layer"},
	animation =
	{
      layers =
      {
        {
			filename = "__FoodIndustry__/graphics/entity/machines/composter.png",
			priority = "high",
			width = 1040/8,
			height = 760/8,
			scale = 0.5,
			frame_count = 64,
			line_length = 8,
			shift = {18/64, 0.0},
        }
      }
    },
    open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
    close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
    working_sound =
    {
      sound = {
        {
          filename = "__base__/sound/assembling-machine-t2-1.ogg",
          volume = 0.0
        }
      },
      idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.0 },
      apparent_volume = 0.0,
    },
    crafting_categories = {"composting"},
    crafting_speed = 1,
	energy_source =
    {
		type = "burner",
		usage_priority = "secondary-input",	
		fuel_categories = {"plant"},
		fuel_inventory_size = 1,
		light_flicker = { intensity = 0, size = 0}, color = { r = 0.0, g = 0.0, b = 0.0 },
    },
    energy_usage = "1W",
	source_inventory_size = 1,
	result_inventory_size = 1,
    module_specification =
    {
      module_slots = 0,
      module_info_icon_shift = {0, 0.5},
      module_info_multi_row_initial_height_modifier = -0.3
    },
    order = "d-e",
    allowed_effects = {}
  },
  {
    type = "furnace",
    name = "electric-composter",
    icon = "__FoodIndustry__/graphics/icons/entities/electric-composter.png",
    icon_size = 32,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {hardness = 0.3, mining_time = 3, result = "electric-composter"},
    max_health = 500,
    resistances =
    {      
    },    
    selection_box = {{-1.65, -1.65}, {1.65, 1.65}}, 
    collision_box = {{-1.65, -1.65}, {1.65, 1.65}},    
	collision_mask = {"item-layer", "object-layer", "water-tile", "player-layer"},
	fluid_boxes =
    {
      {
        production_type = "input",
        pipe_picture = assembler2pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -2,
        pipe_connections = {{ type="input", position = {0.5, 2.5}}, { type="input", position = {-0.5, -2.5}}}
      },
      off_when_no_fluid_recipe = false
    },
	animation = {
        layers = {
          {
            filename = "__base__/graphics/entity/electric-furnace/electric-furnace-base.png",
            frame_count = 1,
            height = 100,
            hr_version = {
              filename = "__base__/graphics/entity/electric-furnace/hr-electric-furnace.png",
              frame_count = 1,
              height = 219,
              priority = "high",
              scale = 0.6,
              shift = {
                0.0234375,
                0.1796875
              },
              width = 239,
			  tint = {r=0.5,g=0.8,b=1,a=0.5}
            },
            priority = "high",
            shift = {
              0.421875,
              0
            },			 
			scale = 1.2,
            width = 129,
			tint = {r=0.5,g=0.8,b=1,a=0.5}
          },
          {
            draw_as_shadow = true,
            filename = "__base__/graphics/entity/electric-furnace/electric-furnace-shadow.png",
            frame_count = 1,
            height = 100,
            hr_version = {
              draw_as_shadow = true,
              filename = "__base__/graphics/entity/electric-furnace/hr-electric-furnace-shadow.png",
              frame_count = 1,
              height = 171,
              priority = "high",
              scale = 0.6,
              shift = {
                0.3515625,
                0.2421875
              },
              width = 227
            },
            priority = "high",
            shift = {
              0.421875,
              0
            },
			scale = 1.2,
            width = 129			
          }
        }
      },
    open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
    close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
    working_sound =
    {
      sound = {
        {
          filename = "__base__/sound/chemical-plant.ogg",
          volume = 0.0
        }
      },
      idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.0 },
      apparent_volume = 1.0,
    },
    crafting_categories = {"auto-composting"},
    crafting_speed = 1,
	energy_source =
    {
		type = "electric",
		usage_priority = "secondary-input",
		emissions = 0.004
    },
    energy_usage = "800kW",
    module_specification =
    {
      module_slots = 4,
      module_info_icon_shift = {0, 0.5},
      module_info_multi_row_initial_height_modifier = -0.3
    },
    order = "d-e",
    allowed_effects = {"speed", "consumption", "pollution"},
	source_inventory_size = 1,
	result_inventory_size = 1,	
    },
  
  
  
  

  {
    type = "assembling-machine",
    name = "burner-cooker",
    icon = "__FoodIndustry__/graphics/icons/entities/burner-cooker.png",
    icon_size = 32,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {hardness = 0.3, mining_time = 1, result = "burner-cooker"},
    max_health = 200,
    resistances =
    {      
    },    
    selection_box = {{-0.95, -0.95}, {0.95, 0.95}}, 
    collision_box = {{-0.95, -0.95}, {0.95, 0.95}},    
	collision_mask = {"item-layer", "object-layer", "water-tile", "player-layer"},
	fluid_boxes =
    {
      {
        production_type = "input",
        pipe_picture = assembler2pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -2,
        pipe_connections = {{ type="input", position = {1.5, 0.5}}}
      },
      off_when_no_fluid_recipe = false
    },
	animation = {
        layers = {
          {
            filename = "__FoodIndustry__/graphics/entity/machines/burner-cooker.png",
            frame_count = 1,
            height = 64,            
            priority = "extra-high",
            shift = {
              0.515625,
              0.0625
            },
            width = 81
          },
        }
      },
    open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
    close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
    working_sound =
    {
      sound = {
        {
          filename = "__base__/sound/chemical-plant.ogg",
          volume = 1.0
        },
		{
          filename = "__base__/sound/furnace.ogg",
          volume = 0.8
        }
      },
      idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.0 },
      apparent_volume = 1.0,
    },
    crafting_categories = {"cooking"},
    crafting_speed = 0.75,
	energy_source =
    {
		type = "burner",
		usage_priority = "secondary-input",	
		fuel_categories = {"chemical"},
		fuel_inventory_size = 1,
		light_flicker = { intensity = 0, size = 0}, color = { r = 1.0, g = 0.9, b = 0.8 },
		emissions = 0.015
    },
    energy_usage = "30kW",
    ingredient_count = 8,
    module_specification =
    {
      module_slots = 0,
      module_info_icon_shift = {0, 0.5},
      module_info_multi_row_initial_height_modifier = -0.3
    },
    order = "d-e",
    allowed_effects = {},
  }, 
  {
    type = "assembling-machine",
    name = "electric-cooker",
    icon = "__FoodIndustry__/graphics/icons/entities/electric-cooker.png",
    icon_size = 32,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {hardness = 0.3, mining_time = 1, result = "electric-cooker"},
    max_health = 200,
    resistances =
    {      
    },    
    selection_box = {{-0.95, -0.95}, {0.95, 0.95}}, 
    collision_box = {{-0.95, -0.95}, {0.95, 0.95}},    
	collision_mask = {"item-layer", "object-layer", "water-tile", "player-layer"},
	fluid_boxes =
    {
      {
        production_type = "input",
        pipe_picture = assembler2pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -2,
        pipe_connections = {{ type="input", position = {1.5, 0.5}}}
      },
	  {
        production_type = "output",
        pipe_picture = assembler2pipepictures(),
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = 1,
        pipe_connections = {{ type="output", position = {-1.5, -0.5}}}
      },
      off_when_no_fluid_recipe = false
    },
	animation =
	{
      layers =
      {
        {
            filename = "__FoodIndustry__/graphics/entity/machines/electric-cooker.png",
            frame_count = 1,
            height = 64,            
            priority = "extra-high",
            shift = {
             0.515625,
              0.0625
            },
            width = 81
          },
      }
    },
    open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
    close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
    working_sound =
    {
      sound = {
        {
          filename = "__base__/sound/chemical-plant.ogg",
          volume = 1.0
        }
      },
      idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.0 },
      apparent_volume = 1.0,
    },
    crafting_categories = {"cooking", "mixing"},
    crafting_speed = 1,
	energy_source =
    {
		type = "electric",
		usage_priority = "secondary-input",
		emissions = 0.004
    },
    energy_usage = "50kW",
    ingredient_count = 8,
    module_specification =
    {
      module_slots = 2,
      module_info_icon_shift = {0, 0.5},
      module_info_multi_row_initial_height_modifier = -0.3
    },
    order = "d-e",
    allowed_effects = {"speed", "consumption", "pollution"},
  },
  
  
  --[[{
    type = "simple-entity",
    name = "used-land",
    icon = "__FoodIndustry__/graphics/icons/used-land.png",
    icon_size = 32,
    flags = {"placeable-neutral", "placeable-player", "player-creation", "not-deconstructable", "not-repairable", "not-rotatable"},
	minable = {hardness = 8000000, minable = false, mining_time = 0},
    selection_box = {{0.5, 0.5}, {-0.5, -0.5}}, 
    collision_box = {{-1.9, -1.9}, {1.9, 1.9}},    
	collision_mask = {"resource-layer"},
	max_health = 1,
	resistances =
    {
      {
        type = "physical",
        percent = 100
      },
	  {
        type = "explosion",
        percent = 100
      },
	  {
        type = "acid",
        percent = 100
      },
	  {
        type = "fire",
        percent = 100
      }
    }, 
	render_layer = "water-tile", 
	picture =
    {        
		filename = "__FoodIndustry__/graphics/entity/farms/used-land.png",
		priority = "medium",
		width = 128,
		height = 128,        
    },	    
    order = "d-a",
  },]]
})