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

local times = {
    --name,        time_min,   time_max
    ["apple"] =  { 1.6*60*60,  2.0*60*60 },
    ["orange"] = { 1.8*60*60,  2.2*60*60 },
    ["wheat"] =  { 1.0*30*60,  1.0*60*60 },
}



local function addSeedling(seedling, event, time)
    --writeDebug("foodi.add "..seedling.name.."") -- DEBUG
    --if seedling.valid and isFruitSeedlings[seedling.name] ~= nil then
    local time_min = 1.6 * 60 * 10
    local time_max = 2.0 * 60 * 10
    if time ~= nil then
        time_min = time[1]
        time_max = time[2]
    end
    if seedling.valid then
        table.insert(global.foodi.fruitSeedlings,
        {
            seedling = seedling,
            fullgrowntick = event.tick + math.random(time_min, time_max)
        })
        --writeDebug("foodi.fruitSeedlings "..seedling.name.." [color=0,1,0]added[/color]") -- DEBUG
        return true
    end
    return false
end

local function local_fruittree_tick(event)
    if #global.foodi.fruitSeedlings > 0 then
        for index, fruitSeedling in ipairs(global.foodi.fruitSeedlings) do
            if fruitSeedling ~= nil
               and fruitSeedling.fullgrowntick < event.tick then

                local surface = fruitSeedling.seedling.surface
                local position = fruitSeedling.seedling.position
                local time = {}
                --local isFruitSeedling = isFruitSeedlings[fruitSeedling.seedling.name]
                local treetype = string.match(fruitSeedling.seedling.name, "(.*)-")
                if string.match(fruitSeedling.seedling.name, ".+seed") == fruitSeedling.seedling.name then
                    table.remove(global.foodi.fruitSeedlings, index)
                    fruitSeedling.seedling.destroy()
                    local fruitSeedlingNew = surface.create_entity{name = treetype.."-seedling", position = position}
                    addSeedling(fruitSeedlingNew, event, times.treetype)
                elseif string.match(fruitSeedling.seedling.name, ".+seedling") == fruitSeedling.seedling.name then
                    table.remove(global.foodi.fruitSeedlings, index)
                    fruitSeedling.seedling.destroy()
                    local fruitSeedlingNew = surface.create_entity{name = treetype.."-sapling", position = position}
                    addSeedling(fruitSeedlingNew, event, times.treetype)
                elseif string.match(fruitSeedling.seedling.name, ".+sapling") == fruitSeedling.seedling.name then
                    table.remove(global.foodi.fruitSeedlings, index)
                    fruitSeedling.seedling.destroy()
                    local fruitSeedlingNew = surface.create_entity{name = treetype.."-young", position = position}
                    addSeedling(fruitSeedlingNew, event, times.treetype)
                elseif string.match(fruitSeedling.seedling.name, ".+young") == fruitSeedling.seedling.name then
                    table.remove(global.foodi.fruitSeedlings, index)
                    fruitSeedling.seedling.destroy()
                    local fruitSeedlingNew = surface.create_entity{name = treetype.."-tree", position = position}
                end

                --writeDebug("foodi.fruitSeedlings "..fruitSeedling.seedling.name.." grown up!") -- DEBUG
            end
        end
    end
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
