local TICKS_TO_GROW_MIN = 30 * 60
local TICKS_TO_GROW_MAX = 2 * 60 * 60

local ORANGE_SEEDLING = "orange-seedling"
local APPLE_SEEDLING = "apple-seedling"

local ORANGE_TREE = "orange-tree"
local APPLE_TREE = "apple-tree"

local isFruitSeedlings = {
    [ORANGE_SEEDLING] = { result = ORANGE_TREE },
    [APPLE_SEEDLING] = { result = APPLE_TREE },
}

-- TODO implement this table
local fruittreestable = {
	--1							2					3				4				5			6			7							8				9																																				
	--seedling,					tree,				growtime_min,	grow_time_max,	time,		amount,		grow_factor,				ingredients		result																																			
	{"apple-seedling",			"apple-tree",		1800,			7200,			1,			1,			{ region="eu", 1.0 },		{},				{{type = "item", name = "apple", amount = 7, probability = 0.8},{type = "item", name = "raw-straw", amount_min = 8, amount_max = 17}}			},
	{"orange-seedling",			"orange-tree",		2000,			11520,			1,			1,			{ region="af", 1.2 },		{},				{{type = "item", name = "orange", amount = 13, probability = 0.87},{type = "item", name = "raw-straw", amount_min = 7, amount_max = 24}}		},
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

                fruitSeedling.seedling.destroy()
                surface.create_entity{name = isFruitSeedling.result, position = position}
            end
        end
    end
end

local function addSeedling(seedling, event)
    if seedling.valid and isFruitSeedlings[seedling.name] ~= nil then
        local fullgrowntick = event.tick + math.random(TICKS_TO_GROW_MIN, TICKS_TO_GROW_MAX)
        table.insert(global.foodi.fruitSeedlings,
        {
            seedling = seedling,
            fullgrowntick = fullgrowntick,
            state = "seedling"
            -- TODO add other states "sapling", "young-tree", "young-fertile-tree", "young-blooming-tree", "blooming-tree", "fertile-tree", "sick-tree", "old-tree".
        })
        -- TODO add counter of landed seedlings fos statistic and achivements
        if global.fi_achievements[index]["trees-gardener"] then
            -- init empty value of trees-gardener
            global.fi_achievements[index]["trees-gardener"][1] = true
            global.fi_achievements[index]["trees-gardener"][2] = global.fi_achievements[index]["trees-gardener"][2] + 1
            --writeDebug("fullgrowntick: "..fullgrowntick)
            --writeDebug(dump(global.fi_achievements[index]["trees-gardener"]))
        else
            writeDebug("[A bug]: global.fi_achievements[trees-gardener] does not exist! Contact the developer.")
        end
        -- debug
        --log("FI_1.8.107_mod: addSeedling "..seedling)
        --log(tostring(global.foodi.fruitSeedlings))
        if game then
            --game.print("fruitSeedlings [table]: ")
            --game.print(tostring(global.foodi.fruitSeedlings))  -- not working
            --writeDebug(dump(global.foodi.fruitSeedlings))
        end

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
        if not global.foodi.fruitSeedlings then global.foodi.fruitSeedlings = {} end   -- tree seedlings
    end

    table.insert(foodi.ticks,local_fruittree_tick)
    table.insert(foodi.on_added,local_fruittree_added)
    table.insert(foodi.on_remove,local_fruittree_removed)
end
