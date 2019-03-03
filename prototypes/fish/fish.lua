data:extend({
    {
        type = "autoplace-control",
        category = "terrain",
        name = "fish",
        order = "w",
        richness = false,
    },

    {
        type = "fish",
        name = "fi-sturgeon",
        icon = "__base__/graphics/icons/fish.png",
        icon_size = 32,
        flags = {"placeable-neutral", "not-on-map"},
        minable = {mining_time = 0.8, result = "fi-raw-sturgeon", count = 1},
        max_health = 20,
        subgroup = "creatures",
        order = "b-a",
        collision_box = {{-0.75, -0.75}, {0.75, 0.75}},
        selection_box = {{-0.5, -0.3}, {0.5, 0.3}},
        pictures =
        {
            {
                filename = "__base__/graphics/entity/fish/fish-1.png",
                priority = "extra-high",
                width = 22,
                height = 36,
                scale = 2
            },
            {
                filename = "__base__/graphics/entity/fish/fish-2.png",
                priority = "extra-high",
                width = 32,
                height = 32,
                scale = 2
            }
        },
        autoplace = { control = "fish", tile_restriction = { "water", "deepwater" }, influence = 0.009, min_influence = 0.009, max_influence = 0.02 }
    },

    {
        type = "capsule",
        name = "fi-raw-sturgeon",
        icon = "__FoodIndustry__/graphics/icons/entities/sturgeon.png",
        icon_size = 128,
        subgroup = "raw-resource",
        capsule_action =
        {
            type = "use-on-self",
            attack_parameters =
            {
                type = "projectile",
                ammo_category = "capsule",
                cooldown = 30,
                range = 0,
                ammo_type =
                {
                    category = "capsule",
                    target_type = "position",
                    action =
                    {
                        type = "direct",
                        action_delivery =
                        {
                            type = "instant",
                            target_effects =
                            {
                                type = "damage",
                                damage = {type = "physical", amount = -80}
                            }
                        }
                    }
                }
            }
        },
        order = "h[raw-sturgeon]",
        stack_size = 100
    },
})