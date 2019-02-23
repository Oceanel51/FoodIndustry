--may need to increase refresh
if not util then require("prototypes.scripts.util") end

local feedTick = 60 -- * 10
local feedCalf = 10

local function getCalf(entity)
    for i,e in pairs(global.foodi.cattle) do
        if e.entity == entity then
            return i, e
        end
    end
    return nil
end

local local_cattle_feeder_process = function(feeder)

    local p = feeder.entity.position
    local range = 4
    local calfs = feeder.entity.surface.find_entities_filtered{ area={left_top = {p.x - range, p.y - range}, right_bottom = {p.x + range, p.y + range}}, name = "cattle-calf" }
    local inventory = feeder.entity.get_output_inventory()

    for i, ent in pairs(calfs) do
        if ent.valid then
            if inventory.get_item_count("straw") > 0 then
                local indexcalf, calf = getCalf(ent)
                if calf == nil then
                    calf = { entity = ent, count = feedCalf }
                    table.insert(global.foodi.cattle, calf)
                end
                calf.count = calf.count - 1
                inventory.remove({name="straw", count=1})
                player_print("feed "..#calfs.." straw "..inventory.get_item_count("straw").." count "..calf.count)
                if calf.count <= 0 then
                    table.remove(global.foodi.cattle, i)
                    local calfPosition = calf.entity.position
                    calf.entity.destroy()
                    feeder.entity.surface.create_entity({ name="cattle", position=calfPosition, force=feeder.entity.force })
                end
            else
                break
            end
        end
    end
--    if #biters > 0 and local_process_feeder_inventory(feeder,#biters) then
--        if biters ~= nil then
--
----            for i, ent in pairs(biters) do
----                local angry = false
----                for index, cattle in ipairs(global.foodi.cattle) do
----                    if cattle.entity.valid then
----                        if not cattle.entity.to_be_deconstructed(cattle.entity.force) then
----                            if ent == cattle.entity then
----                                angry = true
----                            end
----                        end
----                    end
----                end
----                if angry == false then
----                    ent.set_command({type = defines.command.wander ,radius = 8});
----                end
----            end
--        end
--    end
end

local local_cattle_feeder_tick = function()
    if game.tick % feedTick == 0 then
        for index, cattle_feeder in ipairs(global.foodi.cattle_feeders) do
            if cattle_feeder.entity.valid then
                if not cattle_feeder.entity.to_be_deconstructed(cattle_feeder.entity.force) then
                    local_cattle_feeder_process(cattle_feeder)
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
        table.insert(foodi.ticks, local_cattle_feeder_tick)
        table.insert(foodi.on_added, local_cattle_feeder_added)
        table.insert(foodi.on_remove, local_cattle_feeder_removed)
    end
end