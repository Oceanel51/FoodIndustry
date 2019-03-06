
local FLASK = "flask"
local PLASTIC_BOTTLE = "plastic-bottle"
local GLASS_BOTTLE = "glass-bottle"


local PURE_WATER = "pure-water"


local isDrink = {
    [FLASK] = { result = "hand-flask-pure-water" },
    [PLASTIC_BOTTLE] = { result = "plastic-bottle-pure-water" },
    [GLASS_BOTTLE] = { result = "glass-bottle-pure-water" },
}

local function getDrink_on_Click(event)

    local player = game.players[event.player_index]
    if player.selected == nil then
        return
    end

    if not player.cursor_stack.valid_for_read then
        return
    end

    local getDrink = isDrink[player.cursor_stack.name]

    if getDrink ~= nil then
       if player.selected.name == PURE_WATER then
            -- take away some amount resource of pure-water
            if player.cursor_stack.name == "flask" and player.selected.amount - 30 > 0 then
                player.selected.amount = player.selected.amount - 30
            elseif player.cursor_stack.name == "plastic-bottle" and player.selected.amount - 60 > 0 then
                player.selected.amount = player.selected.amount - 60
            elseif player.cursor_stack.name == "glass-bottle" and player.selected.amount - 50 > 0 then
                player.selected.amount = player.selected.amount - 50
            else
                player.print({'print.not-enough-pure-water', "__ITEM__"..player.cursor_stack.name.."__"})
                return
            end
            player.begin_crafting{ count = 1, recipe = getDrink.result }

            local inv = player.get_main_inventory()

            if inv.remove{name=player.cursor_stack.name, count=1} == 1 then

            --elseif player.get_quickbar().remove{name=player.cursor_stack.name, count=1} == 1 then -- commented, because 0.17 get error

            elseif player.cursor_stack.count > 1 then
                player.cursor_stack.count = player.cursor_stack.count - 1
            else
                player.cursor_stack.clear()
            end
      end
    end
end

local isInitGetDrink = false
function initGetDrink()
    if isInitGetDrink then
        return
    end
    isInitGetDrink = true

    script.on_event("get-drink-click", function(event)
        getDrink_on_Click(event)
    end)

end


