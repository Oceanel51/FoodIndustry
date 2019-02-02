for i, t in pairs(data.raw.tree) do
	if t.name == "lettuce-plant" then
		t.minable.result = "lettuce"
	elseif string.find(t.name, "-plant") then
		t.minable.result = t.name
    end
    if t.minable.result == "raw-wood" then
		t.minable.results=
		{
			{type = "item", name = "raw-wood", amount = 4},
			{type = "item", name = "apple", amount = 5}
		}
		t.minable.result = nil
    end
end

data.raw["assembling-machine"].centrifuge.ingredient_count = 74
