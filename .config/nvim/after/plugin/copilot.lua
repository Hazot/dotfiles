use {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function()
        require("copilot_cmp").setup()
    end
}
require("copilot").setup({
    suggestion = { enabled = false },
    panel = { enabled = false },
})
