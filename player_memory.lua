local player_memory = {}

local function get_player_memory(player)
    global.player_memory = global.player_memory or {}
    global.player_memory[player.index] = global.player_memory[player.index] or {
        last_known_map_position = {0, 0},
        current_zoom = 1
    }
    return global.player_memory[player.index]
end

function player_memory.get_last_known_map_position(player)
    return get_player_memory(player).last_known_map_position
end

function player_memory.set_last_known_map_position(player, position)
    get_player_memory(player).last_known_map_position = position
end

function player_memory.get_current_zoom_level(player)
    return get_player_memory(player).current_zoom
end

function player_memory.set_current_zoom_level(player, zoom_level)
    get_player_memory(player).current_zoom = zoom_level
end

return player_memory
