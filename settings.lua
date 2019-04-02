data:extend({
    {
        type = "double-setting",
        name = "ZoomingReinvented_zoom-sensitivity",
        setting_type = "runtime-per-user",
        default_value = 1.5,
        maximum_value = 5.0,
        minimum_value = 1.01,
        order = "01"
    },
    {
        type = "double-setting",
        name = "ZoomingReinvented_max-world-zoom-out",
        setting_type = "runtime-per-user",
        default_value = 0.1,
        maximum_value = 1.0,
        minimum_value = 0.0001,
        order = "02"
    },
    {
        type = "double-setting",
        name = "ZoomingReinvented_default-map-zoom-level",
        setting_type = "runtime-per-user",
        default_value = 0.0313,
        maximum_value = 1.0, -- TODO this should be lower tha max-world-zoom-out, if I can't enforce it here, I can do so in zoom_calculator.calculate_open_map_zoom_level()
        minimum_value = 0.0001,
        order = "03"
    }
})
