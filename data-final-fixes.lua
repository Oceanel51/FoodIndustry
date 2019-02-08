local addApple = true
for i, t in pairs(data.raw.tree) do
	if t.name == "lettuce-plant" then
		t.minable.result = "lettuce"
	elseif string.find(t.name, "-plant") then
		t.minable.result = t.name
    end
    if t.minable.result == "raw-wood" then
		if addApple then
			t.minable.results=
			{
				{type = "item", name = "raw-wood", amount = 4},
				{type = "item", name = "apple", amount = 1, probability = 0.25}
			}
			t.minable.result = nil
			addApple = false
		else
			t.minable.results=
			{
				{type = "item", name = "raw-wood", amount = 4},
				{type = "item", name = "orange", amount = 1, probability = 0.12}
			}
			t.minable.result = nil
			addApple = true
		end
    end
end

data.raw["assembling-machine"].centrifuge.ingredient_count = 74
