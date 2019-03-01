require "libs.helper-functions"


if not figui then figui = {} end

function figui.mod_init()
	if not settings.global["food-industry-calculate"].value then
		local leftGui = player.gui.left
		if not leftGui.frame then
			leftGui.frame.destroy()
		end
		return
	end

    --if not global.settings then global.settings = {} end
    --if not global.settings.update_delay then global.settings.update_delay = 60 end
	for index,player in pairs(game.players) do
		if player.connected then
			fi_global_variables_init()
			figui.create(index, player)
		end
	end
	writeDebug("Init ...OK")
	return
	--for index, player in pairs(game.players) do
	--	if player.valid and player.connected then
	--		-- remove old GUI types
	--		local leftGui = player.gui.left
	--		if leftGui.frame.energylabel then  -- destroy all old frame GUI
	--			leftGui.frame.destroy()
	--			player.print("figui: old frame of GUI destroed!")
	--		end
	--	end
		
        --evogui.create_player_globals(player)
        --evogui.create_sensor_display(player)
	--end
end

--/c game.player.print(game.player.gui.left.frame.energylabel.name)


-- creation or recreation FI GUI
function figui.create(index, player)
	local leftGui = player.gui.left
	
	if leftGui.bar then
		leftGui.bar.destroy()
	end


	-- initialize main .frame
	if not leftGui.frame then
		leftGui.add{type = "frame", name = "frame", direction = "vertical"}
	end

	-- initialize .flow0
	if not leftGui.frame.flow0 then
		leftGui.frame.add{type = "flow", name = "flow0", right_padding = 0, left_padding = 0, width=16, height=16, direction = "horizontal"}
	end
	if not leftGui.frame.flow0.sprite_fi_logo then
		--leftGui.frame.flow0.add{type="sprite", name="sprite_fi_logo", SpritePath="__FoodIndustry__/graphics/icons/fi-icon-x16.png", width=16, height=16, scaleable=false, align="right",}
		leftGui.frame.flow0.add{type="sprite", name="sprite_fi_logo", SpritePath="item/fi-logo-x32", width=16, height=16, scaleable=false, align="right",}
	end
	
	-- initialize labels and bars of .flow1
	if not leftGui.frame.flow1 then
		leftGui.frame.add{type = "flow", name = "flow1", right_padding = 0, left_padding = 0, direction = "horizontal"}
	end
	if not leftGui.frame.flow1.energylabel then
		--leftGui.frame.flow1.add({type="sprite", name="sprite_fi_logo", SpritePath="__FoodIndustry__/graphics/icons/fi-icon-x32.png", width=32, height=32, scaleable=false, align="right",})
		-- "Energy: " .. energylabel .. " (usage: ".. usagelabel .."%)"
		leftGui.frame.flow1.add({type="label", name="label_energy", caption={'label.label-energy', ": "}, style = "fi-label", align="right",})
		--leftGui.frame.flow1.add({type="label", name="label_energy1", caption=": ", style = "fi-label", align="left",})
		leftGui.frame.flow1.add({type="label", name="energylabel", caption="", tooltip = {'label.label-energylabel-tooltip', global.energy_max[index]}, style = "fi-label"})
		--leftGui.frame.flow1.energylabel.tooltip = {'label.label-energylabel-tooltip', global.energy_max[index]}
		--leftGui.frame.flow1.add({type="label", name="label_usage1", caption=" (", left_padding=0, right_padding=0,})
		leftGui.frame.flow1.add({type="label", name="label_usage", caption={'label.label-usage', " (", ": "}, style = "fi-label",})
		--leftGui.frame.flow1.add({type="label", name="label_usage2", caption=": ", left_padding=0, right_padding=0,})
		--leftGui.frame.flow1.add({type="label", name="usagelabel", caption={"", 'label.label-percent', ")"}, left_padding=0, right_padding=0,})
		leftGui.frame.flow1.add({type="label", name="usagelabel", caption="", style = "fi-label",})
		--leftGui.frame.flow1.add({type="label", name="label_percent", caption={'label.label-percent', "%)"}, style = "fi-label",})
		leftGui.frame.flow1.add({type="label", name="label_percent", caption="%)", style = "fi-label",})
		--leftGui.frame.flow1.add({type="label", name="label_percent1", caption=")", left_padding=0, right_padding=0,})
	end
	if not leftGui.frame.energybar then
		leftGui.frame.add({type="progressbar", name="energybar"})
		leftGui.frame.energybar.style.width = 200
	end	


	-- initialize labels and bars of .flow22 - drinks
	if not leftGui.frame.flow22 then
		leftGui.frame.add{type = "flow", name = "flow22", direction = "horizontal"}
	end
	if not leftGui.frame.flow22.drinkslabel then
		-- "Drinks: " .. drinklabel .. " (usage: ".. usagelabel .."%)"
		leftGui.frame.flow22.add({type="label", name="label_drinks", caption={'label.label-drinks', ": "}, style = "fi-label", align="right",})
		leftGui.frame.flow22.add({type="label", name="drinkslabel", caption="", tooltip = {'label.label-drinkslabel-tooltip', global.drinks_max[index]}, style = "fi-label"})
		leftGui.frame.add({type="progressbar", name="drinksbar"})
		leftGui.frame.drinksbar.style.width = 200
		leftGui.frame.drinksbar.style.color = {r=0.2, g=0.2, b=1, a=1}
	end	

	-- DEBUG check this
	if player.connected and player.character then -- if not sandbox mode
		-- initialize labels and bars of .flow2
		if not leftGui.frame.flow2 then
			leftGui.frame.add{type = "flow", name = "flow2", direction = "horizontal"}
		end
		if not leftGui.frame.flow2.fullnesslabel then
			--"Fullness: " .. fullnessbar .."%"
			leftGui.frame.flow2.add({type="label", name="label_fullness", caption={'label.label-fullness', ": "},})
			--leftGui.frame.flow2.add({type="label", name="label_fullness1", caption=": ",})
			leftGui.frame.flow2.add({type="label", name="fullnesslabel", caption=""})
			--leftGui.frame.flow2.add({type="label", name="label_percent", caption={'label.label-percent'},})
			leftGui.frame.flow2.add({type="label", name="label_percent", caption="%",})
		end	
		if not leftGui.frame.fullnessbar then
			leftGui.frame.add({type="progressbar", name="fullnessbar"})
			leftGui.frame.fullnessbar.style.width = 200
			leftGui.frame.fullnessbar.style.color = {r = 1, g = 0.6, a = 1}
		end
		
		-- .flow 3,4,5 rezerved for "Balance of Substances"
		if not leftGui.frame.flow3 then
			leftGui.frame.add{type = "flow", name = "flow3", direction = "horizontal"}
		end
		if not leftGui.frame.flow3.flow33 then
			leftGui.frame.flow3.add{type="flow", name="flow33", direction="vertical"}
			--leftGui.frame.flow3.flow33.style.left_padding=10
			leftGui.frame.flow3.flow33.add({type="label", name="label_substances", caption={'label.label-substances', ": "}, tooltip={'label.label-substances-tooltip',"-10","100"}})
		end
		
		if not leftGui.frame.flow3.flow33.flow331 then
			leftGui.frame.flow3.flow33.add{type="flow", name="flow331", tooltip={'label.label-substancesbar_v-tooltip'}, style="fi-substances-flow"}
			if not leftGui.frame.flow3.flow33.flow331.substancesbar_v then
				--leftGui.frame.flow3.flow33.flow331.add({type="label", name="label_substancesbar_v", caption={'label.label-substancesbar_v'},})
				leftGui.frame.flow3.flow33.flow331.add({type="progressbar", name="substancesbar_v", style="fi-substances-bar"})
				leftGui.frame.flow3.flow33.flow331.substancesbar_v.style.color = {r=0.388235294, g=1, b=0.317647059, a=1}
				leftGui.frame.flow3.flow33.flow331.add({type="label", name="label_substancesbar_v", caption="0", tooltip={'label.label-substancesbar_v-tooltip'}, style="fi-label-mini"})
				leftGui.frame.flow3.flow33.flow331.label_substancesbar_v.style.font_color = {r=0.388235294, g=1, b=0.317647059, a=1}
			end
		end
		if not leftGui.frame.flow3.flow33.flow332 then
			leftGui.frame.flow3.flow33.add{type = "flow", name = "flow332", tooltip={'label.label-substancesbar_m-tooltip'}, style="fi-substances-flow"}
			if not leftGui.frame.flow3.flow33.flow332.substancesbar_m then
				--leftGui.frame.flow3.flow33.flow332.add({type="label", name="label_substancesbar_m", caption={'label.label-substancesbar_m'},})
				leftGui.frame.flow3.flow33.flow332.add({type="progressbar", name="substancesbar_m", style="fi-substances-bar"})
				leftGui.frame.flow3.flow33.flow332.substancesbar_m.style.color = {r=1, g=0.996078431, b=0.047058824, a=1}
				leftGui.frame.flow3.flow33.flow332.add({type="label", name="label_substancesbar_m", caption="0", tooltip={'label.label-substancesbar_m-tooltip'}, style="fi-label-mini"})
				leftGui.frame.flow3.flow33.flow332.label_substancesbar_m.style.font_color = {r=1, g=0.996078431, b=0.047058824, a=1}
			end
		end
		if not leftGui.frame.flow3.flow33.flow333 then
			leftGui.frame.flow3.flow33.add{type = "flow", name = "flow333", tooltip={'label.label-substancesbar_c-tooltip'}, style="fi-substances-flow"}
			if not leftGui.frame.flow3.flow33.flow333.substancesbar_c then
				--leftGui.frame.flow3.flow33.flow333.add({type="label", name="label_substancesbar_c", caption={'label.label-substancesbar_c'},})
				leftGui.frame.flow3.flow33.flow333.add({type="progressbar", name="substancesbar_c", style="fi-substances-bar"})
				leftGui.frame.flow3.flow33.flow333.substancesbar_c.style.color = {r=1, g=0.552941176, b=0.937254902, a=1}
				leftGui.frame.flow3.flow33.flow333.add({type="label", name="label_substancesbar_c", caption="0", tooltip={'label.label-substancesbar_c-tooltip'}, style="fi-label-mini"})
				leftGui.frame.flow3.flow33.flow333.label_substancesbar_c.style.font_color = {r=1, g=0.552941176, b=0.937254902, a=1}
			end
		end
		if not leftGui.frame.flow3.flow33.flow334 then
			leftGui.frame.flow3.flow33.add{type = "flow", name = "flow334", tooltip={'label.label-substancesbar_f-tooltip'}, style="fi-substances-flow"}
			if not leftGui.frame.flow3.flow33.flow334.substancesbar_f then
				--leftGui.frame.flow3.flow33.flow334.add({type="label", name="label_substancesbar_f", caption={'label.label-substancesbar_f'},})
				leftGui.frame.flow3.flow33.flow334.add({type="progressbar", name="substancesbar_f", style="fi-substances-bar"})
				leftGui.frame.flow3.flow33.flow334.substancesbar_f.style.color = {r=0.301960784, g=0.882352941, b=0.984313725, a=1}
				leftGui.frame.flow3.flow33.flow334.add({type="label", name="label_substancesbar_f", caption="0", tooltip={'label.label-substancesbar_f-tooltip'}, style="fi-label-mini"})
				leftGui.frame.flow3.flow33.flow334.label_substancesbar_f.style.font_color = {r=0.301960784, g=0.882352941, b=0.984313725, a=1}
			end
		end

		if not leftGui.frame.flow3.flow34 then
			leftGui.frame.flow3.add{type="flow", name="flow34", direction="horizontal"}
			--leftGui.frame.flow3.flow34.style.left_padding=0
			leftGui.frame.flow3.flow34.style.maximal_width=80
			leftGui.frame.flow3.flow34.add({type="label", name="label_effects", caption={'label.label-effects', ": "},})
			leftGui.frame.flow3.flow34.add({type="label", name="label_effects_count", caption="0",})
		end
		-- TODO Add Effects icons function

		
		-- initialize labels and bars of .flow6
		if not leftGui.frame.flow6 then
			leftGui.frame.add{ type = "flow", name = "flow6", direction = "horizontal", width = 200, align = "right"}
		end
		-- TODO "eat-button-ongui" by Oceanel
		if player.force.technologies["fi-tech-eatout-button"] and player.force.technologies["fi-tech-eatout-button"].researched then
			if not leftGui.frame.flow6.eat_button then
				leftGui.frame.flow6.add{
				type = "button",
				name = "eat_button",
				caption = {'button.eatout'},
				tooltip = {'button.eatout-tooltip'},
				align = "right",
				vertical_align = "bottom",
				--horizontally_stretchable = true,
				--key_sequence = "SHIFT + E",
				height = 20,
				width = 25}
			end
			else
			leftGui.frame.flow6.destroy()
		end
	end

end


-- Update GUI gadgets: Energy, Drinks, Fullness
function figui.update(index, player)
	local leftGui = player.gui.left
	
	if leftGui == nil or leftGui.frame == nil then
		return
	end
	
	
	if leftGui.frame.flow1.energylabel then
		if pcall(function () leftGui.frame.flow1.usagelabel.caption = (math.floor((100 * settings.global["food-industry-hunger-speed"].value * global.usage[index] / global.update_delay[index]) * (1 + global.fi_energy_ussage_modifier[index]) + 0.5) * 0.01) end) then
			-- "Energy: " ... " (usage: "..."%)"
			leftGui.frame.flow1.energylabel.caption = math.floor(global.energy[index])
			leftGui.frame.flow1.usagelabel.caption = (math.floor((100 * settings.global["food-industry-hunger-speed"].value * global.usage[index] / global.update_delay[index]) * (1 + global.fi_energy_ussage_modifier[index]) + 0.5) * 0.01)
		else
			--  "Energy: " ... " (usage: ---%)"
			leftGui.frame.flow1.energylabel.caption = global.energy[index]
			leftGui.frame.flow1.usagelabel.caption = "---"
		end
		leftGui.frame.energybar.value = math.abs(global.energy[index]/global.energy_max[index])
		if global.energy[index] >= global.energy_max[index] * 0.91 then -- >=91%
			leftGui.frame.energybar.style.color = {g = 0.8, b=1, a = 1}
		elseif global.energy[index] >= global.energy_max[index] * 0.30 then -- >=30%
			leftGui.frame.energybar.style.color = {g = 1, a = 1}
		elseif global.energy[index] >= global.energy_max[index] * 0.20 then -- >=20%
			leftGui.frame.energybar.style.color = {r = 1, g = 1, a = 1}
		elseif global.energy[index] >= 0 then
			leftGui.frame.energybar.style.color = {r = 1, g = 0.6, a = 1}
		else 
			leftGui.frame.energybar.style.color = {r = 1, a = 1}
		end
	end

	
	if leftGui.frame.flow22.drinkslabel then
		leftGui.frame.flow22.drinkslabel.caption = math.floor(global.drinks[index])
		leftGui.frame.drinksbar.value = math.abs(global.drinks[index]/global.drinks_max[index])
		if global.drinks[index] >= global.drinks_max[index] * 0.91 then -- >=91%
			leftGui.frame.drinksbar.style.color = {r=0.227450980, g=0, b=0.745098039, a=1}
		elseif global.drinks[index] >= global.drinks_max[index] * 0.5 then -- >=50%
			leftGui.frame.drinksbar.style.color = {r=0.2, g=0.2, b=1, a=1}
		elseif global.drinks[index] >= global.drinks_max[index] * 0.4 then -- >=40%
			leftGui.frame.drinksbar.style.color = {r=0.2, g=0.2, b=1, a=0.9}
		elseif global.drinks[index] >= global.drinks_max[index] * 0.3 then -- >=30%
			leftGui.frame.drinksbar.style.color = {r=0.2, g=0.2, b=1, a=0.8}
		elseif global.drinks[index] >= global.drinks_max[index] * 0.2 then -- >=20%
			leftGui.frame.drinksbar.style.color = {r=0.2, g=0.2, b=1, a=0.7}
		elseif global.drinks[index] >= global.drinks_max[index] * 0.1 then -- >=10%
			leftGui.frame.drinksbar.style.color = {r=0.2, g=0.2, b=1, a=0.6}
		elseif global.drinks[index] >= 0 then
			leftGui.frame.drinksbar.style.color = {r=0.2, g=0.2, b=1, a=0.5}
		else 
			-- TODO add thirst viewing
			leftGui.frame.drinksbar.style.color = {r = 1, a = 1}
		end
	end


	if leftGui.frame.flow2.fullnesslabel then
		--player.print("[Debug] fullness: "..global.fullness[index])
		-- here Overeating
		local fullness_storage = global.fullness[index]
		if global.fullness[index] > 101 then
			--writeDebug("fullnesslabel "..global.fullness[index])
			leftGui.frame.flow2.label_fullness.caption = ({'label.label-overeating', ": "})
			leftGui.frame.flow2.fullnesslabel.caption = math.ceil(global.fullness[index] - 100)
			leftGui.frame.fullnessbar.value = (global.fullness[index] - 100)/100
			leftGui.frame.fullnessbar.style.color = {r = 1, a = 1}
		-- here normal Fullness
		elseif global.fullness[index] < 100 then
			--writeDebug("fullnesslabel "..global.fullness[index])
			leftGui.frame.flow2.label_fullness.caption = ({'label.label-fullness', ": "})
			leftGui.frame.flow2.fullnesslabel.caption = math.abs(math.ceil(global.fullness[index]))
			leftGui.frame.fullnessbar.value = global.fullness[index]/100
			leftGui.frame.fullnessbar.style.color = {r = 1, g = 0.6, a = 1}
		--else
		--	game.players[index].print("[Debug] Warning: Fullness "..fullness_storage.." - is not good!")
		--	return
		end
	end
	
end


-- Update GUI gadgets: balances of Substances
function figui.update_substances(index, player)
	local leftGui = player.gui.left
	
	if leftGui == nil then
		return
	end
	
	-- if substances > 0 then a=0.7
	-- if substances < 0 then make bar darker
	-- else (include substances = 0) then make font grayer
	if leftGui.frame.flow3.flow33.flow331.substancesbar_v then
		leftGui.frame.flow3.flow33.flow331.substancesbar_v.value = math.abs(global.substances[index]["v"]/100)
		leftGui.frame.flow3.flow33.flow331.label_substancesbar_v.caption = math.floor(global.substances[index]["v"])
		if global.substances[index]["v"] > 60 then
			leftGui.frame.flow3.flow33.flow331.substancesbar_v.style.color = {r=0.388235294, g=1, b=0.317647059, a=1}
		elseif global.substances[index]["v"] > 40 then
			leftGui.frame.flow3.flow33.flow331.substancesbar_v.style.color = {r=0.388235294, g=1, b=0.317647059, a=0.9}
		elseif global.substances[index]["v"] > 20 then
			leftGui.frame.flow3.flow33.flow331.substancesbar_v.style.color = {r=0.388235294, g=1, b=0.317647059, a=0.8}
		elseif global.substances[index]["v"] > 0 then
			leftGui.frame.flow3.flow33.flow331.substancesbar_v.style.color = {r=0.388235294, g=1, b=0.317647059, a=0.7}
			leftGui.frame.flow3.flow33.flow331.label_substancesbar_v.style.font_color = {r=0.388235294, g=1, b=0.317647059, a=1}
		elseif global.substances[index]["v"] < 0 then
			leftGui.frame.flow3.flow33.flow331.substancesbar_v.value = math.abs(global.substances[index]["v"]/100*10)
			leftGui.frame.flow3.flow33.flow331.substancesbar_v.style.color = {r=0.388235294, g=0.549019608, b=0.317647059, a=0.9} -- darker bar
			leftGui.frame.flow3.flow33.flow331.label_substancesbar_v.style.font_color = {r=1.0, g=0.17, b=0, a=1}
		else
			leftGui.frame.flow3.flow33.flow331.substancesbar_v.style.color = {r=0.388235294, g=1, b=0.317647059, a=1}
			leftGui.frame.flow3.flow33.flow331.label_substancesbar_v.style.font_color = {r=0.152941176, g=0.388235294, b=0.121568627, a=1} -- grey font
		end
	end

	if leftGui.frame.flow3.flow33.flow332.substancesbar_m then
		leftGui.frame.flow3.flow33.flow332.label_substancesbar_m.caption = math.floor(global.substances[index]["m"])
		leftGui.frame.flow3.flow33.flow332.substancesbar_m.value = math.abs(global.substances[index]["m"]/100)
		if global.substances[index]["m"] > 60 then
			leftGui.frame.flow3.flow33.flow332.substancesbar_m.style.color = {r=1, g=0.996078431, b=0.047058824, a=1}
		elseif global.substances[index]["m"] > 40 then
			leftGui.frame.flow3.flow33.flow332.substancesbar_m.style.color = {r=1, g=0.996078431, b=0.047058824, a=0.9}
		elseif global.substances[index]["m"] > 20 then
			leftGui.frame.flow3.flow33.flow332.substancesbar_m.style.color = {r=1, g=0.996078431, b=0.047058824, a=0.8}
		elseif global.substances[index]["m"] > 0 then
			leftGui.frame.flow3.flow33.flow332.substancesbar_m.style.color = {r=1, g=0.996078431, b=0.047058824, a=0.7}
			leftGui.frame.flow3.flow33.flow332.label_substancesbar_m.style.font_color = {r=1, g=0.996078431, b=0.047058824, a=1}
		elseif global.substances[index]["m"] < 0 then
			leftGui.frame.flow3.flow33.flow332.substancesbar_m.value = math.abs(global.substances[index]["m"]/100*10)
			leftGui.frame.flow3.flow33.flow332.substancesbar_m.style.color = {r=1, g=0.470588235, b=0.047058824, a=0.9} -- darker bar
			leftGui.frame.flow3.flow33.flow332.label_substancesbar_m.style.font_color = {r=1.0, g=0.17, b=0, a=1}
		else
			leftGui.frame.flow3.flow33.flow332.substancesbar_m.style.color = {r=1, g=0.996078431, b=0.047058824, a=1}
			leftGui.frame.flow3.flow33.flow332.label_substancesbar_m.style.font_color = {r=0.447058824, g=0.439215686, b=0.019607843, a=1} -- grey font
		end
	end

	if leftGui.frame.flow3.flow33.flow333.substancesbar_c then
		leftGui.frame.flow3.flow33.flow333.label_substancesbar_c.caption = math.floor(global.substances[index]["c"])
		leftGui.frame.flow3.flow33.flow333.substancesbar_c.value = math.abs(global.substances[index]["c"]/100)
		if global.substances[index]["c"] > 60 then
			leftGui.frame.flow3.flow33.flow333.substancesbar_c.style.color = {r=1, g=0.552941176, b=0.937254902, a=1}
		elseif global.substances[index]["c"] > 40 then
			leftGui.frame.flow3.flow33.flow333.substancesbar_c.style.color = {r=1, g=0.552941176, b=0.937254902, a=0.9}
		elseif global.substances[index]["c"] > 20 then
			leftGui.frame.flow3.flow33.flow333.substancesbar_c.style.color = {r=1, g=0.552941176, b=0.937254902, a=0.8}
		elseif global.substances[index]["c"] > 0 then
			leftGui.frame.flow3.flow33.flow333.substancesbar_c.style.color = {r=1, g=0.552941176, b=0.937254902, a=0.7}
			leftGui.frame.flow3.flow33.flow333.label_substancesbar_c.style.font_color = {r=1, g=0.552941176, b=0.937254902, a=1}
		elseif global.substances[index]["c"] < 0 then
			leftGui.frame.flow3.flow33.flow333.substancesbar_c.value = math.abs(global.substances[index]["c"]/100*10)
			leftGui.frame.flow3.flow33.flow333.substancesbar_c.style.color = {r=0.760784314, g=0.607843137, b=0.937254902, a=0.9} -- darker bar
			leftGui.frame.flow3.flow33.flow333.label_substancesbar_c.style.font_color = {r=1.0, g=0.17, b=0, a=1}
		else
			leftGui.frame.flow3.flow33.flow333.substancesbar_c.style.color = {r=1, g=0.552941176, b=0.937254902, a=1}
			leftGui.frame.flow3.flow33.flow333.label_substancesbar_c.style.font_color = {r=0.509803922, g=0.290196078, b=0.478431373, a=1} -- grey font
		end
	end
	
	if leftGui.frame.flow3.flow33.flow334.substancesbar_f then
		leftGui.frame.flow3.flow33.flow334.label_substancesbar_f.caption = math.floor(global.substances[index]["f"])
		leftGui.frame.flow3.flow33.flow334.substancesbar_f.value = math.abs(global.substances[index]["f"]/100)
		if global.substances[index]["f"] > 60 then
			leftGui.frame.flow3.flow33.flow334.substancesbar_f.style.color = {r=0.301960784, g=0.882352941, b=0.984313725, a=1}
		elseif global.substances[index]["f"] > 40 then
			leftGui.frame.flow3.flow33.flow334.substancesbar_f.style.color = {r=0.301960784, g=0.882352941, b=0.984313725, a=0.9}
		elseif global.substances[index]["f"] > 20 then
			leftGui.frame.flow3.flow33.flow334.substancesbar_f.style.color = {r=0.301960784, g=0.882352941, b=0.984313725, a=0.8}
		elseif global.substances[index]["f"] > 0 then
			leftGui.frame.flow3.flow33.flow334.substancesbar_f.style.color = {r=0.301960784, g=0.882352941, b=0.984313725, a=0.7}
			leftGui.frame.flow3.flow33.flow334.label_substancesbar_f.style.font_color = {r=0.301960784, g=0.882352941, b=0.984313725, a=1}
		elseif global.substances[index]["f"] < 0 then
			leftGui.frame.flow3.flow33.flow334.substancesbar_f.value = math.abs(global.substances[index]["f"]/100*10)
			leftGui.frame.flow3.flow33.flow334.substancesbar_f.style.color = {r=0.301960784, g=0.443137255, b=0.984313725, a=0.9} -- darker bar
			leftGui.frame.flow3.flow33.flow334.label_substancesbar_f.style.font_color = {r=1.0, g=0.17, b=0, a=1}
		else
			leftGui.frame.flow3.flow33.flow334.substancesbar_f.style.color = {r=0.301960784, g=0.882352941, b=0.984313725, a=1}
			leftGui.frame.flow3.flow33.flow334.label_substancesbar_f.style.font_color = {r=0.137254902, g=0.4, b=0.439215686, a=1} -- grey font
		end
	end
	

end



-- Update GUI gadgets: Effects
function figui.update_effects(index, player)
	local leftGui = player.gui.left
	
	local active_effects_count = 0
	for i,effect in pairs(global.effects[index]) do
		if not effect[5] == nil then
			active_effects_count = active_effects_count + table.maxn(effect[5])
		end
	end
	--leftGui.frame.flow3.flow34.label_effects_count.caption = active_effects_count

	-- TODO Update GUI Effects
	for i,effect in pairs(global.effects[index]) do
		-- if effect is active
		--	if effect[1] then

	end

end


function figui.debug_create(index, player)
	local centerGui = player.gui.top
	
	if centerGui.bar then
		centerGui.bar.destroy()
	end


	-- initialize main .frame
	if not centerGui.frame then
		centerGui.add{type = "frame", name = "frame", direction = "vertical"}
	end

	
	if not centerGui.frame.flow1 then
		centerGui.frame.add{type = "flow", name = "flow1", right_padding = 0, center_padding = 0, direction = "horizontal"}
	end
	if not centerGui.frame.flow1.label1c then
		centerGui.frame.flow1.add({type="label", name="label1", caption="speed 1:", style = "fi-label", align="right",})
		centerGui.frame.flow1.add({type="label", name="label1c", caption="", style = "fi-label", align="right",})

		centerGui.frame.flow1.add({type="label", name="label2", caption="/ speed character:", style = "fi-label", align="right",})
		centerGui.frame.flow1.add({type="label", name="label2c", caption="", style = "fi-label", align="right",})
	end

	-- crafting speed
	if not centerGui.frame.flow2 then
		centerGui.frame.add{type = "flow", name = "flow2", right_padding = 0, center_padding = 0, direction = "horizontal"}
	end
	if not centerGui.frame.flow2.label1c then
		centerGui.frame.flow2.add({type="label", name="label1", caption="crafting 1:", style = "fi-label", align="right",})
		centerGui.frame.flow2.add({type="label", name="label1c", caption="", style = "fi-label", align="right",})
	end

	-- mining speed
	if not centerGui.frame.flow3 then
		centerGui.frame.add{type = "flow", name = "flow3", right_padding = 0, center_padding = 0, direction = "horizontal"}
	end
	if not centerGui.frame.flow3.label1c then
		centerGui.frame.flow3.add({type="label", name="label1", caption="mining 1:", style = "fi-label", align="right",})
		centerGui.frame.flow3.add({type="label", name="label1c", caption="", style = "fi-label", align="right",})
	end

	-- long reach
	if not centerGui.frame.flow4 then
		centerGui.frame.add{type = "flow", name = "flow4", right_padding = 0, center_padding = 0, direction = "horizontal"}
	end
	if not centerGui.frame.flow4.label1c then
		centerGui.frame.flow4.add({type="label", name="label1", caption="build_distance 1: ", style = "fi-label", align="right",})
		centerGui.frame.flow4.add({type="label", name="label1c", caption="", style = "fi-label", align="right",})
		centerGui.frame.flow4.add({type="label", name="label2", caption="item_drop_distance 1:", style = "fi-label", align="right",})
		centerGui.frame.flow4.add({type="label", name="label2c", caption="", style = "fi-label", align="right",})
		centerGui.frame.flow4.add({type="label", name="label3", caption="reach_distance 1:", style = "fi-label", align="right",})
		centerGui.frame.flow4.add({type="label", name="label3c", caption="", style = "fi-label", align="right",})
	end

end
function figui.debug_update(index, player)
	local centerGui = player.gui.top

    if player == nil then
        return
    end

	centerGui.frame.flow1.label1c.caption = player.character_running_speed_modifier
	centerGui.frame.flow1.label2c.caption = player.force.character_running_speed_modifier
	
	centerGui.frame.flow2.label1c.caption = player.character_crafting_speed_modifier

	centerGui.frame.flow3.label1c.caption = player.character_mining_speed_modifier
	
	centerGui.frame.flow4.label1c.caption = player.character_build_distance_bonus
	centerGui.frame.flow4.label2c.caption = player.character_item_drop_distance_bonus
	centerGui.frame.flow4.label3c.caption = player.character_reach_distance_bonus
end
