require "libs.helper-functions"


local foods = {
--1									2					3		4		5						6		7		8			9				11
--name,								subgroup,			stack,	cool,	crafting category,		time,	amount,	effect,		order,			ingredients
{"cooked-corn",						"vegan-food",		10,		0.5,	"cooking",				4.0,	1,		false,		"w-d-a",		{{"corn", 1}, {type="fluid", name="pure-water", amount=20}} },
{"basic-salad",						"vegan-food",		10,		0.5,	"cooking",				1.5,	1,		false,		"w-d-b",		{{"tomato", 2}, {"cucumber", 1}, {"lettuce", 2}} },
{"corn-bread",						"vegan-food",		10,		0.5,	"cooking",				8.0,	1,		false,		"w-d-c",		{{"corn-flour", 2}, {type="fluid", name="pure-water", amount=10}} },
{"popcorn",							"vegan-food",		50,		0.2,	"cooking",				1.5,	1,		false,		"w-d-d",		{{"corn-seeds", 1}, {type="fluid", name="canola-oil", amount=1}} },
{"cooked-soy",						"vegan-food",		50,		0.2,	"cooking",				3.0,	5,		false,		"w-d-e",		{{"soy", 5}, {type="fluid", name="pure-water", amount=20}} },
{"baked-potato",					"vegan-food",		10,		0.5,	"cooking",				6.0,	1,		false,		"w-d-f",		{{"potato", 1}} },
{"fries",							"vegan-food",		10,		0.5,	"cooking",				6.0,	1,		false,		"w-d-g",		{{"raw-fries", 1}, {type="fluid", name="canola-oil", amount=6}} },
{"pickles",							"vegan-food",		50,		0.3,	"cooking",				40.0,	10,		false,		"w-d-h",		{{"cucumber", 5}, {"crystal", 2}, {type="fluid", name="pure-water", amount=60}} },
{"ketchup-fries",					"vegan-food",		10,		0.5,	"advanced-cooking",		0.5,	1,		false,		"w-d-i",		{{"fries", 1}, {type="fluid", name="ketchup", amount=1}} },
{"tofu-burger",						"vegan-food",		5,		0.5,	"cooking",				5.0,	1,		false,		"w-d-k",		{{"corn-bread", 1}, {"tomato", 2}, {"pickles", 2}, {"lettuce", 1}, {"tofu", 1}, {type="fluid", name="ketchup", amount=1}} },
{"tofu",							"vegan-food",		10,		0.5,	"chemistry",			4.0,	2,		false,		"w-d-l",		{{"crystal", 1}, {type="fluid", name="soy-milk", amount=24}, {type="fluid", name="sulfuric-acid", amount=1}} },
{"tofu-pizza",						"vegan-food",		5,		0.5,	"cooking",				5.0,	1,		false,		"w-d-m",		{{"corn-flour", 2}, {"tomato", 3}, {"tofu", 1}, {type="fluid", name="ketchup", amount=2}} },
{"best-salad",						"vegan-food",		5,		0.5,	"advanced-cooking",		1.5,	1,		false,		"w-d-n",		{{"lettuce", 4}, {"tomato", 3}, {"pickles", 1}, {"corn-seeds", 2}, {type="fluid", name="soy-sauce", amount=1}} },
-- species
--{"salt",							"foods-species",	100,	0.6,	"mixing",				20.0,	10,		false,		"w-a-a",		{{"crystal", 1}} },
--{"sugar",							"foods-species",	100,	0.6,	"cooking",				30.0,	5,		false,		"w-b-a",		{{"sugarcane", 2},} },
-- fish
{"cooked-fish-meat",				"foods-fish",		10,		0.3,	"cooking",				3.0,	1,		false,		"w-d-c1",		{{"fish-meat-red", 1}, {"corn-flour", 1},} },
{"fish-steak",						"foods-fish",		10,		0.5,	"cooking",				12.0,	1,		false,		"w-d-a1",		{{"fish-meat-red", 1}, {"corn-flour", 1}, {type="fluid", name="canola-oil", amount=2},} },
{"fish-pizza",						"foods-fish",		5,		0.5,	"cooking",				5.0,	1,		false,		"w-d-c1",		{{"corn-flour", 2}, {"tomato", 3}, {"fish-steak", 1}, {type="fluid", name="ketchup", amount=2},} },
{"fish-burger",						"foods-fish",		5,		0.5,	"advanced-cooking",		5.0,	1,		false,		"w-d-d1",		{{"corn-bread", 1}, {"tomato", 2}, {"pickles", 2}, {"lettuce", 1}, {"fish-steak", 1}, {type="fluid", name="ketchup", amount=1},} },
{"fish-salad",						"foods-fish",		5,		0.5,	"advanced-cooking",		1.5,	1,		false,		"w-d-e1",		{{"lettuce", 4}, {"tomato", 3}, {"pickles", 1}, {"corn-seeds", 2}, {"fish-steak", 1},} },
{"fish-and-chips",					"foods-fish",		5,		0.5,	"cooking",				1.5,	1,		false,		"w-d-e2",		{{"fish-steak", 1}, {"fries", 1},} },
-- meat
{"biter-steak",						"foods-meat",		10,		0.5,	"cooking",				12.0,	1,		false,		"w-d-a",		{{"biter-meat", 1}, {type="fluid", name="canola-oil", amount=2}} },
{"schnitzel",						"foods-meat",		10,		0.5,	"cooking",				12.0,	1,		false,		"w-d-b",		{{"biter-meat", 1}, {"corn-flour", 1}, {type="fluid", name="canola-oil", amount=5}} },
{"pizza",							"foods-meat",		5,		0.5,	"cooking",				5.0,	1,		false,		"w-d-c",		{{"corn-flour", 2}, {"tomato", 3}, {"biter-steak", 1}, {type="fluid", name="ketchup", amount=2}} },
{"burger",							"foods-meat",		5,		0.5,	"cooking",				5.0,	1,		false,		"w-d-d",		{{"corn-bread", 1}, {"tomato", 2}, {"pickles", 2}, {"lettuce", 1}, {"biter-steak", 1}, {type="fluid", name="ketchup", amount=1}} },
{"cooked-biter-meat",				"foods-meat",		10,		0.5,	"cooking",				12.0,	1,		false,		"w-d-e",		{{"biter-meat", 1}, {type="fluid", name="pure-water", amount=25}} },
-- capsules
{"vegan-food-capsule",				"cv",		50,		0.5,	"cooking",				60.0,	3,		false,	"w-d-a",			{{"fries", 1}, {"tofu-burger", 1}, {"best-salad", 1}, {"crystal", 1}} },
{"food-capsule",					"cm",		50,		0.5,	"cooking",				60.0,	3,		false,	"w-d-b",			{{"fries", 1}, {"burger", 1}, {"best-salad", 1}, {"crystal", 1}} },

{"simple-speed-capsule",			"cvs",		100,	0.5,	"cooking",				80.0,	3,		true,	"w-capsule-a-aa",	{{"vegan-food-capsule", 5}, {"cucumber", 5}, {"lettuce", 15}, {"inserter", 2}} },
{"simple-speed-capsule",			"cms",		100,	0.5,	"cooking",				80.0,	3,		true,	"w-capsule-a-ab",	{{"food-capsule", 5}, {"biter-steak", 5}, {"inserter", 2}} },
{"basic-speed-capsule",				"cvb",		50,		0.5,	"cooking",				120.0,	3,		true,	"w-capsule-a-ba",	{{"vegan-food-capsule", 5},{"pickles", 10}, {"lettuce", 15}, {"inserter", 2}} },
{"basic-speed-capsule",				"cmb",		50,		0.5,	"cooking",				120.0,	3,		true,	"w-capsule-a-bb",	{{"food-capsule", 5},{"biter-steak", 10}, {"inserter", 2}} },
{"advanced-speed-capsule",			"cva",		50,		0.5,	"centrifuging",			180.0,	3,		true,	"w-capsule-a-ca",	{{"vegan-food-capsule", 60}, {"uranium-235", 1}, {"speed-module", 1}} },
{"advanced-speed-capsule",			"cma",		50,		0.5,	"centrifuging",			180.0,	3,		true,	"w-capsule-a-cb",	{{"food-capsule", 60}, {"uranium-235", 1}, {"speed-module", 1}} },
{"simple-crafting-capsule",			"cvs",		100,	0.5,	"cooking",				80.0,	3,		true,	"w-capsule-b-aa",	{{"vegan-food-capsule", 5},{"tomato", 10}, {"lettuce", 10}, {"iron-axe", 1}} },
{"simple-crafting-capsule",			"cms",		100,	0.5,	"cooking",				80.0,	3,		true,	"w-capsule-b-ab",	{{"food-capsule", 5},{"biter-steak", 5}, {"iron-axe", 1}} },
{"basic-crafting-capsule",			"cvb",		50,		0.5,	"cooking",				120.0,	3,		true,	"w-capsule-b-ba",	{{"vegan-food-capsule", 5},{"ketchup-fries", 10}, {"lettuce", 10}, {"steel-axe", 1}} },
{"basic-crafting-capsule",			"cmb",		50,		0.5,	"cooking",				120.0,	3,		true,	"w-capsule-b-bb",	{{"food-capsule", 5},{"biter-steak", 10}, {"steel-axe", 1}} },
{"advanced-crafting-capsule",		"cva",		50,		0.5,	"centrifuging",			180.0,	3,		true,	"w-capsule-b-ca",	{{"vegan-food-capsule", 60}, {"uranium-235", 1}, {"productivity-module", 1}} },
{"advanced-crafting-capsule",		"cma",		50,		0.5,	"centrifuging",			180.0,	3,		true,	"w-capsule-b-cb",	{{"food-capsule", 60}, {"uranium-235", 1}, {"productivity-module", 1}} },
{"simple-mining-capsule",			"cvs",		100,	0.5,	"cooking",				80.0,	3,		true,	"w-capsule-c-aa",	{{"vegan-food-capsule", 5},{"tomato", 10}, {"lettuce", 10}, {"iron-axe", 1}} },
{"simple-mining-capsule",			"cms",		100,	0.5,	"cooking",				80.0,	3,		true,	"w-capsule-c-ab",	{{"food-capsule", 5},{"biter-steak", 5}, {"iron-axe", 1}} },
{"basic-mining-capsule",			"cvb",		50,		0.5,	"cooking",				120.0,	3,		true,	"w-capsule-c-ba",	{{"vegan-food-capsule", 5},{"ketchup-fries", 10}, {"lettuce", 10}, {"steel-axe", 1}} },
{"basic-mining-capsule",			"cmb",		50,		0.5,	"cooking",				120.0,	3,		true,	"w-capsule-c-bb",	{{"food-capsule", 5},{"biter-steak", 10}, {"steel-axe", 1}} },
{"advanced-mining-capsule",			"cva",		50,		0.5,	"centrifuging",			180.0,	3,		true,	"w-capsule-c-ca",	{{"vegan-food-capsule", 60}, {"uranium-235", 1}, {"steel-axe", 1}} },
{"advanced-mining-capsule",			"cma",		50,		0.5,	"centrifuging",			180.0,	3,		true,	"w-capsule-c-cb",	{{"food-capsule", 60}, {"uranium-235", 1}, {"steel-axe", 1}} },
{"simple-long-reach-capsule",		"cva",		100,	0.5,	"cooking",				80.0,	3,		true,	"w-capsule-d-aa",	{{"vegan-food-capsule", 5}, {"cucumber", 5}, {"lettuce", 15}, {"inserter", 2}} },
{"simple-long-reach-capsule",		"cms",		100,	0.5,	"cooking",				80.0,	3,		true,	"w-capsule-d-ab",	{{"food-capsule", 5}, {"biter-steak", 5}, {"inserter", 2}} },
{"basic-long-reach-capsule",		"cvb",		50,		0.5,	"cooking",				120.0,	3,		true,	"w-capsule-d-ba",	{{"vegan-food-capsule", 5},{"pickles", 10}, {"lettuce", 15}, {"long-handed-inserter", 2}} },
{"basic-long-reach-capsule",		"cmb",		50,		0.5,	"cooking",				120.0,	3,		true,	"w-capsule-d-bb",	{{"food-capsule", 5},{"biter-steak", 10}, {"long-handed-inserter", 2}} },
{"advanced-long-reach-capsule",		"cva",		50,		0.5,	"centrifuging",			180.0,	3,		true,	"w-capsule-d-ca",	{{"vegan-food-capsule", 60}, {"uranium-235", 1}, {"long-handed-inserter", 3}} },
{"advanced-long-reach-capsule",		"cma",		50,		0.5,	"centrifuging",			180.0,	3,		true,	"w-capsule-d-cb",	{{"food-capsule", 60}, {"uranium-235", 1}, {"long-handed-inserter", 3}} },

{"simple-digestive-capsule",		"cvbh",		100,	0.8,	"cooking",				180.0,	1,		true,	"w-d-a",			{{"corn-flour", 2}, } },
{"basic-digestive-capsule",			"cvbh",		100,	0.10,	"cooking",				180.0,	1,		true,	"w-d-b",			{{"corn-flour", 14}, } },
--{"basic-sleep-capsule",				"cvbh",		50,		0.8,	"cooking",				180.0,	1,		true,	"w-d-d",			{{"corn-flour", 10}, } },
--{"advanced-sleep-capsule",			"cvbh",		80,		0.8,	"centrifuging",			180.0,	1,		true,	"w-d-d",			{{"corn-flour", 10}, } },

{"basic-regen-capsule",				"cvb",		50,		0.5,	"cooking",				180.0,	3,		true,	"w-capsule-f-ba",	{{"vegan-food-capsule", 20}, {"tofu", 5}, {"effectivity-module", 1}} },
{"basic-regen-capsule",				"cmb",		50,		0.5,	"cooking",				180.0,	3,		true,	"w-capsule-f-bb",	{{"food-capsule", 20}, {"biter-steak", 5}, {"effectivity-module", 1}} },
{"advanced-regen-capsule",			"cva",		50,		0.5,	"centrifuging",			180.0,	3,		true,	"w-capsule-f-ca",	{{"vegan-food-capsule", 60}, {"uranium-235", 1}, {"effectivity-module", 1}} },
{"advanced-regen-capsule",			"cma",		50,		0.5,	"centrifuging",			180.0,	3,		true,	"w-capsule-f-cb",	{{"food-capsule", 60}, {"uranium-235", 1}, {"effectivity-module", 1}} },
{"basic-health-buffer-capsule",		"cvb",		50,		0.8,	"cooking",				180.0,	3,		true,	"w-capsule-e-ba",	{{"vegan-food-capsule", 20}, {"tofu", 5}, {"light-armor", 1}} },
{"basic-health-buffer-capsule",		"cmb",		50,		0.8,	"cooking",				180.0,	3,		true,	"w-capsule-e-bb",	{{"food-capsule", 20}, {"biter-steak", 5}, {"light-armor", 1}} },
{"advanced-health-buffer-capsule",	"cva",		50,		1.5,	"centrifuging",			180.0,	3,		true,	"w-capsule-e-ca",	{{"vegan-food-capsule", 60}, {"uranium-235", 1}, {"light-armor", 1}} },
{"advanced-health-buffer-capsule",	"cma",		50,		1.5,	"centrifuging",			180.0,	3,		true,	"w-capsule-e-cb",	{{"food-capsule", 60}, {"uranium-235", 1}, {"light-armor", 1}} },

{"simple-neutralizing-capsule",		"cvs",		50,		0.5,	"centrifuging",			180.0,	3,		true,	"w-capsule-s-ca",	{{"vegan-food-capsule", 30}, {"uranium-235", 1}, {"crystal", 1}} },
{"simple-neutralizing-capsule",		"cms",		50,		0.5,	"centrifuging",			180.0,	3,		true,	"w-capsule-s-cb",	{{"food-capsule", 30}, {"uranium-235", 1}, {"crystal", 1}} },
{"invulnerability-capsule",			"cvb",		50,		1.5,	"centrifuging",			360.0,	1,		true,	"w-capsule-z-ca",	{{"advanced-health-buffer-capsule", 1}, {"advanced-regen-capsule", 1}} },
}


for i, f in pairs(foods) do
	local sg = "foods"
	local rn = f[1]
	if f[8] then 
		sg = "effect"
		rn = f[1].."-"..f[10][1][1]
	end
	local ty = "foods"
	if string.match(f[1], ".+capsule$") then
		ty = "capsules"
	else
		ty = "foods"
	end
	
	data:extend({
		{
			type = "capsule",
			name = f[1],
			icon = "__FoodIndustry__/graphics/icons/"..ty.."/"..f[1]..".png",
			icon_size = 32,
			flags = {"goes-to-main-inventory"},
			subgroup = sg,
			order = f[9],
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
