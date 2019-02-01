local foods = {
--1					2		3		4						5		6		7		8
--name,				stack,	cool,	category,				time,	amount,	effect,	ingredients
{"cooked-corn",		10,		0.5,	"cooking",				4.0,	1,		false,	{{"corn", 1}, {type="fluid", name="water", amount=20}} },
{"corn-bread",		10,		0.5,	"cooking",				8.0,	1,		false,	{{"corn-flour", 2}, {type="fluid", name="water", amount=10}} },
{"cooked-fish",		10,		0.2,	"cooking",				3.0,	1,		false,	{{"raw-fish", 1}, {type="fluid", name="water", amount=10}} },
{"popcorn",			50,		0.2,	"cooking",				1.5,	1,		false,	{{"corn-seeds", 1}, {type="fluid", name="canola-oil", amount=1}} },
{"basic-salad",		10,		0.5,	"cooking",				1.5,	1,		false,	{{"tomato", 2}, {"cucumber", 1}, {"lettuce", 2}} },
{"cooked-soy",		50,		0.2,	"cooking",				3.0,	5,		false,	{{"soy", 5}, {type="fluid", name="water", amount=20}} },
{"baked-potato",	10,		0.5,	"cooking",				6.0,	1,		false,	{{"potato", 1}} },
{"fries",			10,		0.5,	"cooking",				6.0,	1,		false,	{{"raw-fries", 1}, {type="fluid", name="canola-oil", amount=6}} },
{"ketchup-fries",	10,		0.5,	"crafting-with-fluid",	0.5,	1,		false,	{{"fries", 1}, {type="fluid", name="ketchup", amount=1}} },
{"biter-steak",		10,		0.5,	"cooking",				12.0,	1,		false,	{{"biter-meat", 1}, {type="fluid", name="canola-oil", amount=2}} },
{"fish-steak",		10,		0.5,	"cooking",				12.0,	1,		false,	{{"raw-fish", 1}, {type="fluid", name="canola-oil", amount=2}} },
{"schnitzel",		10,		0.5,	"cooking",				12.0,	1,		false,	{{"biter-meat", 1}, {"corn-flour", 1}, {type="fluid", name="canola-oil", amount=5}} },
{"pickles",			50,		0.2,	"cooking",				40.0,	20,		false,	{{"cucumber", 5}, {"crystal", 1}, {type="fluid", name="water", amount=100}} },
{"tofu",			10,		0.5,	"chemistry",			4.0,	2,		false,	{{"crystal", 1}, {type="fluid", name="soy-milk", amount=24}, {type="fluid", name="sulfuric-acid", amount=1}} },
{"pizza",			5,		0.5,	"cooking",				5.0,	1,		false,	{{"corn-flour", 2}, {"tomato", 3}, {"biter-steak", 1}, {type="fluid", name="ketchup", amount=2}} },
{"tofu-pizza",		5,		0.5,	"cooking",				5.0,	1,		false,	{{"corn-flour", 2}, {"tomato", 3}, {"tofu", 1}, {type="fluid", name="ketchup", amount=2}} },
{"fish-pizza",		5,		0.5,	"cooking",				5.0,	1,		false,	{{"corn-flour", 2}, {"tomato", 3}, {"fish-steak", 1}, {type="fluid", name="ketchup", amount=2}} },
{"burger",			5,		0.5,	"cooking",				5.0,	1,		false,	{{"corn-bread", 1}, {"tomato", 2}, {"pickles", 2}, {"lettuce", 1}, {"biter-steak", 1}, {type="fluid", name="ketchup", amount=1}} },
{"tofu-burger",		5,		0.5,	"cooking",				5.0,	1,		false,	{{"corn-bread", 1}, {"tomato", 2}, {"pickles", 2}, {"lettuce", 1}, {"tofu", 1}, {type="fluid", name="ketchup", amount=1}} },
{"fish-burger",		5,		0.5,	"cooking",				5.0,	1,		false,	{{"corn-bread", 1}, {"tomato", 2}, {"pickles", 2}, {"lettuce", 1}, {"fish-steak", 1}, {type="fluid", name="ketchup", amount=1}} },
{"best-salad",		5,		0.5,	"crafting-with-fluid",	1.5,	1,		false,	{{"lettuce", 4}, {"tomato", 3}, {"pickles", 1}, {"corn-seeds", 2}, {type="fluid", name="soy-sauce", amount=1}} },
{"fish-salad",		5,		0.5,	"crafting-with-fluid",	1.5,	1,		false,	{{"lettuce", 4}, {"tomato", 3}, {"pickles", 1}, {"corn-seeds", 2}, {"fish-steak", 1}, } },
{"fish-and-chips",	5,		0.5,	"cooking",				1.5,	1,		false,	{{"fish-steak", 1}, {"fries", 1}, } },
{"food-capsule",	50,		0.5,	"centrifuging",			60.0,	3,		false,	{{"fries", 1}, {"burger", 1}, {"best-salad", 1}, {"crystal", 1}} },
{"vegan-food-capsule",50,	0.5,	"centrifuging",			60.0,	3,		false,	{{"fries", 1}, {"tofu-burger", 1}, {"best-salad", 1}, {"crystal", 1}} },
{"cooked-biter-meat",10,	0.5,	"cooking",				12.0,	1,		false,	{{"biter-meat", 1}, {type="fluid", name="water", amount=30}} },
{"long-reach-capsule",50,	0.5,	"centrifuging",			180.0,	3,		true,	{{"food-capsule", 60}, {"uranium-235", 1}, {"long-handed-inserter", 3}} },
{"speed-capsule",	50,		0.5,	"centrifuging",			180.0,	3,		true,	{{"food-capsule", 60}, {"uranium-235", 1}, {"speed-module", 1}} },
{"regen-capsule",	50,		0.5,	"centrifuging",			180.0,	3,		true,	{{"food-capsule", 60}, {"uranium-235", 1}, {"effectivity-module", 1}} },
{"crafting-capsule",50,		0.5,	"centrifuging",			180.0,	3,		true,	{{"food-capsule", 60}, {"uranium-235", 1}, {"productivity-module", 1}} },
{"mining-capsule",	50,		0.5,	"centrifuging",			180.0,	3,		true,	{{"food-capsule", 60}, {"uranium-235", 1}, {"steel-axe", 1}} },
{"invulnerability-capsule",50,0.5,	"centrifuging",			120.0,	1,		true,	{{"health-buffer-capsule", 1}, {"regen-capsule", 1}} },
{"neutralizing-capsule",50,	0.5,	"centrifuging",			180.0,	3,		true,	{{"food-capsule", 60}, {"uranium-235", 1}, {"crystal", 1}} },
{"health-buffer-capsule",50,0.5,	"centrifuging",			180.0,	3,		true,	{{"food-capsule", 60}, {"uranium-235", 1}, {"light-armor", 1}} },
{"long-reach-capsule",50,	0.5,	"centrifuging",			180.0,	3,		true,	{{"vegan-food-capsule", 60}, {"uranium-235", 1}, {"long-handed-inserter", 3}} },
{"speed-capsule",	50,		0.5,	"centrifuging",			180.0,	3,		true,	{{"vegan-food-capsule", 60}, {"uranium-235", 1}, {"speed-module", 1}} },
{"regen-capsule",	50,		0.5,	"centrifuging",			180.0,	3,		true,	{{"vegan-food-capsule", 60}, {"uranium-235", 1}, {"effectivity-module", 1}} },
{"crafting-capsule",50,		0.5,	"centrifuging",			180.0,	3,		true,	{{"vegan-food-capsule", 60}, {"uranium-235", 1}, {"productivity-module", 1}} },
{"mining-capsule",	50,		0.5,	"centrifuging",			180.0,	3,		true,	{{"vegan-food-capsule", 60}, {"uranium-235", 1}, {"steel-axe", 1}} },
{"neutralizing-capsule",50,	0.5,	"centrifuging",			180.0,	3,		true,	{{"vegan-food-capsule", 60}, {"uranium-235", 1}, {"crystal", 1}} },
{"health-buffer-capsule",50,0.5,	"centrifuging",			180.0,	3,		true,	{{"vegan-food-capsule", 60}, {"uranium-235", 1}, {"light-armor", 1}} },
}








for i, f in pairs(foods) do
	local sg = "foods"
	local rn = f[1]
	if f[7] then 
		sg = "effect"
		rn = f[1].."-"..f[8][1][1]
	end
	
	data:extend({
		{
			type = "capsule",
			name = f[1],
			icon = "__FoodIndustry__/graphics/icons/items/"..f[1]..".png",
			icon_size = 32,
			flags = {"goes-to-main-inventory"},
			subgroup = sg,
			order = "w-d",
			stack_size = f[2],
			capsule_action = {
				attack_parameters = {
					ammo_category = "capsule",
					ammo_type = {
						action = {
							action_delivery = {
								target_effects = {
									damage = {
										amount = 0,
										type = "physical"
									},
									type = "damage"
								},
								type = "instant"
							},
							type = "direct"
						},
						category = "capsule",
						target_type = "position"
					},
					cooldown = f[3]*60,
					range = 0,
					type = "projectile"
				},
				type = "use-on-self"
			},
		},
		{
			type = "recipe",
			name = rn,
			enabled = false,
			icon = "__FoodIndustry__/graphics/icons/items/"..f[1]..".png",
			icon_size = 32,
			category = f[4],
			subgroup = sg,
			energy_required = f[5],
			ingredients = f[8],
			results = {{f[1], f[6]}}
		},
	})
end