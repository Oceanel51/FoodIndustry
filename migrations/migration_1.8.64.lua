-- add migration for global.energy_max[index] with researched technology 
for index, player in pairs(game.players) do
	
	if player.valid and player.connected then
		local leftGui = player.gui.left
		
		if not leftGui.frame then break end
		
		if not leftGui.frame.flow1.flow13 then  -- destroy all old frame data of GUI (after 1.8.60)
			leftGui.frame.destroy()
			figui.create(index, player)
			player.print("FI migration_1.8.64: Old frame data of GUI (after 1.8.60) sucesfuly replaced")
		end

	end
	
end
