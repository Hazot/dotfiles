vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", "<Cmd>Ex<CR>")

-- Moves highlighted text together in visual mode with J and K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Does not move mouse when appending lines with J
vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Can delete highlight without copying it and then paste the current buffer
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Format on key press (one from
vim.keymap.set("n", "<leader>wf", vim.lsp.buf.format, { remap = false })
vim.keymap.set("n", "<C-I>", vim.lsp.buf.format, { remap = false })

-- Yank multiple lines to clipboard easily
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Delete without yank
vim.keymap.set({ "n", "v" }, "<leader>D", "\"_d")

-- Only difference between escape and ctrl+c
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Do not use Q
vim.keymap.set("n", "Q", "<nop>")

-- Can you ctrl+f to create a new session on a new project
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Can easily replace all the words in a file
vim.keymap.set("n", "<leader>s",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]
)

-- Fighting one-eyed kirby
vim.keymap.set(
    "v",
    "<leader>k",
    ":s/\\(\\S.*\\)/ \\1/g<left><left><left><left><left>",
    { desc = "Fighting one-eyed kirby" }
)

-- Have j and k working with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Set ctrl+backspace to delete words like C-w
vim.keymap.set("i", "<C-H>", "<C-W>", { noremap = true })
