for i, force in pairs(game.forces) do
	force.recipes["fi-table-logo-lamp"].enabled = force.technologies["optics"].researched
	force.recipes["fi-fluid-tank"].enabled = force.technologies["fluid-handling"].researched
	
end


-- add migration for global.energy_max[index] with researched technology 
--/c game.player.gui.left.frame.destroy()
if global.energy and global.fullness then
	for index, player in pairs(game.players) do
		if global.energy[index] and global.fullness[index] then -- if exists values in global.energy table
			if player.valid and player.connected then
				local leftGui = player.gui.left
				
				if leftGui.frame.energylabel then  -- destroy all old frame data of GUI (after 0.16.30)
					leftGui.frame.energylabel.destroy()
					leftGui.frame.energybar.destroy()
					leftGui.frame.fullnesslabel.destroy()
					leftGui.frame.fullnessbar.destroy()
					player.print("Old frame data of GUI (after 0.16.30) destroed")
					writeDebug("Old frame data of GUI (after 0.16.30) destroed")
				end
				
			end
		end
		
		if player.connected then
			if not global.energy_max[index] then
				global.energy_max[index] = 100 -- set initial max Energy for connected players
			end
		end
		
		
	end
end

