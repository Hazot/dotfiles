require("copilot").setup({
    cmd = "Copilot",
    event = { "BufReadPre", "BufNewFile" },
    panel = {
        enabled = false,
        auto_refresh = true,
    },
    suggestion = {
        enabled = false,
        auto_trigger = "space",
    }
})
