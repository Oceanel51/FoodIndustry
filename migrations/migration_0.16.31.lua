for i, force in pairs(game.forces) do
	force.technologies["optics"].researched = force.recipes["fi-table-logo-lamp"].enabled
end
