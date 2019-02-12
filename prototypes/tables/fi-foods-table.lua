require "stdlib.table"


function collect_all_foods_table()
	local all_foods = {}
	
	--table.insert(all_foods, x, y)
	--table.insert(all_foods, x, y)
	all_foods = table.merge(foods_table(),drinks_table(),true)
	
	return all_foods
end


function foods_table()
	local foods = {
	--  1						  2		  3			  4		  5
	--name,						energy,	fullness,	health,	effect

	--  1								  2							  3		  4			  5			  6		  7		  8		  9
	--name,								type,						energy,	water,	{V,M,C,F},		fullness, c_f,	health,	effect/s
	{"corn", 							"vegan",					5,		-2,		{1,2,0.5,0},	24,		24,		5,		{} },
	{"cucumber", 						"vegan",					8,		12,		{5,4,0,0},		25,		25,		10,		{} },
	{"tomato", 							"vegan",					5,		8,		{5,2,0,0},		14,		14,		15,		{} },
	{"lettuce", 						"vegan",					3,		5,		{3,2,0,0},		8,		8,		3,		{} },
	{"cooked-corn", 					"vegan",					15,		4,		{0,7,3,0},		40,		40,		25,		{} },
	{"corn-bread", 						"vegan-fat",				25,		-2,		{0,1,4,1},		55,		55,		30,		{} },
	{"popcorn", 						"vegan-fat",				4,		-3,		{0,0,1.5,2.2},	14,		14,		10,		{} },
	{"basic-salad", 					"vegan-gourmet",			25,		12,		{8,4,1,0},		40,		40,		40,		{} },
	{"cooked-soy", 						"vegan",					2,		-1,		{0,2,2,1},		5,		5,		5,		{} },
	{"baked-potato", 					"vegan-gourmet",			10,		0,		{2,4,2,1},		30,		0,		30,		{} },
	{"fries", 							"vegan-fat",				20,		-5,		{0,0,3,4},		55,		0,		35,		{} },
	{"ketchup-fries", 					"vegan-fat",				25,		-2,		{0,0,6,6},		70,		0,		45,		{} },
	{"biter-meat", 						"meat",						15,		-15,	{0,0,3,8},		55,		55,		-100,	{{"energy_usage",-0.5,600},} },
	{"biter-steak", 					"meat",						30,		-10,	{0,0,6,13},		70,		70,		-30,	{} },
	{"schnitzel", 						"meat",						35,		-10,	{0,0,10,15},	80,		0,		-40,	{} },
	{"pickles", 						"salt-gourmet",				5,		-5,		{1,2,1,0},		6,		0,		5,		{} },
	{"tofu", 							"vegan",					25,		0,		{3,2,7,5},		60,		0,		15,		{} },
	{"pizza", 							"meat",						70,		-9,		{1,2,6,12},		95,		0,		50,		{} },
	{"burger", 							"meat-gourmet",				75,		-10,	{1,1,10,14},	100,	0,		50,		{} },
	{"tofu-pizza", 						"vegan",					65,		-7,		{1,2,11,7},		95,		0,		70,		{} },
	{"tofu-burger", 					"vegan-gourmet",			60,		-8,		{1,2,13,9},		100,	0,		70,		{} },
	{"best-salad", 						"vegan-gourmet-healthy",	45,		18,		{14,8,6,0},		70,		0,		180,	{} },
	{"cooked-biter-meat",				"meat",						20,		-5,		{0,1,4,10},		60,		0,		-50,	{} },
	{"vegan-food-capsule",				"vegan-special",			50,		0,		{3,3,3,2},		50,		50,		100,	{{"drink_to_add_more_energy",1,180,{{"flask-pure-water",0.8}, {"plastic-bottle-pure-water",0.5},}},} },
	{"food-capsule", 					"meat-special",				50,		0,		{3,3,3,3},		50,		50,		100,	{{"drink_to_add_more_energy",1,180,{{"flask-pure-water",0.8}, {"plastic-bottle-pure-water",0.5},}},} },

	{"simple-speed-capsule",			"special",					30,		0,		{0,0,0,0},		30,		30,		50,		{{"speed",0.25,1200},} },
	{"simple-crafting-capsule",			"special",					30,		0,		{0,0,0,0},		30,		30,		50,		{{"crafting",4,1200},} },
	{"simple-mining-capsule",			"special",					30,		0,		{0,0,0,0},		30,		30,		50,		{{"mining",4,3600},} },
	{"simple-long-reach-capsule",		"special",					30,		0,		{0,0,0,0},		30,		30,		50,		{{"long_reach",5,21600},} },

	{"basic-speed-capsule",				"special",					50,		10,		{2,2,2,1},		50,		50,		0,		{{"speed",0.5,5400},} },
	{"basic-crafting-capsule",			"special",					50,		10,		{2,2,2,1},		50,		50,		0,		{{"crafting",20,1200},} },
	{"basic-mining-capsule",			"special",					50,		10,		{2,2,2,1},		50,		50,		0,		{{"mining",4,3600},} },
	{"basic-long-reach-capsule",		"special",					50,		10,		{2,2,2,1},		50,		50,		0,		{{"long_reach",35,21600},} },

	{"advanced-speed-capsule",			"special",					50,		50,		{2,2,2,1},		50,		0,		0,		{{"speed",0.75,5400},} },
	{"advanced-crafting-capsule",		"special",					50,		50,		{2,2,2,1},		50,		0,		0,		{{"crafting",50,1200},} },
	{"advanced-mining-capsule",			"special",					50,		50,		{2,2,2,1},		50,		0,		0,		{{"mining",4,3600},} },
	{"advanced-long-reach-capsule",		"special",					50,		50,		{2,2,2,1},		50,		50,		0,		{{"long_reach",150,21600},} },

	{"basic-regen-capsule",				"special",					50,		50,		{2,2,2,1},		50,		0,		0,		{{"regeneration",2,900},} },
	{"advanced-regen-capsule",			"special",					80,		80,		{5,5,5,3},		80,		0,		0,		{{"regeneration",5,1800},} },
	{"basic-health-buffer-capsule",		"special",					50,		50,		{2,2,2,1},		50,		0,		0,		{{"health_buffer",200,1800},} },
	{"advanced-health-buffer-capsule",	"special",					80,		80,		{5,5,5,3},		80,		0,		0,		{{"health_buffer",1250,2700},} },
	{"invulnerability-capsule",			"special",					50,		50,		{0,0,0,0},		50,		0,		0,		{{"invulnerability",9750,900},} },

	{"simple-neutralizing-capsule",		"special",					30,		0,		{0,0,0,0},		30,		0,		0,		{{"neutralize_effects",15},} },
	
	{"simple-digestive-capsule",		"special",					20,		0,		{-1,0,0,0},		0,		0,		0,		{{"digestion",0.4,10000},} },
	{"basic-digestive-capsule",			"special",					50,		0,		{0,0,0,0},		10,		10,		0,		{{"digestion",1,5000},} },
	{"advanced-digestive-capsule",		"special",					80,		0,		{0,-1,-1,-1},	20,		20,		0,		{{"digestion",3.5,6200},} },
}
	
	return foods
end


function drinks_table()
	local drinks = {
	--  1								  2					  3		  4		  5				  6		  7		  8		  9
	--name,								type,				energy,	water,	{V,M,C,F},		fullness,c_f,	health,	effect/s
	{"flask-pure-water",				"water",			1,		30,		{0,0,0,0},		30,		30,		3,		{} },
	{"plastic-bottle-pure-water",		"water",			0,		60,		{-1,0,0,0},		60,		60,		0,		{} },
	-- TODO ad new drinks
	{"glass-bottle-pure-water",			"healthy",			4,		50,		{0,1,-1,-0.5},	50,		50,		4,		{} },
	{"tea-cup-with-sugar", 				"sweet",			10,		25,		{0,2,1,0},		30,		0,		5,		{{"crafting",1,12000},{"mining",0.5,12000},{"water-usage",-0.02,12000},} },
	{"tea-cup", 						"",					10,		30,		{0,2,0,0},		30,		0,		5,		{{"crafting",1,12000},{"mining",0.5,12000},{"water-usage",-0.02,12000},} },
	{"coffee-cup-with-sugar",			"sweet",			20,		15,		{0,1,2,1},		30,		0,		10,		{{"speed",0.4,18000},{"crafting",2,18000},{"mining",1,18000},{"energy-usage",0.05,18000},} },
	{"coffee-cup", 						"",					20,		20,		{0,1,1,0},		30,		0,		10,		{{"speed",0.4,18000},{"crafting",2,18000},{"mining",1,18000},{"energy-usage",0.05,18000},} },
	}
	
	return drinks
end
