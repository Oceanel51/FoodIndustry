-- fish spawner
data:extend({

    {
        type = "item",
        name = "fish-farm",
        icon = "__FoodIndustry__/graphics/icons/entities/fishfarm.png",
        icon_size = 32,
        subgroup = "food-machines-fish",
        order = "w-a-k",
        place_result = "fish-farm",
        stack_size = 50
    },

    {
        type = "unit-spawner",
        name = "fish-farm",
        icon = "__FoodIndustry__/graphics/icons/entities/fishfarm.png",
        icon_size = 32,
        flags = {"placeable-player", "placeable-enemy", "not-repairable"},
        minable = {hardness = 0.2, mining_time = 2.0, result = "fish-farm"},
        max_health = 50,
        order="b-b-h",
        subgroup="food-machines-fish",
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
        collision_mask = {'object-layer'},
        collision_box = {{-0.7, -0.7}, {0.7, 0.7}},
        selection_box = {{-0.9, -0.9}, {0.9, 0.9}},
        pollution_absorbtion_absolute = 20,
        pollution_absorbtion_proportional = 0.01,
        corpse = "spitter-spawner-corpse",
        dying_explosion = "blood-explosion-huge",
        max_count_of_owned_units = 7,
        max_friends_around_to_spawn = 15,
        animations =
        {
            layers =
            {
                {
                    filename = "__FoodIndustry__/graphics/entity/fishfarm/fishfarm.png",
                    line_length = 1,
                    width = 76,
                    height = 46,
                    frame_count = 1,
                    animation_speed = 0.1,
                    direction_count = 1,
                    shift = {0.28, 0}
                },
            }
        },
        result_units = (function()
            local res = {}
            res[1] = {"fish", {{0.0, 0.3}, {0.35, 0}}}
            res[2] = {"fish", {{0.25, 0.0}, {0.5, 0.3}, {0.7, 0.0}}}
            res[3] = {"fish", {{0.4, 0.0}, {0.7, 0.3}, {0.9, 0.1}}}
            res[4] = {"fish", {{0.5, 0.0}, {1.0, 0.4}}}
            res[5] = {"fish", {{0.9, 0.0}, {1.0, 0.3}}}
            return res
        end)(),
        -- With zero evolution the spawn rate is 12 seconds, with max evolution it is 6 seconds
        spawning_cooldown = {5 * 60, 5 * 6*60},
        spawning_radius = 15,
        spawning_spacing = 3,
        max_spawn_shift = 0,
        max_richness_for_spawn_shift = 100,
        call_for_help_radius = 1
    },
    {
        type = "recipe",
        name = "fish-farm",
        enabled = false,
        ingredients =
        {
            {"iron-plate", 1}
        },
        result = "fish-farm"
    },
})
