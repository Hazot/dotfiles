-- NerdCommenter
vim.keymap.set("v", "<leader>cc", "<plug>NERDCommenterToggle", { desc = "Toggle commenting" })
vim.keymap.set("n", "<C-_>", "<leader>cc", { desc = "Toggle commenting" })

-- LSP
local opts = { noremap=true, silent=true }

local function quickfix()
    vim.lsp.buf.code_action({
        filter = function(a) return a.isPreferred end,
        apply = true
    })
end

vim.keymap.set('n', '<leader>qf', quickfix, opts)
