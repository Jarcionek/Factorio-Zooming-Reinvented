local player_memory = require("player_memory")
local mod_settings = require("mod_settings")
local zoom_calculator = require("zoom_calculator")
local map_zoom_out_disabler = require("map_zoom_out_disabler")
local binoculars_controler = require("binoculars_controler")



script.on_event(defines.events.on_runtime_mod_setting_changed, function(event)
    local player = game.players[event.player_index]
    mod_settings.validate_and_fix(player)
end)



local function try_zoom_in(player, tick)
    -- prevents double-zoom-in when user has the same key assigned to both actions (in such case both events have the same tick)
    if tick == player_memory.get_last_zoom_in_tick(player) then
        return
    else
        player_memory.set_last_zoom_in_tick(player, tick);
    end

    if player.render_mode == defines.render_mode.game or player.render_mode == defines.render_mode.chart_zoomed_in then
        player.zoom = zoom_calculator.calculate_zoomed_in_level(player)
    else
        zoom_calculator.update_current_zoom_by_user_zooming_in_on_the_map(player)
        map_zoom_out_disabler.disable(player)
    end
end

script.on_event("ZoomingReinvented_zoom-in", function(event)
    local player = game.players[event.player_index]
    try_zoom_in(player, event.tick)
end)

script.on_event("ZoomingReinvented_alt-zoom-in", function(event)
    local player = game.players[event.player_index]
    try_zoom_in(player, event.tick)
end)



script.on_event("ZoomingReinvented_alt-zoom-out", function(event)
    local player = game.players[event.player_index]

    local should_switch_back_to_map = zoom_calculator.should_switch_back_to_map(player)

    if should_switch_back_to_map then
        if map_zoom_out_disabler.is_enabled(player) then
            local map_zoom_level = zoom_calculator.calculate_zoom_out_back_to_map_view(player)
            player.open_map(player_memory.get_last_known_map_position(player), map_zoom_level)
        end
        return
    end

    if player.render_mode == defines.render_mode.chart then
        if map_zoom_out_disabler.is_enabled(player) then
            local zoom_level = zoom_calculator.calculate_zoomed_out_level(player)
            player.open_map(player_memory.get_last_known_map_position(player), zoom_level)
        end
    else
        local zoom_level = zoom_calculator.calculate_zoomed_out_level(player)
        player.zoom = zoom_level
    end
end)

script.on_event("ZoomingReinvented_enable-zoom-out", function(event)
    local player = game.players[event.player_index]
    map_zoom_out_disabler.enable(player)
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
        map_zoom_out_disabler.enable(player)
    end
end)



script.on_event(defines.events.on_selected_entity_changed, function(event)
    local player = game.players[event.player_index]
    if player.render_mode == defines.render_mode.chart_zoomed_in and player.selected then
        player_memory.set_last_known_map_position(player, player.selected.position)
    end
    if player.selected then
        map_zoom_out_disabler.enable(player)
    end
end)



script.on_event("ZoomingReinvented_quick-zoom-in", function(event)
    local player = game.players[event.player_index]
    local zoom_level = mod_settings.get_max_world_zoom_out(player)

    if player.render_mode == defines.render_mode.chart_zoomed_in and not player.selected then
       player.zoom = zoom_level
    else
        -- if player selected something, then last_known_map_position has been already updated to its position
        player.zoom_to_world(player_memory.get_last_known_map_position(player), zoom_level)
    end

    player_memory.set_current_zoom_level(player, zoom_level)
    map_zoom_out_disabler.enable(player)
end)

script.on_event("ZoomingReinvented_quick-zoom-out", function(event)
    local player = game.players[event.player_index]
    local zoom_level = mod_settings.get_quick_zoom_out_zoom_level(player)

    player.open_map({0, 0}, zoom_level)

    if mod_settings.is_bincoulars_auto_equip_enabled(player) then
        local binoculars_name = "ZoomingReinvented_binoculars"
        if not player.cursor_stack.valid_for_read or player.cursor_stack.name ~= binoculars_name then
            local main_inventory = player.get_main_inventory();
            local binoculars_in_inventory = main_inventory.find_item_stack(binoculars_name)

            if not binoculars_in_inventory and main_inventory.can_insert(binoculars_name) then
                main_inventory.insert(binoculars_name)
            end
            binoculars_in_inventory = main_inventory.find_item_stack(binoculars_name)
            if binoculars_in_inventory then
                player.clean_cursor()
                player.cursor_stack.swap_stack(binoculars_in_inventory)
            end
        end
    end

    -- do not reset last_known_map_position to allow to use quick-zoom-in to go back to it
    player_memory.set_current_zoom_level(player, zoom_level)
    map_zoom_out_disabler.enable(player)
end)



script.on_event(defines.events.on_player_used_capsule, function(event)
    local player = game.players[event.player_index]

    if event.item.name == "artillery-targeting-remote" then
        player_memory.set_last_known_map_position(player, event.position)
        map_zoom_out_disabler.enable(player)
    end

    if event.item.name == "ZoomingReinvented_binoculars" then
        binoculars_controler.use(player, event.position)
    end
end)

-- TODO left clicking on the station in the map view (that opens GUI), re-enables zooming out at the previous last known map position - what is causing that?

local function tag_update(event) -- doesn't work for some reason, neither of the trio... :/
    if event.player_index then
        local player = game.players[event.player_index]
        player_memory.set_last_known_map_position(player, event.tag.position)
    end
end

script.on_event(defines.events.on_chart_tag_added, function(event)
    tag_update(event)
end)

script.on_event(defines.events.on_chart_tag_modified, function(event)
    tag_update(event)
end)

script.on_event(defines.events.on_chart_tag_removed, function(event)
    tag_update(event)
end)



script.on_event("ZoomingReinvented_move-down", function(event)
    local player = game.players[event.player_index]
    map_zoom_out_disabler.disable(player)
end)

script.on_event("ZoomingReinvented_move-left", function(event)
    local player = game.players[event.player_index]
    map_zoom_out_disabler.disable(player)
end)

script.on_event("ZoomingReinvented_move-right", function(event)
    local player = game.players[event.player_index]
    map_zoom_out_disabler.disable(player)
end)

script.on_event("ZoomingReinvented_move-up", function(event)
    local player = game.players[event.player_index]
    map_zoom_out_disabler.disable(player)
end)

script.on_event("ZoomingReinvented_drag-map", function(event)
    local player = game.players[event.player_index]
    map_zoom_out_disabler.disable(player)
end)
