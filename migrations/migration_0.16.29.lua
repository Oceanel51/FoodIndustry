for i, force in pairs(game.forces) do
	force.recipes["fi-electric-composter"].enabled = force.technologies["electric-composting"].researched
end