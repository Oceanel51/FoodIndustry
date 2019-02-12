
function eatoutFood()
	for index,player in pairs(game.players) do
		if player.connected then
			-------------------------------------------------------------------------
			local foundFood = false;
			local inv = player.get_inventory(defines.inventory.player_main)
			for trys=1,2 do
				for i,d in pairs(inv.get_contents()) do
					if gives_saturation[i] then -- тут нужно прописать если это еда и она добавляет Energy
						if foundFood == false or foundFoodValue < gives_saturation[i] then
							foundFoodValue = gives_saturation[i]
							foundFood = i
						end	
					end
				end
				inv = player.get_inventory(defines.inventory.player_quickbar)
			end
			if foundFood ~= false and global.EatOrDie_Saturation + foundFoodValue <= 100 then
				-- wenn ich essen kann, dann esse
				local inv = player.get_inventory(defines.inventory.player_main)
				for trys=1,2 do
					if inv.get_item_count(foundFood) >= 1 then
						inv.remove{name=foundFood, count=1}
						global.EatOrDie_Saturation = global.EatOrDie_Saturation + foundFoodValue
						player.print("eating " .. foundFood .. " gives " .. foundFoodValue .. " Saturation")
						break
					end
					inv = player.get_inventory(defines.inventory.player_quickbar)
				end
			end
			-------------------------------------------------------------------------
		end
	end
end
function eatingFood()
end

