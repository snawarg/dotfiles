hl.layer_rule({
    name  = "blur-swaync-center",
    match = { namespace = "swaync-control-center" },
    blur  = true,
    ignore_alpha = 0.79,
})

hl.layer_rule({
    name  = "blur-swaync-notif",
    match = { namespace = "swaync-notification-window" },
    blur  = true,
    ignore_alpha = 0.79,
})
