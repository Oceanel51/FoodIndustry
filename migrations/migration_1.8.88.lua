for _, player in pairs(game.players) do
	index = player.index

	if player.valid and player.connected then
		local leftGui = player.gui.left
		
		if not leftGui.frame then break end

		leftGui.frame.destroy()
		figui.create(index, player)

		player.print("FI migration_1.8.88: main frame of GUI recreated successful")
	end
end
