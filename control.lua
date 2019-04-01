local player_memory = require("player_memory")
local zoom_calculator = require("zoom_calculator")

script.on_event("ZoomingReinvented_alt-zoom-in", function(event)
    local player = game.players[event.player_index]

    if player.render_mode == defines.render_mode.game or player.render_mode == defines.render_mode.chart_zoomed_in then
        player.zoom = zoom_calculator.calculate_zoomed_in_level(player)
    else
        -- cannot do anything here, can I? needs to be using game's default alternative zoom in so that it
        -- respects mouse pointer position and switches to world view...
    end
end)

script.on_event("ZoomingReinvented_alt-zoom-out", function(event)
    local player = game.players[event.player_index]
    local is_already_maximally_zoomed_out = zoom_calculator.is_maximally_zoomed_out_zoom_to_world_view(player)
    local zoom_level = zoom_calculator.calculate_zoomed_out_level(player)

    if player.render_mode == defines.render_mode.game then
        player.zoom = zoom_level
        return
    end

    if player.render_mode == defines.render_mode.chart_zoomed_in then
        if is_already_maximally_zoomed_out then
            player.print("this is currently broken, but it should have opened the map at zoom_level " .. zoom_level)
            player.zoom_to_world(player_memory.get_last_known_map_position(player), zoom_level)
        else
            player.zoom = zoom_level
        end
        return
    end

    if player.render_mode == defines.render_mode.chart then
        player.open_map(player_memory.get_last_known_map_position(player), zoom_level)
    end
end)

script.on_event(defines.events.on_selected_entity_changed, function(event)
    local player = game.players[event.player_index]
    if player.render_mode == defines.render_mode.chart_zoomed_in and player.selected then
        player_memory.set_last_known_map_position(player, player.selected.position)
    end
end)
