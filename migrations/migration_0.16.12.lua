for i, force in pairs(game.forces) do
	force.recipes["rapeseed-growth-w"].enabled = force.technologies["advanced-farming"].researched
	force.recipes["rapeseed-growth-c"].enabled = force.technologies["fertilization"].researched
	force.recipes["rapeseed-growth-f"].enabled = force.technologies["fertilization-2"].researched
	force.recipes["compost-rapeseed"].enabled = force.technologies["fi-electric-composter"].researched
	force.recipes["fill-canola-oil-barrel"].enabled = force.technologies["fluid-handling"].researched
	force.recipes["empty-canola-oil-barrel"].enabled = force.technologies["fluid-handling"].researched
end

for i, player in pairs(game.players) do
	if player.valid then
		player.insert({name="rapeseed-plant", count=8})
	end
end
