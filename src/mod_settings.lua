local mod_settings = {}

mod_settings.get_zoom_sensitivity = function(player)
    return player.mod_settings["ZoomingReinvented_zoom-sensitivity"].value
end

mod_settings.get_max_world_zoom_out = function(player)
    return player.mod_settings["ZoomingReinvented_max-world-zoom-out"].value
end

mod_settings.get_default_map_zoom_level = function(player)
    return player.mod_settings["ZoomingReinvented_default-map-zoom-level"].value
end

mod_settings.get_quick_zoom_out_zoom_level = function(player)
    return player.mod_settings["ZoomingReinvented_quick-zoom-out-zoom-level"].value
end

mod_settings.get_binoculars_zoom_level = function(player)
    return player.mod_settings["ZoomingReinvented_binoculars-zoom-level"].value
end

mod_settings.is_binoculars_double_action_enabled = function(player)
    return player.mod_settings["ZoomingReinvented_binoculars-double-action-enabled"].value
end

mod_settings.is_disable_map_zoom_out_active = function(player)
    return player.mod_settings["ZoomingReinvented_disable-map-zoom-out"].value
end

return mod_settings
