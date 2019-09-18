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


local ingredients = {
	--1						2				3				4
	--plant					ingredients,	energy/water,	result	?
	{"raw-straw",			10,				60.0,			25},		--basic
	{"straw",				100,			60.0,			2},			--0
	{"compressed-straw",	1,				60.0,			6},			--0
	--{"lettuce",				0,				3.0,			6},		--5.4
	--{"cucumber",			0,				4.5,			6},		--5.1
	--{"tomato",				0,				2.0,			4},		--3.6
	--{"potato",				0,				5.0,			8},		--7.0
	--{"corn",				0,				4.0,			8},		--7.2
	--{"soy",					0,				0.5,			1},		--0.9
	--{"rapeseed",			0,				0.4,			0.4}	--0.32
}


for index, ingredient in pairs(ingredients) do
	data:extend({
		{
			type = "recipe",
			name = "fish-feeding-"..ingredient[1],
			enabled = false,
			icon = "__base__/graphics/icons/fish.png",
			icon_size = 32,
			category = "fish-feeding",
			subgroup = "fish-feeding",
			energy_required = ingredient[3],
			ingredients = {
				{ ingredient[1], ingredient[2] }
			},
			results = {
			},
		},
        table.insert(data.raw.technology["fish-breeding"].effects,
        {recipe = "fish-feeding-"..ingredient[1], type = "unlock-recipe"}
    )
	})
end
