for i, t in pairs(data.raw.tree) do
	if t.name == "lettuce-plant" then
		t.minable.result = "lettuce"
	elseif string.find(t.name, "-plant") then
		t.minable.result = t.name
	end
end

data.raw["assembling-machine"].centrifuge.ingredient_count = 74

--table.insert(p.inputs, "food-science-pack")
