vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Moves highlighted text together in visual mode with J and K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Does not move mouse when appending lines with J
vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "<C-d>","<C-d>zz")
vim.keymap.set("n", "<C-u>","<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Can delete highlight without copying it and then paste the current buffer
vim.keymap.set("x", "<leader>p", "\"_dP")


-- Yank multiple lines to clipboard easily
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Only difference between escape and ctrl+c
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Do not use Q
vim.keymap.set("n", "Q", "<nop>")

-- Can you ctrl+f to create a new session on a new project
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Can easily replace all the words in a file
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
