if data.raw.recipe["fruit-scissor"] then
  data.raw.recipe["fruit-scissor"].ingredients = {
        {"bronze-plate", 2},
        {"bronze-rivet", 2},
    }
end

if data.raw.recipe["burner-fishing-inserter"] then
  data.raw.recipe["burner-fishing-inserter"].ingredients = {
        {"bronze-gear-wheel", 1},
        {"burner-inserter", 1},
    }
end
if data.raw.recipe["burner-food-picker"] then
  data.raw.recipe["burner-food-picker"].ingredients = {
        {"bronze-gear-wheel", 1},
        {"burner-inserter", 1},
    }
end

if data.raw.recipe["fi-basic-farmland"] then
  data.raw.recipe["fi-basic-farmland"].ingredients = {
        {"tin-plate", 6},
        {"wood", 32},
    }
end

if data.raw.recipe["burner-cooker"] then
  data.raw.recipe["burner-cooker"].ingredients = {
		{"stone-brick", 4},
		{"stone-furnace", 1},
		{"copper-plate", 5}
    }
end

if data.raw.recipe["electric-cooker"] then
  data.raw.recipe["electric-cooker"].ingredients = {
		{"burner-cooker", 1},
		{"electronic-circuit", 4},
		{"copper-cable", 10},
		{"iron-plate", 2},
	}
end

if data.raw.technology["fertilization"] then
  data.raw.technology["fertilization"].prerequisites = {"electric-heating", "advanced-farming"}
end

if data.raw.technology["electric-heating"] then
  data.raw.technology["electric-heating"].prerequisites = {"electronics", "cooking"}
end

if data.raw.recipe["flask"] then
  data.raw.recipe["flask"].ingredients = {
		{"tin-plate", 3}
	}
end
if data.raw.recipe["flask-recycle"] then
  data.raw.recipe["flask-recycle"].ingredients = {
		{"flask", 1}
  }
  data.raw.recipe["flask-recycle"].results = {
		{"tin-ingot", 1}
	}
end

