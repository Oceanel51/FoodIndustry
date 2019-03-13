for i, force in pairs(game.forces) do
	local technologies = force.technologies;
	local recipes = force.recipes;

	  --if force.technologies["salad"].researched then
	if game.technology_prototypes["salad"] and technologies["salad"].researched then
		force.recipes["fish-salad"].enabled = true
		recipes["fish-salad"].reload()
	end
	if force.technologies["complex-foods"].researched then
		force.recipes["fish-and-chips"].enabled = true
		force.recipes["fish-and-chips"].reload()
	end

	force.reset_recipes()
	force.reset_technologies()
end


-- add migration for global.energy_max[index] with researched technology 
for index, player in pairs(game.players) do
	
	if player.valid and player.connected then
		local leftGui = player.gui.left
		
		if not leftGui.frame then
			break
		end

		--if not global.effects[index]["overeating"] then
		--	global.effects[index]["overeating"] = {false,0,0,0}	-- init empty value of Overeating
		--end

	end

	player.print("FI migration_1.8.57.0: reset some technologies")
end
