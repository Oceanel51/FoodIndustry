--may need to increase refresh
if not util then require("prototypes.scripts.util") end

local local_cattle_feeder_notify_damaged = function(ent)
    if ent.name == "cattle-calf" or ent.name == "cattle"
    then
        for index, cattle in ipairs(global.foodi.cattle) do
            if cattle.entity.valid then
                if not cattle.entity.to_be_deconstructed(cattle.entity.force) then
                    if ent == cattle.entity then
                        --reset
                        cattle.countdown = 15
                        return
                    end
                end
            else
                table.remove(global.foodi.cattle, index)
                return
            end
        end
        local entity = {entity = ent, countdown = 15}
        table.insert(global.foodi.cattle, entity)
    end
end

local local_process_feeder_inventory = function(feeder,biters)
    local inventory = feeder.entity.get_output_inventory()
    local contents = inventory.get_contents()
    local ret = false
    for n, c in pairs(contents) do
        if ret == false and n == "straw" then
            feeder.countdown = feeder.countdown - math.min(biters,100)
            if feeder.countdown <= 0 then
                feeder.countdown = 100
                inventory.remove({name=n, count=1})
            end
            ret = true
        else
            inventory.remove({name=n, count=c})
            feeder.entity.surface.spill_item_stack(feeder.entity.position, {name=n, count=c})
        end
    end
    return ret
end

local has_biters = false
local local_cattle_feeder_process = function(feeder)
    has_biters = false
    --gets called 2 times a second
--    for index, cattle in ipairs(global.foodi.cattle) do
--        if cattle.entity.valid then
--            if not cattle.entity.to_be_deconstructed(cattle.entity.force) then
--                cattle.countdown = cattle.countdown - 1
--                if cattle.countdown <= 0 then
--                    table.remove(global.foodi.cattle, index)
--                end
--            end
--        end
--    end

    local entities = get_entities_around(feeder.entity, 10)
    local biters = {}
    for i, ent in pairs(entities) do
        if ent.name == "cattle" or ent.name == "cattle-calf"
        then
            table.insert(biters,ent)
        end
    end
    if #biters > 0 and local_process_feeder_inventory(feeder,#biters) then
        if biters ~= nil then
            has_biters = true
--            for i, ent in pairs(biters) do
--                local angry = false
--                for index, cattle in ipairs(global.foodi.cattle) do
--                    if cattle.entity.valid then
--                        if not cattle.entity.to_be_deconstructed(cattle.entity.force) then
--                            if ent == cattle.entity then
--                                angry = true
--                            end
--                        end
--                    end
--                end
--                if angry == false then
--                    ent.set_command({type = defines.command.wander ,radius = 8});
--                end
--            end
        end
    end
end

local local_cattle_feeder_tick = function()
    local tick = 20
    if has_biters == true then tick = 1 end
    if game.tick % 10 == 0 then
        for index, cattle_feeder in ipairs(global.foodi.cattle_feeders) do
            if cattle_feeder.entity.valid then
                if not cattle_feeder.entity.to_be_deconstructed(cattle_feeder.entity.force) then
                    -- local_cattle_feeder_process(cattle_feeder)
                end
            end
        end
    end
end

local local_cattle_feeder_added = function(ent)
    if ent.name == "cattle-feeder" then
        local entity = {entity = ent, countdown = 100}
        table.insert(global.foodi.cattle_feeders, entity)
    end
end

local local_cattle_feeder_removed = function(entity)
    if entity.name == "cattle-feeder" then
        for index, cattle_feeder in ipairs(global.foodi.cattle_feeders) do
            if cattle_feeder.entity.valid and cattle_feeder.entity == entity then
                table.remove(global.foodi.cattle_feeders, index)
                return
            end
        end
    end
end


local isInitCattle = false
function initCattle()
    if isInitCattle then
        return
    end
    isInitCattle = true

    if global ~= nil then
        if not global.foodi then global.foodi = {} end
        if not global.foodi.cattle_feeders then global.foodi.cattle_feeders = {} end
        if not global.foodi.cattle then global.foodi.cattle = {} end
    end

    if foodi.ticks ~= nil then
--        if script ~= nil then
--            script.on_event(defines.events.on_entity_damaged,function (event)
--                local entity = event.entity
--                if entity ~= nil then
--                    local_cattle_feeder_notify_damaged(entity)
--                end
--            end)
--        end
        table.insert(foodi.ticks, local_cattle_feeder_tick)
        table.insert(foodi.on_added, local_cattle_feeder_added)
        table.insert(foodi.on_remove, local_cattle_feeder_removed)
    end
end