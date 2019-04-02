local player_memory = require("player_memory")
local zoom_calculator = require("zoom_calculator")

script.on_event("ZoomingReinvented_alt-zoom-in", function(event)
    local player = game.players[event.player_index]

    if player.render_mode == defines.render_mode.game or player.render_mode == defines.render_mode.chart_zoomed_in then
        player.zoom = zoom_calculator.calculate_zoomed_in_level(player)
    else
        zoom_calculator.update_current_zoom_by_user_zooming_in_on_the_map(player)
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

script.on_event("ZoomingReinvented_toggle-map", function(event)
    local player = game.players[event.player_index]

    if player.render_mode == defines.render_mode.game then
        local zoom_level = zoom_calculator.calculate_open_map_zoom_level(player)
        player.open_map(player.position, zoom_level)
    else
        player.close_map()
        player.zoom = 1 --TODO set the zoom level to what? does calculator need to handle what is the actual range (exactly)?
        player_memory.wipe_memory(player) -- TODO this also wipes the last know map position which will prevent reopening it :/
    end
end)

script.on_event(defines.events.on_selected_entity_changed, function(event)
    local player = game.players[event.player_index]
    if player.render_mode == defines.render_mode.chart_zoomed_in and player.selected then
        player_memory.set_last_known_map_position(player, player.selected.position)
    end
end)

script.on_event(defines.events.on_runtime_mod_setting_changed, function(event)
    local player = game.players[event.player_index]
    player.print("wiping!")
    player_memory.wipe_memory(player)
    player.zoom = 1
end)

