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

return calculator
