for i, t in pairs(data.raw.tree) do
	if t.name == "lettuce-plant" then
		t.minable.result = "lettuce"
	elseif string.find(t.name, "-plant") then
		t.minable.result = t.name
	end
end

data.raw["assembling-machine"].centrifuge.ingredient_count = 74


-- for Bob's chemical-plant 1, 2, 3, 4 compabillity
-- TODO Bob's chemical-plants - проверить и записать в лог
for i=1,4 do
	if data.raw["assembling-machine"]["chemical-plant-"..i] then
		table.insert(data.raw["assembling-machine"]["chemical-plant-"..i].crafting_categories, "mixing")
		log("Compabillities for Bob's chemical-plant-"..i)
	end
end
