--require('__stdlib__/stdlib/event/event').set_protected_mode(true)

require ("libs.tile-fertility")
--require ("__Bio_Industries__.control_tree")

-- TODO merge table "global.foodi.tilefertility" with "Bi_Industries.fertility"


--local BioInd = require('common')('Bio_Industries')
--
--local ICONPATH = BioInd.modRoot .. "/graphics/entities/wood_products/rails/"
--
--local type = { straight_rail_horizontal = { prefix = "straight-rail", dir = "horizontal" },
--              straight_rail_vertical = { prefix = "straight-rail", dir = "vertical" },
--              straight_rail_diagonal_left_top = { prefix = "straight-rail", dir = "diagonal-left-top" },
--              straight_rail_diagonal_right_top = { prefix = "straight-rail", dir = "diagonal-right-top" },
--              straight_rail_diagonal_left_bottom = { prefix = "straight-rail", dir = "diagonal-left-bottom" },
--              straight_rail_diagonal_right_bottom = { prefix = "straight-rail", dir = "diagonal-right-bottom" },
--
--              curved_rail_horizontal_left_bottom = { prefix = "curved-rail", dir = "horizontal-left-bottom" },
--              curved_rail_horizontal_right_bottom = { prefix = "curved-rail", dir = "horizontal-right-bottom" },
--              curved_rail_horizontal_left_top = { prefix = "curved-rail", dir = "horizontal-left-top" },
--              curved_rail_horizontal_right_top = { prefix = "curved-rail", dir = "horizontal-right-top" },
--              curved_rail_vertical_left_bottom = { prefix = "curved-rail", dir = "vertical-left-bottom" },
--              curved_rail_vertical_right_bottom = { prefix = "curved-rail", dir = "vertical-right-bottom" },
--              curved_rail_vertical_left_top = { prefix = "curved-rail", dir = "vertical-left-top" },
--              curved_rail_vertical_right_top = { prefix = "curved-rail", dir = "vertical-right-top" }
--        }
--
--for class, info in pairs(type) do
--   local proto = data.raw[info.prefix]
----BioInd.writeDebug("doing" .. tostring(class) .. " " .. tostring(info.prefix) .. "   " .. tostring(info.dir) .. "    ".. tostring(proto).. "   " )
--        data.raw[info.prefix]["bi-" .. info.prefix .. "-wood-bridge"].pictures[class].stone_path.hr_version.filename = ICONPATH .. info.prefix .. "-bridge/hr-" .. info.prefix .. "-" .. info.dir .. "-stone-path.png"
--        data.raw[info.prefix]["bi-" .. info.prefix .. "-wood-bridge"].pictures[class].stone_path_background.hr_version.filename = ICONPATH .. info.prefix .. "-bridge/hr-" .. info.prefix .. "-" .. info.dir .. "-stone-path-background.png"
--        data.raw[info.prefix]["bi-" .. info.prefix .. "-wood-bridge"].pictures[class].stone_path.filename = ICONPATH ..info.prefix .. "-bridge/" .. info.prefix .. "-" .. info.dir .. "-stone-path.png"
--        data.raw[info.prefix]["bi-" .. info.prefix .. "-wood-bridge"].pictures[class].stone_path_background.filename = ICONPATH .. info.prefix .. "-bridge/" .. info.prefix .. "-" .. info.dir .. "-stone-path-background.png"
--end
