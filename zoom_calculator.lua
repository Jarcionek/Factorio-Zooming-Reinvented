local constant = require("constants")
local player_memory = require("player_memory")

local calculator = {}

function calculator.calculate_zoomed_in_level(player)
    local zoom_sensitivity = player.mod_settings["ZoomPresets_zoom-sensitivity"].value

    local new_zoom_level = player_memory.get_current_zoom_level(player) * zoom_sensitivity

    local max_zoom_in_level = player.render_mode == defines.render_mode.game and constant.MAX_WORLD_ZOOM_IN_LEVEL or constant.MAX_MAP_ZOOM_IN_LEVEL

    if new_zoom_level <= max_zoom_in_level then
        player_memory.set_current_zoom_level(player, new_zoom_level)
    end

    return player_memory.get_current_zoom_level(player)
end

function calculator.calculate_zoomed_out_level(player)
    local zoom_sensitivity = player.mod_settings["ZoomPresets_zoom-sensitivity"].value
    local max_world_zoom_out_level = player.mod_settings["ZoomPresets_max-world-zoom-out"].value

    local new_zoom_level = player_memory.get_current_zoom_level(player) / zoom_sensitivity

    local max_zoom_out_level = player.render_mode == defines.render_mode.game and max_world_zoom_out_level or constant.MAX_MAP_ZOOM_OUT_LEVEL

    if new_zoom_level >= max_zoom_out_level then
        player_memory.set_current_zoom_level(player, new_zoom_level)
    end

    return player_memory.get_current_zoom_level(player)
end

return calculator
