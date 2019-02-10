if not util then require("prototypes.scripts.util") end

local grabbingDistance = 5
local catchDistance = 2

local local_try_pickup_cattle_at_position = function(inserter,entity)

	if #inserter.held_stack == 0 and distance(inserter.position.x,inserter.position.y,entity.position.x,entity.position.y) <= grabbingDistance then
		inserter.pickup_position = {
			x = entity.position.x,
			y = entity.position.y
		}
		inserter.direction = inserter.direction
		if distance(inserter.held_stack_position.x,inserter.held_stack_position.y,entity.position.x,entity.position.y) <= catchDistance then
			entity.destroy()
			inserter.held_stack.set_stack({name="cattle", count=1})
		end
	end
end

local local_cattle_grabber_process = function(entity)
	local cattle = get_entities_around(entity, grabbingDistance)
	local cattle_count = 0
	local target
	local current_dist = 0
	local target_dist = 100
	if cattle ~= nil then
		for i, ent in pairs(cattle) do
			if ent.prototype.name == "cattle" then
				cattle_count = cattle_count + 1
				local dist = distance(entity.held_stack_position.x,entity.held_stack_position.y,ent.position.x,ent.position.y)
				if dist > current_dist then
					current_dist = dist
				end
				if dist < target_dist then
					target_dist = dist
					target = ent
				end
			end
		end
	end
	if target ~= nil then	
		local_try_pickup_cattle_at_position(entity,target)
	end
end

local local_cattle_grabber_tick = function()
	if game.tick % 30 == 0 then
		for index, cattle_grabber in ipairs(global.foodi.cattle_grabbers) do
			if cattle_grabber.valid then
				if not cattle_grabber.to_be_deconstructed(cattle_grabber.force) then
				    local_cattle_grabber_process(cattle_grabber)
				end
			end
		end
	end
end

local local_cattle_grabber_added = function(ent)
	if ent.name == "cattle-grabber" then
		ent.operable = false
		ent.set_filter(1,"cattle")
		table.insert(global.foodi.cattle_grabbers, ent)
	end
end

local local_cattle_grabber_removed = function(entity)
	if entity.name == "cattle-grabber" then
		for index, cattle_grabber in ipairs(global.foodi.cattle_grabbers) do
			if cattle_grabber.valid and cattle_grabber == entity then
				table.remove(global.foodi.cattle_grabbers, index)
				return
			end
		end
	end
end

local isInitCattleGrabber = false
function initCattleGrabber()
	if isInitCattleGrabber then
		return false
	end
	isInitCattleGrabber = true
	if foodi.ticks ~= nil then
		table.insert(foodi.ticks,local_cattle_grabber_tick)
		table.insert(foodi.on_added,local_cattle_grabber_added)
		table.insert(foodi.on_remove,local_cattle_grabber_removed)
	end

	if global ~= nil then
		if not global.foodi then global.foodi = {} end
		if not global.foodi.cattle_grabbers then global.foodi.cattle_grabbers = {} end
	end

end