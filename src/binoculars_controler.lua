local constant = require("constants")
local player_memory = require("player_memory")
local map_zoom_out_disabler = require("map_zoom_out_disabler")

local binoculars_controler = {}

binoculars_controler.use = function(player, position)
    local double_action_enabled = player.mod_settings["ZoomingReinvented_binoculars-double-action-enabled"].value
    local zoom_level

    if double_action_enabled and player.render_mode == defines.render_mode.chart and player_memory.get_current_zoom_level(player) < constant.MIN_MAP_ZOOM_LEVEL_WITH_LABELS_VISIBLE then
        zoom_level = constant.MIN_MAP_ZOOM_LEVEL_WITH_LABELS_VISIBLE
        player.open_map(position, zoom_level)
    else
        zoom_level = player.mod_settings["ZoomingReinvented_binoculars-zoom-level"].value
        player.zoom_to_world(position, zoom_level)
    end

    player_memory.set_current_zoom_level(player, zoom_level)
    player_memory.set_last_known_map_position(player, position)
    map_zoom_out_disabler.enable(player)
end

return binoculars_controler
