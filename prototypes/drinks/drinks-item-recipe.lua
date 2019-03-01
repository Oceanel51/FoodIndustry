require "libs.helper-functions"
--	1					2			3							4			5		6		7
--	name				type		category					amount		tint for liquid color
--																			r		g		b
local ingredients = {
	{"pure-water",		"fluid",	"crafting-with-fluid",		6,			{0.0,	0.5,	1.0}  },
	{"apple",			"item",		"crafting-with-fluid",		3,			{1,		0.2,	0}} ,
	{"orange",			"item",		"crafting-with-fluid",		3,			{0.6,	0.6,	0} },
}

for i1, di in pairs(ingredients) do

	local foods = {
		--1							2		3		4			5		6		7		8			9																		10
		--name,						stack,	cool,	category,	time,	amount,	type,	enabled,	ingredients,													tint for liquid color
		{"flask-"..di[1],			10,		0.5,	di[3],		3.0,	1,		"",		true,		{{"flask", 1}, {type=di[2], name=di[1], amount=30}},			{r=di[5],g=di[6],b=di[7],a=0.6} },
		{"plastic-bottle-"..di[1],	10,		0.5,	di[3],		5.0,	1,		"",		false,		{{"plastic-bottle", 1}, {type=di[2], name=di[1], amount=60}},	{r=di[5],g=di[6],b=di[7],a=0.5} },
		{"glass-bottle-"..di[1],	10,		0.5,	di[3],		6.0,	1,		"",		false,		{{"glass-bottle", 1}, {type=di[2], name=di[1], amount=50}},		{r=di[5],g=di[6],b=di[7],a=0.8} },
	}

	for i, f in pairs(foods) do
		local sg = "drinks-"..di[1]
		local rn = f[1]
		if f[7] == "test" then
			sg = "effect"
			rn = f[1].."-"..f[9][1][1]
		end
		local icon1 = ""
		local icon2 = ""
		if string.match(f[1], "flask") == "flask" then
			icon1 = "flask-full"
			icon2 = "flask-full-mask"
		elseif string.match(f[1], "plastic%-bottle") == "plastic-bottle" then
			icon1 = "plastic-bottle-full"
			if f[10]["a"] >= 9 then
				icon2 = "plastic-bottle-full-mask-9"
			elseif f[10]["a"] >= 7 then
				icon2 = "plastic-bottle-full-mask-7"
			elseif f[10]["a"] >= 5 then
				icon2 = "plastic-bottle-full-mask-5"
			elseif f[10]["a"] >= 2 then
				icon2 = "plastic-bottle-full-mask-2"
			else
				icon2 = "plastic-bottle-full-mask"
			end
		elseif string.match(f[1], "glass%-bottle") == "glass-bottle" and data.raw.item["glass"] then
			-- TODO add glass tara
		end

		if icon1 == "" or icon2 == "" then break end

		data:extend({
			{
				type = "capsule",
				name = f[1],
				--icon = "__FoodIndustry__/graphics/icons/drinks/"..f[1]..".png",
				icons = {
					{ icon = "__FoodIndustry__/graphics/icons/drinks/"..icon1..".png", },
					{
						icon = "__FoodIndustry__/graphics/icons/drinks/"..icon2..".png",
						tint = di[5]
						--scale = 0.7 * 32 / icon_size,
						--shift = {0, 0},
					},
				},
				icon_size = 64,
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
				enabled = f[8],
				--icon = "__FoodIndustry__/graphics/icons/drinks/"..f[1]..".png",
				icons = {
					{ icon = "__FoodIndustry__/graphics/icons/drinks/"..icon1..".png", },
					{
						icon = "__FoodIndustry__/graphics/icons/drinks/"..icon2..".png",
						tint = di[5]
					},
				},
				icon_size = 64,
				category = f[4],
				subgroup = sg,
				energy_required = f[5],
				ingredients = f[9],
				results = {{f[1], f[6]}}
			},
		})
	end
end