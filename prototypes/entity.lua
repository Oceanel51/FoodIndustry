data:extend(
{

  {
    type = "assembling-machine",
    name = "fi-basic-farmland",
    icon = "__FoodIndustry__/graphics/icons/entities/fi-basic-farmland.png",
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
      layers = {
        {
			filename = "__FoodIndustry__/graphics/entity/farms/fi-basic-farmland.png",
			priority = "high",
			width = 559,
			height = 467,
			scale = 0.4,
			frame_count = 1,
			line_length = 1,
			shift = {0.45, 0.0},
        },
        {
			filename = "__FoodIndustry__/graphics/entity/fi-table-wood1.png",
			priority = "high",
			width = 168,
			height = 138,
			scale = 0.16,
			frame_count = 1,
			shift = {-2.03, 2.11},
        },
        {
			draw_as_shadow = true,
            filename = "__FoodIndustry__/graphics/entity/fi-table-wood1-shadow.png",
			priority = "high",
			width = 398,
			height = 201,
			scale = 0.16,
			frame_count = 1,
			shift = {-1.40, 2.24},
        }
      }
    },
    working_visualisations =
    {
      {
        animation =
        {
            filename = "__FoodIndustry__/graphics/entity/farms/fi-basic-farmland-working2.png",
            priority = "high",
            width = 481,
            height = 337,
            frame_count = 8,
            line_length = 4,
            animation_speed = 0.14,
            shift = {0.722, -0.426},
            scale = 0.4,
			run_mode = "forward-then-backward",
        }
        --[[animation =
        {
            filename = "__FoodIndustry__/graphics/entity/farms/fi-basic-farmland-working.png",
            priority = "high",
            width = 481,
            height = 337,
            frame_count = 24,
            line_length = 4,
            animation_speed = 0.08,
            shift = {0.722, -0.426},
            scale = 0.4,
			--repeat_count = 1,
        }]]
      },
      {
        animation =
        {
			filename = "__FoodIndustry__/graphics/entity/fi-table-wood1.png",
			priority = "high",
			width = 168,
			height = 138,
			scale = 0.16,
			frame_count = 1,
			shift = {-2.03, 2.11},
        },
        {
			draw_as_shadow = true,
            filename = "__FoodIndustry__/graphics/entity/fi-table-wood1-shadow.png",
			priority = "high",
			width = 398,
			height = 201,
			scale = 0.16,
			frame_count = 1,
			shift = {-1.40, 2.24},
        }
      },
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
		fuel_categories = {"humus"},		-- changed by Oceanel
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
    name = "fi-greenhouse",
    icon = "__FoodIndustry__/graphics/icons/entities/fi-greenhouse.png",
    icon_size = 32,    
	flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {hardness = 0.5, mining_time = 3, result = "fi-greenhouse"},
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
			filename = "__FoodIndustry__/graphics/entity/farms/fi-greenhouse.png",
			priority = "high",
			width = 426,
			height = 438,
			scale = 0.351,
			frame_count = 1,
			--line_length = 1,
			shift = {-0.022, -0.008},
        },
        {
            filename = "__FoodIndustry__/graphics/entity/fi-mashines-propeller1.png",
            priority = "high",
            width = 97,
            height = 69,
            frame_count = 1,
            shift = {-1.14, 0.28},
            scale = 0.32,
            hr_version = {
              filename = "__FoodIndustry__/graphics/entity/fi-mashines-propeller1.png",
              frame_count = 1,
              width = 97,
              height = 69,
              priority = "high",
              scale = 0.32,
              shift = {-1.14, 0.28},
            }
        },
        {
			draw_as_shadow = true,
            filename = "__FoodIndustry__/graphics/entity/farms/fi-greenhouse-shadow.png",
			priority = "high",
			width = 609,
			height = 442,
			scale = 0.351,
			frame_count = 1,
			shift = {0.998, 0.012},
        }
      }
    },
    -----------------
    working_visualisations = {
      {
        animation =
        {
            filename = "__FoodIndustry__/graphics/entity/farms/fi-greenhouse-working.png",
            priority = "high",
            width = 426,
            height = 438,
            line_length = 4,
            frame_count = 8,
            animation_speed = 0.06,
            shift = {-0.022, -0.008},
            scale = 0.351,
            hr_version =
            {
              filename = "__FoodIndustry__/graphics/entity/farms/fi-greenhouse-working.png",
              priority = "high",
              width = 426,
              height = 438,
              line_length = 4,
              frame_count = 8,
              animation_speed = 0.1,
              shift = {-0.022, -0.008},
              scale = 0.351
            }
        }
      },
      {
        animation =
        {
          filename = "__FoodIndustry__/graphics/entity/fi-mashines-propeller1-working.png",
          priority = "high",
          width = 97,
          height = 69,
          --line_length = 1,
          frame_count = 9,
          animation_speed = 0.4,
          shift = {-1.14, 0.28},
          scale = 0.32,
          hr_version =
          {
            filename = "__FoodIndustry__/graphics/entity/fi-mashines-propeller1-working.png",
            priority = "high",
            width = 97,
            height = 69,
            frame_count = 9,
            animation_speed = 0.4,
            shift = {-1.14, 0.28},
            scale = 0.32
          }
        }
      },
    },
    ----------
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
    name = "fi-big-greenhouse",
    icon = "__FoodIndustry__/graphics/icons/entities/fi-big-greenhouse.png",
    icon_size = 32,    
	flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {hardness = 0.5, mining_time = 4, result = "fi-big-greenhouse"},
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
			filename = "__FoodIndustry__/graphics/entity/farms/fi-big-greenhouse.png",
			priority = "high",
			width = 572,
			height = 589,
			scale = 0.43,
			frame_count = 1,
			line_length = 1,
			shift = {0.0, -0.1},
          },
          {
            filename = "__FoodIndustry__/graphics/entity/fi-mashines-propeller1.png",
            priority = "high",
            width = 97,
            height = 69,
            frame_count = 1,
            shift = {0.0, -0.0},
            scale = 0.43,
            --tint = {r=0.5,g=0.8,b=1,a=0.5},
          },
          {
            draw_as_shadow = true,
            filename = "__FoodIndustry__/graphics/entity/machines/fi-electric-composter-shadow.png",
            priority = "high",
            width = 499,
            height = 381,
            frame_count = 1,
            shift = {0.76, -0.044},
            scale = 0.32,
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
    name = "fi-incubator",
    icon = "__FoodIndustry__/graphics/icons/entities/fi-incubator.png",
    icon_size = 32,    
	flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {hardness = 0.6, mining_time = 3, result = "fi-incubator"},
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
			filename = "__FoodIndustry__/graphics/entity/farms/fi-incubator.png",
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



---- Composters
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
			width = 130,
			height = 95,
			scale = 0.5,
			frame_count = 1,
			--line_length = 8,
			shift = {18/64, 0.0},
        },
        {
			filename = "__FoodIndustry__/graphics/entity/fi-table-wood1.png",
			priority = "high",
			width = 168,
			height = 138,
			scale = 0.1,
			frame_count = 1,
			shift = {0.01, 0.41},
        },
        {
			draw_as_shadow = true,
            filename = "__FoodIndustry__/graphics/entity/fi-table-wood1-shadow.png",
			priority = "high",
			width = 398,
			height = 201,
			scale = 0.1,
			frame_count = 1,
			shift = {0.38, 0.50},
        }
      }
    },
    working_visualisations = {
      {
        animation =
        {
			filename = "__FoodIndustry__/graphics/entity/machines/composter-working.png",
			priority = "high",
			width = 1040/8,
			height = 760/8,
			scale = 0.5,
			frame_count = 64,
			line_length = 8,
			shift = {18/64, 0.0},
        },
      },
      {
        animation =
        {
			filename = "__FoodIndustry__/graphics/entity/fi-table-wood1.png",
			priority = "high",
			width = 168,
			height = 138,
			scale = 0.1,
			frame_count = 1,
			shift = {0.01, 0.41},
        },
        {
			draw_as_shadow = true,
            filename = "__FoodIndustry__/graphics/entity/fi-table-wood1-shadow.png",
			priority = "high",
			width = 398,
			height = 201,
			scale = 0.1,
			frame_count = 1,
			shift = {0.38, 0.50},
        }
      },
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
    name = "fi-electric-composter",
    icon = "__FoodIndustry__/graphics/icons/entities/fi-electric-composter-icon.png",
    icon_size = 64,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {hardness = 0.3, mining_time = 3, result = "fi-electric-composter"},
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
            filename = "__FoodIndustry__/graphics/entity/machines/fi-electric-composter.png",
            priority = "high",
            width = 342,
            height = 377,
            frame_count = 1,
            shift = {0.0, -0.055},
            scale = 0.32,
            --tint = {r=0.5,g=0.8,b=1,a=0.5},
            hr_version = {
              filename = "__FoodIndustry__/graphics/entity/machines/fi-electric-composter.png",
              frame_count = 1,
              width = 342,
              height = 377,
              priority = "high",
              scale = 0.32,
              shift = {0.0, -0.055},
              --tint = {r=0.5,g=0.8,b=1,a=0.5}
            }
          },
          {
            filename = "__FoodIndustry__/graphics/entity/fi-mashines-propeller1.png",
            priority = "high",
            width = 97,
            height = 69,
            frame_count = 1,
            shift = {0.75, -0.45},
            scale = 0.32,
            --tint = {r=0.5,g=0.8,b=1,a=0.5},
            hr_version = {
              filename = "__FoodIndustry__/graphics/entity/fi-mashines-propeller1.png",
              frame_count = 1,
              width = 97,
              height = 69,
              priority = "high",
              scale = 0.32,
              shift = {0.0, -0.055},
              --tint = {r=0.5,g=0.8,b=1,a=0.5}
            }
          },
          {
            draw_as_shadow = true,
            filename = "__FoodIndustry__/graphics/entity/machines/fi-electric-composter-shadow.png",
            priority = "high",
            width = 499,
            height = 381,
            frame_count = 1,
            shift = {0.76, -0.044},
            scale = 0.32,
            hr_version = {
              draw_as_shadow = true,
              filename = "__FoodIndustry__/graphics/entity/machines/fi-electric-composter-shadow.png",
              priority = "high",
              width = 499,
              height = 381,
              frame_count = 1,
              scale = 0.32,
              shift = {0.76, -0.042},
            }
          }
        }
      },
	  
-----------------
    working_visualisations =
    {
      {
        animation =
        {
          filename = "__FoodIndustry__/graphics/entity/machines/fi-electric-composter-working.png",
          priority = "high",
          width = 342,
          height = 377,
          line_length = 5,
          frame_count = 24,
          animation_speed = 0.3,
          shift = {0, -0.055},
          scale = 0.32,
          hr_version =
          {
            filename = "__FoodIndustry__/graphics/entity/machines/fi-electric-composter-working.png",
            priority = "high",
            width = 342,
            height = 377,
            line_length = 6,
            frame_count = 12,
            animation_speed = 0.5,
            shift = util.by_pixel(0, 0),
            scale = 0.32
          }
        }
      },
      --[[{
        animation =
        {
          filename = "__base__/graphics/entity/electric-furnace/electric-furnace-heater.png",
          priority = "high",
          width = 25,
          height = 15,
          frame_count = 12,
          animation_speed = 0.5,
          shift = {0.015625, 0.890625},
          hr_version =
          {
            filename = "__base__/graphics/entity/electric-furnace/hr-electric-furnace-heater.png",
            priority = "high",
            width = 60,
            height = 56,
            frame_count = 12,
            animation_speed = 0.5,
            shift = util.by_pixel(1.75, 32.75),
            scale = 0.5
          }
        },
        light = {intensity = 0.4, size = 6, shift = {0.0, 1.0}, color = {r = 1.0, g = 1.0, b = 1.0}}
      },]]
      {
        animation =
        {
          filename = "__FoodIndustry__/graphics/entity/fi-mashines-propeller1-working.png",
          priority = "high",
          width = 97,
          height = 69,
          --line_length = 1,
          frame_count = 9,
          animation_speed = 0.6,
          shift = {0.75, -0.46},
          scale = 0.32,
          hr_version =
          {
            filename = "__FoodIndustry__/graphics/entity/fi-mashines-propeller1-working.png",
            priority = "high",
            width = 97,
            height = 69,
            frame_count = 9,
            animation_speed = 0.6,
            shift = {0.75, -0.45},
            scale = 0.32
          }
        }
      },
      --[[{
        animation =
        {
          filename = "__base__/graphics/entity/electric-furnace/electric-furnace-propeller-2.png",
          priority = "high",
          width = 12,
          height = 9,
          frame_count = 4,
          animation_speed = 0.5,
          shift = {0.0625, -1.234375},
          hr_version =
          {
            filename = "__base__/graphics/entity/electric-furnace/hr-electric-furnace-propeller-2.png",
            priority = "high",
            width = 23,
            height = 15,
            frame_count = 4,
            animation_speed = 0.5,
            shift = util.by_pixel(3.5, -38),
            scale = 0.5
          }
        }
      }]]
    },
-----------------
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
  
  
  
  
  ---- Cookers
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