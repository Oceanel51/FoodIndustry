require "prototypes.functions.fi-GUI"


-- Early game "Eat/Drink" Buttons creation
function figui.create.eedb(index, player)
	-- local leftGui = player.gui.left
	local ScreenGui = player.gui.screen
	
	if not settings.global["food-industry-calculate"].value then
		if not ScreenGui.frame then
			ScreenGui.frame.destroy()
		end
		return false
	end

	-- if ScreenGui.bar then
	-- 	ScreenGui.bar.destroy()
	-- end

	-- initialize main .frame
	if not ScreenGui.frame then
		ScreenGui.add{type = "frame", name = "frame", direction = "horizontal"}
	end

		-- TODO "eat-button-ongui" by Oceanel
		-- if player.force.technologies["fi-tech-eatout-button"] and player.force.technologies["fi-tech-eatout-button"].researched then
		-- 	if not leftGui.frame.flow6.eat_button then
		-- 		leftGui.frame.flow6.add{
		-- 		type = "button",
		-- 		name = "eat_button",
		-- 		caption = {'button.eatout'},
		-- 		tooltip = {'button.eatout-tooltip'},
		-- 		align = "right",
		-- 		vertical_align = "bottom",
		-- 		--horizontally_stretchable = true,
		-- 		--key_sequence = "SHIFT + E",
		-- 		height = 20,
		-- 		width = 25}
		-- 	end
		-- 	else
		-- 	leftGui.frame.flow6.destroy()
		-- end
	return true
end


-- Early game "Eat/Drink" Buttons creation
function figui.destroy.eedb(index, player)
	-- local leftGui = player.gui.left
	local ScreenGui = player.gui.screen
	
	if not settings.global["food-industry-calculate"].value then
		if not ScreenGui.frame then
			ScreenGui.frame.destroy()
		end
		return false
	end

	if ScreenGui.frame then
		ScreenGui.frame.destroy()
	end

end
