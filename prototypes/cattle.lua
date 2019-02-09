require ("prototypes.cattle-autoplace")
require ("prototypes.cattle-spawner-animation")

local cattlescale = 0.5
local calfscale = 0.25

-- spawner
-- feeder
-- butcher
-- cattle
-- cattle-calf
data:extend({
    {
        type = "unit",
        name = "cattle",
        icon = "__base__/graphics/icons/small-biter.png",
        icon_size = 32,
        flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "not-repairable", "breaths-air"},
        max_health = 15,
        order = "b-b-a",
        subgroup="enemies",
        healing_per_tick = 0.01,
        collision_box = {{-0.2, -0.2}, {0.2, 0.2}},
        selection_box = {{-0.4, -0.7}, {0.7, 0.4}},
        attack_parameters =
        {
            type = "projectile",
            range = 0,
            cooldown = 35,
            ammo_category = "melee",
            ammo_type = make_unit_melee_ammo_type(0),
            sound = make_biter_roars(0.4),
            animation = biterattackanimation(cattlescale, small_biter_tint1, small_biter_tint2)
        },
        vision_distance = 30,
        movement_speed = 0.2,
        distance_per_frame = 0.1,
        pollution_to_join_attack = 200,
        distraction_cooldown = 300,
        min_pursue_time = 10 * 60,
        max_pursue_distance = 50,
        corpse = "small-biter-corpse",
        dying_explosion = "blood-explosion-small",
        dying_sound =  make_biter_dying_sounds(0.4),
        working_sound =  make_biter_calls(0.3),
        run_animation = biterrunanimation(cattlescale, small_biter_tint1, small_biter_tint2)
    },
    {
        type = "unit",
        name = "cattle-calf",
        icon = "__base__/graphics/icons/small-biter.png",
        icon_size = 32,
        flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "not-repairable", "breaths-air"},
        max_health = 5,
        order = "b-b-a",
        subgroup="enemies",
        healing_per_tick = 0.01,
        collision_box = {{-0.2, -0.2}, {0.2, 0.2}},
        selection_box = {{-0.4, -0.7}, {0.7, 0.4}},
        attack_parameters =
        {
            type = "projectile",
            range = 0,
            cooldown = 35,
            ammo_category = "melee",
            ammo_type = make_unit_melee_ammo_type(0),
            sound = make_biter_roars(0.4),
            animation = biterattackanimation(calfscale, small_biter_tint1, small_biter_tint2)
        },
        vision_distance = 30,
        movement_speed = 0.2,
        distance_per_frame = 0.1,
        pollution_to_join_attack = 200,
        distraction_cooldown = 300,
        min_pursue_time = 10 * 60,
        max_pursue_distance = 50,
        corpse = "small-biter-corpse",
        dying_explosion = "blood-explosion-small",
        dying_sound =  make_biter_dying_sounds(0.4),
        working_sound =  make_biter_calls(0.3),
        run_animation = biterrunanimation(calfscale, small_biter_tint1, small_biter_tint2)
    },

})

-- cattle spawner
spitter_spawner_tint = {r=0.99, g=0.09, b=0.09, a=1}

data:extend({
    {
        type = "item",
        name = "cattle-spawner",
        icon = "__base__/graphics/icons/biter-spawner.png",
        icon_size = 32,
        flags = {"goes-to-quickbar"},
        subgroup = "cattle",
        order = "a",
        place_result = "cattle-spawner",
        stack_size = 50
    },
    {
        type = "unit-spawner",
        name = "cattle-spawner",
        icon = "__base__/graphics/icons/biter-spawner.png",
        icon_size = 32,
        flags = {"placeable-player", "placeable-enemy", "not-repairable"},
        minable = {hardness = 0.2, mining_time = 2.0, result = "cattle-spawner"},
        max_health = 350,
        order="b-b-h",
        subgroup="cattle",
        working_sound =
        {
            sound =
            {
                {
                    filename = "__base__/sound/creatures/spawner.ogg",
                    volume = 1.0
                }
            },
            apparent_volume = 2
        },
        dying_sound =
        {
            {
                filename = "__base__/sound/creatures/spawner-death-1.ogg",
                volume = 1.0
            },
            {
                filename = "__base__/sound/creatures/spawner-death-2.ogg",
                volume = 1.0
            }
        },
        resistances =
        {
            {
                type = "physical",
                decrease = 2,
                percent = 15
            },
            {
                type = "explosion",
                decrease = 5,
                percent = 15
            },
            {
                type = "fire",
                decrease = 3,
                percent = 60
            }
        },
        healing_per_tick = 0.02,
        collision_box = {{-3.2, -2.2}, {2.2, 2.2}},
        selection_box = {{-3.5, -2.5}, {2.5, 2.5}},
        pollution_absorbtion_absolute = 20,
        pollution_absorbtion_proportional = 0.01,
        corpse = "spitter-spawner-corpse",
        dying_explosion = "blood-explosion-huge",
        max_count_of_owned_units = 7,
        max_friends_around_to_spawn = 5,
        animations =
        {
            spawner_idle_animation(0, spitter_spawner_tint),
            spawner_idle_animation(1, spitter_spawner_tint),
            spawner_idle_animation(2, spitter_spawner_tint),
            spawner_idle_animation(3, spitter_spawner_tint)
        },
--        result_units = {
--            {
--                unit = "cattle",
--                spawn_points = { 0, 0 }
--            },
--            {
--                unit = "cattle",
--                spawn_points = { 1, 1 }
--            }
--        },
        result_units = (function()
            local res = {}
            res[1] = {"cattle-calf", {{0.0, 0.3}, {0.35, 0}}}
            res[2] = {"cattle-calf", {{0.25, 0.0}, {0.5, 0.3}, {0.7, 0.0}}}
            res[3] = {"cattle-calf", {{0.4, 0.0}, {0.7, 0.3}, {0.9, 0.1}}}
            res[4] = {"cattle-calf", {{0.5, 0.0}, {1.0, 0.4}}}
            res[5] = {"cattle", {{0.9, 0.0}, {1.0, 0.3}}}
            return res
        end)(),
        -- With zero evolution the spawn rate is 6 seconds, with max evolution it is 2.5 seconds
        spawning_cooldown = {360, 150},
        spawning_radius = 10,
        spawning_spacing = 3,
        max_spawn_shift = 0,
        max_richness_for_spawn_shift = 100,
        --autoplace = enemy_spawner_autoplace(1),
        call_for_help_radius = 50
    },
    {
        type = "recipe",
        name = "cattle-spawner",
        enabled = false,
        ingredients =
        {
            {"iron-plate", 1}
        },
        result = "cattle-spawner"
    },




    })


data:extend({
    {
        type = "container",
        name = "cattle-feeder",
        icon = "__FoodIndustry__/graphics/icons/entities/cattle-feeder.png",
        icon_size = 32,
        flags = {"placeable-neutral", "player-creation"},
        minable = {mining_time = 1, result = "cattle-feeder"},
        max_health = 400,
        corpse = "small-remnants",
        collision_box = {{-0.35, -0.35}, {0.35, 0.35}},
        fast_replaceable_group = "container",
        selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
        inventory_size = 16,
        open_sound = { filename = "__base__/sound/metallic-chest-open.ogg", volume=0.65 },
        close_sound = { filename = "__base__/sound/metallic-chest-close.ogg", volume = 0.7 },
        vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
        picture =
        {
            filename = "__FoodIndustry__/graphics/entity/cattle/cattle-feeder.png",
            priority = "extra-high",
            width = 48,
            height = 34,
            shift = {0.1875, 0}
        },
        circuit_wire_connection_point = circuit_connector_definitions["chest"].points,
        circuit_connector_sprites = circuit_connector_definitions["chest"].sprites,
        circuit_wire_max_distance = default_circuit_wire_max_distance
    },

    {
        type = "item",
        name = "cattle-feeder",
        icon = "__FoodIndustry__/graphics/icons/entities/cattle-feeder.png",
        icon_size = 32,
        flags = {"goes-to-quickbar"},
        subgroup = "cattle",
        order = "b",
        place_result = "cattle-feeder",
        stack_size = 50
    },

    {
        type = "recipe",
        name = "cattle-feeder",
        enabled = false,
        ingredients =
        {
            {"iron-plate", 1}
        },
        result = "cattle-feeder"
    },
})

local pipe_left = {
    south = {
        filename = "__FoodIndustry__/graphics/entity/cattle-butcher/bottom-left.png",
        priority = "low",
        width = 160,
        height = 248
    }
}

local pipe_right = {
    south = {
        filename = "__FoodIndustry__/graphics/entity/cattle-butcher/bottom-right.png",
        priority = "low",
        width = 160,
        height = 248
    }
}

function PipesEmpty_picture()
    return {
        filename = '__core__/graphics/empty.png',
        priority = 'extra-high',
        width = 1,
        height = 1
    }
end

--Define pipe connection pipe pictures, not all entities use these. This function needs some work though.
function PipesPictures(pictures, shift_north, shift_south, shift_west, shift_east, replacements)
    local new_pictures = {
        north = shift_north and
                {
                    filename = '__base__/graphics/entity/' .. pictures .. '/' .. pictures .. '-pipe-N.png',
                    priority = 'extra-high',
                    width = 35,
                    height = 18,
                    shift = shift_north
                } or
                PipesEmpty_picture(),
        south = shift_south and
                {
                    filename = '__base__/graphics/entity/' .. pictures .. '/' .. pictures .. '-pipe-S.png',
                    priority = 'extra-high',
                    width = 44,
                    height = 31,
                    shift = shift_south
                } or
                PipesEmpty_picture(),
        west = shift_west and
                {
                    filename = '__base__/graphics/entity/' .. pictures .. '/' .. pictures .. '-pipe-W.png',
                    priority = 'extra-high',
                    width = 19,
                    height = 37,
                    shift = shift_west
                } or
                PipesEmpty_picture(),
        east = shift_east and
                {
                    filename = '__base__/graphics/entity/' .. pictures .. '/' .. pictures .. '-pipe-E.png',
                    priority = 'extra-high',
                    width = 20,
                    height = 38,
                    shift = shift_east
                } or
                PipesEmpty_picture()
    }
    for direction, image in pairs(replacements or {}) do
        if not (new_pictures[direction].filename == '__core__/graphics/empty.png') then
            new_pictures[direction].filename = image.filename
            new_pictures[direction].width = image.width
            new_pictures[direction].height = image.height
            new_pictures[direction].priority = image.priority or new_pictures[direction].priority
        end
    end
    return new_pictures
end

function PipesCovers(n, s, w, e)
    if (n == nil and s == nil and w == nil and e == nil) then
        n, s, e, w = true, true, true, true
    end

    n =
    n and
            {
                layers = {
                    {
                        filename = '__base__/graphics/entity/pipe-covers/pipe-cover-north.png',
                        priority = 'extra-high',
                        width = 64,
                        height = 64,
                        hr_version = {
                            filename = '__base__/graphics/entity/pipe-covers/hr-pipe-cover-north.png',
                            priority = 'extra-high',
                            width = 128,
                            height = 128,
                            scale = 0.5
                        }
                    },
                    {
                        filename = '__base__/graphics/entity/pipe-covers/pipe-cover-north-shadow.png',
                        priority = 'extra-high',
                        width = 64,
                        height = 64,
                        draw_as_shadow = true,
                        hr_version = {
                            filename = '__base__/graphics/entity/pipe-covers/hr-pipe-cover-north-shadow.png',
                            priority = 'extra-high',
                            width = 128,
                            height = 128,
                            scale = 0.5,
                            draw_as_shadow = true
                        }
                    }
                }
            } or
            PipesEmpty_picture()
    e =
    e and
            {
                layers = {
                    {
                        filename = '__base__/graphics/entity/pipe-covers/pipe-cover-east.png',
                        priority = 'extra-high',
                        width = 64,
                        height = 64,
                        hr_version = {
                            filename = '__base__/graphics/entity/pipe-covers/hr-pipe-cover-east.png',
                            priority = 'extra-high',
                            width = 128,
                            height = 128,
                            scale = 0.5
                        }
                    },
                    {
                        filename = '__base__/graphics/entity/pipe-covers/pipe-cover-east-shadow.png',
                        priority = 'extra-high',
                        width = 64,
                        height = 64,
                        draw_as_shadow = true,
                        hr_version = {
                            filename = '__base__/graphics/entity/pipe-covers/hr-pipe-cover-east-shadow.png',
                            priority = 'extra-high',
                            width = 128,
                            height = 128,
                            scale = 0.5,
                            draw_as_shadow = true
                        }
                    }
                }
            } or
            PipesEmpty_picture()
    s =
    s and
            {
                layers = {
                    {
                        filename = '__base__/graphics/entity/pipe-covers/pipe-cover-south.png',
                        priority = 'extra-high',
                        width = 64,
                        height = 64,
                        hr_version = {
                            filename = '__base__/graphics/entity/pipe-covers/hr-pipe-cover-south.png',
                            priority = 'extra-high',
                            width = 128,
                            height = 128,
                            scale = 0.5
                        }
                    },
                    {
                        filename = '__base__/graphics/entity/pipe-covers/pipe-cover-south-shadow.png',
                        priority = 'extra-high',
                        width = 64,
                        height = 64,
                        draw_as_shadow = true,
                        hr_version = {
                            filename = '__base__/graphics/entity/pipe-covers/hr-pipe-cover-south-shadow.png',
                            priority = 'extra-high',
                            width = 128,
                            height = 128,
                            scale = 0.5,
                            draw_as_shadow = true
                        }
                    }
                }
            } or
            PipesEmpty_picture()
    w =
    w and
            {
                layers = {
                    {
                        filename = '__base__/graphics/entity/pipe-covers/pipe-cover-west.png',
                        priority = 'extra-high',
                        width = 64,
                        height = 64,
                        hr_version = {
                            filename = '__base__/graphics/entity/pipe-covers/hr-pipe-cover-west.png',
                            priority = 'extra-high',
                            width = 128,
                            height = 128,
                            scale = 0.5
                        }
                    },
                    {
                        filename = '__base__/graphics/entity/pipe-covers/pipe-cover-west-shadow.png',
                        priority = 'extra-high',
                        width = 64,
                        height = 64,
                        draw_as_shadow = true,
                        hr_version = {
                            filename = '__base__/graphics/entity/pipe-covers/hr-pipe-cover-west-shadow.png',
                            priority = 'extra-high',
                            width = 128,
                            height = 128,
                            scale = 0.5,
                            draw_as_shadow = true
                        }
                    }
                }
            } or
            PipesEmpty_picture()

    return {north = n, south = s, east = e, west = w}
end


data:extend({


{
    type = "recipe",
    name = "cattle-butcher",
    energy_required = 10,
    enabled = false,
    ingredients = {
        {"iron-plate", 1}
    },
    results = {
        {"cattle-butcher", 1}
    }
},

{
    type = "item",
    name = "cattle-butcher",
    icon = "__FoodIndustry__/graphics/icons/entities/cattle-butcher.png",
    icon_size = 32,
    flags = {"goes-to-quickbar"},
    subgroup = "cattle",
    order = "d",
    place_result = "cattle-butcher",
    stack_size = 10
},

{
    type = "assembling-machine",
    name = "cattle-butcher",
    icon = "__FoodIndustry__/graphics/icons/entities/cattle-butcher.png",
    icon_size = 32,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 1, result = "cattle-butcher"},
    fast_replaceable_group = "cattle-butcher",
    max_health = 100,
    corpse = "medium-remnants",
    dying_explosion = "big-explosion",
    collision_box = {{-2.4, -2.4}, {2.4, 2.4}},
    selection_box = {{-2.5, -2.5}, {2.5, 2.5}},
    module_specification = {
        module_slots = 4
    },
    allowed_effects = {"consumption", "speed", "productivity", "pollution"},
    crafting_categories = {"cattle"},
    crafting_speed = 1,
    energy_source = {
        type = "electric",
        usage_priority = "secondary-input",
        emissions = 0.01
    },
    energy_usage = "150kW",
    ingredient_count = 20,
    animation = {
        layers = {
            {
                filename = "__FoodIndustry__/graphics/entity/cattle-butcher/cattle-butcher.png",
                --priority = "high",
                width = 160,
                height = 248,
                line_length = 12,
                frame_count = 61,
                animation_speed = 0.4,
                shift = util.by_pixel(0, -36)
            },
            {
                filename = "__FoodIndustry__/graphics/entity/cattle-butcher/shadow.png",
                --priority = "high",
                width = 173,
                height = 168,
                line_length = 11,
                frame_count = 61,
                animation_speed = 0.4,
                draw_as_shadow = true,
                shift = util.by_pixel(12, 8)
            }
        }
    },
    fluid_boxes = {
        --1
        {
            production_type = "input",
            pipe_picture = PipesPictures("assembling-machine-2", nil, {-1.0, -4.04}, nil, nil, pipe_right),
            pipe_covers = PipesCovers(false, true, true, true),
            base_area = 10,
            base_level = -1,
            pipe_connections = {{type = "input", position = {1.0, 3.0}}}
        },
        {
            production_type = "input",
            pipe_picture = PipesPictures("assembling-machine-2", nil, {-1.0, -4.04}, nil, nil, pipe_right),
            pipe_covers = PipesCovers(false, true, true, true),
            base_area = 10,
            base_level = -1,
            pipe_connections = {{type = "input", position = {-1.0, -3.0}}}
        },
        {
            production_type = "input",
            pipe_picture = PipesPictures("assembling-machine-2", nil, {-1.0, -4.04}, nil, nil, pipe_right),
            pipe_covers = PipesCovers(false, true, true, true),
            base_area = 10,
            base_level = -1,
            pipe_connections = {{type = "input", position = {3.0, -1.0}}}
        },
        {
            production_type = "input",
            pipe_picture = PipesPictures("assembling-machine-2", nil, {-1.0, -4.04}, nil, nil, pipe_right),
            pipe_covers = PipesCovers(false, true, true, true),
            base_area = 10,
            base_level = -1,
            pipe_connections = {{type = "input", position = {-3.0, 1.0}}}
        },
        {
            production_type = "output",
            pipe_picture = PipesPictures("assembling-machine-2", nil, {1.0, -4.04}, nil, nil, pipe_left),
            pipe_covers = PipesCovers(false, true, true, true),
            base_level = 1,
            pipe_connections = {{type = "output", position = {-1.0, 3.0}}}
        },
        {
            production_type = "output",
            pipe_picture = PipesPictures("assembling-machine-2", nil, {1.0, -4.04}, nil, nil, pipe_left),
            pipe_covers = PipesCovers(false, true, true, true),
            base_level = 1,
            pipe_connections = {{type = "output", position = {-3.0, -1.0}}}
        },
        {
            production_type = "output",
            pipe_picture = PipesPictures("assembling-machine-2", nil, {1.0, -4.04}, nil, nil, pipe_left),
            pipe_covers = PipesCovers(false, true, true, true),
            base_level = 1,
            pipe_connections = {{type = "output", position = {1.0, -3.0}}}
        },
        {
            production_type = "output",
            pipe_picture = PipesPictures("assembling-machine-2", nil, {1.0, -4.04}, nil, nil, pipe_left),
            pipe_covers = PipesCovers(false, true, true, true),
            base_level = 1,
            pipe_connections = {{type = "output", position = {3.0, 1.0}}}
        },
        off_when_no_fluid_recipe = true
    },
    vehicle_impact_sound = {filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65},
    working_sound = {
        sound = {filename = "__FoodIndustry__/sounds/cattle-butcher.ogg", volume = 0.8},
        idle_sound = {filename = "__FoodIndustry__/sounds/cattle-butcher.ogg", volume = 0.6},
        apparent_volume = 2.5
    }
}
    })
