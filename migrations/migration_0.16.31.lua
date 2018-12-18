for i, force in pairs(game.forces) do
	force.technologies["optics"].researched = force.recipes["fi-table-logo-lamp"].enabled
	force.technologies["fluid-handling"].researched = force.recipes["fi-fluid-tank"].enabled
end

--if not leftGui.frame1 then
--	leftGui.frame.destroy()
--end

-- add migration for global.energy_max[index] with researched technology 