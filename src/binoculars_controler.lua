local player_memory = require("player_memory")
local map_zoom_out_disabler = require("map_zoom_out_disabler")

local binoculars_controler = {}

binoculars_controler.use = function(player, position)
    local zoom_level = player.mod_settings["ZoomingReinvented_max-world-zoom-out"].value
    player.zoom_to_world(position, zoom_level)
    player_memory.set_current_zoom_level(player, zoom_level)
    player_memory.set_last_known_map_position(player, position)
    map_zoom_out_disabler.enable(player)
end

return binoculars_controler
