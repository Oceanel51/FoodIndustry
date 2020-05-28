local TICKS_TO_GROW_MIN = 30 * 60
local TICKS_TO_GROW_MAX = 2 * 60 * 60


local ORANGE_SEEDLING = "orange-seedling"
local APPLE_SEEDLING = "apple-seedling"
local WHEAT_SEEDLING = "wheat-seed"

local ORANGE_TREE = "orange-tree"
local APPLE_TREE = "apple-tree"
local WHEAT_TREE = "wheat-wild-plant"

local isFruitSeedlings = {
    [ORANGE_SEEDLING] = { result = ORANGE_TREE },
    [APPLE_SEEDLING] = { result = APPLE_TREE },
    [WHEAT_SEEDLING] = { result = WHEAT_TREE },
}

local function local_fruittree_tick(event)
    if #global.foodi.fruitSeedlings > 0 then
        for index, fruitSeedling in ipairs(global.foodi.fruitSeedlings) do
            if fruitSeedling ~= nil
               and fruitSeedling.fullgrowntick < event.tick then

                table.remove(global.foodi.fruitSeedlings, index)

                local surface = fruitSeedling.seedling.surface
                local position = fruitSeedling.seedling.position
                local isFruitSeedling = isFruitSeedlings[fruitSeedling.seedling.name]

                --writeDebug("foodi.fruitSeedlings "..fruitSeedling.seedling.name.." grown up!") -- DEBUG
                fruitSeedling.seedling.destroy()
                surface.create_entity{name = isFruitSeedling.result, position = position}
            end
        end
    end
end

local function addSeedling(seedling, event)
    --writeDebug("foodi.add "..seedling.name.."") -- DEBUG
    if seedling.valid and isFruitSeedlings[seedling.name] ~= nil then
        table.insert(global.foodi.fruitSeedlings,
        {
            seedling = seedling,
            fullgrowntick = event.tick + math.random(TICKS_TO_GROW_MIN, TICKS_TO_GROW_MAX)
        })
        --writeDebug("foodi.fruitSeedlings "..seedling.name.." [color=0,1,0]added[/color]") -- DEBUG
        return true
    end
    return false
end

local local_fruittree_added = function(entity, event)
    if addSeedling(entity, event) then
        return
    end
end

local local_fruittree_removed = function(entity)
    if entity.valid and isFruitSeedlings[entity.name] ~= nil then
        for index, fruitseedling in ipairs(global.foodi.fruitSeedlings) do
            if fruitseedling.seedling == entity then
                table.remove(global.foodi.fruitSeedlings, index)
                --writeDebug("foodi.fruitSeedlings "..entity.name.." [color=1,0,0]removed[/color]") -- DEBUG
                return
            end
        end
    end
end

local isInitFruitTrees = false
function initFruitTrees()
    if isInitFruitTrees then
        return
    end
    isInitFruitTrees = true
    if global ~= nil then
        if not global.foodi then global.foodi = {} end
        if not global.foodi.fruittrees then global.foodi.fruittrees = {} end
        if not global.foodi.fruitSeedlings then global.foodi.fruitSeedlings = {} end
    end

    table.insert(foodi.ticks,local_fruittree_tick)
    table.insert(foodi.on_added,local_fruittree_added)
    table.insert(foodi.on_remove,local_fruittree_removed)
end
