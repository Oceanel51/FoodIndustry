require "libs.helper-functions"


local foods = {
--1									2			3		4		5						6		7		8		9					10
--name,								subtype,	stack,	cool,	category,				time,	amount,	effect,	order,				ingredients
{"cooked-corn",						"fv",		10,		0.5,	"cooking",				4.0,	1,		false,	"",					{{"corn", 1}, {type="fluid", name="water", amount=20}} },
{"corn-bread",						"fv",		10,		0.5,	"cooking",				8.0,	1,		false,	"",					{{"corn-flour", 2}, {type="fluid", name="water", amount=10}} },
{"popcorn",							"fv",		50,		0.2,	"cooking",				1.5,	1,		false,	"",					{{"corn-seeds", 1}, {type="fluid", name="canola-oil", amount=1}} },
{"basic-salad",						"fv",		10,		0.5,	"cooking",				1.5,	1,		false,	"",					{{"tomato", 2}, {"cucumber", 1}, {"lettuce", 2}} },
{"cooked-soy",						"fv",		50,		0.2,	"cooking",				3.0,	5,		false,	"",					{{"soy", 5}, {type="fluid", name="water", amount=20}} },
{"baked-potato",					"fv",		10,		0.5,	"cooking",				6.0,	1,		false,	"",					{{"potato", 1}} },
{"fries",							"fv",		10,		0.5,	"cooking",				6.0,	1,		false,	"",					{{"raw-fries", 1}, {type="fluid", name="canola-oil", amount=6}} },
{"ketchup-fries",					"fv",		10,		0.5,	"crafting-with-fluid",	0.5,	1,		false,	"",					{{"fries", 1}, {type="fluid", name="ketchup", amount=1}} },
{"biter-steak",						"fm",		10,		0.5,	"cooking",				12.0,	1,		false,	"",					{{"biter-meat", 1}, {type="fluid", name="canola-oil", amount=2}} },
{"schnitzel",						"fm",		10,		0.5,	"cooking",				12.0,	1,		false,	"",					{{"biter-meat", 1}, {"corn-flour", 1}, {type="fluid", name="canola-oil", amount=5}} },
{"pickles",							"fv",		50,		0.2,	"cooking",				40.0,	20,		false,	"",					{{"cucumber", 5}, {"crystal", 1}, {type="fluid", name="water", amount=100}} },
{"tofu",							"fv",		10,		0.5,	"chemistry",			4.0,	2,		false,	"",					{{"crystal", 1}, {type="fluid", name="soy-milk", amount=24}, {type="fluid", name="sulfuric-acid", amount=1}} },
{"pizza",							"fm",		5,		0.5,	"cooking",				5.0,	1,		false,	"",					{{"corn-flour", 2}, {"tomato", 3}, {"biter-steak", 1}, {type="fluid", name="ketchup", amount=2}} },
{"tofu-pizza",						"fv",		5,		0.5,	"cooking",				5.0,	1,		false,	"",					{{"corn-flour", 2}, {"tomato", 3}, {"tofu", 1}, {type="fluid", name="ketchup", amount=2}} },
{"burger",							"fm",		5,		0.5,	"cooking",				5.0,	1,		false,	"",					{{"corn-bread", 1}, {"tomato", 2}, {"pickles", 2}, {"lettuce", 1}, {"biter-steak", 1}, {type="fluid", name="ketchup", amount=1}} },
{"tofu-burger",						"fv",		5,		0.5,	"cooking",				5.0,	1,		false,	"",					{{"corn-bread", 1}, {"tomato", 2}, {"pickles", 2}, {"lettuce", 1}, {"tofu", 1}, {type="fluid", name="ketchup", amount=1}} },
{"best-salad",						"fv",		5,		0.5,	"crafting-with-fluid",	1.5,	1,		false,	"",					{{"lettuce", 4}, {"tomato", 3}, {"pickles", 1}, {"corn-seeds", 2}, {type="fluid", name="soy-sauce", amount=1}} },
{"food-capsule",					"cm",		50,		0.5,	"centrifuging",			60.0,	3,		false,	"",					{{"fries", 1}, {"burger", 1}, {"best-salad", 1}, {"crystal", 1}} },
{"vegan-food-capsule",				"cv",		50,		0.5,	"centrifuging",			60.0,	3,		false,	"",					{{"fries", 1}, {"tofu-burger", 1}, {"best-salad", 1}, {"crystal", 1}} },
{"cooked-biter-meat",				"fm",		10,		0.5,	"cooking",				12.0,	1,		false,	"",					{{"biter-meat", 1}, {type="fluid", name="water", amount=30}} },
{"advanced-long-reach-capsule",		"mca",		50,		0.5,	"centrifuging",			180.0,	3,		true,	"",					{{"food-capsule", 60}, {"uranium-235", 1}, {"long-handed-inserter", 3}} },
{"advanced-speed-capsule",			"mca",		50,		0.5,	"centrifuging",			180.0,	3,		true,	"w-capsule-a-cb",	{{"food-capsule", 60}, {"uranium-235", 1}, {"speed-module", 1}} },
{"advanced-regen-capsule",			"mca",		50,		0.5,	"centrifuging",			180.0,	3,		true,	"",					{{"food-capsule", 60}, {"uranium-235", 1}, {"effectivity-module", 1}} },
{"advanced-crafting-capsule",		"mca",		50,		0.5,	"centrifuging",			180.0,	3,		true,	"w-capsule-a-cb",	{{"food-capsule", 60}, {"uranium-235", 1}, {"productivity-module", 1}} },
{"advanced-mining-capsule",			"mca",		50,		0.5,	"centrifuging",			180.0,	3,		true,	"",					{{"food-capsule", 60}, {"uranium-235", 1}, {"steel-axe", 1}} },
{"advanced-health-buffer-capsule",	"mca",		50,		0.5,	"centrifuging",			180.0,	3,		true,	"",					{{"food-capsule", 60}, {"uranium-235", 1}, {"light-armor", 1}} },
{"advanced-long-reach-capsule",		"vca",		50,		0.5,	"centrifuging",			180.0,	3,		true,	"",					{{"vegan-food-capsule", 60}, {"uranium-235", 1}, {"long-handed-inserter", 3}} },
{"advanced-speed-capsule",			"vca",		50,		0.5,	"centrifuging",			180.0,	3,		true,	"w-capsule-a-ca",	{{"vegan-food-capsule", 60}, {"uranium-235", 1}, {"speed-module", 1}} },
{"advanced-regen-capsule",			"vca",		50,		0.5,	"centrifuging",			180.0,	3,		true,	"",					{{"vegan-food-capsule", 60}, {"uranium-235", 1}, {"effectivity-module", 1}} },
{"advanced-crafting-capsule",		"vca",		50,		0.5,	"centrifuging",			180.0,	3,		true,	"w-capsule-b-ca",	{{"vegan-food-capsule", 60}, {"uranium-235", 1}, {"productivity-module", 1}} },
{"advanced-mining-capsule",			"vca",		50,		0.5,	"centrifuging",			180.0,	3,		true,	"",					{{"vegan-food-capsule", 60}, {"uranium-235", 1}, {"steel-axe", 1}} },
{"advanced-health-buffer-capsule",	"vca",		50,		0.5,	"centrifuging",			180.0,	3,		true,	"",					{{"vegan-food-capsule", 60}, {"uranium-235", 1}, {"light-armor", 1}} },
{"simple-neutralizing-capsule",		"vca",		50,		0.5,	"centrifuging",			180.0,	3,		true,	"",					{{"vegan-food-capsule", 60}, {"uranium-235", 1}, {"crystal", 1}} },
{"simple-long-reach-capsule",		"vca",		100,	0.5,	"cooking",				80.0,	3,		true,	"",					{{"vegan-food-capsule", 5}, {"cucumber", 5}, {"lettuce", 15}, {"inserter", 2}} },
{"simple-long-reach-capsule",		"cms",		100,	0.5,	"cooking",				80.0,	3,		true,	"",					{{"food-capsule", 5}, {"biter-steak", 5}, {"inserter", 2}} },
{"simple-speed-capsule",			"vcs",		100,	0.5,	"cooking",				80.0,	3,		true,	"w-capsule-a-aa",	{{"vegan-food-capsule", 5}, {"cucumber", 5}, {"lettuce", 15}, {"inserter", 2}} },
{"simple-speed-capsule",			"cms",		100,	0.5,	"cooking",				80.0,	3,		true,	"w-capsule-a-ab",	{{"food-capsule", 5}, {"biter-steak", 5}, {"inserter", 2}} },
{"simple-crafting-capsule",			"cvs",		100,	0.5,	"cooking",				80.0,	3,		true,	"w-capsule-b-aa",	{{"vegan-food-capsule", 5},{"tomato", 10}, {"lettuce", 10}, {"iron-axe", 1}} },
{"simple-crafting-capsule",			"cms",		100,	0.5,	"cooking",				80.0,	3,		true,	"w-capsule-b-ab",	{{"food-capsule", 5},{"biter-steak", 5}, {"iron-axe", 1}} },
{"simple-mining-capsule",			"cvs",		100,	0.5,	"cooking",				80.0,	3,		true,	"",					{{"vegan-food-capsule", 5},{"tomato", 10}, {"lettuce", 10}, {"iron-axe", 1}} },
{"simple-mining-capsule",			"cms",		100,	0.5,	"cooking",				80.0,	3,		true,	"",					{{"food-capsule", 5},{"biter-steak", 5}, {"iron-axe", 1}} },
{"simple-neutralizing-capsule",		"cvs",		50,		0.5,	"centrifuging",			180.0,	3,		true,	"",					{{"vegan-food-capsule", 30}, {"uranium-235", 1}, {"crystal", 1}} },
{"simple-neutralizing-capsule",		"cms",		50,		0.5,	"centrifuging",			180.0,	3,		true,	"",					{{"food-capsule", 30}, {"uranium-235", 1}, {"crystal", 1}} },
{"basic-long-reach-capsule",		"cmb",		50,		0.5,	"cooking",				120.0,	3,		true,	"",					{{"food-capsule", 5},{"biter-steak", 10}, {"long-handed-inserter", 2}} },
{"basic-long-reach-capsule",		"cvb",		50,		0.5,	"cooking",				120.0,	3,		true,	"",					{{"vegan-food-capsule", 5},{"pickles", 10}, {"lettuce", 15}, {"long-handed-inserter", 2}} },
{"basic-speed-capsule",				"cvb",		50,		0.5,	"cooking",				120.0,	3,		true,	"w-capsule-a-ba",	{{"vegan-food-capsule", 5},{"pickles", 10}, {"lettuce", 15}, {"inserter", 2}} },
{"basic-speed-capsule",				"cmb",		50,		0.5,	"cooking",				120.0,	3,		true,	"w-capsule-a-bb",	{{"food-capsule", 5},{"biter-steak", 10}, {"inserter", 2}} },
{"basic-crafting-capsule",			"cvb",		50,		0.5,	"cooking",				120.0,	3,		true,	"w-capsule-b-ba",	{{"vegan-food-capsule", 5},{"ketchup-fries", 10}, {"lettuce", 10}, {"steel-axe", 1}} },
{"basic-crafting-capsule",			"cmb",		50,		0.5,	"cooking",				120.0,	3,		true,	"w-capsule-b-bb",	{{"food-capsule", 5},{"biter-steak", 10}, {"steel-axe", 1}} },
{"basic-mining-capsule",			"cvb",		50,		0.5,	"cooking",				120.0,	3,		true,	"",					{{"vegan-food-capsule", 5},{"ketchup-fries", 10}, {"lettuce", 10}, {"steel-axe", 1}} },
{"basic-mining-capsule",			"cmb",		50,		0.5,	"cooking",				120.0,	3,		true,	"",					{{"food-capsule", 5},{"biter-steak", 10}, {"steel-axe", 1}} },
{"basic-regen-capsule",				"cvb",		50,		0.5,	"cooking",				180.0,	3,		true,	"",					{{"vegan-food-capsule", 20}, {"tofu", 5}, {"effectivity-module", 1}} },
{"basic-regen-capsule",				"cmb",		50,		0.5,	"cooking",				180.0,	3,		true,	"",					{{"food-capsule", 20}, {"biter-steak", 5}, {"effectivity-module", 1}} },
{"basic-health-buffer-capsule",		"cvb",		50,		0.5,	"cooking",				180.0,	3,		true,	"",					{{"vegan-food-capsule", 20}, {"tofu", 5}, {"light-armor", 1}} },
{"basic-health-buffer-capsule",		"cmb",		50,		0.5,	"cooking",				180.0,	3,		true,	"",					{{"food-capsule", 20}, {"biter-steak", 5}, {"light-armor", 1}} },
{"invulnerability-capsule",			"cvb",		50,		0.5,	"centrifuging",			120.0,	1,		true,	"",					{{"advanced-health-buffer-capsule", 1}, {"advanced-regen-capsule", 1}} },
{"simple-digestive-capsule",		"cvb",		100,	0.8,	"cooking",				180.0,	1,		true,	"",					{{"corn-flour", 2}, } },
}


for i, f in pairs(foods) do
	local sg = "foods"
	local rn = f[1]
	if f[8] then 
		sg = "effect"
		rn = f[1].."-"..f[10][1][1]
	end
	local ty = "items"
	if string.match(f[1], ".+capsule$") then
		ty = "capsules"
	else
		ty = "items"
	end
	
	data:extend({
		{
			type = "capsule",
			name = f[1],
			icon = "__FoodIndustry__/graphics/icons/"..ty.."/"..f[1]..".png",
			icon_size = 32,
			flags = {"goes-to-main-inventory"},
			subgroup = sg,
			order = "w-d",
			stack_size = f[3],
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
					cooldown = f[4]*60,
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
			icon = "__FoodIndustry__/graphics/icons/"..ty.."/"..f[1]..".png",
			icon_size = 32,
			category = f[5],
			subgroup = sg,
			energy_required = f[6],
			ingredients = f[10],
			results = {{f[1], f[7]}}
		},
	})
end
