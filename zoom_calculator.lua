local constant = require("constants")
local player_memory = require("player_memory")

local calculator = {}

function calculator.calculate_zoomed_in_level(player)
    local zoom_sensitivity = player.mod_settings["ZoomingReinvented_zoom-sensitivity"].value

    local new_zoom_level = player_memory.get_current_zoom_level(player) * zoom_sensitivity

    local max_zoom_in_level
    if player.render_mode == defines.render_mode.game or player.render_mode == defines.render_mode.chart_zoomed_in then
        max_zoom_in_level = constant.MAX_WORLD_ZOOM_IN_LEVEL
    else
        max_zoom_in_level = constant.MAX_MAP_ZOOM_IN_LEVEL
    end

    --TODO for now, I guess I could just set it to the actual max rather than ignoring it
    -- it will simplify things when watching when the game switched to zoom to world by using base game's "alternative zoom in" on the map
    -- in the future, on mod settings change I could calculate what is the actual min/max and store that in player's memory
    --TODO but then, what to do with features like quick zoom out which will have its zoom level configurable?
    -- I would have to recalculate it and set it to the closest "correct" value...
    if new_zoom_level <= max_zoom_in_level then
        player_memory.set_current_zoom_level(player, new_zoom_level)
    end

    return player_memory.get_current_zoom_level(player)
end

function calculator.calculate_zoomed_out_level(player)
    local zoom_sensitivity = player.mod_settings["ZoomingReinvented_zoom-sensitivity"].value
    local max_world_zoom_out_level = player.mod_settings["ZoomingReinvented_max-world-zoom-out"].value

    local new_zoom_level = player_memory.get_current_zoom_level(player) / zoom_sensitivity

    local max_zoom_out_level
    if player.render_mode == defines.render_mode.game or player.render_mode == defines.render_mode.chart_zoomed_in then
        max_zoom_out_level = max_world_zoom_out_level
    else
        max_zoom_out_level = constant.MAX_MAP_ZOOM_OUT_LEVEL
    end

    if new_zoom_level >= max_zoom_out_level then
        player_memory.set_current_zoom_level(player, new_zoom_level)
    end

    return player_memory.get_current_zoom_level(player)
end

function calculator.is_maximally_zoomed_out_zoom_to_world_view(player)
    if player.render_mode == defines.render_mode.chart_zoomed_in then
        local zoom_sensitivity = player.mod_settings["ZoomingReinvented_zoom-sensitivity"].value
        local max_world_zoom_out_level = player.mod_settings["ZoomingReinvented_max-world-zoom-out"].value
        return player_memory.get_current_zoom_level(player) / zoom_sensitivity < max_world_zoom_out_level
    else
        return false
    end
end

function calculator.calculate_open_map_zoom_level(player)
    local zoom_level = player.mod_settings["ZoomingReinvented_default-map-zoom-level"].value
    player_memory.set_current_zoom_level(player, zoom_level)
    return zoom_level
end

function calculator.update_current_zoom_by_user_zooming_in_on_the_map(player)
    local zoom_level = player_memory.get_current_zoom_level(player)
    zoom_level = zoom_level * constant.BASE_GAME_ANY_MAP_ZOOM_SENSITIVITY
    player_memory.set_current_zoom_level(player, zoom_level)
end

return calculator
