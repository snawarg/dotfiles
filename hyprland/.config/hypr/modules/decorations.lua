hl.config({
    decoration = {
        rounding       = 12,
        rounding_power = 1,

        shadow = {
            enabled        = true,
            range          = 20,
            render_power   = 3,
            color          = "rgba(00ff9f44)",
            color_inactive = "rgba(00000000)",
        },

        blur = {
            enabled           = true,
            size              = 4,
            passes            = 2,
            new_optimizations = true,
        },
    }
})
