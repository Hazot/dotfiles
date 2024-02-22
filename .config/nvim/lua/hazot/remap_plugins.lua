-- Copilot enable/disable
vim.keymap.set("n", "<leader>ce", [[:Copilot enable<CR>]], { desc = "Copilot" })
vim.keymap.set("n", "<leader>cd", [[:Copilot disable<CR>]], { desc = "Copilot" })

-- Nvim Tree
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- ToggleTerm
vim.keymap.set({ "n", "v" }, "<leader>tt", "<cmd>ToggleTermToggleAll<cr>", {
    desc = "Toggle terminal",
})
