-- add migration for global.energy_max[index] with researched technology 
for index, player in pairs(game.players) do
	
	if player.valid and player.connected then
		local leftGui = player.gui.left
		
		if not leftGui.frame then
			break
		end

		if not global.effects[index]["overeating"] then
			global.effects[index]["overeating"] = {false,0,0,0}	-- init empty value of Overeating
		end

	end

	player.print("FI migration_1.8.56.0: add Overeating global.effects variable")
end
