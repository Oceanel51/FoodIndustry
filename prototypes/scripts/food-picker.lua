if not util then require("prototypes.scripts.util") end

-- todo: change direction while picking
-- todo: don't add apples and oranges to dead or dry trees

local treeDistance = 5
local catchDistance = 2
local getFruitEveryXTicks = 60 * 5

local local_food_picker_process = function(picker)
    local trees = get_entities_around(picker, treeDistance)
    local trees_count = #trees
    if trees_count == 0 then
        return
    end
    local index = math.random(1, trees_count)

    local tree = trees[index]

    if tree == nil then
        return
    end

    if not picker.held_stack.can_set_stack({name="apple", count=1}) then
        return
    end

    picker.pickup_position = {
        x = tree.position.x,
        y = tree.position.y
    }
    picker.direction = picker.direction

    if tree.prototype.mineable_properties.products == nil then
        return
    end

    for _, r in ipairs(tree.prototype.mineable_properties.products) do
        if r.name == "apple" then
            picker.held_stack.set_stack({name="apple", count=1})
        elseif r.name == "orange" then
            picker.held_stack.set_stack({name="orange", count=1})
        end
    end
end

local local_food_picker_tick = function()
    if game.tick % getFruitEveryXTicks == 0 then
        for index, food_picker in ipairs(global.foodi.food_pickers) do
            if food_picker.valid then
                if not food_picker.to_be_deconstructed(food_picker.force) then
                    local_food_picker_process(food_picker)
                end
            end
        end
    end
end

local local_food_picker_added = function(ent)
    if ent.name == "food-picker" or ent.name == "burner-food-picker" then
        ent.operable = false
        ent.set_filter(1,"apple")
        ent.set_filter(2,"orange")
        table.insert(global.foodi.food_pickers, ent)
    end
end

local local_food_picker_removed = function(entity)
    if entity.name == "food-picker" or entity.name == "burner-food-picker" then
        for index, food_picker in ipairs(global.foodi.food_pickers) do
            if food_picker.valid and food_picker == entity then
                table.remove(global.foodi.food_pickers, index)
                return
            end
        end
    end
end

function initFoodPicker()
    if global ~= nil then
        if not global.foodi then global.foodi = {} end
        if not global.foodi.food_pickers then global.foodi.food_pickers = {} end
    end

    if foodi.ticks ~= nil then
        table.insert(foodi.ticks,local_food_picker_tick)
        table.insert(foodi.on_added,local_food_picker_added)
        table.insert(foodi.on_remove,local_food_picker_removed)
    end
end