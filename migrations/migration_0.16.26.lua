for i, force in pairs(game.forces) do
	force.recipes["fi-composter"].enabled = force.technologies["composting"].researched
end