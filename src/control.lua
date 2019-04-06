local player_memory = require("player_memory")
local zoom_calculator = require("zoom_calculator")


local function disable_map_zoom_out_if_in_map_view(player)
    if player.render_mode == defines.render_mode.chart then
        player_memory.set_map_zoom_out_enabled(player, false)
    end
end



script.on_event("ZoomingReinvented_alt-zoom-in", function(event)
    local player = game.players[event.player_index]

    if player.render_mode == defines.render_mode.game or player.render_mode == defines.render_mode.chart_zoomed_in then
        player.zoom = zoom_calculator.calculate_zoomed_in_level(player)
    else
        zoom_calculator.update_current_zoom_by_user_zooming_in_on_the_map(player)
        disable_map_zoom_out_if_in_map_view(player)
    end
end)



script.on_event("ZoomingReinvented_alt-zoom-out", function(event)
    local player = game.players[event.player_index]

    local should_switch_back_to_map = zoom_calculator.should_switch_back_to_map(player)

    if should_switch_back_to_map then
        local map_zoom_level = zoom_calculator.calculate_zoom_out_back_to_map_view(player)
        player.open_map(player_memory.get_last_known_map_position(player), map_zoom_level)
        return
    end

    if player.render_mode == defines.render_mode.chart then
        local map_zoom_out_disabling_active = player.mod_settings["ZoomingReinvented_disable-map-zoom-out"].value
        local map_zoom_out_enabled = player_memory.is_map_zoom_out_enabled(player)

        if not map_zoom_out_disabling_active or map_zoom_out_enabled then
            local zoom_level = zoom_calculator.calculate_zoomed_out_level(player)
            player.open_map(player_memory.get_last_known_map_position(player), zoom_level)
        end
    else
        local zoom_level = zoom_calculator.calculate_zoomed_out_level(player)
        player.zoom = zoom_level
    end
end)



script.on_event("ZoomingReinvented_toggle-map", function(event)
    local player = game.players[event.player_index]

    if player.render_mode == defines.render_mode.game then
        local zoom_level = zoom_calculator.calculate_open_map_zoom_level(player)
        player.open_map(player.position, zoom_level)
        player_memory.set_last_known_map_position(player, player.position)
    else
        player.close_map()
        player.zoom = 1
        player_memory.set_current_zoom_level(player, 1)
        player_memory.set_map_zoom_out_enabled(player, true)
    end
end)



script.on_event(defines.events.on_selected_entity_changed, function(event)
    local player = game.players[event.player_index]
    if player.render_mode == defines.render_mode.chart_zoomed_in and player.selected then
        player_memory.set_last_known_map_position(player, player.selected.position)
    end
    if player.selected then
        player_memory.set_map_zoom_out_enabled(player, true)
    end
end)



script.on_event("ZoomingReinvented_quick-zoom-in", function(event)
    local player = game.players[event.player_index]
    local zoom_level = player.mod_settings["ZoomingReinvented_max-world-zoom-out"].value

    if player.render_mode == defines.render_mode.chart_zoomed_in and not player.selected then
       player.zoom = zoom_level
    else
        player.zoom_to_world(player_memory.get_last_known_map_position(player), zoom_level)
    end

    player_memory.set_current_zoom_level(player, zoom_level)
    player_memory.set_map_zoom_out_enabled(player, true)
end)

script.on_event("ZoomingReinvented_quick-zoom-out", function(event)
    local player = game.players[event.player_index]
    local zoom_level = player.mod_settings["ZoomingReinvented_quick-zoom-out-zoom-level"].value

    player.open_map({0, 0}, zoom_level)

    player_memory.set_current_zoom_level(player, zoom_level)
    player_memory.set_last_known_map_position(player, {0, 0})
    player_memory.set_map_zoom_out_enabled(player, true)
end)


script.on_event(defines.events.on_player_used_capsule, function(event)
    if event.item.name == "ZoomingReinvented_binoculars" then
        local player = game.players[event.player_index]
        local position = event.position
        local zoom_level = player.mod_settings["ZoomingReinvented_max-world-zoom-out"].value
        player.zoom_to_world(position, zoom_level)
        player_memory.set_current_zoom_level(player, zoom_level)
        player_memory.set_last_known_map_position(player, position)
        player_memory.set_map_zoom_out_enabled(player, true)
    end
end)


script.on_event("ZoomingReinvented_move-down", function(event)
    local player = game.players[event.player_index]
    disable_map_zoom_out_if_in_map_view(player)
end)

script.on_event("ZoomingReinvented_move-left", function(event)
    local player = game.players[event.player_index]
    disable_map_zoom_out_if_in_map_view(player)
end)

script.on_event("ZoomingReinvented_move-right", function(event)
    local player = game.players[event.player_index]
    disable_map_zoom_out_if_in_map_view(player)
end)

script.on_event("ZoomingReinvented_move-up", function(event)
    local player = game.players[event.player_index]
    disable_map_zoom_out_if_in_map_view(player)
end)

script.on_event("ZoomingReinvented_drag-map", function(event)
    local player = game.players[event.player_index]
    disable_map_zoom_out_if_in_map_view(player)
end)
