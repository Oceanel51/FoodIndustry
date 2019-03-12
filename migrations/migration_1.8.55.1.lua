-- add migration for global.energy_max[index] with researched technology 
for index, player in pairs(game.players) do
	
	if player.valid and player.connected then
		local leftGui = player.gui.left
		
		if not leftGui.frame then
			break
		end


		if table.maxn(global.effects[index]["speed"][5]) == 0 then
			global.effects[index]["speed"][1] = false
			global.effects[index]["speed"][2] = 0
			global.effects[index]["speed"][3] = 0
			global.effects[index]["speed"][4] = 0
			game.players[index].character_running_speed_modifier = 0
		end

	end

	player.print("FI migration_1.8.55.1: speed effects sucesfuly changed")
end
