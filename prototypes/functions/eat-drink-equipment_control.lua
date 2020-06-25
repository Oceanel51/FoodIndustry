require "prototypes.functions.fi-GUI"


-- Early game "Eat/Drink" Buttons creation
function figui.eedb.create(index, player)
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

	if not ScreenGui.frame.flow1 then
		ScreenGui.frame.add{type = "flow", name = "flow1", right_padding = 0, left_padding = 0, direction = "horizontal"}
	end
	-- TODO "eat-button-ongui" by Oceanel
	-- if player.force.technologies["fi-tech-eatout-button"] and player.force.technologies["fi-tech-eatout-button"].researched then
		if not ScreenGui.frame.flow1.eat_button then
			ScreenGui.frame.flow1.add{
			type = "button",
			name = "eat_button",
			caption = {'button.eatout'},
			tooltip = {'button.eatout-tooltip'},
			align = "right",
			vertical_align = "bottom",
			--horizontally_stretchable = true,
			--key_sequence = "SHIFT + E",
			height = 16,
			width = 24}
		end
	-- 	else
	-- 	ScreenGui.frame.flow6.destroy()
	-- end

	if not ScreenGui.frame.flow2 then
		ScreenGui.frame.add{type = "flow", name = "flow2", right_padding = 0, left_padding = 0, width=16, height=32, direction = "vertical"}
	end
	if not ScreenGui.frame.flow2.sprite_foods_icon then
		ScreenGui.frame.flow2.add({type="sprite", name="sprite_foods_icon", sprite="foods_icon_gray", scaleable=false, align="left",})
	end
	if not ScreenGui.frame.flow2.sprite_drinks_icon then
		ScreenGui.frame.flow2.add({type="sprite", name="sprite_drinks_icon", sprite="drinks_icon_gray", scaleable=false, align="left",})
	end

	if not ScreenGui.frame.flow3 then
		ScreenGui.frame.add{type = "flow", name = "flow3", right_padding = 0, left_padding = 0, direction = "horizontal"}
	end

	return true
end


-- Early game "Eat/Drink" Buttons creation
function figui.eedb.destroy(index, player)
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

function figui.eedb.update(index, player)
	
end
