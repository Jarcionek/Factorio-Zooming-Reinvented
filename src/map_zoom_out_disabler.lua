local player_memory = require("player_memory")

local map_zoom_out_disabler = {}

map_zoom_out_disabler.disable = function (player)
    if player.render_mode ~= defines.render_mode.game then
        player_memory.set_map_zoom_out_enabled(player, false)
    end
end

map_zoom_out_disabler.enable = function (player)
    player_memory.set_map_zoom_out_enabled(player, true)
end


map_zoom_out_disabler.is_enabled = function (player)
    local map_zoom_out_disabling_active = player.mod_settings["ZoomingReinvented_disable-map-zoom-out"].value
    local map_zoom_out_enabled = player_memory.is_map_zoom_out_enabled(player)
    return not map_zoom_out_disabling_active or map_zoom_out_enabled
end

return map_zoom_out_disabler
